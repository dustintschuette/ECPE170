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

    server_ip = "10.10.4.50"
    port = 3456
    server_address = (server_ip, port)

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
    
    #pack and unpack
    #struct.pack("BH", val1, val2)
    #B = 1, H = 2, L = 4
    #(val1, val2) = struct.unpack("BH", raw_bytes)
    # use ! for big endian format


    #pack 'B'
    raw_bytes += (struct.pack("B", 66))
    #pack 3
    raw_bytes += (struct.pack("!B", 3))

    #pack 6 length of name
    raw_bytes += (struct.pack("B", 6))
    name = "Dustin"
    name = name.encode()
    raw_bytes += name
    raw_bytes += (struct.pack("B", 100))
    raw_bytes += (struct.pack("B", 115))







    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    bytes_sent = s.sendto(raw_bytes, server_address)
    max_bytes = 2500

    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    raw_bytes = s.recvfrom(max_bytes)



    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s.close()


    # Decode DNS message and display to screen
    print(raw_bytes)
    raw_bytes.decode()


if __name__ == "__main__":
    sys.exit(main())
