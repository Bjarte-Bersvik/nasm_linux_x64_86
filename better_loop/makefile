all: better_loop

.PHONY: all clean

%: %.o
	gcc -no-pie -o $@ $<

%.o: %.asm
	nasm -f elf64 -g -F dwarf $< -l $*.lst
