# Ada_Morse

Ada project: you input Morse code with just one button, and the text shows up on the screen of your STM32F4!

This project is a submission to the MakeWithAda contest.

## Requirements

You need:

- a STM32F429 board;
- Gnat for `arm-eabi` and `x86_64-linux-gnu` toolchains;
- `Ada_Drivers_Library` from AdaCore containing the`boards/stm32f429_discovery/obj` directory.

## How to build

``` shell
git clone https://github.com/JoelJPresent/ada_morse.git
cd ada_morse
git clone https://github.com/AdaCore/Ada_Drivers_Library.git
python ./Ada_Drivers_Library/scripts/install_dependencies.py
python ./Ada_Drivers_Library/scripts/project_wizard.py
# Choose the STM32F429 option.
make
```

## How to flash

``` shell
make flash
```

## How to lauch testsuite

``` shell
make test
```

## Team members

- Joël J. Présent (`joel.present`)
- Guillaume Pagnoux (`pagnou_g`)
- Maxence Caron-Lasne (`caron-_m`)
