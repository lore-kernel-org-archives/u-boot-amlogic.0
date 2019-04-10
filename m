Received: by mail-wr1-f65.google.com with SMTP id k17so3440910wrx.10
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFHQq3PCMkKYvbi3nvPAayhSFJ9qOAotuF5uUaepGsk=;
        b=Y3/ZyfMhiayJj+CuaGEscVqjh5SQa4m3hATzRGfpbcGjNfSQCJNMunEMi/9xxyY0NN
         yZP0mhfCUxfDNroNa9mZ8InPsKOvVGTeEEICZqyVmwOGtYgnMfrN4/1JmrNxB/jPBrjM
         6W3dGhWs7tA9Y7r2ubZZ52I+IIjSt0WE2Iod6L/A6xEdm0M6fuZUn/iRlCokpVFj0N2J
         BK8/ZHYItrtT2aJwbbp6nQj65N1EwxNTbCVQjJofxKNQ8HM/syxY09JcEJqYRWLJzvWV
         v5LK7FOduRvMaEUJhKYrfpQgI2nsdTtmVlDsKIHG0vtG49G4+jLTEg6xLIMVOr7NAZRC
         u4jw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 2/6] clk: create meson directory and move related drivers
Date: Wed, 10 Apr 2019 17:23:44 +0200
Message-Id: <20190410152348.13777-3-narmstrong@baylibre.com>
In-Reply-To: <20190410152348.13777-1-narmstrong@baylibre.com>
References: <20190410152348.13777-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>
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
index f9ee4281d9..f5c1e70605 100644
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

