Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web09.1972.1571904949188144878
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Oct 2019 01:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1571904944;
	bh=pM7Ygz3Yb6+Aie1d9mOFFHTQQEDOLLPIaeAy4CzzSQY=;
	h=From:To:CC:Subject:Date;
	b=fGlVgDDLMtHQbc5nAUbav4PgNkXTwgjVFJIIDPLQsVWroYXdQmvWZ+UloIhGKCXIS
	 CPdcRrBFuIYQdep7hsDK3yvi2sw9Vnqu/ETmouYtiYeb4t3DNokNP4jj5mCqrWPI8q
	 AVKoeWocZceUi/SaDgLEmtKgSMiNkHvYmeEqlQYM=
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] configs: sei610: khadas-vim3 : disable Gadget support for the DWC3
Date: Thu, 24 Oct 2019 10:15:40 +0200
Message-ID: <20191024081540.6229-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: marex@denx.de, trini@konsulko.com
Cc: u-boot@lists.denx.de, narmstrong@baylibre.com, u-boot-amlogic@groups.io, Jean-Jacques Hiblot <jjhiblot@ti.com>
List-ID: <u-boot-amlogic@groups.io>

Those platform use the DWC2 controller for the gadget support and the
DWC3 for host-only operations.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---

Applies on u-boot/master.
Fixes build breakage introduced by "usb: dwc3: Kconfig: get rid of obsolete mode
selection"

 configs/khadas-vim3_defconfig | 1 +
 configs/sei610_defconfig      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index cd37f7840e..81ac42e599 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -44,6 +44,7 @@ CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 520a683d2e..1f36722a8e 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -62,6 +62,7 @@ CONFIG_DM_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
-- 
2.17.1

