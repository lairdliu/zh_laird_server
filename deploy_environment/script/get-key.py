from __future__ import print_function
import io
import os
import hashlib
import argparse
import sys
import json
class Motherboard(object):
    '''
    Motherboard contains motherboard info
    '''
    def __init__(self):
        self.board_name = ''
        self.board_vendor = ''
        self.board_version = ''

def read_file_as_str(file_name):
    '''
    read file's whole content as string
    '''
    with io.open(file_name) as file:
        return str(file.read())

def get_mother_board():
    '''
    get motherboard info
    '''
    motherboard = Motherboard()
    motherboard.board_name = read_file_as_str('/sys/class/dmi/id/board_name')
    motherboard.board_vendor = read_file_as_str('/sys/class/dmi/id/board_vendor')
    motherboard.board_version = read_file_as_str('/sys/class/dmi/id/board_version')
    return motherboard

class NicInfo(object):
    def __init__(self):
        self.nic = ''
        self.pic_id = ''
        
def get_pci_ids():
    pipe_net = os.popen('''sh -c "lspci | grep -i net | awk '{print \$1}'"''')
    pci_ids_net = pipe_net.read().split()
    pci_info_net='pci_ids_net:'
    for pci_id in pci_ids_net:
        pci_info_net_tmp=pci_info_net+pci_id+','
        pci_info_net=pci_info_net_tmp
        
    pipe_firewire = os.popen('''sh -c "lspci | grep -i firewire | awk '{print \$1}'"''')
    pci_ids_firewire = pipe_firewire.read().split()
    pci_info_firewire='pci_ids_firewire:'
    if len(pci_ids_firewire) > 0:
        for pci_id1 in pci_ids_firewire:
            pci_info_firewire_tmp=pci_info_firewire+','+pci_id1
            pci_info_firewire=pci_info_firewire_tmp
        pci_info=pci_info_net+pci_info_firewire
        print('pci ids firewire:', pci_ids_firewire)
    else:
        pci_info=pci_info_net
        
    print('pci info:', pci_info)
    return pci_info
   
def store(data):
    with open('data.json', 'w') as json_file:
        json_file.write(json.dumps(data))
    
if __name__ == '__main__':
    with io.open('/opt/jdwa/etc/mactype') as file:
        machine_type=str(file.read())
    with io.open('/opt/jdwa/etc/systype') as file:
        systype=str(file.read())
    with io.open('/opt/jdwa/etc/oem') as file:
        oem=str(file.read())
    print("systype:",systype)
    print("mac:",machine_type)
    print("oem:",oem)
    board=get_mother_board()
    pci_info=get_pci_ids()
    board_info=board.board_name+board.board_version+board.board_vendor
    if oem == 'H3C':
        info=pci_info+' board_info:'+board_info+' systype:'+systype+' machine_type:'+machine_type+' oem:'+oem
    else:
        info=pci_info+' board_info:'+board_info+' systype:'+systype+' machine_type:'+machine_type
    #m = hashlib.md5()
    #m.update(info)
    #psw = m.hexdigest()
    
    file=open('/opt/jdwa/etc/key-tmp','w')  
    file.write(info)
    file.close()   
    print("mac keys:",info)