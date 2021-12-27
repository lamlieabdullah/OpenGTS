#!/usr/bin/env python
#####
#
# Read GPS nmea and save to file
# crontab -e
# @reboot sh /boot/gps.sh
#
# gps.sh
#   #!/bin/sh
#   sudo python /boot/logger.py
#
#
# https://www.instructables.com/Raspberry-Pi-GPS-Logger/
# https://github.com/postronium/raspberry-pi-gps-logger
######

import os
import datetime
import serial
import time
import io
from time import sleep

#configure serial
ser = serial.Serial('/dev/ttyUSB0',4800, timeout=1)
sio = io.TextIOWrapper(io.BufferedRWPair(ser, ser, 1), encoding='ascii', newline='\r')

while True:
    time.sleep(0.05)

    #start recording GPS data
    print("recording")

    #define output file
    millis = int(round(time.time() * 1000))
    #outfile='/boot/gps-recording-'+str(millis)+'.nmea'
    outfile='/boot/gps-log/gps-recording-'+str(millis)+'.nmea'

    is_running = True

    with open(outfile,'a') as f:
        while is_running:
            time.sleep(0.05)
            datastring = sio.readline()
            f.write(datastring)       #+ '\n' is new line
            f.flush()                                    #write data to disk
            print(datastring)
