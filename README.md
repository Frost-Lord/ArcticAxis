# ArcticAxis
ArcticAxis is a minimal operating system written in 16-bit x86 Assembly. It features a simple shell interface where you can run basic commands like help, clear, and reboot.

<img src="./imgs/2023-09-01 18-43-54.png">

## Install
To get started with ArcticAxis, you'll need to install several packages including make, nasm, qemu, and micro.
```
sudo apt update
sudo apt install make nasm qemu cargo
snap install micro --classic
sudo apt-get install mtools
sudo apt install qemu-system-x86
```

## Build
After installing the required packages, you can build and run ArcticAxis using the following commands:
```
make && qemu-system-i386 -fda build/main_floppy.img
```
This will compile the assembly files and generate a floppy disk image, which will then be run using QEMU.

## Features
- Written entirely in 16-bit x86 Assembly
- Simple shell interface
- Basic commands like help, clear, and reboot

## Contributing
If you'd like to contribute, please fork the repository and create a new branch, commit your changes, and then submit a pull request.
