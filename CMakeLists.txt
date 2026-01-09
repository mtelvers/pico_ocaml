cmake_minimum_required(VERSION 3.13)

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

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# Path to the OCaml cross-compiler
set(OCAML_CROSS_COMPILER "${OCAML_DIR}/ocamlopt.opt")

# ==============================================================================
# OCaml compilation: Single combined object with -output-obj -without-runtime
# This produces one .o file containing all OCaml modules, stdlib, startup code,
# curry/apply functions, frametables, and exception definitions.
# ==============================================================================
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/ocaml_code.o
    COMMAND ${OCAML_CROSS_COMPILER}
            -I ${OCAML_STDLIB_DIR}
            -I ${CMAKE_CURRENT_SOURCE_DIR}
            ${OCAML_STDLIB_DIR}/stdlib.cmxa
            -farch armv8-m.main -ffpu soft -fthumb
            -output-obj -without-runtime
            -o ${CMAKE_CURRENT_BINARY_DIR}/ocaml_code.o
            ${CMAKE_CURRENT_SOURCE_DIR}/net.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/pio.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/hello.ml
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/net.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/pio.ml
            ${CMAKE_CURRENT_SOURCE_DIR}/hello.ml
    COMMENT "Compiling OCaml modules to single object file (net.ml, pio.ml, hello.ml)"
)

# OCaml runtime library (compiled separately)
set(OCAML_RUNTIME_LIB "${CMAKE_CURRENT_SOURCE_DIR}/lib/ocaml_runtime/libasmrun.a")

add_executable(ocaml_pico
    pico_main.c
    ocaml_stubs.c
    net_stubs.c
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

# Add the OCaml combined object and runtime to the link
# pico_cyw43_arch_lwip_poll for WiFi + TCP/IP networking
# Link order: ocaml_code.o (contains all OCaml code + stdlib) -> runtime
target_link_libraries(ocaml_pico
    pico_stdlib
    pico_cyw43_arch_lwip_poll
    pico_multicore
    ${CMAKE_CURRENT_BINARY_DIR}/ocaml_code.o
    ${OCAML_RUNTIME_LIB}
    m
)


# Make sure OCaml object is built before linking
add_custom_target(ocaml_code DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/ocaml_code.o)
add_dependencies(ocaml_pico ocaml_code)

# Enable USB output, disable UART output
pico_enable_stdio_usb(ocaml_pico 1)
pico_enable_stdio_uart(ocaml_pico 0)

# Use custom linker script that puts all code in flash (saves ~92KB RAM)
pico_set_linker_script(ocaml_pico ${CMAKE_CURRENT_SOURCE_DIR}/memmap_flash.ld)

# Create map/bin/hex/uf2 files
pico_add_extra_outputs(ocaml_pico)
