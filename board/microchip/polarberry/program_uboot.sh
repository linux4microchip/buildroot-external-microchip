#!/bin/bash

source ./FLASH_CONFIG.CONF

stty -F $UART_DEVICE 115200 cs8 -cstopb -parenb raw

printf "\t\n  ***** WAITING FOR HSS  *****"

(
    while test "${key}" != "Timeout"
    do
	read -r uart
	key=`echo $uart | grep Timeout | awk '{print $1}'`
    done
) < $UART_DEVICE

printf "\t\n  ***** GOT THE TIMEOUT STRING *****"

echo "" > $UART_DEVICE
printf "\t\n Starting \"ymodem\" command"
echo "ymodem" > $UART_DEVICE
sleep 1
printf "\t\n Starting init eMMC command"
echo "2" > $UART_DEVICE
sleep 1
printf "\t\n Starting ymodem receiving command\n"
echo "3" > $UART_DEVICE
sleep 1

sz -b --ymodem $BUILDROOT_DIRECTORY/output/images/payload.bin > $UART_DEVICE < $UART_DEVICE

printf "\t\n Saving the UBOOT to the eMMC memory"
echo "5" > $UART_DEVICE
sleep 2
echo "6" > $UART_DEVICE
sleep 1
printf "\t\n  ***** Programming U-BOOT to the eMMC of the POLARBERRY board is DONE!!! *****"
