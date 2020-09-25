Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.2319.1601018366025427523
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2020 00:19:27 -0700
Received: by mail-wm1-f66.google.com with SMTP id e2so2083934wme.1
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2020 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5d1uSCEXdi9BCvvPW+b3HWzWIEHrsmSjf/C0eLA/XU=;
        b=CJ9BhFHzB+vdE4ByTPbzmtbc5+C1/wwLI6hfksAhN3TMSdjiz0DDfZiN+2OU99zVoF
         8btH4eKTNWfFcBLpMb4uNSUbFJMfIiEW0+U3KQ2PXTY2V5htDmHwH8Jy+7N3IvUaFOpM
         tTx094wL6uq2HXUnwV/NClDoNQHat4O8+1sceF4PkqYby6gPl34acr/27MjK7drhGPZT
         hd2fKD32OKUsz8kUXiT9wt83hr/piRoyq1pYq3j8dwC/8h7P8u5cA1GETQxYB09ptwqM
         QOtSuAfohGVIxrbw9yAmh+ttcJOgmQb5Df1+isfCHwtq7yX/WXdyxIZHX5Sl9vbA0hZC
         8f8w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] rng: meson: make core clock optional
Date: Fri, 25 Sep 2020 09:19:20 +0200
Message-Id: <20200925071920.9211-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, sughosh.ganu@linaro.org
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Scott K Logan <logans@cottsay.net>
List-ID: <u-boot-amlogic@groups.io>

This fixes HWRNG support on Amlogic GXL, GXM, G12A, G12B & SM1
based boards dues to the lack of the core clock in the device tree.

It was reported breaking EFI boot in the Linux EFI stub, because the
EFI_RNG_PROTOCOL didn't check for the RNG device presence before
installing itself.

The Linux amlogic,meson-rng.yaml doesn't mandate the core clock,
this the clock should be ignores if not present.

Nevertheless, the clock should be present and this should be fixed
on the Linux meson-gxl.dtsi & meson-g12-common.dtsi then synced
with U-Boot.

The change has been tested on a Khadas VIM3, which uses the common
meson-g12-common.dtsi like the Odroid-C4 & Odroid-N2 in Scott's
report, along with the RNG cmd.

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reported-by: Scott K Logan <logans@cottsay.net>
Fixes: bc40eb278b ("drivers/rng: add Amlogic hardware RNG driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/rng/meson-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
index 4b81a62353..57a5a702a2 100644
--- a/drivers/rng/meson-rng.c
+++ b/drivers/rng/meson-rng.c
@@ -90,8 +90,9 @@ static int meson_rng_ofdata_to_platdata(struct udevice *dev)
 	if (!pdata->base)
 		return -ENODEV;
 
+	/* Get optional "core" clock */
 	err = clk_get_by_name(dev, "core", &pdata->clk);
-	if (err)
+	if (err && err != -ENODATA)
 		return err;
 
 	return 0;
-- 
2.22.0

