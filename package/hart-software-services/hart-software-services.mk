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
    cp $(@D)/$(subst ",,$(BR2_PACKAGE_HART_SOFTWARE_SERVICES_CONFIG)) $(@D)/.config
    $(MAKE) -C $(@D) BOARD=$(subst ",,$(BR2_PACKAGE_HART_SOFTWARE_SERVICES_BOARD)) CROSS_COMPILE=$(TARGET_CROSS) V=3 DIE=$(subst ",,$(BR2_PACKAGE_HART_SOFTWARE_SERVICES_DIE)) PACKAGE=$(subst ",,$(BR2_PACKAGE_HART_SOFTWARE_SERVICES_PACKAGE))
endef

$(eval $(generic-package))
