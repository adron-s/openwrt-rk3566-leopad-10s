include $(TOPDIR)/rules.mk

PKG_NAME:=tty-cube
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ikz87/TTY-Cube.git
PKG_SOURCE_DATE:=2023-05-01
PKG_SOURCE_VERSION:=HEAD
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Serhii Serhieiev <adron@ngnp.net>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/tty-cube
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=TTY Cube - 3D rotating cube in terminal
  DEPENDS:=+libevdev
  URL:=https://github.com/ikz87/TTY-Cube
endef

define Package/tty-cube/description
  A simple 3D rotating cube that runs in the terminal using ncurses and libevdev for input handling.
endef

define Build/Compile
	$(TARGET_CC) $(PKG_BUILD_DIR)/tty_cube.c -o $(PKG_BUILD_DIR)/tty-cube \
		-I$(STAGING_DIR)/usr/include \
		-L$(STAGING_DIR)/usr/lib \
		-lm -levdev -O3 \
		$(TARGET_CFLAGS) $(TARGET_LDFLAGS)
endef

define Package/tty-cube/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tty-cube $(1)/usr/bin/
endef

$(eval $(call BuildPackage,tty-cube))
