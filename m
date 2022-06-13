Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.6265.1655128889801031072
 for <u-boot-amlogic@groups.io>;
 Mon, 13 Jun 2022 07:01:30 -0700
Received: by mail-wm1-f49.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso3166056wml.1
        for <u-boot-amlogic@groups.io>; Mon, 13 Jun 2022 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+lXB34SkI8aDJNmLYH6SVyGOAPNL4+vRXIVTafAwqQ=;
        b=gGIJXTdAQ9sdYflGyJigVDm+87/uF0RIlIga1OjKmX0qIi6JDVTG8jz9h6pgk5U2QJ
         FxpdvnRC04o9BKcQhL6GmKJy1PlYae7YQ2s9QGLqsCpjwI3JC2jzyJWD/iSdwVeq8fR9
         Cg2KSkWeZPVfE6i83C/hUkaD8EpYp3g//2q55MIiIOrWCZq4MtQVtsk28PQLxeikj2Di
         QK65wmtMUPaSU1li4r5bxd7nhBfuXmmSttLdxZl53DrME8UV4//G3aSmfuvXsbSMjj95
         paJQheEbFCsv3q/NM8CZB06P6HMRfjW6qVxPdkA+6S7y2lo79pVtwkmsOG0vtT1+UzbE
         FmpQ==
Return-Path: <pboos@baylibre.com>
From: Philippe Boos <pboos@baylibre.com>
Subject: [PATCH v2] watchdog: add amlogic watchdog support
Date: Mon, 13 Jun 2022 16:00:56 +0200
Message-Id: <20220613140056.10316-1-pboos@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Stefan Roese <sr@denx.de>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Philippe Boos <pboos@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, Jerome Brunet <jbrunet@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for hardware watchdog timer for Amlogic SoCs.
This driver has been heavily inspired by his Linux equivalent
(meson_gxbb_wdt.c).

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Philippe Boos <pboos@baylibre.com>

---

Your recommendations have been implemented. I let you check this version 2.
The reset works well when triggered by the wdt command in u-boot.

This watchdog driver has been tested on a GXL libretech-cc board and also on
a custom G12a board. I did the following test cases:
 * boot with a faulty boot command, then we reach watchdog reset successfully,
 * boot a Linux kernel with and without watchdog support, and check if it is
   working as expected.


 MAINTAINERS                       |   1 +
 doc/board/amlogic/index.rst       |   2 +
 drivers/watchdog/Kconfig          |   7 ++
 drivers/watchdog/Makefile         |   1 +
 drivers/watchdog/meson_gxbb_wdt.c | 136 ++++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 drivers/watchdog/meson_gxbb_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4d38238..ab3ef041f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -160,6 +160,7 @@ F:	drivers/spi/meson_spifc.c
 F:	drivers/pinctrl/meson/
 F:	drivers/power/domain/meson-gx-pwrc-vpu.c
 F:	drivers/video/meson/
+F:	drivers/watchdog/meson_gxbb_wdt.c
 F:	include/configs/meson64.h
 F:	include/configs/meson64_android.h
 F:	doc/board/amlogic/
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 9c7fadf2c0..cc2ba50889 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -73,6 +73,8 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 | PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*        | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
+| Watchdog                      | *N/A*     | **Yes**         | *N/A*        | *N/A*       | *N/A*      | *N/A*       | *N/A*        |
++-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 
 Boot Documentation
 ------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c3eb8a8aec..da0fa5396f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -175,6 +175,13 @@ config WDT_MAX6370
 	help
 	  Select this to enable max6370 watchdog timer.
 
+config WDT_MESON_GXBB
+	bool "Amlogic watchdog timer support"
+	depends on WDT
+	help
+	  Select this to enable Meson watchdog timer,
+	  which can be found on some Amlogic platforms.
+
 config WDT_MPC8xx
 	bool "MPC8xx watchdog timer support"
 	depends on WDT && MPC8xx
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 1f6199beca..0e2f582a5f 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_WDT_ORION) += orion_wdt.o
 obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
 obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
+obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
 obj-$(CONFIG_WDT_MPC8xx) += mpc8xx_wdt.o
 obj-$(CONFIG_WDT_MT7620) += mt7620_wdt.o
 obj-$(CONFIG_WDT_MT7621) += mt7621_wdt.o
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
new file mode 100644
index 0000000000..6ab005813f
--- /dev/null
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2022 BayLibre, SAS.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <reset.h>
+#include <wdt.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+#define GXBB_WDT_CTRL_REG			0x0
+#define GXBB_WDT_TCNT_REG			0x8
+#define GXBB_WDT_RSET_REG			0xc
+
+#define GXBB_WDT_CTRL_SYS_RESET_NOW		BIT(26)
+#define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
+#define GXBB_WDT_CTRL_CLK_EN			BIT(24)
+#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
+#define GXBB_WDT_CTRL_EN			BIT(18)
+
+#define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
+#define GXBB_WDT_TCNT_SETUP_MASK		GENMASK(15, 0)
+
+
+struct amlogic_wdt_priv {
+	void __iomem *reg_base;
+};
+
+static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+
+	if (timeout_ms > GXBB_WDT_TCNT_SETUP_MASK) {
+		dev_warn(dev, "%s: timeout_ms=%llu: maximum watchdog timeout exceeded\n",
+		         __func__, timeout_ms);
+		timeout_ms = GXBB_WDT_TCNT_SETUP_MASK;
+	}
+
+	writel(timeout_ms, data->reg_base + GXBB_WDT_TCNT_REG);
+
+	return 0;
+}
+
+static int amlogic_wdt_stop(struct udevice *dev)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+
+	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) & ~GXBB_WDT_CTRL_EN,
+	       data->reg_base + GXBB_WDT_CTRL_REG);
+
+	return 0;
+}
+
+static int amlogic_wdt_start(struct udevice *dev, u64 time_ms, ulong flags)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+
+	writel(readl(data->reg_base + GXBB_WDT_CTRL_REG) | GXBB_WDT_CTRL_EN,
+	       data->reg_base + GXBB_WDT_CTRL_REG);
+
+	return amlogic_wdt_set_timeout(dev, time_ms);
+}
+
+static int amlogic_wdt_reset(struct udevice *dev)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+
+	writel(0, data->reg_base + GXBB_WDT_RSET_REG);
+
+	return 0;
+}
+
+static int amlogic_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+
+	writel(0, data->reg_base + GXBB_WDT_CTRL_SYS_RESET_NOW);
+
+	return 0;
+}
+
+static int amlogic_wdt_probe(struct udevice *dev)
+{
+	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+	int ret;
+
+	data->reg_base = dev_remap_addr(dev);
+	if (!data->reg_base)
+		return -EINVAL;
+
+	struct clk clk;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&clk);
+	if (ret) {
+		clk_free(&clk);
+		return ret;
+	}
+
+	/* Setup with 1ms timebase */
+	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
+	       GXBB_WDT_CTRL_EE_RESET |
+	       GXBB_WDT_CTRL_CLK_EN |
+	       GXBB_WDT_CTRL_CLKDIV_EN,
+	       data->reg_base + GXBB_WDT_CTRL_REG);
+
+	return 0;
+}
+
+static const struct wdt_ops amlogic_wdt_ops = {
+	.start = amlogic_wdt_start,
+	.reset = amlogic_wdt_reset,
+	.stop = amlogic_wdt_stop,
+	.expire_now = amlogic_wdt_expire_now,
+};
+
+static const struct udevice_id amlogic_wdt_ids[] = {
+	{ .compatible = "amlogic,meson-gxbb-wdt" },
+	{}
+};
+
+U_BOOT_DRIVER(amlogic_wdt) = {
+	.name = "amlogic_wdt",
+	.id = UCLASS_WDT,
+	.of_match = amlogic_wdt_ids,
+	.priv_auto = sizeof(struct amlogic_wdt_priv),
+	.probe = amlogic_wdt_probe,
+	.ops = &amlogic_wdt_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.20.1

