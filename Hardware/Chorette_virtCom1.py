'''

Author: Nicholas Chorette
Date Edited: 10/23/2022
Purpose: Sends and recieves data on the virtual COM port '/dev/pts/3' (this is subject to change later).
This was Origionally developed to talk to an ACTUAL physical COM port, however, this works just as well
for virtual COM ports as well. :) 

Please note this code is simply test code to make sure (manually) things are working as they should for
both real and virutal COM ports alike. Please keep in mind this code was origionally developed to send a
serial message to an Arduino Uno and the Uno would, upon recieving the message, reply back to the Pi, to
ensure it got the data it needed. 

'''
import os
import serial
import time

virtCom = serial.Serial(port='/dev/pts/3', baudrate=115200, timeout=1)
def write_read(x):
    virtCom.write(bytes(x, 'utf-8'))
    time.sleep(0.05)
    data = virtCom.readline()
    return data
while True:
    num = input("Enter a number: ") # Taking input from user
    value = write_read(num)
    print(value) # printing the value


