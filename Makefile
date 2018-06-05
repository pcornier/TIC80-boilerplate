
CART = cart.lua

ifeq (Android,$(shell uname -o))
	TICDIR = /storage/emulated/0/Android/data/com.nesbox.tic/files/TIC-80
else
	TICDIR = /home/pcornier/.local/share/com.nesbox.tic/TIC-80
endif

META = src/_meta.lua
LIBS = src/libs/*.lua
OBJS = $(shell find src/objs/ -name '*.lua')
MAIN = src/main.lua


$(CART): $(META) $(LIBS) $(OBJS) $(MAIN)
	@cat $^ > $@
	@if [ -f 'xx01' ]; then cat xx01 >> $@; fi
	@cp ./$(CART) $(TICDIR)/$(CART)

data:
	@csplit -q $(TICDIR)/$(CART) "/-- <TILES>/" && rm xx00
