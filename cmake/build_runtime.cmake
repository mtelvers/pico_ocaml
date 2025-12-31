# CMake script to build OCaml runtime for Pico 2 W (ARM Cortex-M33)
# Usage: cmake -DOCAML_RUNTIME_DIR=... -DOUTPUT_DIR=... -DPROJECT_DIR=... -P build_runtime.cmake

message(STATUS "Building OCaml runtime from ${OCAML_RUNTIME_DIR}")

# Clean and create output directory
file(REMOVE_RECURSE "${OUTPUT_DIR}")
file(MAKE_DIRECTORY "${OUTPUT_DIR}")

# Get list of C files
file(GLOB C_FILES "${OCAML_RUNTIME_DIR}/*.c")

# Compile each C file
set(compiled 0)
foreach(src ${C_FILES})
    get_filename_component(name ${src} NAME_WE)
    execute_process(
        COMMAND arm-none-eabi-gcc -c ${src}
            -I${OCAML_RUNTIME_DIR}
            -I${PROJECT_DIR}
            -include ocaml_stubs.h
            -DNATIVE_CODE -DTARGET_arm -DCAML_NAME_SPACE -DIO_BUFFER_SIZE=4096
            -march=armv8-m.main -mthumb -O2
            -o ${OUTPUT_DIR}/${name}.o
        RESULT_VARIABLE result
        ERROR_QUIET
    )
    if(EXISTS "${OUTPUT_DIR}/${name}.o")
        math(EXPR compiled "${compiled} + 1")
    endif()
endforeach()
message(STATUS "Compiled ${compiled} C files")

# Compile arm.S with ARMv8-M model
message(STATUS "Compiling arm.S...")
execute_process(
    COMMAND arm-none-eabi-gcc -c ${OCAML_RUNTIME_DIR}/arm.S
        -I${OCAML_RUNTIME_DIR}
        -DSYS_linux_eabihf -DMODEL_armv8m -DNATIVE_CODE -DTARGET_arm
        -march=armv8-m.main -mthumb
        -o ${OUTPUT_DIR}/arm.o
    RESULT_VARIABLE result
)
if(result EQUAL 0)
    message(STATUS "OK: arm.S")
else()
    message(WARNING "FAILED: arm.S (${result})")
endif()

# Remove conflicting/unwanted files
file(REMOVE
    "${OUTPUT_DIR}/startup_aux.o"
    "${OUTPUT_DIR}/fail_byt.o"
    "${OUTPUT_DIR}/backtrace_byt.o"
    "${OUTPUT_DIR}/misc.o"
)

# Create archive
file(GLOB OBJ_FILES "${OUTPUT_DIR}/*.o")
list(LENGTH OBJ_FILES obj_count)
execute_process(
    COMMAND arm-none-eabi-ar rcs ${OUTPUT_DIR}/libasmrun.a ${OBJ_FILES}
)
message(STATUS "Built: ${OUTPUT_DIR}/libasmrun.a (${obj_count} objects)")
