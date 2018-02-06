#!/usr/bin/env bash

make_repo() {
    cd $1
    echo "create repo for version: $1"
    rm -rf repodata
    createrepo .
    cd ..
}

for version in `ls -d */`; do
    version=${version:0:-1}
    case $version in 
        common | sshkey | gpg | update | sshd_config)
            # common packages in this directory, this is not a release version,
            # skip it.
            ;;
        *)
            if [ -n "$1" ]; then
                if [ "$1" = $version ]; then
                    make_repo $version
                fi
            else 
                make_repo $version
            fi
            ;;
    esac
done

