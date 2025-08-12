#!/bin/sh

#Create FAT linux Image (linux kernel  + rootfs + DTS)
cp -R output/images ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/som1-soc
/usr/bin/mkimage -A riscv -O linux -T flat_dt -f ${BR2_EXTERNAL_MCHP_PATH}/board/microchip/som1-soc/fitimage_som1-soc.its output/images/fitimage_som1-soc.itb

#Copy UBOOT adopted image to the TFTP server directory
#sudo cp output/images/payload.bin /srv/tftp

#Copy Linux FTD image to the TFTP server directory
#sudo cp output/images/fitimage_som1-soc.itb /srv/tftp

#clean up
