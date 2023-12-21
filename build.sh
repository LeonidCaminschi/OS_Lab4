#!/bin/bash

rm -f floppy.img

nasm -f bin -o 1s_bootloader.com 1s_bootloader.asm
truncate -s 1474560 1s_bootloader.com
mv 1s_bootloader.com floppy.img

nasm -f bin -o 2s_bootloader.com 2s_bootloader.asm
dd if=2s_bootloader.com of=floppy.img bs=512 count=2 seek=1 conv=notrunc
echo -n -e '\x46\x46' | dd of=floppy.img bs=1 count=2 seek=1534 conv=notrunc
rm -f 2s_bootloader.com

nasm -f bin -o main.com test.asm
dd if=main.com of=floppy.img bs=512 count=2 seek=444 conv=notrunc
echo -n -e '\x41\x4d\x4f\x47\x55\x53' | dd of=floppy.img bs=1 count=6 seek=228346 conv=notrunc
rm -f main.com