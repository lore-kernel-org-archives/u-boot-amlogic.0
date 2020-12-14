Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web11.33618.1607945686285256768
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:34:47 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201214113428euoutp02b79cef5cdd18f1ec44df695938785842~QkhEQGDJe2821328213euoutp024
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:34:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201214113428euoutp02b79cef5cdd18f1ec44df695938785842~QkhEQGDJe2821328213euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945668;
	bh=0IVGif5ilUpSeG00Prh0wm52IU2BOP+iajtgbRV//3c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OUK4iJDjDK83oN0FNAOtC/E191wMYat4tzj7H5T0apTClpVwChMfD/jbtmJOu9Dr/
	 jqPCzpoe+W4muRnasR7WgHo9+zY4IzhZEXYEIMUcNgqFNSFnDQ+6nOg4zwJ3GHa3Qn
	 yS5PTFidHBPl3dpTNxoRnzEGNo6FhnrF4EySDxy0=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] usb: dwc3-meson-g12a: always configure dr-mode
Date: Mon, 14 Dec 2020 12:34:19 +0100
Message-Id: <20201214113419.19103-1-m.szyprowski@samsung.com>
References: <CGME20201214113427eucas1p203c6afe2f9af60e5bfb5ccc04dd966d5@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

dwc3_meson_g12a_force_mode() sets the dr-mode of the USB PHY. However
it skips setting the mode if it matches the one done during driver probe
(stored in private structure). This fails if the mode has been changed
to other value and then back to initial one. Fix this by configuring the
dr-mode always, regadless of the one set at the driver probe).

This fixes operation of USB gadget based drivers when they are initialized
for the second time.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 6567502cdd1..6f0bac2a00c 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -269,9 +269,6 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 	if (!priv->phys[USB2_OTG_PHY].dev)
 		return -EINVAL;
 
-	if (mode == priv->otg_mode)
-		return 0;
-
 	if (mode == USB_DR_MODE_HOST)
 		debug("%s: switching to Host Mode\n", __func__);
 	else
-- 
2.17.1

