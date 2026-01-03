# OCaml 5 on Raspberry Pi Pico 2 W

Running OCaml 5 with multicore support on bare-metal Raspberry Pi Pico 2 W (RP2350, ARM Cortex-M33).

Target Hardware: Raspberry Pi Pico 2 W (RP2350, dual ARM Cortex-M33, CYW43 WiFi)
Build Host: Raspberry Pi 5 (ARM64)
OCaml Version: 5.5.0+dev [mtelvers/ocaml](https://github.com/mtelvers/ocaml) arm32-multicore branch

## Features

- Full OCaml 5 runtime with garbage collection
- Standard library support
- Domain.spawn multicore support
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

This builds `ocamlopt.opt` - a compiler that runs on ARM64 but generates ARM32 code with ARMv8-M support.

Verify:
```bash
./ocamlopt.opt -config | grep architecture
# Should show: architecture: arm
```

## Building the Pico Project

### Initial Setup

```bash
git clone https://github.com/mtelvers/pico_ocaml
cd ~/pico-ocaml
mkdir -p build && cd build
PICO_SDK_PATH=~/pico-sdk PICO_BOARD=pico2_w cmake ..
```

### Build Runtime and Stdlib

```bash
make runtime    # Build OCaml runtime library
make stdlib     # Build OCaml standard library
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
# After changing hello.ml only:
make -j4

# After changing ~/ocaml/runtime/* files:
make runtime && make -j4

# After changing ~/ocaml/stdlib/* files:
make stdlib && make -j4
```

## Project Structure

```
pico-ocaml/
├── CMakeLists.txt          # Main build configuration
├── hello.ml                # Main OCaml program
├── net.ml                  # Network module (WiFi, TCP)
├── pio.ml                  # Pio module (effects-based I/O)
├── pico_main.c             # C entry point
├── ocaml_stubs.c           # POSIX stubs for bare-metal
├── ocaml_stubs.h           # Stub header included by runtime
├── pthread.h               # Pthread stub header
├── unistd.h                # POSIX stub header
├── frametables.S           # GC frame table registration
├── memmap_flash.ld         # Custom linker script (code in flash)
├── sys/
│   ├── mman.h              # mmap stub header
│   └── ioctl.h             # ioctl stub header
├── cmake/
│   ├── build_runtime.cmake # Runtime build script
│   └── build_stdlib.cmake  # Stdlib build script
├── lib/
│   ├── ocaml_runtime/      # Built runtime library
│   │   └── libasmrun.a
│   ├── pico_stdlib/        # Built stdlib library
│   │   └── libstdlib_pico.a
│   └── curry.s             # Curry/apply functions
└── build/
    └── ocaml_pico.uf2      # Flashable firmware
```

## Writing OCaml Programs

### Example: LED Blink with Domain.spawn

> On the Pico 2 W, the LED is connected to the WiFi module.

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

  (* Spawn a domain to blink LED *)
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

(* GPIO (for non-W boards) *)
external gpio_init : int -> unit = "ocaml_gpio_init"
external gpio_set_dir_out : int -> unit = "ocaml_gpio_set_dir_out"
external gpio_put : int -> bool -> unit = "ocaml_gpio_put"
```

## Frame Tables

The `frametables.S` file registers GC frame tables for stack walking. Only include modules that are actually used - each reference pulls in that module's frame data:

```asm
caml_frametable:
    .word caml_system.frametable
    .word camlHello.frametable
    .word camlStdlib__Domain.frametable
    .word camlStdlib__Mutex.frametable
    .word camlStdlib__Condition.frametable
    .word camlStdlib__Atomic.frametable
    .word camlStdlib__List.frametable
    .word 0
```

## Troubleshooting

### "inconsistent assumptions over interface Stdlib"
Rebuild the stdlib:
```bash
make stdlib && make -j4
```

### "undefined reference to caml_curry*"
Ensure curry functions are built:
```bash
make stdlib
```

### Link errors about architecture mismatch
Verify all objects are ARMv8-M:
```bash
arm-none-eabi-objdump -f file.o | grep architecture
# Should show: armv8-m.main
```

### RAM overflow
Too many modules in `frametables.S`. Remove unused module references.

## Regenerating curry.s

The `lib/curry.s` file contains the implementations of `caml_curry*`, `caml_apply*`, and `caml_tuplify*` functions. These are runtime support functions for partial application and are generated on-demand by the OCaml compiler during linking.

If you need additional curry/apply arities (e.g., if your code or the stdlib uses functions with more arguments), you need to regenerate curry.s.

### Step 1: Update curry.ml

Edit `lib/curry.ml` to include functions of the arities you need. For example, to get `caml_curry9`, `caml_curry10`, `caml_curry11`:

```ocaml
(* Functions that trigger curry function generation *)
let f9 a b c d e f g h i = a + b + c + d + e + f + g + h + i
let f10 a b c d e f g h i j = a + b + c + d + e + f + g + h + i + j
let f11 a b c d e f g h i j k = a + b + c + d + e + f + g + h + i + j + k

(* Force the compiler to record these arities *)
let _ = f9 1 2 3 4 5 6 7 8 9
let _ = f10 1 2 3 4 5 6 7 8 9 10
let _ = f11 1 2 3 4 5 6 7 8 9 10 11

(* Apply functions through higher-order use *)
let apply9 f = f 1 2 3 4 5 6 7 8 9
let apply10 f = f 1 2 3 4 5 6 7 8 9 10
let apply11 f = f 1 2 3 4 5 6 7 8 9 10 11

let _ = apply9 f9
let _ = apply10 f10
let _ = apply11 f11
```

### Step 2: Compile and Link to Generate Startup Assembly

```bash
cd ~/pico_ocaml/lib

# Compile curry.ml (generates curry.cmx with required arities)
~/ocaml/ocamlopt.opt -I ~/ocaml/stdlib -c -S curry.ml

# Attempt to link - this fails but generates the startup file with curry functions
~/ocaml/ocamlopt.opt -I ~/ocaml/stdlib -dstartup curry.ml 2>/dev/null || true
```

This creates `a.out.startup.s` containing all the curry/apply/tuplify implementations.

### Step 3: Extract and Convert the Functions

```bash
cd ~/pico_ocaml/lib

# Create curry.s with proper header and extracted functions
(
  echo '	.syntax unified'
  echo '	.thumb'
  echo '	.arch armv8-m.main'
  echo '	.fpu softvfp'
  echo ''
  echo '@ OCaml register aliases'
  echo 'alloc_ptr	.req	r10'
  echo 'domain_state_ptr	.req	r11'
  echo 'trap_ptr	.req	r8'
  echo ''
  # Extract from .text before caml_curry11 through end of caml_apply2
  # Find the line numbers for your version - these may differ
  sed -n '79,6220p' a.out.startup.s | sed 's/\.arm/.thumb/g'
) > curry.s

# Clean up
rm -f a.out.startup.s curry.cmx curry.cmi curry.o
```

### Step 4: Verify

```bash
# Check that all needed functions are present
grep -c "\.globl.*caml_curry\|\.globl.*caml_apply\|\.globl.*caml_tuplify" curry.s
# Should show the count of curry/apply/tuplify function declarations
```

### Finding the Correct Line Numbers

The line numbers (79 and 6220 above) depend on your curry.ml content. To find them:

```bash
# Find start: first .globl caml_curry (look for .text before it)
grep -n "\.globl.*caml_curry11$" a.out.startup.s

# Find end: after .size caml_apply2
grep -n "\.size.*caml_apply2" a.out.startup.s
```

Extract from a few lines before the first `.globl caml_curry` (to include `.text` and `.align`) through the `.size caml_apply2` line.

## References

- [Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)
- [OCaml Manual - Native-code compilation](https://ocaml.org/manual/native.html)
- [RP2350 Datasheet](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)
- [ARM Cortex-M33 Technical Reference](https://developer.arm.com/documentation/100230/latest/)

