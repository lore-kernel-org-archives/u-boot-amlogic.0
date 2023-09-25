Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 by mx.groups.io with SMTP id smtpd.web10.5075.1695678921216682361
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Sep 2023 14:55:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=zMsGuIfJvgsb3hYh3zub+/OtyK8e4FVprM0ct46kaZw=;
	b=mF3G8A8/X0v0b4dg3+tN2qT9ypZ1sqQjJ3r49wJxFA8APRRD9l6QymzsfUPOwlga4gr6
	xdpvta4mr3JPH1jMqwsRsdckmLi6nUGrOnsKXamzfNt6kIbuJZ0iPkln6G9ffB2wBP4N4P
	zMOi/VBWPvNFj9SL32Vsem7RmeH7SoPWuqAqF1PWkOpDAnZlv4ltdJd+11yd+Ji1Ur3+F2
	QjCdSQbHXrcoXGqpicWgSfiNc6tN5s84g11cyFm7nnPM/LoblKZWkijovHgTRV9maqipDL
	X2SD550PsRjNiwGG/Cymqtj+i9OE4YAsaxJA7YVGo8Ocsxt4UXoFrw15nGgPZzNw==
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building SPL
Date: Mon, 25 Sep 2023 21:55:19 +0000 (UTC)
Message-ID: <20230925215516.1528643-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

With MMC_PWRSEQ enabled the following link issue may happen when
building SPL and SPL_PWRSEQ is not enabled.

  aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meson_mmc_probe':
  drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_power'

Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
pwrseq support in SPL.

Also add depends on DM_GPIO to fix following link issue:

  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pwrseq_set_power':
  drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_name'
  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined reference to `dm_gpio_set_value'
  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined reference to `dm_gpio_set_value'

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mmc/Kconfig           | 10 +++++++++-
 drivers/mmc/Makefile          |  2 +-
 drivers/mmc/meson_gx_mmc.c    |  2 +-
 drivers/mmc/rockchip_dw_mmc.c |  2 +-
 include/mmc.h                 |  4 ++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index de01b9687bad..a9931d39412d 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -20,11 +20,19 @@ config MMC_WRITE
 
 config MMC_PWRSEQ
 	bool "HW reset support for eMMC"
-	depends on PWRSEQ
+	depends on PWRSEQ && DM_GPIO
 	help
 	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
 	  devices.
 
+config SPL_MMC_PWRSEQ
+	bool "HW reset support for eMMC in SPL"
+	depends on SPL_PWRSEQ && SPL_DM_GPIO
+	default y if MMC_PWRSEQ
+	help
+	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
+	  devices in SPL.
+
 config MMC_BROKEN_CD
 	bool "Poll for broken card detection case"
 	help
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 2c65c4765ab2..0a79dd058bef 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
-obj-$(CONFIG_MMC_PWRSEQ) += mmc-pwrseq.o
+obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
 
 ifndef CONFIG_$(SPL_)BLK
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index fcf4f03d1e24..0825c0a2a838 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
 
 	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	/* Enable power if needed */
 	ret = mmc_pwrseq_get_power(dev, cfg);
 	if (!ret) {
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 72c820ee6330..ad4529d6afa8 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 
 	host->fifo_mode = priv->fifo_mode;
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	/* Enable power if needed */
 	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
 	if (!ret) {
diff --git a/include/mmc.h b/include/mmc.h
index 1022db3ffa7c..9aef31ea5deb 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -590,7 +590,7 @@ struct mmc_config {
 	uint f_max;
 	uint b_max;
 	unsigned char part_type;
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	struct udevice *pwr_dev;
 #endif
 };
@@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
  */
 int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 /**
  * mmc_pwrseq_get_power() - get a power device from device tree
  *
-- 
2.42.0

