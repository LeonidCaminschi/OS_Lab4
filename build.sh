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
dd if=main.com of=floppy.img bs=512 count=2 seek=1489 conv=notrunc
echo -n -e '\x49\x75\x6C\x79' | dd of=floppy.img bs=1 count=4 seek=763388 conv=notrunc
rm -f main.com