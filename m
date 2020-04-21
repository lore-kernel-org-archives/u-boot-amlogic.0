Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.4765.1587457071012689159
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Apr 2020 01:17:51 -0700
Received: by mail-wr1-f67.google.com with SMTP id k11so15410050wrp.5
        for <u-boot-amlogic@groups.io>; Tue, 21 Apr 2020 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3LPGZ2DkYBx4ELdfVMIxPvPGCcgSPABTiRJ//sGZc8=;
        b=Si0xFObXXRgkcOfyVp/5JczYnkSZV6Yb2nAlCIzOKeEGNbFzd147WTZL151acz1QBN
         IjyCKEIR+9QRjkUQg8q6b+A5cMINYaTMcMHBHXlDY4jaWOdcHG7nqY3/5lIBos0pDs5k
         kW/fSZwUsOE9bg4dxnJ1zcGeCM/Kbnl8TJsU6zhXCMxtH7aBiuJHWzInzEtGL8hOZpnA
         tuFMgVj7W/fUw6R/vtWO8Cl7/XT7ze4fG01lCvr3A/sgYDYu/V31bKexc55hGxrkBBsC
         zDW2UzUnUt59QS+lXAu055/hXWkwYfn8FLqGzsV4lAFjzihGURU+gachBglv6J3Nyq1G
         myqw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2] usb: dwc3-meson-g12a: add power-on/off of the PHYs
Date: Tue, 21 Apr 2020 10:17:42 +0200
Message-Id: <20200421081742.24628-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, marex@denx.de
Cc: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Power on/off the PHYs to enable power to the USB ports, fixing USB support
on Khadas VIM3/VIM3L boards.

The G12A USB complex has at least 2 USB2 PHYs, but one is muxed between the
DWC2 and DWC3 controller and the other one directly connected to the DWC3
controller. The USB3+PCIe combo PHY is muxed between the DWC3 controller
and a DW-PCIE controller.
All PHYs are optional, but it's type (usb2/usb3) and position are important
to determine it's capabilities, thus they are stored in a fixed size
array and the phy-name determines it's position, it's position determining
it's type and functionnalities.
This is why we need to loop over the array to power on all the DT provided
PHYs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- removed extra space before semicolon
- added clarification in commit message

 drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index d4453f8784..de964d6c10 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 			goto err_phy_init;
 	}
 
+	for (i = 0; i < PHY_COUNT; ++i) {
+		if (!priv->phys[i].dev)
+			continue;
+
+		ret = generic_phy_power_on(&priv->phys[i]);
+		if (ret)
+			goto err_phy_init;
+	}
+
 	return 0;
 
 err_phy_init:
@@ -430,6 +439,13 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
 
 	clk_release_all(&priv->clk, 1);
 
+	for (i = 0; i < PHY_COUNT; ++i) {
+		if (!priv->phys[i].dev)
+			continue;
+
+		 generic_phy_power_off(&priv->phys[i]);
+	}
+
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
-- 
2.22.0

