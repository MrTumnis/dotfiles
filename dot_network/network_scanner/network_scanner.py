#! /usr/bin/etc/ver python
import optparse

import scapy.all as scapy
import argparse

def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--target", dest="target", help="ip of target")
    options = parser.parse_args()
    return options

def scan(ip):
    arp_request = scapy.ARP(pdst=ip)
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_request_broadcast = broadcast/arp_request
    answered_list = scapy.srp(arp_request_broadcast, timeout=1, verbose=False)[0] #Using a list (answered_list) and telling the program to only show index 1 [0]
    clients_list = []
    # using a FOR loop, define a variable (element) and IN that list, list the index's one by one
    for element in answered_list:
        client_dict = {"ip":element[1].psrc, "mac": element[1].hwsrc}
        clients_list.append(client_dict)
        # .show() to show the packet info
    return clients_list

def print_result(results_list):
    print("IP\t\t\tMAC Address\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    for client in results_list:
        print(client["ip"] + "\t\t" + client["mac"])

options = get_arguments()
scan_result = scan(options.target)
print_result(scan_result)