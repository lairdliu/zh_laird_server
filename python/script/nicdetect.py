#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function
import sys
import os
import io
import json
import argparse
import re
import string

# 该脚本用来生成网卡重命名配置文件


conf_file = '/opt/jdwa/etc/nic.json'
nic_sql_file = '/opt/jdwa/etc/nic.sql'

class NicNameRule:
    def __init__(self, pci_id, name, is_data_nic=False, is_tun_nic=False):
        self.pci_id = pci_id
        self.name = name
        self.is_data_nic = is_data_nic
        self.is_tun_nic = is_tun_nic


def save_nic_conf(rules):
    tun_nics = []
    data_nics = []
    for rule in rules:
        if rule.is_tun_nic:
            tun_nics.append(rule.name)
        if rule.is_data_nic:
            data_nics.append(rule.name)

    nic_conf = {'tun_nics': tun_nics, 'data_nics': data_nics}
    with io.open(conf_file, 'w+') as file:
        file.write(unicode(json.dumps(nic_conf, indent=2, sort_keys=True), 'utf-8'))


def save_udev_rules(rules):
    with io.open('/usr/lib/udev/rules.d/60-net.rules', 'w') as file:
        for rule in rules:
            if rule.name == 'firewire0' or rule.name == 'firewire1':
                 str_rule = '#ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{type}=="1", ' + 'DEVPATH=="*{}*", NAME="{}" GOTO="END"\n'.format(rule.pci_id, rule.name)
            else :
                 str_rule = 'ACTION=="add", SUBSYSTEM=="net", DRIVERS=="?*", ATTR{type}=="1", ' + 'DEVPATH=="*{}*", NAME="{}" GOTO="END"\n'.format(rule.pci_id, rule.name)
            file.write(unicode(str_rule))
        file.write(unicode('LABEL="END"\n'))
    

def insert_sort(lists):
    # 插入排序
    count = len(lists)
    for i in range(1, count):
        key = lists[i]
        j = i - 1
        while j >= 0:
            if "eth" in lists[j]:
                  list=lists[j]
                  li=string.atoi(list[3:])
                  ke=string.atoi(key[3:])
                  if li > ke:
                    lists[j + 1] = lists[j]
                    lists[j] = key
            else :
                if lists[j] > key:
                    lists[j + 1] = lists[j]
                    lists[j] = key
            j -= 1
    return lists
    
def make_sql(rules):
    sql = ''
    name = []
    for rule in rules:
        if rule.is_data_nic:
            name.append(rule.name)
    for exchanger_id in [1, 2]:
        newname=insert_sort(name)
        for rule in newname:            
            sql += "INSERT INTO gap_exchanger_nic (exchanger_id, name, type) VALUES ('{}', '{}', 0);\n".format(exchanger_id, rule)
    sql += 'COMMIT;\n'
    with io.open(nic_sql_file, 'w') as file:
        file.write(unicode(sql))
	os.system("sync")


def changer_cardnum_sql():
    os.system('/opt/jdwa/bin/upgrade_sql.py ')


def make_nic_rules():
    rules = []
    os.system('python /opt/uniway/script/get-key.py')
    with io.open('/opt/uniway/etc/nic_library.json') as file:
        nic_conf = json.load(file)
    with io.open('/opt/jdwa/etc/key-tmp') as file:
        key=str(file.read())
        print('key:',key)
    try:
        nics = nic_conf[key]
    except Exception,e:
        print('the key type not in our library')
        sys.exit(0)
    for index in range(len(nics)):
        if index==0:
            continue        
        if "tun" in nics[index]['name'] or "firewire" in nics[index]['name']:
            rules.append(NicNameRule(nics[index]['pci_id'], nics[index]['name'], is_tun_nic=True))
            print('nic:',nics[index]['name'])
            print('pci:',nics[index]['pci_id'])
        else:
            if "man" in nics[index]['name']:
                rules.append(NicNameRule(nics[index]['pci_id'],'man'))
            elif "ha" in nics[index]['name']:
                rules.append(NicNameRule(nics[index]['pci_id'],'ha'))
            else:
                rules.append(NicNameRule(nics[index]['pci_id'], nics[index]['name'], is_data_nic=True))
    for rule in rules:
        print('name: {}, pci_id: {}'.format(rule.name, rule.pci_id))        
    return rules            
    

