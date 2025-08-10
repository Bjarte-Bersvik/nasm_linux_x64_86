all: stack

.PHONY: all clean

%: %.o
	gcc -no-pie -o $@ $< -g

%.o: %.asm
	nasm -f elf64 -g -F dwarf $< -l $*.lst
