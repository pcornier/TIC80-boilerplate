
First, edit CART, LINUX and/or ANDROID vars in Makefile.

Then
- run `make data` to extract data from the specified TIC-80 cartridge. You will need csplit.
- run `make` to generate the cartridge with data. The generated cartridge will be copied to the TIC-80 directory.

This project contains a very basic Entity Component System: **libs/ecs.lua**, a messaging system: **libs/bus.lua** and a state manager: **libs/state.lua**.
