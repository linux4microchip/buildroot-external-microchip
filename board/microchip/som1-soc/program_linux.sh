#!/bin/bash

source ./FLASH_CONFIG.CONF

stty -F $UART_DEVICE 115200 cs8 -cstopb -parenb raw

printf "\t\n  ***** WAITING FOR UBOOT  *****"

(
    while test "${key}" != "SundanceDSP"
    do
	read -r uart
	key=`echo $uart | grep "Model: SundanceDSP Polarberry" | awk '{print $2}'`
#	echo $uart
    done
) < $UART_DEVICE

printf "\t\n  ***** GOT THE TIMEOUT STRING FROM UBOOT *****"
sleep 1
echo ".\n" > $UART_DEVICE
printf "\t\n  ***** Starting programming linux image to the POLARBERRY board *****"
echo "setenv ipaddr $DEVICE_IP" > $UART_DEVICE
echo "setenv serverip $PC_IP" > $UART_DEVICE
echo "setenv bootfile $IMAGE_NAME" > $UART_DEVICE
echo "run flash_linux" > $UART_DEVICE
sleep 1

(
    while test "${key}" != "MMC"
    do
	read -r uart
	key=`echo $uart | grep "MMC write" | awk '{print $1}'`
#	echo $uart
    done
) < $UART_DEVICE

printf "\t\n  ***** Programming LINUX to the eMMC of the POLARBERRY board is DONE!!! *****"
