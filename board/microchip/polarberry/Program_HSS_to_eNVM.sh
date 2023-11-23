#!/bin/bash
source ./FLASH_CONFIG.CONF
make -C $BUILDROOT_DIRECTORY/output/build/hart-software-services-next program
