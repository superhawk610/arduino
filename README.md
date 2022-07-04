# blink

Blink the built-in status light.

## Build

To generate the target description `avr-atmega328p.json`:

```
rustc +nightly --print target-spec-json -Z unstable-options --target avr-unknown-gnu-atmega328 > avr-atmega328p.json
```

then remove `is-builtin` and change `cpu` and `-mmcu` to `atmega328p` (add the
`p`).

Then, to build:

```
AVR_CPU_FREQUENCY_HZ=16000000 cargo +nightly build -Z build-std=core --target avr-atmega328p.json --release
```

CPU is 16MHz, hence the value for `AVR_CPU_FREQUENCY_HZ`.

## Flash

On WSL2, it appears that COMX is available at /dev/ttySX, e.g.

```
COM3
/dev/ttyS3
```

To flash after building the `.elf`:

```
avrdude -patmega328p -carduino -P/dev/ttyS3 -b115200 -D -Uflash:w:target/avr-atmega328p/release/blink.elf:e
```

Since USB support on WSL2 is [currently lacking](https://github.com/microsoft/WSL/issues/4322),
the easiest solution to flash on Windows is to install `avrdude` for Windows,
build the `.elf` on WSL, then flash from Windows (you can reference the Windows
`.exe` directly).

```
/mnt/../avrdude.exe -patmega328p -carduino -PCOM3 -b115200 -D -Uflash:w:target/avr-atmega328p/release/blink.elf:e
```
