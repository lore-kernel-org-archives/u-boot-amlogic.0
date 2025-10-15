Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262ACCD185
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:24 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
 by mx.groups.io with SMTP id smtpd.web11.22369.1760545574098486446
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 09:26:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=qpNqjB4F;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.172, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760545572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NqDIUXSxlNtLuXcRwJW1BdBFfXYZ6BNIfI40USl2Kk=;
	b=qpNqjB4FhXmhA7xdUzIUce8C6YP5ekM0B0ugzgN27Pheh1QggtdRQ4hgZ+u2lmuEFsEhL3
	xgBHHjaLPvyes/2tXcsDubkQZcK+65lE4rTu+dcgLurRIRc2eeojO+2iiEdROjjZ6zvSgG
	DlBMexyjXmltUPjICyfXjRTq8R3shhGTLiuKTfOLgWwW+nZ+X1B2R3Izu8a/yGE53BBxq7
	iEvb8BXwibjXxwZ5CPdzj3MzOjquCS/EZPK9SKMI4/8olDcgv/NL3KG/ldMJ/HVEveYb8H
	EQDNraemfJsQWHuA5dwnpOcXmVZMSx04pSJouZOQecODDS+kLY7a+qjY7n+WzA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:49 +0000
Subject: [PATCH v4 2/8] mmc: meson_gx_mmc: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-spl-gx-v4-2-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
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
 bh=58d75lvMpdAohq/Kw1m2tbrFsmiVO+flxwNNPql8uww=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78seuKnDDkv0STldfcs0hWbbipPPsxvqHg7B/
 FDZjEX4vUGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHgAKCRCEr8vQ14ma
 A2zhD/4mbaOiE72qN0FHMXoS2jsPk5DYHluSxPSb7jWGG4uUdK+XqK3vTTLu480qortBuNEoCdR
 iI03Izu83CHqjGeI1mT+7UHVkHPbGVJCcX/fd/lsOX7WpnFCn7uZ7SquIsnM+TcXpdsN+4dzrwq
 hYHjSF6SH9zhZA5Eg4opvH5BkmP7DGd2BFJvZp/rkdrF7X+Fy6Ffxl5mkjkvamN/aeRX6puXCKc
 ckOqaLES7I4Wi+TAYHq5LFOKXXuEJDIVfZ2QvL45imRLABOCOFIoIjJ/yRmAOl3HpjnWM3uja/F
 bNw7/fH/ioDclEP688hjrMkU7MbPmVixxaJGDr/rOLs4EvGrshMaWy5rKKcJKyOgj70HtsBHrXf
 RX0UauL15HyhR+bdLQTupysMZJJV1aFLpZhoRY8RxPUsh20ltyMDpwQ5I3iQW6TGTaltJb+Z6Sn
 b+8qwbTx+wj6kfVMwdr/5pDQREdBXB1nrhxQIB2EGoUvywh2Byo4ETRLQi0FvgUoNjP5ajN4G0H
 F5C7Pd3P479qKyvxuCymIdjo7MSmx3v3yeK7NAA22xhCBRsAD3UvRNETHne4ABsE5mUBF0VUW/J
 hcCrqUmvFSFDsR9fea9P5reK8H18m+P1AkyJAmrxLiym0PHe0rT07txQv2twgFipVJqGoeOF+i0
 VvLSj71deK8/DkA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 16:26:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2812

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
2.51.0


