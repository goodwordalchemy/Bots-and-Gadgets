#!/opt/local/bin/python2.7
import gtk, os, pygtk
pygtk.require('2.0')

window = gtk.Window()
window.connect("destroy", gtk.main_quit)

image = gtk.Image()
window.add(image)
image.set_from_file(os.path.join("data", "image1.jpg"))

window.show_all()
gtk.main()