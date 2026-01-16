# OCaml 5 on Raspberry Pi Pico 2 W

Running OCaml 5 with multicore support on bare-metal Raspberry Pi Pico 2 W (RP2350, ARM Cortex-M33).

Target Hardware: Raspberry Pi Pico 2 W (RP2350, dual ARM Cortex-M33, CYW43 WiFi)
Build Host: Raspberry Pi 5 (ARM64)
OCaml Version: 5.5.0+dev [mtelvers/ocaml](https://github.com/mtelvers/ocaml) arm32-multicore branch

## Features

- Full OCaml 5 runtime with garbage collection
- Standard library support
- Domain.spawn multicore support (dual-core)
- Native ARMv8-M code generation
- WiFi networking with TCP/IP (lwIP)
- Pio (effects-based I/O for Pico, following Eio conventions)

## Prerequisites

### Hardware
- Raspberry Pi 5 (or similar ARM64 Linux system) as build host
- Raspberry Pi Pico 2 W connected via USB

### Software

```bash
# Build tools and ARM toolchains
sudo apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib build-essential gcc-arm-linux-gnueabi

# Pico SDK
git clone https://github.com/raspberrypi/pico-sdk.git ~/pico-sdk --branch master --depth 1
cd ~/pico-sdk && git submodule update --init

# Add to ~/.bashrc
export PICO_SDK_PATH="$HOME/pico-sdk"
```

## Building the OCaml Cross-Compiler

### Step 1: Clone OCaml with ARM32 Multicore Support

```bash
git clone https://github.com/mtelvers/ocaml.git ~/ocaml
cd ~/ocaml
git checkout arm32-multicore
```

### Step 2: Build and Install Host Compiler

The cross-compiler build requires a host OCaml compiler of the same version:

```bash
cd ~/ocaml
./configure
make world.opt -j4
sudo make install
```

### Step 3: Build the Cross-Compiler

```bash
cd ~/ocaml
make distclean
./configure --target=arm-linux-gnueabi
make crossopt -j4
```

This builds `ocamlopt.opt` - a compiler that runs on ARM64 but generates ARM32 code.

Verify:
```bash
./ocamlopt.opt -config | grep architecture
# Should show: architecture: arm
```

### Step 4: Rebuild Stdlib with ARMv8-M Architecture

The cross-compiler builds the stdlib with default ARM architecture (ARMv4T), but Pico 2 W requires ARMv8-M. Rebuild the stdlib with the correct flags:

```bash
# Copy the host ocamlrun to boot directory (needed for stdlib build)
cp /usr/local/bin/ocamlrun ~/ocaml/boot/ocamlrun

# Rebuild stdlib with ARMv8-M architecture flags
cd ~/ocaml
make -C stdlib 'OPTCOMPFLAGS=-O3 -farch armv8-m.main -ffpu soft -fthumb' allopt
```

Verify the stdlib has the correct architecture:
```bash
arm-linux-gnueabi-objdump -f ~/ocaml/stdlib/stdlib.a | head -10
# Should show: architecture: armv8-m.main
```

## Building the Pico Project

### Initial Setup

```bash
git clone https://github.com/mtelvers/pico_ocaml
cd ~/pico_ocaml
mkdir -p build && cd build
PICO_SDK_PATH=~/pico-sdk PICO_BOARD=pico2_w cmake ..
```

### Build Runtime

```bash
make runtime    # Build OCaml runtime library (required first time)
```

### Build the UF2 Image

```bash
make -j4
```

Output: `build/ocaml_pico.uf2`

## Flashing to Pico 2 W

1. Hold BOOTSEL button while connecting Pico 2 W via USB
2. It mounts as a USB mass storage device (RP2350)
3. Copy the UF2 file:

```bash
cp build/ocaml_pico.uf2 /media/$USER/RP2350/
```

### View Output

```bash
minicom -D /dev/ttyACM0 -b 115200
```

## Quick Rebuild After Changes

```bash
# After changing OCaml source files (hello.ml, net.ml, pio.ml):
make -j4

# After changing ~/ocaml/runtime/* files:
make runtime && make -j4
```

## Project Structure

```
pico_ocaml/
├── CMakeLists.txt          # Main build configuration
├── hello.ml                # Main OCaml program
├── net.ml                  # Network module (WiFi, TCP)
├── pio.ml                  # Pio module (effects-based I/O)
├── pico_main.c             # C entry point
├── ocaml_stubs.c           # POSIX stubs for bare-metal
├── net_stubs.c             # Network C stubs (lwIP integration)
├── memmap_flash.ld         # Custom linker script (code in flash)
├── lwipopts.h              # lwIP configuration
├── pthread.h               # Pthread stub header
├── unistd.h                # POSIX stub header
├── sys/
│   ├── mman.h              # mmap stub header
│   └── ioctl.h             # ioctl stub header
├── cmake/
│   └── build_runtime.cmake # Runtime build script
├── lib/
│   └── ocaml_runtime/      # Built runtime library
│       └── libasmrun.a
└── build/
    └── ocaml_pico.uf2      # Flashable firmware
```

## Writing OCaml Programs

### Example: Dual-Core with Domain.spawn

```ocaml
external print_endline : string -> unit = "pico_print"
external cyw43_init : unit -> int = "ocaml_cyw43_init"
external cyw43_led_set : bool -> unit = "ocaml_cyw43_led_set"
external sleep_ms : int -> unit = "ocaml_sleep_ms"

let blink_led () =
  for _ = 1 to 5 do
    cyw43_led_set true;
    sleep_ms 200;
    cyw43_led_set false;
    sleep_ms 200
  done

let () =
  print_endline "OCaml 5 on Pico 2 W";
  ignore (cyw43_init ());

  (* Spawn work on second core *)
  let d = Domain.spawn blink_led in
  Domain.join d;

  print_endline "Done!"
```

### Available External Functions

```ocaml
(* Console output *)
external print_endline : string -> unit = "pico_print"
external print_int : int -> unit = "pico_print_int"

(* CYW43 WiFi chip (Pico W / Pico 2 W) *)
external cyw43_init : unit -> int = "ocaml_cyw43_init"
external cyw43_led_set : bool -> unit = "ocaml_cyw43_led_set"

(* Timing *)
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external time_ms : unit -> int = "ocaml_time_ms"

(* GPIO (for non-W boards) *)
external gpio_init : int -> unit = "ocaml_gpio_init"
external gpio_set_dir_out : int -> unit = "ocaml_gpio_set_dir_out"
external gpio_put : int -> bool -> unit = "ocaml_gpio_put"
```

## Troubleshooting

### "inconsistent assumptions over interface Stdlib"
Rebuild the stdlib in ~/ocaml with the correct architecture flags:
```bash
cd ~/ocaml && make -C stdlib clean
make -C stdlib 'OPTCOMPFLAGS=-O3 -farch armv8-m.main -ffpu soft -fthumb' allopt
cd ~/pico_ocaml/build && make -j4
```

### Link errors about architecture mismatch (ARMv8-M vs ARMv4T)
This error occurs when the stdlib was not rebuilt with the correct architecture flags. Fix by rebuilding the stdlib:
```bash
cp /usr/local/bin/ocamlrun ~/ocaml/boot/ocamlrun
cd ~/ocaml && make -C stdlib 'OPTCOMPFLAGS=-O3 -farch armv8-m.main -ffpu soft -fthumb' allopt
cd ~/pico_ocaml/build && make -j4
```

Verify all objects are ARMv8-M:
```bash
arm-linux-gnueabi-objdump -f ~/ocaml/stdlib/stdlib.a | head -10
# Should show: architecture: armv8-m.main
```

### Out of memory at runtime
The Pico 2 W has limited RAM (~404KB available for heap). Reduce memory usage by:
- Using fewer stdlib modules
- Reducing data structure sizes
- The runtime uses 8KB pools for the major heap

## References

- [Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)
- [OCaml Manual - Native-code compilation](https://ocaml.org/manual/native.html)
- [RP2350 Datasheet](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)
- [ARM Cortex-M33 Technical Reference](https://developer.arm.com/documentation/100230/latest/)
