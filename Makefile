build:
	clang -Wall -Wextra -c ./src/*.c -I ./include -L ./lib -lraylib -lm -o demo
run:
	./demo
clean:
	rm -f ./demo
