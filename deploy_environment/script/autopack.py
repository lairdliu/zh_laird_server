#!/usr/bin/env python


from __future__ import print_function
import logging
import os
import io
import sys
import argparse
import time
import json
import re
import traceback
import pytoml as toml
from distutils.version import LooseVersion
from sh import git
from sh import tar
from sh import head
from sh import rm
from sh import ssh
from sh import scp
from sh import rpmbuild
from sh import gzip
from sh import mkdir
from sh import glob
from sh import cp
from sh import curl
from sh import gpg
from sh import chmod
from sh import echo
from sh import wget

logHandler = logging.StreamHandler(sys.stdout)
logHandler.setFormatter(logging.Formatter(fmt='[%(levelname)-5s] %(message)s'))
log = logging.getLogger('autopack')
log.addHandler(logHandler)
log.setLevel(logging.DEBUG)

repo_server = '192.168.50.60'


class FerrywayModule:
    def __init__(self, name, commit, spec_file, version):
        self.name = name
        self.commit = commit
        self.spec_file = spec_file
        self.version = version
        self.reversion = ''

    def __str__(self):
        return '[name: {}, commit: {}, spec_file: {}, version: {}, reversion: {}]'.format(
            self.name, self.commit, self.spec_file, self.version,
            self.reversion)


class FerrywayVersion:
    def __init__(self, version, update_script_commit, modules, deps, updates):
        self.version = version
        self.update_script_commit = update_script_commit
        self.modules = modules
        self.deps = deps
        self.updates = updates

class Dependency:
    def __init__(self, name, url):
        self.name = name       # package name
        self.url = url


class FerrywayUpdate:
    def __init__(self, target_version, new_version, modules, deps):
        self.id = target_version + '-' + new_version
        self.target_version = target_version
        self.new_version = new_version
        self.modules = modules
        self.deps = [] if deps is None else deps


def load_conf():
    with io.open('conf.toml', 'r') as file:
        confs = toml.load(file)

    version_confs = confs['versions']
    versions = {}
    for ver_conf in version_confs:
        modules = []
        for mod_conf in ver_conf['modules']:
            module = FerrywayModule(mod_conf['name'], mod_conf['commit'],
                                    mod_conf['spec'],
                                    mod_conf.get('version', ''))
            modules.append(module)

        deps = []
        deps_conf = ver_conf.get('deps')
        if deps_conf is not None:
            for dep_conf in deps_conf:
                deps.append(Dependency(dep_conf['name'], dep_conf['url']))

        updates = []
        for up_conf in ver_conf.get('updates', []):
            update = FerrywayUpdate(up_conf['target_version'],
                                    ver_conf['version'], up_conf['modules'], up_conf.get('deps'))
            updates.append(update)

        version = FerrywayVersion(ver_conf['version'],
                                  ver_conf.get('update_script_commit', ''),
                                  modules, deps, updates)
        versions[version.version] = version

    return versions


def fetch_source(mod):
    output_file = '/root/rpmbuild/SOURCES/' + mod.name + '-' + mod.version + '.tar'
    rm('-f', output_file)
    git('archive', '--prefix=' + mod.name + '-' + mod.version + '/',
        '--remote=git@gitlab.jdwa.cn:root/' + mod.name + '.git',
        '--output=' + output_file, mod.commit)
    log.info('save source to: ' + output_file)


def compress_source(mod):
    output_file = '/root/rpmbuild/SOURCES/' + mod.name + '-' + mod.version + '.tar'
    gzip('-1', '-f', output_file)


def fetch_spec(mod):
    repo = 'git@gitlab.jdwa.cn:root/' + mod.name + '.git'
    mod.reversion = str(head(git('ls-remote', repo, mod.commit), '-c', '8'))
    if mod.reversion == '':
        raise Exception('can not get reversion for module: ' + mod.name +
                        ', commit: ' + mod.commit)

    log.info('reversion: %s', mod.reversion)
    spec = tar(
        git('archive', '--remote=' + repo, mod.commit, mod.spec_file), '-xO')
    spec = spec.replace('{{checkout}}', mod.reversion, 1)
    if mod.version != '':
        # modify version in spec file
        spec = spec.replace('{{version}}', mod.version, 1)
    else:
        # get version from spec file
        match = re.search(r'Version:\s+(\S+)\n', spec)
        mod.version = match.group(1)
        log.debug('version: %s', mod.version)
    saved_spec_file = '/root/rpmbuild/SPECS/' + mod.name + '.spec'
    with io.open(saved_spec_file, 'w') as file:
        file.write(u'' + spec)
    log.info('save spec to: ' + saved_spec_file)


