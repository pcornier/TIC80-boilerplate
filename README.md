
First, edit Makefile and adjust these 3 parameters:
- CART: the name of you cartridge
- LINUX: the path to the TIC-80 directory if you are using Linux
- ANDROID: the path to the TIC-80 directory if you are using Android

There's no WINDOWS parameter currently but feel free to fork the repo!

Then
- run `make data` to extract data from the TIC-80 cartridge. You will need to install `csplit`, which is part of `coreutils` package.
- run `make` to generate the cartridge with data. The generated cartridge will be copied to the TIC-80 directory.

This project contains:
- a very basic Entity Component System: **libs/ecs.lua**
- a messaging system: **libs/bus.lua**
- a state manager: **libs/state.lua**

There's a small demo project there: https://github.com/pcornier/tic80-mini-platformer

On Android, I recommand the two apps Termux and DroidEdit. Termux will provide you with the two linux commands `make`and `csplit`. DroidEdit is a nice little code editor that can connect Termux through ssh in order to trigger the `make` command remotely!
