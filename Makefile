CC=clang
LD=clang
AS=yasm
ASFLAGS=-f elf64 -g dwarf2
CFLAGS=-c -g
LDFLAGS=
TARGETS=main struc_test c_test
BIN=$(addprefix bin/, $(TARGETS))

.PHONY: clean
all: $(BIN)

bin/main: build/main.o
	$(LD) $^ -o $@

bin/struc_test: build/struc_test.o build/vec3.o
	$(LD) $< -o $@

bin/c_test: build/c_test.o build/vec3.o
	$(LD) $^ -o $@

build/%.o: src/%.asm
	$(AS) $(ASFLAGS) $< -o $@

build/%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f build/* bin/*
