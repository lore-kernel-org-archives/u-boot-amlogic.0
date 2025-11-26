Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67834D10F2D
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 12:17:45 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11619.1764159455429795610
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 04:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=VD3Od9lL;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.177, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764159453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW1X3O57eL0OGMC/Q2brwt90jXZW9zX3F8YNB+SjacQ=;
	b=VD3Od9lLmoDLZ478NUKYXBEeWQALVV+sL8J5ASPKkjNciQW4LKkfEbNYbbALiWNdG4aLaK
	nhhC51+3zVOwi4/AAQaZnmwigMsRE9ywNMbI3weuh50TuDVkheyMRXa1JtxBMfkJtEMBhE
	Brz+rIdKlVzbyOGrusGH/YH/JzYSMySLJ4tHAkAGpmpjoKa0CZbCXhk1/PVYNctYqISvQ4
	7vqAPa4SgVfeHo0ZaG403MZUQRTWaDI1paCrm+qfyXOT/Ozf53cABSTE71+u/ucSwT0U9w
	27SAe8vJmPY+bXVLdJlVa4zkKYFBARgMK51UQbwnEE6nLF7Jy8LEFOsT3smqsQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:04 +0000
Subject: [PATCH v5 02/10] mmc: meson_gx_mmc: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-2-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5216;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=8uAezbqRh6Q7yRl/CRqaA01f1FVq+nrbDdJQ9c+m6uQ=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/XJtAAsr7zu1rlsVcYiEPgQEmmfJtQLQZPD
 vOAa+Tyw5SJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv1wAKCRCEr8vQ14ma
 A5o8D/4xKaWH3LzQyEzKIlxEdHuCPtCW88soZxx1eCaUy2EMiygCJPD5aO5A7IhHZJrpbDP9xFx
 uP6sum5YrU0Mp3rC0pHDs58g6/NJxgNpXxGnqZcMx8l2KFeaFtf6Jo2iX0IYG3mtDpzwDD5w40b
 rRxy9nBlY8ZT14cBfE5+XKOzbd2NewgU6JcrNqKP0b1NAjmJSCXN93/kZDJdExaR+nAQpKiwoGv
 i0P6I0jBeMfeV4UTTc5NleoshJGtjv/UcXNsYS64PQ/95jfl0Va3+M7GZPw5H7wIlJCv7W+YhOJ
 j2Ho9H5Wa1px1N8EFIqyvnB5FxxLuFGXrfEegMIvymrRsGVRWvF3dPSVfwdXo6PyxCf5F6iNFYI
 g5dzAfm+Xq0Q4q4YnBFPv9BQlaWTeDT3x5HhgxMfwBzur/c0xAiPb7RxBTJlGTE9pWtbPU8eAfL
 MsWbOVbpnnMcDzWFCoLq3dZRcDYuXay3v0lce/sIsoEbMLS/4jn11It80jtt+v9JmUTymyqBHqM
 8kxsbpo7JemjDpcmhYEcKkOnrXQkezoAMeyWH6x6C+TOgtnQD1KG5QCgTUDnIRjypaOMp7qHxEC
 iMNbS652F6cg6UwgglT5NiUenZ7YrQjx7WkVrhd8fjyDUc8Cd4m3LwlVIu/iwYavwTn1EDuFT5Q
 czvSe62sVtmdfLw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 12:17:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2853

Add a minimal non-DM MMC driver for use in size-constrained
environments.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/gx.h |  5 +++
 drivers/mmc/meson_gx_mmc.c           | 77 ++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/gx.h b/arch/arm/include/asm/arch-meson/gx.h
index 26ec5d0bc34..8cfc6b00329 100644
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
index 5852b24c6d2..d1558ebe3a2 100644
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
@@ -67,10 +69,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	 * Other SoCs use CLK_CO_PHASE_180 by default.
 	 * It needs to find what is a proper value about each SoCs.
 	 */
+#if CONFIG_IS_ENABLED(DM_MMC)
 	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
 		meson_mmc_clk |= CLK_CO_PHASE_270;
 	else
 		meson_mmc_clk |= CLK_CO_PHASE_180;
+#else /* U-Boot SPL on GX SoCs */
+	meson_mmc_clk |= CLK_CO_PHASE_180;
+#endif
 
 	/* 180 phase tx clock */
 	meson_mmc_clk |= CLK_TX_PHASE_000;
@@ -82,9 +88,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
 	meson_write(mmc, meson_mmc_clk, MESON_SD_EMMC_CLOCK);
 }
 
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int meson_dm_mmc_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+#else /* U-Boot SPL */
+static int meson_legacy_mmc_set_ios(struct mmc *mmc)
+{
+#endif
 	uint32_t meson_mmc_cfg;
 
 	meson_mmc_config_clock(mmc);
@@ -193,10 +204,16 @@ static void meson_mmc_read_response(struct mmc *mmc, struct mmc_cmd *cmd)
 	}
 }
 
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 				 struct mmc_data *data)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
+#else /* U-Boot SPL */
+static int meson_legacy_mmc_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
+				     struct mmc_data *data)
+{
+#endif
 	struct meson_mmc_plat *pdata = mmc->priv;
 	uint32_t status;
 	ulong start;
@@ -235,6 +252,59 @@ static int meson_dm_mmc_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 	return ret;
 }
 
+#if !CONFIG_IS_ENABLED(DM_MMC) /* Non-DM MMC driver for use in U-Boot SPL */
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
+#else /* DM-based driver for use in U-Boot proper */
 static const struct dm_mmc_ops meson_dm_mmc_ops = {
 	.send_cmd = meson_dm_mmc_send_cmd,
 	.set_ios = meson_dm_mmc_set_ios,
@@ -282,6 +352,12 @@ static int meson_mmc_probe(struct udevice *dev)
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
 
@@ -336,3 +412,4 @@ U_BOOT_DRIVER(meson_mmc) = {
 	.of_to_plat = meson_mmc_of_to_plat,
 	.plat_auto	= sizeof(struct meson_mmc_plat),
 };
+#endif /* CONFIG_IS_ENABLED(DM_MMC) */

-- 
2.51.2


