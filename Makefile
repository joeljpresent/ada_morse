build:
	gprbuild morse_ada.gpr
	arm-eabi-objcopy -O binary obj/main main.bin

test:
	gprbuild morse_tests.gpr
	./obj_tests/main_tests

flash: build
	st-flash write main.bin 0x8000000
