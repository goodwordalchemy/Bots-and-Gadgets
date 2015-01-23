#!/opt/local/bin/python2.7
import serial, gtk, gobject, sys

ser = serial.Serial('/dev/tty.usbmodem411', 9600);

def pollSerial():
	sys.stdout.write(ser.read(1))
	sys.stdout.flush()
	return True

if (ser):
	print("Serial port " + ser.portstr + " opened.")
	gobject.timeout_add(100, pollSerial)

gtk.main()