# get nic card num
def get_cardnum():
    if os.path.exists('/opt/jdwa/etc/cardnum'):
        with io.open('/opt/jdwa/etc/cardnum', 'r') as file:
            return file.readline()
    else:
        with io.open('/opt/jdwa/etc/nic.json') as file:
            nic_conf = json.load(file, encoding='utf-8')
            data_nics=nic_conf['data_nics']
            print("cardnum file not exists")
            print("data nic num:",len(data_nics))
            return len(data_nics)

   
def make_three_sql():
    cardnum = get_cardnum()
    sql = ''
    print('card num:',cardnum)
    nics = ['eth0', 'eth1', 'eth2', 'eth3', 'eth4', 'eth5', 'eth6', 'eth7']
    cardnum_map = {
            'one': 1,
            'two': 2,
            'three': 3,
            'four': 4,
            'five': 5,
            'six': 6,
            }
    num = cardnum_map.get(cardnum)
    if num is not None:
        nics = nics[:num]
    for exchanger_id in [1, 2]:
        for nic in nics:
            sql+="INSERT INTO gap_exchanger_nic (exchanger_id, name, type) VALUES ('{}', '{}', 0);\n".format(exchanger_id, nic)

    sql += 'COMMIT\n'
    with io.open(nic_sql_file, 'w+') as file:
        file.write(unicode(sql, 'utf-8'))
    print('save sql script to update.sql')

    nic_conf = {'tun_nics': tun_nics, 'data_nics': data_nics}
    with io.open(conf_file, 'w+') as file:
        file.write(unicode(json.dumps(nic_conf, indent=2, sort_keys=True), 'utf-8'))



def save_pci_ids(rules):
     pci_ids = []
     pci_names = []
     for rule in rules:
         pci_ids.append(rule.pci_id)
         pci_names.append(rule.name)
     pci_info = {'pci_ids':pci_ids,'pci_names':pci_names}
     with io.open('/opt/jdwa/etc/nic_pci_id.json','w') as file1:
         file1.write(unicode(json.dumps(pci_info, indent=2, sort_keys=True), 'utf-8'))


def compare_nic_pci(rules):
    pci_ids_new = []
    new_rules = rules[:]
    with io.open('/opt/jdwa/etc/nic_pci_id.json','r') as file:
        pci_info = json.load(file, encoding='utf-8')
        pci_ids = pci_info['pci_ids']
        pci_names = pci_info['pci_names']
        print('pci_names:',pci_names)
        for pci_name in pci_names:
            print('pci_name:',pci_name)
            for rule in new_rules:
                if cmp(pci_name,rule.name)==0:
                    print('remove:',rule.name)
                    new_rules.remove(rule)
                    break
    return new_rules

        
if __name__ == '__main__':
    new_rules = []
    cardnum = 0
    addnum = 0
    with io.open('/opt/jdwa/etc/mactype') as file:
        mactype=str(file.read())
    with io.open('/opt/jdwa/etc/systype') as file:
        systype=str(file.read())
    rules = make_nic_rules()
    record_rules = rules[:] 
    save_udev_rules(rules)
    save_nic_conf(rules)
    if os.path.exists('/opt/jdwa/etc/nic_pci_id.json'):
        new_rules = compare_nic_pci(rules)
        if len(new_rules) > 0:
            rules = new_rules
    if mactype == 'three' and systype == 'mid':
        make_three_sql()
    elif systype == 'int':
        make_sql(rules)
    os.system('mv /opt/jdwa/etc/key-tmp /opt/jdwa/etc/key')
    save_pci_ids(record_rules)
    if len(new_rules) > 0:
	os.system("touch /tmp/update_nic.flg")
        print('update nic to sql')
	os.system('echo  updatasql >>  /root/record.txt')


