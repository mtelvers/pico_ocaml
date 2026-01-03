cmake_minimum_required(VERSION 3.13)

# Increase heap size for OCaml runtime BEFORE SDK init (default is only 2KB!)
# Must use add_compile_definitions to affect crt0.S
# Heap must fit before stack at 0x20080000, currently starts at 0x2001f5f8
add_compile_definitions(PICO_HEAP_SIZE=409600)  # 400KB heap - reduced for lwIP networking

# Initialize the SDK based on PICO_SDK_PATH
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(ocaml_pico C CXX ASM)

# ==============================================================================
# OCaml paths
# ==============================================================================
set(OCAML_DIR "$ENV{HOME}/ocaml")
set(OCAML_RUNTIME_DIR "${OCAML_DIR}/runtime")
set(OCAML_STDLIB_DIR "${OCAML_DIR}/stdlib")

# ==============================================================================
# Target: runtime - builds libasmrun.a from OCaml runtime sources
# ==============================================================================
set(RUNTIME_OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/ocaml_runtime")

add_custom_target(runtime
    COMMAND ${CMAKE_COMMAND} -E echo "=== Building OCaml runtime for Pico 2 W ==="
    COMMAND ${CMAKE_COMMAND}
        -DOCAML_RUNTIME_DIR=${OCAML_RUNTIME_DIR}
        -DOUTPUT_DIR=${RUNTIME_OUTPUT_DIR}
        -DPROJECT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
        -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/build_runtime.cmake
    COMMENT "Building OCaml runtime library"
    VERBATIM
)

# ==============================================================================
# Target: stdlib - builds libstdlib_pico.a from OCaml stdlib
# ==============================================================================
set(STDLIB_OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/pico_stdlib")

add_custom_target(stdlib
    COMMAND ${CMAKE_COMMAND} -E echo "=== Building OCaml stdlib for Pico 2 W ==="
    COMMAND ${CMAKE_COMMAND}
        -DOCAML_STDLIB_DIR=${OCAML_STDLIB_DIR}
        -DOUTPUT_DIR=${STDLIB_OUTPUT_DIR}
        -DPROJECT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
        -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/build_stdlib.cmake
    COMMENT "Building OCaml stdlib library"
    VERBATIM
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# Path to the OCaml cross-compiler
set(OCAML_CROSS_COMPILER "${OCAML_DIR}/ocamlopt.opt")

# ==============================================================================
# OCaml compilation: net.ml (Network effects module)
# ==============================================================================
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/net.s
           ${CMAKE_CURRENT_SOURCE_DIR}/net.cmi
           ${CMAKE_CURRENT_SOURCE_DIR}/net.cmx
    COMMAND ${OCAML_CROSS_COMPILER}
            -I ${OCAML_STDLIB_DIR}
            ${OCAML_STDLIB_DIR}/stdlib.cmxa
            -farch armv8-m.main -ffpu soft -fthumb
            -S -c ${CMAKE_CURRENT_SOURCE_DIR}/net.ml
    COMMAND mv ${CMAKE_CURRENT_SOURCE_DIR}/net.s ${CMAKE_CURRENT_BINARY_DIR}/net.s
    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/net.o
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/net.ml
    COMMENT "Compiling net.ml to Cortex-M33 assembly"
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/net.o
    COMMAND arm-none-eabi-as
            -march=armv8-m.main
            -mthumb
            ${CMAKE_CURRENT_BINARY_DIR}/net.s
            -o ${CMAKE_CURRENT_BINARY_DIR}/net.o
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/net.s
    COMMENT "Assembling net.o for Cortex-M33"
)

# ==============================================================================
# OCaml compilation: pio.ml (Fiber scheduler, imports Net)
# ==============================================================================
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/pio.s
           ${CMAKE_CURRENT_SOURCE_DIR}/pio.cmi
           ${CMAKE_CURRENT_SOURCE_DIR}/pio.cmx
    COMMAND ${OCAML_CROSS_COMPILER}
            -I ${OCAML_STDLIB_DIR}
            -I ${CMAKE_CURRENT_SOURCE_DIR}
            ${OCAML_STDLIB_DIR}/stdlib.cmxa
            -farch armv8-m.main -ffpu soft -fthumb
            -S -c ${CMAKE_CURRENT_SOURCE_DIR}/pio.ml
    COMMAND mv ${CMAKE_CURRENT_SOURCE_DIR}/pio.s ${CMAKE_CURRENT_BINARY_DIR}/pio.s
    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/pio.o
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/pio.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/net.cmi
    COMMENT "Compiling pio.ml to Cortex-M33 assembly (with Net module)"
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/pio.o
    COMMAND arm-none-eabi-as
            -march=armv8-m.main
            -mthumb
            ${CMAKE_CURRENT_BINARY_DIR}/pio.s
            -o ${CMAKE_CURRENT_BINARY_DIR}/pio.o
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/pio.s
    COMMENT "Assembling pio.o for Cortex-M33"
)

# ==============================================================================
# OCaml compilation: hello.ml (Main application, imports Net and Pio)
# ==============================================================================
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/hello.s
    COMMAND ${OCAML_CROSS_COMPILER}
            -I ${OCAML_STDLIB_DIR}
            -I ${CMAKE_CURRENT_SOURCE_DIR}
            ${OCAML_STDLIB_DIR}/stdlib.cmxa
            -farch armv8-m.main -ffpu soft -fthumb
            -S -c ${CMAKE_CURRENT_SOURCE_DIR}/hello.ml
    COMMAND mv ${CMAKE_CURRENT_SOURCE_DIR}/hello.s ${CMAKE_CURRENT_BINARY_DIR}/hello.s
    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/hello.o
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/hello.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/net.cmi
            ${CMAKE_CURRENT_SOURCE_DIR}/pio.cmi
    COMMENT "Compiling hello.ml to Cortex-M33 assembly (with Net and Pio modules)"
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/hello.o
    COMMAND arm-none-eabi-as
            -march=armv8-m.main
            -mthumb
            ${CMAKE_CURRENT_BINARY_DIR}/hello.s
            -o ${CMAKE_CURRENT_BINARY_DIR}/hello.o
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/hello.s
    COMMENT "Assembling hello.o for Cortex-M33"
)

