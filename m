Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE15E9A74A
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:24:15 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8209.1774307018082566427
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Mar 2026 16:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iG+QOAwD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50b4001af28so34935531cf.1
        for <u-boot-amlogic@groups.io>; Mon, 23 Mar 2026 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1774307017; x=1774911817; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hTCRLHoymAPBArsW36X5D4k8l8yBhAMZQ27e3e32Zs=;
        b=iG+QOAwDMjcFIHrJu7q1NCTWTepTt5qjjMPPaMSF4DWhfYf2dMVNkZUeywqhVlFHep
         AlHTdrURKkp83hkn/2uAWlUvLUIuyr1aWol2go1BHuaHrafgjCAWLZ7+3RGga4h92qcQ
         okI6HGx07qwyOCN0+cqql/CFYljZ4f2TF7ItU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774307017; x=1774911817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTCRLHoymAPBArsW36X5D4k8l8yBhAMZQ27e3e32Zs=;
        b=dReJjzIRDj24nQzZe7GxUk+nwjBaYX4tqCI8HZ61SDoj9oIESt0HQQO9frwvgLHLNa
         3KR6G6vsJYv2V7T/94fkPOi/wCKHRUEskEQIUbtHOivjaTw/H5QjSQqW4+nU/rz29JgX
         M2DXXxEZSFEzHhum6KKhGLGYAIR6q2Mk75c/WH1LW1noW3XFACkIs0tGXqiE5Ov54Pgy
         bOFRXX6hmQkYRj+pfur2OnFcL2epyAsQ3piYHyIl/Tyf7bHs6JlUf0jdtA75qhbqG8zF
         zgDtXkNF/id+3hWkElpiDkQx9flkrsAP6boeZSEE8XP8z6BsbM0CE53XzXxRdVBUQ8BA
         j+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVrkMMikrfYYSF81VRvFYTw/Fcc6oR1Ip0j90LhSxVnHdhHpPFBsCw3475nvI6jJxZLyNcee7r88i1fvmZBXQ==@groups.io
X-Gm-Message-State: AOJu0YzUNvk3g/DcWX2rF49uRoa4VPH69fINmkGAiMlwwuOWcaQ1unsg
	mw2JQiYerZu2eVIfnLO4seyJD+uNjTrqNDE1yJC0RNmtFQkKqkMao94tBRQqJ0T727OVSox41VD
	odv7lN50=
X-Gm-Gg: ATEYQzxo8H2479pYRmNNOl3sNIKdQQXgiIVv/lIHxFvYh2OKzashS1/3QDEtoAi773n
	YQE1uch+f7aK3K8MLhDa+ijp9GTEoUrdFQLjoVLh2xWFBiI2jKUHEdHvsNa1KfeiBQbGyH0q9tD
	8mxY6EU8VCmgscgGCEqW3W3rRM+oaref7scZrzOUDMleyBZZOYWgsN+8hbEn8Va+jAMdYHcRRCR
	C7lPtMtavBh8qFjqs7GodhxusYwTDwpIgXFQ8i6kUUcw1R19h+mIb/86BKQ4mAfXDAAHXyZfI3t
	cEh1q8xJCObglrXzuPAamfNSqRQR/TvVugDykBlNuBPFt8w0q48gzfncBuHIPBtW5HOifcLiqES
	VHAwyOCWai5/HlgPlhAe2tLQj5k+x0Wosqo9D+1beCprtWn8pqgOXSZEDh6xyRfDjYjUPPzH/XI
	e4ODSg7xbvunuO1QNVxlpmEDoMkPYWcDz5QS4M6MUmX3V1xy1D0vwSD9WpMZgVLpZ3Q1yjconf8
	pT8acdtn4nj0v9TtpmRVTcz+dTpqFdT59ytwPRlsfp76m4h0bFbHCJ4UjW2fw==
