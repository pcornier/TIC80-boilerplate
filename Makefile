
CART = cart.lua
ANDROID = /storage/emulated/0/Android/data/com.nesbox.tic/files/TIC-80
LINUX = ~/.local/share/com.nesbox.tic/TIC-80

ifeq (Android,$(shell uname -o))
	TICDIR = $(ANDROID)
else
	TICDIR = $(LINUX)
endif

META = src/_meta.lua
LIBS = src/libs/*.lua
OBJS = $(shell find src/objs/ -name '*.lua')
MAIN = src/main.lua

.PHONY: $(CART)

$(CART): $(META) $(LIBS) $(OBJS) $(MAIN)
	@cat $^ > $@
	@if [ -f 'xx01' ]; then cat xx01 >> $@; fi
	@cp ./$(CART) $(TICDIR)/$(CART)

data:
	@csplit -q $(TICDIR)/$(CART) "/-- <TILES>/" && rm xx00
