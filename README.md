# ArcticAxis
A simple OS

## Install
```
sudo apt update
sudo apt install make nasm qemu
snap install micro --classic
sudo apt-get install mtools
sudo apt install qemu-system-x86
```

## Build
```
make && qemu-system-i386 -fda build/main_floppy.img
```