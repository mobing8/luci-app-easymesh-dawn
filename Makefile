#
#-- Copyright (C) 2021 dz <dingzhong110@gmail.com>
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-easymesh
LUCI_TITLE:=LuCI Support for easymesh
LUCI_DEPENDS:= +kmod-cfg80211 +batctl-default +kmod-batman-adv +wpad-mesh-openssl +dawn
PKG_VERSION:=2.0
PKG_RELEASE:=1
PKG_MAINTAINER:=mobing8 <https://github.com/mobing8>
LUCI_PKGARCH:=all

# 新增：禁止luci.mk自动将翻译打入主包，由独立翻译包提供
LUCI_I18N:=0

include $(TOPDIR)/feeds/luci/luci.mk

# ========== 新增：独立简体中文翻译包 ==========
define Package/luci-i18n-easymesh-zh-cn
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Translations
  TITLE:=EasyMesh - Simplified Chinese translation
  DEPENDS:=luci-app-easymesh
  PKGARCH:=all
  VERSION:=$(PKG_VERSION)-$(PKG_RELEASE)
endef

define Package/luci-i18n-easymesh-zh-cn/description
  Simplified Chinese translation for luci-app-easymesh
endef

define Package/luci-i18n-easymesh-zh-cn/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(STAGING_DIR_HOST)/bin/po2lmo $(CURDIR)/po/zh_Hans/easymesh.po $(1)/usr/lib/lua/luci/i18n/easymesh.zh-cn.lmo
endef

# 注册两个安装包：主程序包 + 简体中文翻译包
$(eval $(call BuildPackage,luci-app-easymesh))
$(eval $(call BuildPackage,luci-i18n-easymesh-zh-cn))