def fetch_modules(version):
    for mod in version.modules:
        log.info('====================== starting to fecth module: %s',
                 mod.name)
        fetch_spec(mod)
        fetch_source(mod)
        log.info('module info: %s', mod)
        log.info('====================== fetch module successfully: %s',
                 mod.name)
    if LooseVersion(version.version) < LooseVersion('3.3.8'):
        # source package suffix is .tar.gz for old version 
        for mod in version.modules:
            compress_source(mod)


def fetch_deps(deps):
    for dep in deps:
        log.info('********************** fetch dependency: %s', dep.name)
        wget('-P', '/root/rpmbuild/RPMS/x86_64', 'http://' + repo_server + dep.url)


def clean():
    rm('-rf', '/root/rpmbuild')
    mkdir('-p', '/root/rpmbuild/BUILD')
    mkdir('-p', '/root/rpmbuild/BUILDROOT')
    mkdir('-p', '/root/rpmbuild/RPMS')
    mkdir('-p', '/root/rpmbuild/SOURCES')
    mkdir('-p', '/root/rpmbuild/SPECS')
    mkdir('-p', '/root/rpmbuild/SRPMS')


def list_versions(args):
    print('availabe versions:')
    for ver in load_conf().iterkeys():
        print(ver)


def parse_args():
    parser = argparse.ArgumentParser(description='Automaticly build packages')
    subparsers = parser.add_subparsers()
    # list versions in config
    list_parser = subparsers.add_parser(
        'list',
        help='print versions in config file')
    list_parser.set_defaults(func=list_versions)

    # build version mode
    build_parser = subparsers.add_parser(
        'build',
        help='build packages, then upload to release repo')
    build_parser.add_argument('version',
                              nargs='?',
                              help='the version will be packaged')
    build_parser.set_defaults(func=build)

    # build single package mode
    mod_parser = subparsers.add_parser(
            'mod', help='only build single module')
    mod_parser.add_argument('version', nargs='?',
            help='the version will be packaged')
    mod_parser.add_argument('mod', nargs='?',
            help='the module will be packaged')
    mod_parser.set_defaults(func=build_module)

    args = parser.parse_args(sys.argv[1:])

    return args


def make_release_info(version):
    module_infos = []
    for mod in version.modules:
        module_infos.append({'name': mod.name,
                             'version': mod.version + '-' + mod.reversion})
    ver_info = {'sys_version': version.version, 'modules': module_infos}
    with io.open('/tmp/uniway-release', 'w') as file:
        file.write(unicode(json.dumps(ver_info, indent=2)))


def build(args):
    clean()
    versions = load_conf()

    version = versions[args.version]
    # fetch dependencies
    fetch_deps(version.deps)
    # fetch source code and rpm spec file
    fetch_modules(version)

    #build rpm
    for mod in version.modules:
        rpmbuild('-bb', '/root/rpmbuild/SPECS/' + mod.name + '.spec')
        log.info('build module successfully: ' + mod.name)

    repo_dir = '/var/www/hpf/repo/jdwa/' + version.version
    ssh('root@' + repo_server, 'rm -rf ' + repo_dir)
    ssh('root@' + repo_server, 'mkdir ' + repo_dir)
    for mod in version.modules:
        mod_rpm = mod.name + '-' + mod.version + '-' + mod.reversion + '.el7.centos.x86_64.rpm'
        scp('/root/rpmbuild/RPMS/x86_64/' + mod_rpm,
            'root@{}:{}'.format(repo_server, repo_dir))
        log.info('upload module to repo: %s', mod_rpm)
    make_release_info(version)
    scp('/tmp/uniway-release', 'root@{}:{}'.format(repo_server, repo_dir))
    log.info('upload release info successfully')
    ssh('root@' + repo_server,
        'cd /var/www/hpf/repo/jdwa/; ./updaterepo.sh ' + args.version)
    log.info('update repo successfully')
    
    # build update package
    for update in version.updates:
        modules = []
        for mod_name in update.modules:
            for mod in version.modules:
                if mod.name == mod_name:
                    modules.append(mod)
        #create_update_pack(version.update_script_commit, update, modules)

    clean()


