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


import argparse
import ctypes
import random
import socket
import struct
import sys


def main():

    #define server parameters
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
    packetO = bytearray()
    packetO += struct.pack("B", 1)
    num1 = 17
    packetO += struct.pack("!L", 17)
    num2 = 38
    packetO += struct.pack("!L", 38)
    packetO += struct.pack("!L", 6)

    name = "Dustin"
    name = name.encode()

    packetO += name
    
    
    
    #packet = struct.pack("B", 5)
    
    #pack and unpack
    #struct.pack("BH", val1, val2)
    #B = 1, H = 2, L = 4
    #(val1, val2) = struct.unpack("BH", raw_bytes)
    # use ! for big endian format


    #pack 'B'
    #packet += (struct.pack("B", 66))

    #pack 7 length of name
    #packet += (struct.pack("B", 101))
    #example on changing whole string to
    #name = "Example"
    #name = name.encode()







    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------

    #send packet
    packetO = s.sendto(packetO, server_address)
    max_bytes = 2750

    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------


    #recieve response
    (packetO, src_addr) = s.recvfrom(max_bytes)



    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s.close()


    # Decode DNS message and display to screen
    print(packetO)
    print("\n")

    protocol = packetO[:1]
    status = packetO[1:3]
    sum = packetO[-4:]

    status = int.from_bytes(status, "big")
    sum = int.from_bytes(sum, "big")
    print(f"status: {status}")
    if status == 1 or status == "1":
        print("Success \n")
    else:
        print("Failure \n")

    print(f"Sum of {num1} and {num2} is {sum} \n")




if __name__ == "__main__":
    sys.exit(main())

