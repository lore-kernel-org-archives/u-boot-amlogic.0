Received: by mail-wr1-f68.google.com with SMTP id k11so7348560wro.5
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hjZaPWtBO2ePhrJbukdSDBmuszznkmFzrQY6Ji6spNE=;
        b=QX3iBdO+tT0otMK9YWaDyDidhppdg0b1abLh5+LatmU+UWve5mfM2tgA+hHSqTrKAe
         0oWMFXer6RcVuQ5C2iYVAB8slkNsPluIAEYDxFUCXzvj5Puf0YpME5n23AFDrTNA2y9S
         i1fLq9CEb1t5Sjr1frI1pd9pQ7ytLXwssN8fNXxIkEa3QfDBo4brLSHqUJSDFwPB0fz4
         Jjmw7Yud75RxJ1cCd280V9adAQC6C9Byyv1AwKCR6Z4ljyoKZzOdARVDLflMvl5y0Im5
         2ZDo3WFgLaXeZew6P2Z8c2uGvQQF/oVkeOq9IBfJFgZX1oiwUiBDXy521kLy2PKTcVQa
         H7fg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/6] clk: create meson directory and move related drivers
Date: Tue, 26 Mar 2019 16:02:36 +0100
Message-Id: <20190326150240.20620-3-narmstrong@baylibre.com>
In-Reply-To: <20190326150240.20620-1-narmstrong@baylibre.com>
References: <20190326150240.20620-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, sjg@chromium.org, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Jerome Brunet <jbrunet@baylibre.com>

In order to support the Amlogic G12A clock controller,
re-architect the clock files into a meson directory.

No functionnal changes.

MAINTAINERS entry is also updated.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS                                  |  2 +-
 drivers/clk/Kconfig                          |  1 +
 drivers/clk/Makefile                         |  2 +-
 drivers/clk/meson/Kconfig                    | 15 +++++++++++++++
 drivers/clk/meson/Makefile                   |  8 ++++++++
 drivers/clk/{clk_meson_axg.c => meson/axg.c} |  0
 drivers/clk/{ => meson}/clk_meson.h          |  0
 drivers/clk/{clk_meson.c => meson/gxbb.c}    |  0
 8 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/meson/Kconfig
 create mode 100644 drivers/clk/meson/Makefile
 rename drivers/clk/{clk_meson_axg.c => meson/axg.c} (100%)
 rename drivers/clk/{ => meson}/clk_meson.h (100%)
 rename drivers/clk/{clk_meson.c => meson/gxbb.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a4c5d4eab..845ecca758 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,7 +93,7 @@ L:	u-boot-amlogic@groups.io
 T:	git git://git.denx.de/u-boot-amlogic.git
 F:	arch/arm/mach-meson/
 F:	arch/arm/include/asm/arch-meson/
-F:	drivers/clk/clk_meson*
+F:	drivers/clk/meson/
 F:	drivers/serial/serial_meson.c
 F:	drivers/reset/reset-meson.c
 F:	drivers/i2c/meson_i2c.c
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ff60fc5c45..96969b9e30 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -101,6 +101,7 @@ config CLK_STM32MP1
 source "drivers/clk/at91/Kconfig"
 source "drivers/clk/exynos/Kconfig"
 source "drivers/clk/imx/Kconfig"
+source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
 source "drivers/clk/renesas/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1d9d725cae..719b9b8e02 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,7 +12,7 @@ obj-y += imx/
 obj-y += tegra/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
 obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/
-obj-$(CONFIG_ARCH_MESON) += clk_meson.o clk_meson_axg.o
+obj-$(CONFIG_ARCH_MESON) += meson/
 obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip/
 obj-$(CONFIG_ARCH_SOCFPGA) += altera/
 obj-$(CONFIG_CLK_AT91) += at91/
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
new file mode 100644
index 0000000000..2419a30dcb
--- /dev/null
+++ b/drivers/clk/meson/Kconfig
@@ -0,0 +1,15 @@
+config CLK_MESON_GX
+	bool "Enable clock support for Amlogic GX"
+	depends on CLK && ARCH_MESON
+	default MESON_GX
+	help
+	  Enable clock support for the Amlogic GX SoC family, such as
+	  the S905, S905X/D and S912.
+
+config CLK_MESON_AXG
+	bool "Enable clock support for Amlogic AXG"
+	depends on CLK && ARCH_MESON
+	default MESON_AXG
+	help
+	  Enable clock support for the Amlogic AXG SoC family, such as
+	  the A113X/D
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
new file mode 100644
index 0000000000..47a5ad588e
--- /dev/null
+++ b/drivers/clk/meson/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2019 Baylibre, SAS
+# Jerome Brunet <jbrunet@baylibre.com>
+
+obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
+obj-$(CONFIG_CLK_MESON_AXG) += axg.o
+
diff --git a/drivers/clk/clk_meson_axg.c b/drivers/clk/meson/axg.c
similarity index 100%
rename from drivers/clk/clk_meson_axg.c
rename to drivers/clk/meson/axg.c
diff --git a/drivers/clk/clk_meson.h b/drivers/clk/meson/clk_meson.h
similarity index 100%
rename from drivers/clk/clk_meson.h
rename to drivers/clk/meson/clk_meson.h
diff --git a/drivers/clk/clk_meson.c b/drivers/clk/meson/gxbb.c
similarity index 100%
rename from drivers/clk/clk_meson.c
rename to drivers/clk/meson/gxbb.c
-- 
2.21.0

