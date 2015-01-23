#!/opt/local/bin/python2.7
import serial, sys

ser = serial.Serial("/dev/tty.usbmodem411", 9600)

if (ser):
    print("Serial port " + ser.portstr + " opened.")

while True:
    sys.stdout.write(ser.read(1) )
    sys.stdout.flush()