def build_module(args):
    versions = load_conf()
    version = versions[args.version]
    mod_name = args.mod
    mod = None
    for m in version.modules:
        if m.name == mod_name:
           mod = m 
           break
    if mod is None:
        print("no module '{}' in version '{}'".format(mod_name, args.version))
    
    log.info('====================== starting to fecth module: %s',
             mod.name)
    fetch_spec(mod)
    fetch_source(mod)
    log.info('module info: %s', mod)
    log.info('====================== fetch module successfully: %s',
             mod.name)
    if LooseVersion(version.version) < LooseVersion('3.3.8'):
        # source package suffix is .tar.gz for old version 
        for mod in version.modules:
            compress_source(mod)
    rpmbuild('-bb', '/root/rpmbuild/SPECS/' + mod.name + '.spec')
    log.info('build module successfully: ' + mod.name)


def make_metadata(update, modules):
    module_infos = []
    for mod in modules:
        module_infos.append({'name': mod.name,
                             'version': mod.version + '-' + mod.reversion})
    md = {
        'target_version': update.target_version,
        'new_version': update.new_version,
        'timestamp': str(int(time.time())),
        'modules': module_infos
    }

    with io.open('/root/update/metadata.json', 'w+') as file:
        file.write(unicode(json.dumps(md, indent=2)))
    return md


def fetch_nic_library():
    nic_conf = unicode(tar(
        git('archive', '--remote=git@gitlab.jdwa.cn:root/installer.git', 'master', 'nic_library.json'), '-xO'))
    # test config is json format or not
    json.loads(nic_conf)
    with io.open('/root/update/nic_library.json', 'w') as file:
        file.write(nic_conf)


def create_update_pack(update_script_commit, update, modules):
    try:
        log.info(
            'start to create update package, target_version: %s, new_version: %s',
            update.target_version, update.new_version)
        rm('-rf', 'update')
        mkdir('/root/update')
        for mod in update.modules:
            cp(
                glob('/root/rpmbuild/RPMS/x86_64/' + mod +
                     '-*.el7.centos.x86_64.rpm'), '/root/update')
        for dep in update.deps:
            cp(
                glob('/root/rpmbuild/RPMS/x86_64/' + dep +
                     '-*.rpm'), '/root/update')

        curl('-o', '/root/update/gap_sshkey_rsa.pri',
             'http://{}/repo/jdwa/sshkey/gap_sshkey_rsa.pri'.format(
                 repo_server))
        chmod('0600', '/root/update/gap_sshkey_rsa.pri')
        upgrade = tar(
            git('archive', '--remote=git@gitlab.jdwa.cn:root/installer.git',
                update_script_commit,
                'build/' + update.id + '/upgrade'), '-xO')
        with io.open('/root/update/upgrade', 'w+') as file:
            file.write(unicode(upgrade))
            chmod('+x', '/root/update/upgrade')
        fetch_nic_library()

        md = make_metadata(update, modules)
        tar('cvf', '/root/update.tar', 'update')
        update_pkg = 'ferryway-update-{}-{}.bin'.format(
            update.id, md['timestamp'])
        gpg(
            echo('Jdwa*2003'), '--batch', '--passphrase-fd', '0', '-z', '9',
            '--output', update_pkg, '--sign', 'update.tar')
        log.info('create update package successfully: %s', update_pkg)
        repo_dir = '/var/www/hpf/repo/jdwa/update'
        ssh('root@' + repo_server, 'mkdir -p ' + repo_dir)
        ssh('root@' + repo_server,
            'rm -rf ' + repo_dir + '/ferryway-update-' + update.id + '-*')
        scp(update_pkg, 'root@{}:{}'.format(repo_server, repo_dir))
        log.info('upload update package to repo: %s', update_pkg)
        rm('-rf', 'update', 'update.tar', update_pkg)
    except Exception as e:
        print('failed to create update package: ')
        traceback.print_exc()


if __name__ == '__main__':
    args = parse_args()
    args.func(args)
