Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.1855.1570808044958033862
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:05 -0700
Received: by mail-wm1-f66.google.com with SMTP id 7so10887166wme.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9SjI9FpHk2o7EgIc3zDVmm2hXQ7TC5RMUfEGxR6KxI=;
        b=kb6JC+0x/XtevFFATz3KDJ5m1gsai4NAnAHVvFDMX3yuVkqd7ntNVI+u3zn4urRGJ0
         cGuPTXzMd2IC5Drt8N/X8s7oRh+JBWR8cQOEs5aUzdZWD8D8jVTYqEmsws/qj9dWpxHg
         KFiBqIHnU2ck6kU4RfgZz3SOGbOdRaWO6+dqx/4YUw15VSm9zx+7OghLKXo7mOGboOva
         XyFc756v14z3/bgbQrR3WHDQrhEGdQsvQ5axJB5M1kqiZmWiQI8C3N7YgnVlehrUj+HO
         bzn2VsNfnQIJl0lnSnwZ3prxjB7tgSgwfRtyv56IrAa1DJYsGkYnXH0PIa2pRNTrwJt0
         3Y3w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/8] mmc: meson-gx: add support for mmc-pwrseq-emmc
Date: Fri, 11 Oct 2019 17:33:52 +0200
Message-Id: <20191011153358.29739-3-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for mmc-pwrseq-emmc in the meson-gx mmc driver to support
enabling the eMMC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/meson_gx_mmc.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 767dfff805..031cc79ccb 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -7,8 +7,10 @@
 #include <dm.h>
 #include <fdtdec.h>
 #include <malloc.h>
+#include <pwrseq.h>
 #include <mmc.h>
 #include <asm/io.h>
+#include <asm/gpio.h>
 #include <asm/arch/sd_emmc.h>
 #include <linux/log2.h>
 
@@ -239,6 +241,10 @@ static int meson_mmc_probe(struct udevice *dev)
 	struct mmc *mmc = &pdata->mmc;
 	struct mmc_config *cfg = &pdata->cfg;
 	uint32_t val;
+#ifdef CONFIG_PWRSEQ
+	struct udevice *pwr_dev;
+	int ret;
+#endif
 
 	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
 			MMC_VDD_31_32 | MMC_VDD_165_195;
@@ -254,6 +260,17 @@ static int meson_mmc_probe(struct udevice *dev)
 
 	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
 
+#ifdef CONFIG_PWRSEQ
+	/* Enable power if needed */
+	ret = uclass_get_device_by_phandle(UCLASS_PWRSEQ, dev, "mmc-pwrseq",
+					   &pwr_dev);
+	if (!ret) {
+		ret = pwrseq_set_power(pwr_dev, true);
+		if (ret)
+			return ret;
+	}
+#endif
+
 	/* reset all status bits */
 	meson_write(mmc, STATUS_MASK, MESON_SD_EMMC_STATUS);
 
@@ -292,3 +309,37 @@ U_BOOT_DRIVER(meson_mmc) = {
 	.ofdata_to_platdata = meson_mmc_ofdata_to_platdata,
 	.platdata_auto_alloc_size = sizeof(struct meson_mmc_platdata),
 };
+
+#ifdef CONFIG_PWRSEQ
+static int meson_mmc_pwrseq_set_power(struct udevice *dev, bool enable)
+{
+	struct gpio_desc reset;
+	int ret;
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &reset, GPIOD_IS_OUT);
+	if (ret)
+		return ret;
+	dm_gpio_set_value(&reset, 1);
+	udelay(1);
+	dm_gpio_set_value(&reset, 0);
+	udelay(200);
+
+	return 0;
+}
+
+static const struct pwrseq_ops meson_mmc_pwrseq_ops = {
+	.set_power	= meson_mmc_pwrseq_set_power,
+};
+
+static const struct udevice_id meson_mmc_pwrseq_ids[] = {
+	{ .compatible = "mmc-pwrseq-emmc" },
+	{ }
+};
+
+U_BOOT_DRIVER(meson_mmc_pwrseq_drv) = {
+	.name		= "mmc_pwrseq_emmc",
+	.id		= UCLASS_PWRSEQ,
+	.of_match	= meson_mmc_pwrseq_ids,
+	.ops		= &meson_mmc_pwrseq_ops,
+};
+#endif
-- 
2.22.0

