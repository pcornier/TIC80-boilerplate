# Python Make file for Windows
# If you already started to create some gfx or sounds/music in TIC-80,
# then remember to export your cart in .lua format (PRO version) by saving
# your cart in .lua format from TIC-80.
# > save mygame.lua
# Then go to your terminal and cd in your project and extract the "data"
# section of the cartridge with:
# $ make.py data
# This will generate a xx01 file.
# Do your work in you favorite code editor then compile your files with:
# $ make.py
# This will create the new cartride. It will be automatically copied to
# the TIC-80 directory.
# And remember to regenerate the xx01 file regularly!

import sys, os, glob, re
from shutil import copyfile

CART = 'cart.lua'
TICPATH = os.getenv('APPDATA') + '\\com.nesbox.tic\\TIC-80'
META = 'src\\_meta.lua'
LIBS = 'src\\libs\\*.lua'
OBJS = 'src\\objs\\*.lua'
MAIN = 'src\\main.lua'


if len(sys.argv) > 1:
  if sys.argv[1] == "data":
    cart_path = TICPATH + '\\' + CART
    if os.path.exists(cart_path):
      file = open(cart_path)
      data = file.read()
      file.close()
      result = re.findall("(.+?)(--..TILES.+)", data, re.MULTILINE|re.DOTALL)
      if result[0][1]:
        with open('xx01', 'w') as outfile:
          outfile.write(result[0][1])

else:    
  if os.path.exists(CART):
    os.remove(CART)

  with open(CART, 'w') as outfile:

    with open(META) as infile:
      outfile.write(infile.read())

    for filename in glob.glob(LIBS):
      with open(filename) as infile:
        outfile.write(infile.read())

    for filename in glob.glob(OBJS):
      with open(filename) as infile:
        outfile.write(infile.read())

    with open(MAIN) as infile:
      outfile.write(infile.read())


    if os.path.exists('xx01'):
      with open('xx01') as infile:
        outfile.write(infile.read())

    copyfile(CART, TICPATH + '\\' + CART)
  
