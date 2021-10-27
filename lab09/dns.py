#!/usr/bin/env python3

# Python DNS query client
#
# Example usage:
#   ./dns.py --type=A --name=www.pacific.edu --server=8.8.8.8
#   ./dns.py --type=AAAA --name=www.google.com --server=8.8.8.8

# Should provide equivalent results to:
#   dig www.pacific.edu A @8.8.8.8 +noedns
#   dig www.google.com AAAA @8.8.8.8 +noedns
#   (note that the +noedns option is used to disable the pseduo-OPT
#    header that dig adds. Our Python DNS client does not need
#    to produce that optional, more modern header)


from dns_tools import dns, dns_header_bitfields  # Custom module for boilerplate code

import argparse
import ctypes
import random
import socket
import struct
import sys


def main():

    # Setup configuration
    parser = argparse.ArgumentParser(description='DNS client for ECPE 170')
    parser.add_argument('--type', action='store', dest='qtype',
                        required=True, help='Query Type (A or AAAA)')
    parser.add_argument('--name', action='store', dest='qname',
                        required=True, help='Query Name')
    parser.add_argument('--server', action='store', dest='server_ip',
                        required=True, help='DNS Server IP')

    args = parser.parse_args()
    qtype = args.qtype
    qname = args.qname
    server_ip = args.server_ip
    port = 53
    server_address = (server_ip, port)

    if qtype not in ("A", "AAAA"):
        print("Error: Query Type must be 'A' (IPv4) or 'AAAA' (IPv6)")
        sys.exit()

    # Create UDP socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Generate DNS request message
    # ---------
    # STUDENT TO-DO
    # ---------
    raw_bytes = bytearray()
    if qtype == 'A':
        qtype = 1
    else: 
        qtype = 28
        # 0 28
    
    #pack and unpack
    #struct.pack("BH", val1, val2)
    #B = 1, H = 2, L = 4
    #(val1, val2) = struct.unpack("BH", raw_bytes)
    # use ! for big endian format


    flags = dns_header_bitfields()
    flags.qr = 0
    flags.opcode = 0
    flags.aa = 0
    flags.tc = 0
    flags.rd = 1
    flags.ra = 0
    flags.reserve = 2
    flags.rcode = 0

    Q = 1
    Ans = 0
    Auth = 0
    Add = 0


    name = qname.split('.')
    raw_name = bytearray()
    for i in name:
        #print(len(name[i]))
        raw_name += struct.pack("!B", len(i))
        piece = i.encode()
        raw_name += piece
    raw_name += struct.pack("!B", 0)
    messageId = struct.pack("!H", random.randrange(0, 65535, 1))
    #messageID
    raw_bytes += (messageId)
    #Flags
    raw_bytes += bytes(flags)
    #QDCount
    raw_bytes += (struct.pack("!H", Q))
    #ANCount
    raw_bytes += (struct.pack("!H", Ans))
    #NSCount
    raw_bytes += (struct.pack("!H", Auth))
    #ARCount
    raw_bytes += (struct.pack("!H", Add))
    #Qname
    raw_bytes += (raw_name)
    #QType
    raw_bytes += (struct.pack("!H", qtype))
    #QClass
    raw_bytes += (struct.pack("!H", 1))






    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    bytes_sent = s.sendto(raw_bytes, server_address)
    max_bytes = 4096

    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    (raw_bytes, src_addr) = s.recvfrom(max_bytes)



    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s.close()


    # Decode DNS message and display to screen
    print(repr(dns.decode_dns(raw_bytes)))


if __name__ == "__main__":
    sys.exit(main())
