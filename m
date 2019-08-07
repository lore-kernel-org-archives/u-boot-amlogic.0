DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565193349;
	bh=9JKC/jxhocrjUK/iVZUesC3jio71WaNyeI7UUZuSrqY=;
	h=From:To:CC:Subject:Date;
	b=oeyaJqIbztCuVZWxGD6ci5sBT1Bz8Ak2r+sGciSPBcc7TbtMi01q1NhEn6h7uTtbE
	 DAW+CAuUqF04ThRVTDJ0yc5YtZqVZxoGXbTvNQFS+Yrjkkbmzys8f8gXIl1ppiYxvD
	 Oy0EYVcj+944tcb3fPWI/5nESZ4J4zrwXNOw7i4A=
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] usb: dwc3: Kconfig: get rid of obsolete mode selection
Date: Wed, 7 Aug 2019 17:55:39 +0200
Message-ID: <20190807155539.29369-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: marex@denx.de, narmstrong@baylibre.com, kever.yang@rock-chips.com, lukma@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, sven@svenschwermer.de, jjhiblot@ti.com
List-ID: <u-boot-amlogic@groups.io>

The mode selection for the DWC3 is kind of obsolete. The driver does not
have to be host only or gadget only. This choice is confusing.
All the remaining callers of dwc3_uboot_init() explicitly set dr_mode
before calling the function, so none rely on a default behavior.

Remove the choice menu and keep only the USB_DWC3_GADGET option. Enable it
by default if USB_GADGET and USB_DWC3 are enabled.
It must be disabled for the evb-rk3328 and odroid-n2 as it uses DWC2 for
the gadget and DWC3 for the host.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>

---

This patch applies on top of git://git.denx.de/u-boot-usb.git master

This patch was a part of a larger series. The changes since are:
- Fix the test of the USB_DWC3_GADGET option. IS_ENABLED() requires the
  whole option name including the 'CONFIG_' prefix
- disable the CONFIG_USB_DWC3_GADGET option for the new odroid-n2 config


configs/evb-rk3328_defconfig |  1 +
 configs/odroid-n2_defconfig  |  1 +
 drivers/usb/dwc3/Kconfig     | 18 ++----------------
 drivers/usb/dwc3/core.c      |  4 ++--
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index fcc04f27ec..373ddf2f7f 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -63,6 +63,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
 CONFIG_USB_GADGET_VENDOR_NUM=0x2207
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 38d1549375..40b491e170 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -49,6 +49,7 @@ CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 25e1a38aee..c302486291 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -7,25 +7,11 @@ config USB_DWC3
 
 if USB_DWC3
 
-choice
-	bool "DWC3 Mode Selection"
-
-config USB_DWC3_HOST
-	bool "Host only mode"
-	depends on USB
-	help
-	  Select this when you want to use DWC3 in host mode only,
-	  thereby the gadget feature will be regressed.
-
 config USB_DWC3_GADGET
-	bool "Gadget only mode"
+	bool "USB Gadget support for DWC3"
+	default y
 	depends on USB_GADGET
 	select USB_GADGET_DUALSPEED
-	help
-	  Select this when you want to use DWC3 in gadget mode only,
-	  thereby the host feature will be regressed.
-
-endchoice
 
 comment "Platform Glue Driver Support"
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1baad39796..10b3f837f2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -707,9 +707,9 @@ int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
 		return -ENOMEM;
 	}
 
-	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+	else if (!IS_ENABLED(CONFIG_USB_HOST))
 		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
 
 	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-- 
2.17.1

