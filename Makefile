.PHONY: all clean build flash

TARGET_DIR=target/avr-atmega328p/release
TARGET_ELF=${TARGET_DIR}/blink.elf
FLASH_DIR=/mnt/downloads

all: build

clean:
	rm -f ${TARGET_ELF}

build: export AVR_CPU_FREQUENCY_HZ = 16000000
build:
	cargo +nightly build -Z build-std=core --target avr-atmega328p.json --release

# prerequisite: install avrdude for Windows [here](https://github.com/avrdudes/avrdude/releases)
# make sure the binary is available in WSL path
flash: build
	cp ${TARGET_ELF} ${FLASH_DIR}/flash.elf
	cd ${FLASH_DIR} && avrdude.exe -patmega328p -carduino -PCOM3 -b115200 -D -Uflash:w:flash.elf:e
	rm -f ${FLASH_DIR}/flash.elf
