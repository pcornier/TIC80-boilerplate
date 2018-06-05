
First, edit CART, LINUX and/or ANDROID vars in Makefile.

Then
- run `make data` to extract data from the specified TIC-80 cartridge. You will need csplit.
- run `make` to generate the cartridge with data. The generated cartridge will be copied to the TIC-80 directory.


