Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF4DCA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 18:13:53 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
 by mx.groups.io with SMTP id smtpd.web11.26234.1757528024229204102
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 11:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=WeGDFJ/d;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.182, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757528022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv6FCZWp4VR2JrabdtHumoJUusT4rpu1mBioYzP5QBc=;
	b=WeGDFJ/dxAc8++2yWcuFzmOZd+B47Wy4dKaCJOAZbjt82IwDTYQNGz87jVB43+G69VJ+rU
	BWn0mDmP7+qYdrYZxEZ1hBXheRanszVKds3eFE1XovFmbGuRW/Bc+ojKs6w+QC4zn1QchK
	uInXICBSFESw3f1tiMo9HTOBz3XELDCMaNYHb7kTPjhNMvLk9aqo2Rn9ipaujGl2iKOs6h
	6vx800dzEhVV2tHT+yZMJCMrfnzKLw09FQpto76zeNGNrtYjxS2ciqtcUiYQG9WKWqHMSq
	+vN1hX5tI7puit7Ol5nCcNDOY6ahqDqD7H7OJhKqRjWm1CI48gJNKUBntWdrMA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 10 Sep 2025 18:13:22 +0000
Subject: [PATCH RFC v2 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-spl-gx-v2-2-8f52aac47e04@postmarketos.org>
References: <20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org>
In-Reply-To: <20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5038;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ebJD2FNBe9DByCt2k3nHhBr1mj7Kxl8J6JqYSPqORTo=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBowb/QrLKzj1rBH+huPWICOeCkhb2yy7Pl3A5X7
 3liYQYu6YaJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaMG/0AAKCRCEr8vQ14ma
 A6PvEACK4Divgu9wCVTdJ4IugR6k/WqR5cUbwoejjhq2a7Fvd3tpa0JZaOPrY3hjGqiyDQZcRtO
 dto/nOSihbJBEJZnhKXuOG1OEUI7Wv01hcpMUkxqF5J/wCkT1klcZnoMl3tg6UyW8zpm9kQSAef
 l0XYbeHT/sO+N2HiMYq7LWYBt6Do+78HDadw6+ILhiHcgTe7PCr2XoHja2StVEXp0tK+k1Qds6z
 xbHixfqfnXLqZBWE6PSpcJvji40us0FFO9JrAKD0GUBThHupSqd6WRgZCdRhznQxBoTSQzELBqD
 Oblx4DgACNOfUm8t/NaBS76uL/6dXJIhECMJ1x7HuDK5r8KdnOt3dMNuZO690Nh7CfZOs4+9o0H
 cz5+lttesHNidr81FCR82yqoCBdGq8JMj8udgz/T9YD1IWUtTshoRBHrJolEWfI0Xs0RAjXFkCR
 IX57uMm7R2I/OMZpZlyHeq9MqZJCVvXOrjSlqZLRKRl2chmr5+BLVNHm6BhrQZ59/J3ZURA+e8z
 Ed0/4frxMAribLLThpvYMOimXV4+XXyM6nJal8oPcZB3gjV3pmmELK4hEGMpi+CWufTPGAkvCGr
 jZzW5+E3diurF3jm2pFYxHXyKABiwYTHnDjU8OZkZ7BA49Wg/FsdPX5L4WM+K53NDUEARkJIDXP
 tCQTZnfhP0liLvw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 18:13:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2766

Add a minimal non-DM MMC driver for use in size-constrained
environments.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/gx.h |  5 +++
 drivers/mmc/meson_gx_mmc.c           | 75 +++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
index 26ec5d0bc340bc03587047d68a88042779e64536..8cfc6b00329f252bbf452dba00f8ad56b480c707 100644
--- a/arch/arm/include/asm/arch-meson/gx.h
+++ b/arch/arm/include/asm/arch-meson/gx.h
@@ -41,4 +41,9 @@
 #define GX_GPIO_IN(n)		GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 1)
 #define GX_GPIO_OUT(n)	GX_PERIPHS_ADDR(_GX_GPIO_OFF(n) + 2)
 
+/* Non-DM MMC init */
+#if CONFIG_IS_ENABLED(MMC) && !CONFIG_IS_ENABLED(DM_MMC)
+struct mmc *meson_mmc_init(int mmc_no);
+#endif
+
 #endif /* __GX_H__ */
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 5852b24c6d2a5a9d1b1e8a62f8c0ec325b339182..a4338f1e29c1da07acb0333be9b75a318cba1334 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -16,6 +16,7 @@
 #include <linux/log2.h>
 #include "meson_gx_mmc.h"
 
+#if CONFIG_IS_ENABLED(DM_MMC)
 bool meson_gx_mmc_is_compatible(struct udevice *dev,
 				enum meson_gx_mmc_compatible family)
 {
@@ -23,6 +24,7 @@ bool meson_gx_mmc_is_compatible(struct udevice *dev,
 
 	return compat == family;
 }
+#endif
 
 static inline void *get_regbase(const struct mmc *mmc)
 {
@@ -67,7 +69,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	 * Other SoCs use CLK_CO_PHASE_180 by default.
 	 * It needs to find what is a proper value about each SoCs.
 	 */
-	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
+	if (IS_ENABLED(CONFIG_MESON_SM))
 		meson_mmc_clk |= CLK_CO_PHASE_270;
 	else
 		meson_mmc_clk |= CLK_CO_PHASE_180;
@@ -82,9 +84,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	meson_write(mmc, meson_mmc_clk, MESON_SD_EMMC_CLOCK);
 }
 
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int meson_dm_mmc_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+#else
+static int meson_legacy_mmc_set_ios(struct mmc *mmc)
+{
+#endif
 	uint32_t meson_mmc_cfg;
 
 	meson_mmc_config_clock(mmc);
@@ -193,10 +200,16 @@ static void meson_mmc_read_response(struct mmc *mmc, struct mmc_cmd *cmd)
 	}
 }
 
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 				 struct mmc_data *data)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+#else
+static int meson_legacy_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
+				     struct mmc_data *data)
+{
+#endif
 	struct meson_mmc_plat *pdata = mmc->priv;
 	uint32_t status;
 	ulong start;
@@ -235,6 +248,59 @@ static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 	return ret;
 }
 
