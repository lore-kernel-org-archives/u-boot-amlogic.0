Received: by mail-wr1-f66.google.com with SMTP id q17so10539990wrx.10
        for <u-boot-amlogic@groups.io>; Mon, 09 Sep 2019 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mgW95iiIEYs8Ik4hLY+MXkO6+YJsMz1RvMmgO0HgvHU=;
        b=PDbsi0j4W0BnzL+1OhMNOf0L7TRHn45qdg8No1RLiiu+Tj9Kl0JPJIqZ78EC80XGiQ
         Hk6jbyr3axyc1eNrkg2K5bXZii2QW/bSXci1C9X1myW+oo2vi0UjPHbP+g9HEvWh5nFV
         n3yqSfWw37g4FBVz6QJlo+bFE0eAM0xvklhI/Vg3FpGROJs7qUqbVDvQQR+U/5tdOVh4
         mM1X5LLaI/clYPnJT7oNABsV2l5/SxhLbrjm3RrHQ09OUcDFQpiS3Y097Er/BqLvZ0ru
         oTkMHD846NgKszQh13eW+1TPNFBEZTeM0ym6ybX9SmQMb5EYixtox+XMw9kEkjT5Ovyp
         Q+nA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] usb: xhci-dwc3: Add support for dis_u2_susphy_quirk
Date: Mon,  9 Sep 2019 18:52:39 +0000
Message-Id: <1568055159-27982-1-git-send-email-narmstrong@baylibre.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Yuri Frolov <crashing.kernel@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This quirk is necessary for the Amlogic GXL SoCs otherwise the
Port 2 PHY doesn't get out of suspend and U-Boot resets the board after:

XHCI timeout on event type 33... cannot recover.
BUG: failure at drivers/usb/host/xhci-ring.c:474/xhci_wait_for_event()!
BUG!

This quirk is also handled in the dwc3 core code, but until the
xhci-dwc3 driver uses the dwc3 core, the quirk must be handled here
to fix USB support on the Amlogic libretech-cc and libretech-ac board
when a device is only plugged in the OTG port.

Cc: Yuri Frolov <crashing.kernel@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Fixes: dc9cdf859e ("usb: dwc3: Add DWC3 controller driver support")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/host/xhci-dwc3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 9e8cae7ae4..55a1b22cf6 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -150,6 +150,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
 	if (dev_read_bool(dev, "snps,dis-u2-freeclk-exists-quirk"))
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
+	if (dev_read_bool(dev, "snps,dis_u2_susphy_quirk"))
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
 	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
 
 	dr_mode = usb_get_dr_mode(dev_of_offset(dev));
-- 
2.17.1