# OCaml runtime library (compiled separately)
set(OCAML_RUNTIME_LIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/ocaml_runtime/libasmrun.a")

# OCaml stdlib library (compiled for Cortex-M33)
set(OCAML_STDLIB_LIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/pico_stdlib/libstdlib_pico.a")

# Add executable
add_executable(ocaml_pico
    pico_main.c
    ocaml_stubs.c
    net_stubs.c
    frametables.S
)

# Include paths for OCaml headers
target_include_directories(ocaml_pico PRIVATE
    ${OCAML_RUNTIME_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# Compile definitions
target_compile_definitions(ocaml_pico PRIVATE
    NATIVE_CODE
    TARGET_arm
    CAML_NAME_SPACE
)

# Add the OCaml object files and runtime to the link
# pico_cyw43_arch_lwip_poll for WiFi + TCP/IP networking
# Link order: hello.o -> pio.o -> net.o -> stdlib -> runtime
target_link_libraries(ocaml_pico
    pico_stdlib
    pico_cyw43_arch_lwip_poll
    pico_multicore
    ${CMAKE_CURRENT_BINARY_DIR}/hello.o
    ${CMAKE_CURRENT_BINARY_DIR}/pio.o
    ${CMAKE_CURRENT_BINARY_DIR}/net.o
    ${OCAML_STDLIB_LIB}
    ${OCAML_RUNTIME_LIB}
    ${OCAML_STDLIB_LIB}
    m
)

# Make sure OCaml objects are built before linking
add_custom_target(ocaml_net DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/net.o)
add_custom_target(ocaml_pio DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/pio.o)
add_custom_target(ocaml_hello DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/hello.o)
add_dependencies(ocaml_pio ocaml_net)
add_dependencies(ocaml_hello ocaml_pio)
add_dependencies(ocaml_pico ocaml_hello)

# Enable USB output, disable UART output
pico_enable_stdio_usb(ocaml_pico 1)
pico_enable_stdio_uart(ocaml_pico 0)

# Use custom linker script that puts all code in flash (saves ~92KB RAM)
pico_set_linker_script(ocaml_pico ${CMAKE_CURRENT_SOURCE_DIR}/memmap_flash.ld)

# Create map/bin/hex/uf2 files
pico_add_extra_outputs(ocaml_pico)