+#if !CONFIG_IS_ENABLED(DM_MMC)
+struct meson_mmc_plat mmc_plat[2];
+
+static int meson_legacy_mmc_init(struct mmc *mmc)
+{
+	/* reset all status bits */
+	meson_write(mmc, STATUS_MASK, MESON_SD_EMMC_STATUS);
+
+	/* disable interrupts */
+	meson_write(mmc, 0, MESON_SD_EMMC_IRQ_EN);
+
+	return 0;
+}
+
+static const struct mmc_ops meson_mmc_ops = {
+	.send_cmd	= meson_legacy_mmc_send_cmd,
+	.set_ios	= meson_legacy_mmc_set_ios,
+	.init		= meson_legacy_mmc_init,
+};
+
+struct mmc *meson_mmc_init(int mmc_no)
+{
+	struct meson_mmc_plat *pdata = &mmc_plat[mmc_no];
+	struct mmc_config *cfg = &pdata->cfg;
+
+	cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
+			MMC_VDD_31_32 | MMC_VDD_165_195;
+	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT;
+	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
+	cfg->f_max = 6000000; /* 6 MHz */
+	cfg->b_max = 127; /* max 128 - 1 block */
+	cfg->name = "Meson SD/eMMC";
+	cfg->ops = &meson_mmc_ops;
+
+	if (mmc_no == 0) /* MMC1: SD card */
+		pdata->regbase = (void *)0xd0072000;
+	else if (mmc_no == 1) /* MMC2: eMMC */
+		pdata->regbase = (void *)0xd0074000;
+
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
+	/* Enable power if needed */
+	ret = mmc_pwrseq_get_power(dev, cfg);
+	if (!ret) {
+		ret = pwrseq_set_power(cfg->pwr_dev, true);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return mmc_create(cfg, pdata);
+}
+
+#else
 static const struct dm_mmc_ops meson_dm_mmc_ops = {
 	.send_cmd = meson_dm_mmc_send_cmd,
 	.set_ios = meson_dm_mmc_set_ios,
@@ -282,6 +348,12 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
 
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
+		cfg->f_max = 6000000; /* 6 MHz */
+		cfg->b_max = 127; /* max 128 - 1 block */
+	}
+
 	mmc->priv = pdata;
 	upriv->mmc = mmc;
 
@@ -336,3 +408,4 @@ U_BOOT_DRIVER(meson_mmc) = {
 	.of_to_plat = meson_mmc_of_to_plat,
 	.plat_auto	= sizeof(struct meson_mmc_plat),
 };
+#endif

-- 
2.51.0


