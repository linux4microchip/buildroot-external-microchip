#!/bin/bash

source ./FLASH_CONFIG.CONF

./program_hss.sh
./program_uboot.sh

echo "reset" > $UART_DEVICE

./program_linux.sh
