#!/bin/bash

source ./FLASH_CONFIG.CONF

./Program_HSS_to_eNVM.sh
./Program_UBOOT_to_eMMC.sh

echo "reset" > $UART_DEVICE

./Program_LINUX_to_eMMC.sh
