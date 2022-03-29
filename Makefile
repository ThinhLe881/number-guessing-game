all: guessGame.asm
	nasm -f elf64 -F dwarf -g -o guessGame.o guessGame.asm
	gcc -m64 -no-pie -o guessGame.out guessGame.o

clean:
	rm *.out
	rm *.o