# CMake script to build OCaml stdlib for Pico 2 W (ARM Cortex-M33)
# Usage: cmake -DOCAML_STDLIB_DIR=... -DOUTPUT_DIR=... -DPROJECT_DIR=... -P build_stdlib.cmake

message(STATUS "Building OCaml stdlib from ${OCAML_STDLIB_DIR}")

# Build stdlib with OCaml's make system
message(STATUS "Running: make -C stdlib clean")
execute_process(
    COMMAND make -C ${OCAML_STDLIB_DIR} clean
    RESULT_VARIABLE result
)

message(STATUS "Running: make -C stdlib allopt (ARMv8-M, soft float)")
execute_process(
    COMMAND make -C ${OCAML_STDLIB_DIR}
        "OCAMLRUN=ocamlrun"
        "OPTCOMPFLAGS=-O3 -farch armv8-m.main -ffpu soft -fthumb"
        allopt
    RESULT_VARIABLE result
)
if(NOT result EQUAL 0)
    message(FATAL_ERROR "Failed to build stdlib")
endif()

# Create output directory
file(REMOVE_RECURSE "${OUTPUT_DIR}")
file(MAKE_DIRECTORY "${OUTPUT_DIR}")

# Copy stdlib object files
file(GLOB STDLIB_OBJS "${OCAML_STDLIB_DIR}/stdlib*.o")
file(GLOB CAML_OBJS "${OCAML_STDLIB_DIR}/camlintern*.o")
file(COPY ${STDLIB_OBJS} DESTINATION "${OUTPUT_DIR}")
file(COPY ${CAML_OBJS} DESTINATION "${OUTPUT_DIR}")
file(COPY "${OCAML_STDLIB_DIR}/std_exit.o" DESTINATION "${OUTPUT_DIR}")

# Assemble curry functions
message(STATUS "Assembling curry functions...")
execute_process(
    COMMAND arm-none-eabi-as -march=armv8-m.main -mthumb
        ${PROJECT_DIR}/lib/curry.s
        -o ${OUTPUT_DIR}/curry_functions.o
    RESULT_VARIABLE result
)

# Create archive
file(GLOB OBJ_FILES "${OUTPUT_DIR}/*.o")
list(LENGTH OBJ_FILES obj_count)
execute_process(
    COMMAND arm-none-eabi-ar rcs ${OUTPUT_DIR}/libstdlib_pico.a ${OBJ_FILES}
)
message(STATUS "Built: ${OUTPUT_DIR}/libstdlib_pico.a (${obj_count} objects)")
