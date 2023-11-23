################################################################################
#
# hart-software-services
#
################################################################################
HART_SOFTWARE_SERVICES_VERSION = next
HART_SOFTWARE_SERVICES_SITE = $(call github,polarfire-soc,hart-software-services,$(HART_SOFTWARE_SERVICES_VERSION))
HART_SOFTWARE_SERVICES_LICENSE = MIT
HART_SOFTWARE_SERVICES_LICENSE_FILES = LICENSE.md

define HART_SOFTWARE_SERVICES_BUILD_CMDS
    cp $(@D)/boards/polarberry/def_config $(@D)/.config
    $(MAKE) -C $(@D) BOARD=polarberry CROSS_COMPILE=$(TARGET_CROSS) V=2
endef

$(eval $(generic-package))