X-Received: by 2002:a05:6830:8283:b0:7d7:d1f1:1031 with SMTP id 46e09a7af769-7d7eb028de9mr10150549a34.20.1774306544548;
        Mon, 23 Mar 2026 15:55:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net. [189.203.97.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadce96dsm10640999a34.18.2026.03.23.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:55:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
	Bin Meng <bmeng.cn@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Heiko Schocher <hs@nabladev.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jerome Forissier <jerome.forissier@arm.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	=?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Peng Fan <peng.fan@nxp.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Simon Glass <sjg@chromium.org>,
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Tien Fong Chee <tien.fong.chee@altera.com>,
	u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	u-boot-qcom@groups.io,
	linux@analog.com
Subject: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Date: Mon, 23 Mar 2026 16:55:37 -0600
Message-ID: <20260323225537.896180-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 24 Mar 2026 09:24:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2937

The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
all entries here must be unique. This in turn means that all entries in
the code should also be unique in order to not lead to build failures
later with unexpected build combinations. Typically, the problem we have
here is when a driver is obviously based on another driver and didn't
update this particular field and so while the name field reflects
something unique the linker entry itself is not. In a few places this
provides a more suitable string name as well, however.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Łukasz Majewski <lukma@nabladev.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: u-boot-amlogic@groups.io
Cc: uboot-stm32@st-md-mailman.stormreply.com
Cc: u-boot-qcom@groups.io
Cc: linux@analog.com
---
 arch/x86/cpu/broadwell/sdram.c             | 2 +-
 arch/x86/cpu/ivybridge/early_me.c          | 2 +-
 board/liebherr/btt/btt.c                   | 2 +-
 board/liebherr/xea/xea.c                   | 2 +-
 drivers/block/efi_blk.c                    | 2 +-
 drivers/clk/at91/compat.c                  | 4 ++--
 drivers/clk/at91/sckc.c                    | 2 +-
 drivers/clk/meson/a1.c                     | 2 +-
 drivers/clk/meson/gxbb.c                   | 2 +-
 drivers/clk/nuvoton/clk_npcm7xx.c          | 2 +-
 drivers/clk/nuvoton/clk_npcm8xx.c          | 2 +-
 drivers/clk/stm32/clk-stm32mp13.c          | 2 +-
 drivers/dma/ti/k3-udma.c                   | 2 +-
 drivers/i2c/tegra186_bpmp_i2c.c            | 2 +-
 drivers/mmc/bcm2835_sdhci.c                | 2 +-
 drivers/mmc/fsl_esdhc_imx.c                | 2 +-
 drivers/mmc/rockchip_sdhci.c               | 2 +-
 drivers/net/calxedaxgmac.c                 | 2 +-
 drivers/net/dwc_eth_xgmac.c                | 2 +-
 drivers/net/qe/dm_qe_uec_phy.c             | 2 +-
 drivers/net/sni_netsec.c                   | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 2 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c    | 4 ++--
 drivers/reset/stm32/stm32-reset-mp1.c      | 2 +-
 drivers/spi/kirkwood_spi.c                 | 4 ++--
 drivers/spi/mvebu_a3700_spi.c              | 4 ++--
 drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c         | 2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c          | 2 +-
 drivers/usb/host/ehci-exynos.c             | 2 +-
 drivers/usb/host/ehci-msm.c                | 2 +-
 drivers/usb/host/ehci-tegra.c              | 2 +-
 drivers/usb/host/ehci-vf.c                 | 2 +-
 drivers/usb/host/ohci-da8xx.c              | 2 +-
 drivers/usb/musb-new/pic32.c               | 2 +-
 drivers/usb/musb-new/sc5xx.c               | 2 +-
 drivers/usb/musb-new/sunxi.c               | 2 +-
 drivers/video/rockchip/rk3288_mipi.c       | 4 ++--
 drivers/video/rockchip/rk3399_mipi.c       | 4 ++--
 drivers/watchdog/arm_smc_wdt.c             | 2 +-
 40 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdram.c
index cd534a17cf15..1ba7f403c8a1 100644
--- a/arch/x86/cpu/broadwell/sdram.c
+++ b/arch/x86/cpu/broadwell/sdram.c
@@ -205,7 +205,7 @@ static const struct udevice_id broadwell_syscon_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(syscon_intel_me) = {
+U_BOOT_DRIVER(syscon_intel_me_broadwell) = {
 	.name = "intel_me_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = broadwell_syscon_ids,
diff --git a/arch/x86/cpu/ivybridge/early_me.c b/arch/x86/cpu/ivybridge/early_me.c
index ac868025f8ed..ca73fc21262e 100644
--- a/arch/x86/cpu/ivybridge/early_me.c
+++ b/arch/x86/cpu/ivybridge/early_me.c
@@ -166,7 +166,7 @@ static const struct udevice_id ivybridge_syscon_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(syscon_intel_me) = {
+U_BOOT_DRIVER(syscon_intel_me_ivybridge) = {
 	.name = "intel_me_syscon",
 	.id = UCLASS_SYSCON,
 	.of_match = ivybridge_syscon_ids,
diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
index dc683bd082ad..e1ff041c54f5 100644
--- a/board/liebherr/btt/btt.c
+++ b/board/liebherr/btt/btt.c
@@ -421,7 +421,7 @@ static const struct udevice_id imx28_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(fsl_imx28_clkctrl) = {
+U_BOOT_DRIVER(btt_dummy_fsl_imx28_clkctrl) = {
 	.name           = "fsl_imx28_clkctrl",
 	.id             = UCLASS_CLK,
 	.of_match       = imx28_clk_ids,
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 9630e7f576b2..a277163683c1 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -351,7 +351,7 @@ static const struct udevice_id imx28_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(fsl_imx28_clkctrl) = {
+U_BOOT_DRIVER(xea_dummy_fsl_imx28_clkctrl) = {
 	.name           = "fsl_imx28_clkctrl",
 	.id             = UCLASS_CLK,
 	.of_match       = imx28_clk_ids,
diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
index f3ae70290e7e..a1714c41d00b 100644
--- a/drivers/block/efi_blk.c
+++ b/drivers/block/efi_blk.c
@@ -79,7 +79,7 @@ static const struct blk_ops efi_blk_ops = {
 	.write	= efi_bl_write,
 };
 
-U_BOOT_DRIVER(efi_block) = {
+U_BOOT_DRIVER(efi_media_block) = {
 	.name		= "efi_block",
 	.id		= UCLASS_BLK,
 	.ops		= &efi_blk_ops,
diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index 1d738f160b6e..2449ac9fae6e 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -136,7 +136,7 @@ static const struct udevice_id at91_sckc_match[] = {
 	{}
 };
 
-U_BOOT_DRIVER(at91_sckc) = {
+U_BOOT_DRIVER(at91sam9x5_sckc) = {
 	.name = "at91-sckc",
 	.id = UCLASS_SIMPLE_BUS,
 	.of_match = at91_sckc_match,
@@ -368,7 +368,7 @@ static const struct udevice_id at91_system_clk_match[] = {
 	{}
 };
 
-U_BOOT_DRIVER(at91_system_clk) = {
+U_BOOT_DRIVER(at91rm9200_system_clk) = {
 	.name = "at91-system-clk",
 	.id = UCLASS_MISC,
 	.of_match = at91_system_clk_match,
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 3fde8ea71382..dcaffd360fdf 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -162,7 +162,7 @@ static const struct udevice_id sam9x60_sckc_ids[] = {
 	{ /* Sentinel. */ },
 };
 
-U_BOOT_DRIVER(at91_sckc) = {
+U_BOOT_DRIVER(sam9x60_sckc) = {
 	.name = UBOOT_DM_CLK_AT91_SCKC,
 	.id = UCLASS_CLK,
 	.of_match = sam9x60_sckc_ids,
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index a1b8d7914910..669247a9a09c 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -712,7 +712,7 @@ static struct clk_ops meson_clk_ops = {
 #endif
 };
 
-U_BOOT_DRIVER(meson_clk) = {
+U_BOOT_DRIVER(meson_clk_a1) = {
 	.name		= "meson-clk-a1",
 	.id		= UCLASS_CLK,
 	.of_match	= meson_clk_ids,
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 51f124869c9c..218be45c2cb9 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -962,7 +962,7 @@ static const struct udevice_id meson_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(meson_clk) = {
+U_BOOT_DRIVER(meson_clk_gxbb) = {
 	.name		= "meson_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= meson_clk_ids,
diff --git a/drivers/clk/nuvoton/clk_npcm7xx.c b/drivers/clk/nuvoton/clk_npcm7xx.c
index b23dd37af6c8..4c787823d053 100644
--- a/drivers/clk/nuvoton/clk_npcm7xx.c
+++ b/drivers/clk/nuvoton/clk_npcm7xx.c
@@ -84,7 +84,7 @@ static const struct udevice_id npcm7xx_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(clk_npcm) = {
+U_BOOT_DRIVER(clk_npcm750) = {
 	.name           = "clk_npcm",
 	.id             = UCLASS_CLK,
 	.of_match       = npcm7xx_clk_ids,
diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/clk_npcm8xx.c
index d1b32e32371e..c7a510f5c256 100644
--- a/drivers/clk/nuvoton/clk_npcm8xx.c
+++ b/drivers/clk/nuvoton/clk_npcm8xx.c
@@ -87,7 +87,7 @@ static const struct udevice_id npcm8xx_clk_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(clk_npcm) = {
+U_BOOT_DRIVER(clk_npcm845) = {
 	.name           = "clk_npcm",
 	.id             = UCLASS_CLK,
 	.of_match       = npcm8xx_clk_ids,
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index 39ec06a9556c..5e88cf63e204 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -2193,7 +2193,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-U_BOOT_DRIVER(stm32mp1_clock) = {
+U_BOOT_DRIVER(stm32mp13_clock) = {
 	.name = "stm32mp13_clk",
 	.id = UCLASS_CLK,
 	.ops = &stm32_clk_ops,
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 018243109952..5b440bb38b80 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2866,7 +2866,7 @@ static const struct udevice_id udma_ids[] = {
 	{ /* Sentinel */ },
 };
 
-U_BOOT_DRIVER(ti_edma3) = {
+U_BOOT_DRIVER(ti_udma) = {
 	.name	= "ti-udma",
 	.id	= UCLASS_DMA,
 	.of_match = udma_ids,
diff --git a/drivers/i2c/tegra186_bpmp_i2c.c b/drivers/i2c/tegra186_bpmp_i2c.c
index d30eb5231229..b76ef016cda3 100644
--- a/drivers/i2c/tegra186_bpmp_i2c.c
+++ b/drivers/i2c/tegra186_bpmp_i2c.c
@@ -117,7 +117,7 @@ static const struct udevice_id tegra186_bpmp_i2c_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(i2c_gpio) = {
+U_BOOT_DRIVER(tegra186_bpmp_i2c) = {
 	.name	= "tegra186_bpmp_i2c",
 	.id	= UCLASS_I2C,
 	.of_match = tegra186_bpmp_i2c_ids,
diff --git a/drivers/mmc/bcm2835_sdhci.c b/drivers/mmc/bcm2835_sdhci.c
index 598a51d914a9..655d9902dfa9 100644
--- a/drivers/mmc/bcm2835_sdhci.c
+++ b/drivers/mmc/bcm2835_sdhci.c
@@ -243,7 +243,7 @@ static const struct udevice_id bcm2835_sdhci_match[] = {
 	{ /* sentinel */ }
 };
 
-U_BOOT_DRIVER(sdhci_cdns) = {
+U_BOOT_DRIVER(sdhci_bcm2835) = {
 	.name = "sdhci-bcm2835",
 	.id = UCLASS_MMC,
 	.of_match = bcm2835_sdhci_match,
diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 335b44a8a1a0..87125493c0dc 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1686,7 +1686,7 @@ static int fsl_esdhc_bind(struct udevice *dev)
 	return mmc_bind(dev, &plat->mmc, &plat->cfg);
 }
 
-U_BOOT_DRIVER(fsl_esdhc) = {
+U_BOOT_DRIVER(fsl_esdhc_imx) = {
 	.name	= "fsl_esdhc",
 	.id	= UCLASS_MMC,
 	.of_match = fsl_esdhc_ids,
diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 8116e464278f..b685da8643c3 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -745,7 +745,7 @@ static const struct udevice_id sdhci_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(arasan_sdhci_drv) = {
+U_BOOT_DRIVER(rockchip_sdhci_5_1_drv) = {
 	.name		= "rockchip_sdhci_5_1",
 	.id		= UCLASS_MMC,
 	.of_match	= sdhci_ids,
diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
index ebb399457fb5..92990fa6d479 100644
--- a/drivers/net/calxedaxgmac.c
+++ b/drivers/net/calxedaxgmac.c
@@ -597,7 +597,7 @@ static const struct udevice_id xgmac_eth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(eth_xgmac) = {
+U_BOOT_DRIVER(calxeda_hb_xgmac) = {
 	.name		= "eth_xgmac",
 	.id		= UCLASS_ETH,
 	.of_match	= xgmac_eth_ids,
diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index 458b87af7a27..add1ea2e978f 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -1206,7 +1206,7 @@ static const struct udevice_id xgmac_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(eth_xgmac) = {
+U_BOOT_DRIVER(dwc_eth_xgmac) = {
 	.name = "eth_xgmac",
 	.id = UCLASS_ETH,
 	.of_match = of_match_ptr(xgmac_ids),
diff --git a/drivers/net/qe/dm_qe_uec_phy.c b/drivers/net/qe/dm_qe_uec_phy.c
index 8c0168be859e..107c7686b3b5 100644
--- a/drivers/net/qe/dm_qe_uec_phy.c
+++ b/drivers/net/qe/dm_qe_uec_phy.c
@@ -152,7 +152,7 @@ static const struct udevice_id qe_uec_mdio_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mvmdio) = {
+U_BOOT_DRIVER(qe_uec_mdio) = {
 	.name			= "qe_uec_mdio",
 	.id			= UCLASS_MDIO,
 	.of_match		= qe_uec_mdio_ids,
diff --git a/drivers/net/sni_netsec.c b/drivers/net/sni_netsec.c
index 71afe78fd28a..b74a5c27cae1 100644
--- a/drivers/net/sni_netsec.c
+++ b/drivers/net/sni_netsec.c
@@ -1138,7 +1138,7 @@ static const struct udevice_id netsec_ids[] = {
 	{}
 };
 
-U_BOOT_DRIVER(ave) = {
+U_BOOT_DRIVER(synquacer_netsec) = {
 	.name     = "synquacer_netsec",
 	.id       = UCLASS_ETH,
 	.of_match = netsec_ids,
diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 67114df6824a..29cfdcaa7f89 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1283,7 +1283,7 @@ static const struct udevice_id meson_g12a_pinctrl_match[] = {
 	{ },
 };
 
-U_BOOT_DRIVER(meson_axg_pinctrl) = {
+U_BOOT_DRIVER(meson_g12a_pinctrl) = {
 	.name = "meson-g12a-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(meson_g12a_pinctrl_match),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index c32d590a7e0e..b3727b917dc8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -182,8 +182,8 @@ static const struct udevice_id tegra_pinctrl_ids[] = {
 	{ },
 };
 
-U_BOOT_DRIVER(tegra_pinctrl) = {
-	.name		= "tegra_pinctrl",
+U_BOOT_DRIVER(tegra20_pinctrl) = {
+	.name		= "tegra20_pinctrl",
 	.id		= UCLASS_PINCTRL,
 	.of_match	= tegra_pinctrl_ids,
 	.bind		= tegra_pinctrl_bind,
diff --git a/drivers/reset/stm32/stm32-reset-mp1.c b/drivers/reset/stm32/stm32-reset-mp1.c
index ce4532561e5e..e7ac2c6f066b 100644
--- a/drivers/reset/stm32/stm32-reset-mp1.c
+++ b/drivers/reset/stm32/stm32-reset-mp1.c
@@ -46,7 +46,7 @@ static int stm32_reset_probe(struct udevice *dev)
 	return stm32_reset_core_probe(dev, &stm32mp1_reset_data);
 }
 
-U_BOOT_DRIVER(stm32mp25_rcc_reset) = {
+U_BOOT_DRIVER(stm32mp1_rcc_reset) = {
 	.name		= "stm32mp1_reset",
 	.id		= UCLASS_RESET,
 	.probe		= stm32_reset_probe,
diff --git a/drivers/spi/kirkwood_spi.c b/drivers/spi/kirkwood_spi.c
index 095cbea0fca9..bb5ab26685c4 100644
--- a/drivers/spi/kirkwood_spi.c
+++ b/drivers/spi/kirkwood_spi.c
@@ -347,8 +347,8 @@ static const struct udevice_id mvebu_spi_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mvebu_spi) = {
-	.name = "mvebu_spi",
+U_BOOT_DRIVER(kirkwood_spi) = {
+	.name = "kirkwood_spi",
 	.id = UCLASS_SPI,
 	.of_match = mvebu_spi_ids,
 	.ops = &mvebu_spi_ops,
diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.c
index 79836d7e2715..370a52a90b3d 100644
--- a/drivers/spi/mvebu_a3700_spi.c
+++ b/drivers/spi/mvebu_a3700_spi.c
@@ -307,8 +307,8 @@ static const struct udevice_id mvebu_spi_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mvebu_spi) = {
-	.name = "mvebu_spi",
+U_BOOT_DRIVER(mvebu_a3700_spi) = {
+	.name = "mvebu_a3700_spi",
 	.id = UCLASS_SPI,
 	.of_match = mvebu_spi_ids,
 	.ops = &mvebu_spi_ops,
diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
index 6ce30d9eaf0b..e1267ac118ae 100644
--- a/drivers/sysreset/sysreset_socfpga_soc64.c
+++ b/drivers/sysreset/sysreset_socfpga_soc64.c
@@ -80,7 +80,7 @@ static struct sysreset_ops socfpga_sysreset = {
 	.request = socfpga_sysreset_request,
 };
 
-U_BOOT_DRIVER(sysreset_socfpga) = {
+U_BOOT_DRIVER(sysreset_socfpga_soc64) = {
 	.id	= UCLASS_SYSRESET,
 	.name	= "socfpga_sysreset",
 	.ops	= &socfpga_sysreset,
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 41d15996e5b2..49e9c3fa0e99 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -533,7 +533,7 @@ static const struct udevice_id dwc3_meson_g12a_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(dwc3_generic_wrapper) = {
+U_BOOT_DRIVER(dwc3_meson_g12a) = {
 	.name	= "dwc3-meson-g12a",
 	.id	= UCLASS_SIMPLE_BUS,
 	.of_match = dwc3_meson_g12a_ids,
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 5fb9b477adaf..0edf41a4720a 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -430,7 +430,7 @@ static const struct udevice_id dwc3_meson_gxl_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(dwc3_generic_wrapper) = {
+U_BOOT_DRIVER(dwc3_meson_gxl) = {
 	.name	= "dwc3-meson-gxl",
 	.id	= UCLASS_SIMPLE_BUS,
 	.of_match = dwc3_meson_gxl_ids,
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index e1fc04efd2e9..ec21b7c6246c 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -249,7 +249,7 @@ static const struct udevice_id ehci_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_ehci) = {
+U_BOOT_DRIVER(ehci_exynos) = {
 	.name	= "ehci_exynos",
 	.id	= UCLASS_USB,
 	.of_match = ehci_usb_ids,
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 8aeb6a915563..a58eff7cb9c8 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -117,7 +117,7 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
 }
 #endif
 
-U_BOOT_DRIVER(usb_ehci) = {
+U_BOOT_DRIVER(ehci_msm) = {
 	.name	= "ehci_msm",
 	.id	= UCLASS_USB,
 	.of_to_plat = ehci_usb_of_to_plat,
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 89b87886da18..c1f76752cb1e 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -969,7 +969,7 @@ static const struct udevice_id ehci_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_ehci) = {
+U_BOOT_DRIVER(ehci_tegra) = {
 	.name	= "ehci_tegra",
 	.id	= UCLASS_USB,
 	.of_match = ehci_usb_ids,
diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 5afe28ea3033..96d1363a76ea 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -344,7 +344,7 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_ehci) = {
+U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index d321d147c2f9..a36950082afb 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -165,7 +165,7 @@ static const struct udevice_id da8xx_ohci_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(ohci_generic) = {
+U_BOOT_DRIVER(ohci_da8xx) = {
 	.name	= "ohci-da8xx",
 	.id	= UCLASS_USB,
 	.of_match = da8xx_ohci_ids,
diff --git a/drivers/usb/musb-new/pic32.c b/drivers/usb/musb-new/pic32.c
index 0b25e5893b3c..b878e979d93d 100644
--- a/drivers/usb/musb-new/pic32.c
+++ b/drivers/usb/musb-new/pic32.c
@@ -279,7 +279,7 @@ static const struct udevice_id pic32_musb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_musb) = {
+U_BOOT_DRIVER(musb_pic32) = {
 	.name		= "pic32-musb",
 	.id		= UCLASS_USB,
 	.of_match	= pic32_musb_ids,
diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
index 991846818a22..b1765abe8279 100644
--- a/drivers/usb/musb-new/sc5xx.c
+++ b/drivers/usb/musb-new/sc5xx.c
@@ -188,7 +188,7 @@ static const struct udevice_id sc5xx_musb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_musb) = {
+U_BOOT_DRIVER(musb_sc5xx) = {
 	.name		= "sc5xx-musb",
 	.id		= UCLASS_USB,
 	.of_match	= sc5xx_musb_ids,
diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
index b577ba418780..0747f025f2a1 100644
--- a/drivers/usb/musb-new/sunxi.c
+++ b/drivers/usb/musb-new/sunxi.c
@@ -545,7 +545,7 @@ static const struct udevice_id sunxi_musb_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(usb_musb) = {
+U_BOOT_DRIVER(musb_sunxi) = {
 	.name		= "sunxi-musb",
 #ifdef CONFIG_USB_MUSB_HOST
 	.id		= UCLASS_USB,
diff --git a/drivers/video/rockchip/rk3288_mipi.c b/drivers/video/rockchip/rk3288_mipi.c
index 850fe3107549..574ba8c69573 100644
--- a/drivers/video/rockchip/rk3288_mipi.c
+++ b/drivers/video/rockchip/rk3288_mipi.c
@@ -177,8 +177,8 @@ static const struct udevice_id rk_mipi_dsi_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(rk_mipi_dsi) = {
-	.name	= "rk_mipi_dsi",
+U_BOOT_DRIVER(rk3288_mipi_dsi) = {
+	.name	= "rk3288_mipi_dsi",
 	.id	= UCLASS_DISPLAY,
 	.of_match = rk_mipi_dsi_ids,
 	.of_to_plat = rk_mipi_of_to_plat,
diff --git a/drivers/video/rockchip/rk3399_mipi.c b/drivers/video/rockchip/rk3399_mipi.c
index 57e36eed6a99..68316df871cb 100644
--- a/drivers/video/rockchip/rk3399_mipi.c
+++ b/drivers/video/rockchip/rk3399_mipi.c
@@ -168,8 +168,8 @@ static const struct udevice_id rk_mipi_dsi_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(rk_mipi_dsi) = {
-	.name	= "rk_mipi_dsi",
+U_BOOT_DRIVER(rk3399_mipi_dsi) = {
+	.name	= "rk3399_mipi_dsi",
 	.id	= UCLASS_DISPLAY,
 	.of_match = rk_mipi_dsi_ids,
 	.of_to_plat = rk_mipi_of_to_plat,
diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wdt.c
index f6854aa9ac93..151dc42d1164 100644
--- a/drivers/watchdog/arm_smc_wdt.c
+++ b/drivers/watchdog/arm_smc_wdt.c
@@ -130,7 +130,7 @@ static const struct udevice_id smcwd_dt_ids[] = {
 	{}
 };
 
-U_BOOT_DRIVER(wdt_sandbox) = {
+U_BOOT_DRIVER(arm_smc_wdt) = {
 	.name = "smcwd",
 	.id = UCLASS_WDT,
 	.of_match = smcwd_dt_ids,
-- 
2.43.0


