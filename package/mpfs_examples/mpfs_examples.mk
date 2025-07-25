################################################################################
#
# Microchip PolarFire SoC Examples
#
################################################################################
MPFS_EXAMPLES_VERSION = 2025.07
MPFS_EXAMPLES_SITE = $(call github,polarfire-soc,polarfire-soc-linux-examples,v$(MPFS_EXAMPLES_VERSION))
MPFS_EXAMPLES_LICENSE = MIT
MPFS_EXAMPLES_LICENSE_FILES = LICENSE
MPFS_EXAMPLE_DIRS = $(call qstrip,$(BR2_PACKAGE_MPFS_EXAMPLES_DIRS))
MPFS_EXAMPLE_FILES_ALL += amp/rpmsg-pingpong/rpmsg-pingpong amp/rpmsg-tty-example/rpmsg-tty gpio/gpiod-test gpio/gpio-event system-services/system-services-example system-services/signature-verification-demo fpga-fabric-interfaces/lsram/uio-lsram-read-write dma/uio-dma-interrupt pdma/pdma-ex
MPFS_EXAMPLE_TARGET_DIR = /opt/microchip/
MPFS_EXAMPLE_FILES = \
    $(foreach d,$(MPFS_EXAMPLE_DIRS),$(filter $(d)/%,$(MPFS_EXAMPLE_FILES_ALL)))

define MPFS_EXAMPLES_INSTALL_DIRS
	$(foreach d,$(MPFS_EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)$(d)$(sep))
endef

define MPFS_EXAMPLES_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)
	$(foreach d,$(MPFS_EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)$(d)$(sep))

	echo $(MPFS_EXAMPLE_FILES)
	$(foreach example_file,$(MPFS_EXAMPLE_FILES), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(dir $(example_file)) \
			$(notdir $(example_file)) CC=$(TARGET_CC); \
		$(INSTALL) -D -m 775 $(@D)/$(example_file) \
			$(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)$(example_file);)

	if echo "$(MPFS_EXAMPLE_DIRS)" | grep -wq ethernet; then \
		ln -sf $(MPFS_EXAMPLE_TARGET_DIR)/ethernet/iio-http-server \
			$(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)/iiohttpserver; \
	fi
endef

define MPFS_EXAMPLES_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/ethernet/iio-http-server/collection/collectdiio.service \
		$(TARGET_DIR)/usr/lib/systemd/system/collectdiio.service
endef

define MPFS_EXAMPLES_INSTALL_INIT_SYSV
	# iiohttp server
	$(INSTALL) -D -m 775 $(@D)/ethernet/iio-http-server/collection/collectdiio.busybox \
		$(TARGET_DIR)/etc/init.d/collectdiio
	# busy box init requires script renames
	mv $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{sh,systemd}
	mv $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{busybox,sh}
	chmod +x $(TARGET_DIR)$(MPFS_EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.sh
endef

$(eval $(generic-package))
