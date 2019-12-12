Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web09.383.1576111730913536102
 for <u-boot-amlogic@groups.io>;
 Wed, 11 Dec 2019 16:48:51 -0800
Received: by mail-il1-f196.google.com with SMTP id f6so490233ilh.9
        for <u-boot-amlogic@groups.io>; Wed, 11 Dec 2019 16:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BTRd9TGvrzhYEbyAQpguxlLavymbvcg4GVMkqjP01M=;
        b=XPSFzGoKabQTle2X2H1AWqNWYXsvFa9qABx0P0IpULAVGBNxheKMHDt3c9N6g/3KdM
         bNemOpqr9veyUVMF86rpQvDH/QFzRtygsYREg9wpr/h0i7Aik3JDu3Xi03YnWo8n3RvT
         09p6pYLQ7BrDj6fnS7GLTNGo9EnE2UpjxKX3w=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 24/35] common: Move reset_cpu() to the CPU header
Date: Wed, 11 Dec 2019 17:47:43 -0700
Message-Id: <20191212004755.11091-14-sjg@chromium.org>
In-Reply-To: <20191212004755.11091-2-sjg@chromium.org>
References: <20191212004755.11091-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Bai Ping <ping.bai@nxp.com>, Boris Brezillon <boris.brezillon@bootlin.com>, "Cogent Embedded, Inc." <source@cogentembedded.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, David Feng <fenghua@phytium.com.cn>, =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>, Eric Nelson <eric@nelint.com>, Eugen Hristev <eugen.hristev@microchip.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Fabien Parent <fparent@baylibre.com>, Fabio Estevam <festevam@gmail.com>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Hannes Schmelzer <hannes.schmelzer@br-automation.com>, Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Grinberg <grinberg@compulab.co.il>, Joe Hershberger <joe.hershberger@ni.com>, Jon Mason <jon.mason@broadcom.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, Lukasz Majewski <lukma@denx.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>, Matthias Brugger <mbrugger@suse.com>, Max Krummenacher <max.krummenacher@toradex.com>, Michal Simek <michal.simek@xilinx.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong <narmstrong@baylibre.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Oliver Graute <oliver.graute@kococonnector.com>, Otavio Salvador <otavio@ossystems.com.br>, Patrice Chotard <patrice.chotard@st.com>, Patrick Delaunay <patrick.delaunay@st.com>, Peng Fan <peng.fan@nxp.com>, Peter Griffin <peter.griffin@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, Richard Hu <richard.hu@technexion.com>, Rick Chen <rick@andestech.com>, Robert Hancock <hancock@sedsystems.ca>, Ryder Lee <ryder.lee@mediatek.com>, Sergey Temerkhanov <s.temerkhanov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Agner <stefan.agner@toradex.com>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Tetsuyuki Kobayashi <koba@kmckk.co.jp>, Tom Warren <twarren@nvidia.com>, Urja Rannikko <urjaman@gmail.com>, Vanessa Maegima <vanessa.maegima@nxp.com>, Vikas Manocha <vikas.manocha@st.com>, Weijie Gao <weijie.gao@mediatek.com>, Xiaoliang Yang <xiaoliang.yang_1@nxp.com>, liuhao <liuhao@phytium.com.cn>, mingming lee <mingming.lee@mediatek.com>, shuyiqi <shuyiqi@phytium.com.cn>, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com
List-ID: <u-boot-amlogic@groups.io>

Move this function out of common.h and into a relevant header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arc/lib/reset.c                                    | 1 +
 arch/arm/cpu/arm920t/ep93xx/cpu.c                       | 1 +
 arch/arm/cpu/arm920t/imx/timer.c                        | 3 ++-
 arch/arm/cpu/arm926ejs/armada100/timer.c                | 3 ++-
 arch/arm/cpu/arm926ejs/mx25/reset.c                     | 1 +
 arch/arm/cpu/arm926ejs/mx27/reset.c                     | 1 +
 arch/arm/cpu/arm926ejs/mxs/mxs.c                        | 1 +
 arch/arm/cpu/arm926ejs/spear/reset.c                    | 1 +
 arch/arm/cpu/armv7/bcm281xx/reset.c                     | 1 +
 arch/arm/cpu/armv7/bcmcygnus/reset.c                    | 1 +
 arch/arm/cpu/armv7/bcmnsp/reset.c                       | 1 +
 arch/arm/cpu/armv7/stv0991/reset.c                      | 1 +
 arch/arm/cpu/armv8/s32v234/generic.c                    | 1 +
 arch/arm/lib/interrupts.c                               | 3 ++-
 arch/arm/lib/interrupts_m.c                             | 1 +
 arch/arm/lib/reset.c                                    | 1 +
 arch/arm/mach-at91/arm920t/reset.c                      | 1 +
 arch/arm/mach-at91/arm926ejs/reset.c                    | 1 +
 arch/arm/mach-at91/armv7/reset.c                        | 1 +
 arch/arm/mach-bcm283x/reset.c                           | 1 +
 arch/arm/mach-davinci/reset.c                           | 1 +
 arch/arm/mach-imx/mx7ulp/soc.c                          | 1 +
 arch/arm/mach-k3/common.c                               | 1 +
 arch/arm/mach-keystone/ddr3.c                           | 1 +
 arch/arm/mach-kirkwood/cpu.c                            | 1 +
 arch/arm/mach-mediatek/mt8516/init.c                    | 1 +
 arch/arm/mach-mediatek/mt8518/init.c                    | 1 +
 arch/arm/mach-meson/board-common.c                      | 1 +
 arch/arm/mach-mvebu/armada3700/cpu.c                    | 1 +
 arch/arm/mach-omap2/omap5/hwinit.c                      | 1 +
 arch/arm/mach-omap2/reset.c                             | 1 +
 arch/arm/mach-socfpga/misc_gen5.c                       | 1 +
 arch/arm/mach-tegra/cmd_enterrcm.c                      | 1 +
 arch/arm/mach-tegra/pmc.c                               | 1 +
 arch/arm/mach-uniphier/reset.c                          | 1 +
 arch/arm/mach-zynqmp-r5/cpu.c                           | 1 +
 arch/nds32/lib/interrupts.c                             | 1 +
 arch/sh/cpu/sh4/cpu.c                                   | 2 +-
 arch/sh/cpu/sh4/watchdog.c                              | 1 +
 board/BuR/brppt2/board.c                                | 1 +
 board/abilis/tb100/tb100.c                              | 1 +
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c   | 1 +
 board/armltd/vexpress64/vexpress64.c                    | 1 +
 board/atmark-techno/armadillo-800eva/armadillo-800eva.c | 1 +
 board/bosch/shc/board.c                                 | 1 +
 board/broadcom/bcmns2/northstar2.c                      | 1 +
 board/cavium/thunderx/thunderx.c                        | 1 +
 board/compulab/cm_t335/spl.c                            | 1 +
 board/freescale/imx8mm_evk/spl.c                        | 1 +
 board/freescale/imx8mn_evk/spl.c                        | 1 +
 board/freescale/imx8qm_mek/imx8qm_mek.c                 | 1 +
 board/freescale/imx8qxp_mek/imx8qxp_mek.c               | 1 +
 board/freescale/mx6memcal/spl.c                         | 1 +
 board/hisilicon/hikey/hikey.c                           | 1 +
 board/hisilicon/hikey960/hikey960.c                     | 1 +
 board/hisilicon/poplar/poplar.c                         | 1 +
 board/kmc/kzm9g/kzm9g.c                                 | 1 +
 board/liebherr/display5/spl.c                           | 1 +
 board/phytium/durian/durian.c                           | 1 +
 board/qualcomm/dragonboard410c/dragonboard410c.c        | 1 +
 board/qualcomm/dragonboard820c/dragonboard820c.c        | 1 +
 board/renesas/alt/alt.c                                 | 1 +
 board/renesas/alt/alt_spl.c                             | 1 +
 board/renesas/blanche/blanche.c                         | 1 +
 board/renesas/condor/condor.c                           | 1 +
 board/renesas/draak/draak.c                             | 1 +
 board/renesas/eagle/eagle.c                             | 1 +
 board/renesas/ebisu/ebisu.c                             | 1 +
 board/renesas/gose/gose.c                               | 1 +
 board/renesas/gose/gose_spl.c                           | 1 +
 board/renesas/grpeach/grpeach.c                         | 1 +
 board/renesas/koelsch/koelsch.c                         | 1 +
 board/renesas/koelsch/koelsch_spl.c                     | 1 +
 board/renesas/lager/lager.c                             | 1 +
 board/renesas/lager/lager_spl.c                         | 1 +
 board/renesas/porter/porter.c                           | 1 +
 board/renesas/porter/porter_spl.c                       | 1 +
 board/renesas/rcar-common/gen3-spl.c                    | 1 +
 board/renesas/salvator-x/salvator-x.c                   | 1 +
 board/renesas/silk/silk.c                               | 1 +
 board/renesas/silk/silk_spl.c                           | 1 +
 board/renesas/stout/cpld.c                              | 1 +
 board/renesas/stout/stout_spl.c                         | 1 +
 board/synopsys/emsdp/emsdp.c                            | 1 +
 board/synopsys/iot_devkit/iot_devkit.c                  | 1 +
 board/technexion/pico-imx6ul/spl.c                      | 1 +
 board/technexion/pico-imx7d/spl.c                       | 1 +
 board/toradex/apalis-imx8/apalis-imx8.c                 | 1 +
 board/toradex/apalis_imx6/apalis_imx6.c                 | 1 +
 board/toradex/colibri-imx8x/colibri-imx8x.c             | 1 +
 board/toradex/colibri_imx6/colibri_imx6.c               | 1 +
 board/toradex/colibri_imx7/colibri_imx7.c               | 1 +
 board/ucRobotics/bubblegum_96/bubblegum_96.c            | 1 +
 board/xilinx/versal/board.c                             | 1 +
 cmd/tpm_test.c                                          | 1 +
 drivers/sysreset/sysreset-uclass.c                      | 1 +
 drivers/watchdog/imx_watchdog.c                         | 1 +
 drivers/watchdog/ulp_wdog.c                             | 1 +
 include/common.h                                        | 2 --
 include/cpu_func.h                                      | 2 ++
 lib/efi/efi_app.c                                       | 1 +
 101 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/arch/arc/lib/reset.c b/arch/arc/lib/reset.c
index 02e08df48d..30dd4b5238 100644
--- a/arch/arc/lib/reset.c
+++ b/arch/arc/lib/reset.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <common.h>
+#include <cpu_func.h>
 
 __weak void reset_cpu(ulong addr)
 {
diff --git a/arch/arm/cpu/arm920t/ep93xx/cpu.c b/arch/arm/cpu/arm920t/ep93xx/cpu.c
index 3aae12f8ad..c9ea4e46a8 100644
--- a/arch/arm/cpu/arm920t/ep93xx/cpu.c
+++ b/arch/arm/cpu/arm920t/ep93xx/cpu.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/arch/ep93xx.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/cpu/arm920t/imx/timer.c b/arch/arm/cpu/arm920t/imx/timer.c
index 403cd8ae57..21129a7901 100644
--- a/arch/arm/cpu/arm920t/imx/timer.c
+++ b/arch/arm/cpu/arm920t/imx/timer.c
@@ -13,6 +13,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <time.h>
 #if defined (CONFIG_IMX)
 
@@ -79,7 +80,7 @@ ulong get_tbclk(void)
 /*
  * Reset the cpu by setting up the watchdog timer and let him time out
  */
-void reset_cpu (ulong ignored)
+void reset_cpu(ulong ignored)
 {
 	/* Disable watchdog and set Time-Out field to 0 */
 	WCR = 0x00000000;
diff --git a/arch/arm/cpu/arm926ejs/armada100/timer.c b/arch/arm/cpu/arm926ejs/armada100/timer.c
index a11a4f3a5b..f4962ec45f 100644
--- a/arch/arm/cpu/arm926ejs/armada100/timer.c
+++ b/arch/arm/cpu/arm926ejs/armada100/timer.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <time.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/armada100.h>
@@ -138,7 +139,7 @@ int timer_init(void)
  * 2. Write key value to TMP_WSAR reg.
  * 3. Perform write operation.
  */
-void reset_cpu (unsigned long ignored)
+void reset_cpu(unsigned long ignored)
 {
 	struct armd1mpmu_registers *mpmu =
 		(struct armd1mpmu_registers *) ARMD1_MPMU_BASE;
diff --git a/arch/arm/cpu/arm926ejs/mx25/reset.c b/arch/arm/cpu/arm926ejs/mx25/reset.c
index 576f7fac6f..38df1c9402 100644
--- a/arch/arm/cpu/arm926ejs/mx25/reset.c
+++ b/arch/arm/cpu/arm926ejs/mx25/reset.c
@@ -16,6 +16,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 
diff --git a/arch/arm/cpu/arm926ejs/mx27/reset.c b/arch/arm/cpu/arm926ejs/mx27/reset.c
index e2437d13c8..320b0a65e7 100644
--- a/arch/arm/cpu/arm926ejs/mx27/reset.c
+++ b/arch/arm/cpu/arm926ejs/mx27/reset.c
@@ -16,6 +16,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 
diff --git a/arch/arm/cpu/arm926ejs/mxs/mxs.c b/arch/arm/cpu/arm926ejs/mxs/mxs.c
index 85c65dcb44..62ad8b8c25 100644
--- a/arch/arm/cpu/arm926ejs/mxs/mxs.c
+++ b/arch/arm/cpu/arm926ejs/mxs/mxs.c
@@ -10,6 +10,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/cpu/arm926ejs/spear/reset.c b/arch/arm/cpu/arm926ejs/spear/reset.c
index 05c7ecdb49..3b884cd0d3 100644
--- a/arch/arm/cpu/arm926ejs/spear/reset.c
+++ b/arch/arm/cpu/arm926ejs/spear/reset.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/spr_syscntl.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/reset.c b/arch/arm/cpu/armv7/bcm281xx/reset.c
index fbdeea4de3..fda5a9527e 100644
--- a/arch/arm/cpu/armv7/bcm281xx/reset.c
+++ b/arch/arm/cpu/armv7/bcm281xx/reset.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/sysmap.h>
 
diff --git a/arch/arm/cpu/armv7/bcmcygnus/reset.c b/arch/arm/cpu/armv7/bcmcygnus/reset.c
index 7f3f4055e4..3bfed34533 100644
--- a/arch/arm/cpu/armv7/bcmcygnus/reset.c
+++ b/arch/arm/cpu/armv7/bcmcygnus/reset.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 
 #define CRMU_MAIL_BOX1		0x03024028
diff --git a/arch/arm/cpu/armv7/bcmnsp/reset.c b/arch/arm/cpu/armv7/bcmnsp/reset.c
index 674166daab..675f99fe99 100644
--- a/arch/arm/cpu/armv7/bcmnsp/reset.c
+++ b/arch/arm/cpu/armv7/bcmnsp/reset.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 
 #define CRU_RESET_OFFSET	0x1803F184
diff --git a/arch/arm/cpu/armv7/stv0991/reset.c b/arch/arm/cpu/armv7/stv0991/reset.c
index d4b3ab7fd8..008e271dcc 100644
--- a/arch/arm/cpu/armv7/stv0991/reset.c
+++ b/arch/arm/cpu/armv7/stv0991/reset.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/stv0991_wdru.h>
 void reset_cpu(ulong ignored)
diff --git a/arch/arm/cpu/armv8/s32v234/generic.c b/arch/arm/cpu/armv8/s32v234/generic.c
index 50ca4198be..ec4641dcdb 100644
--- a/arch/arm/cpu/armv8/s32v234/generic.c
+++ b/arch/arm/cpu/armv8/s32v234/generic.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <clock_legacy.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/lib/interrupts.c b/arch/arm/lib/interrupts.c
index 75b70d9125..6dbf03b00c 100644
--- a/arch/arm/lib/interrupts.c
+++ b/arch/arm/lib/interrupts.c
@@ -19,6 +19,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <efi_loader.h>
 #include <irq_func.h>
 #include <asm/proc-armv/ptrace.h>
@@ -48,7 +49,7 @@ int disable_interrupts(void)
 void bad_mode (void)
 {
 	panic ("Resetting CPU ...\n");
-	reset_cpu (0);
+	reset_cpu(0);
 }
 
 static void show_efi_loaded_images(struct pt_regs *regs)
diff --git a/arch/arm/lib/interrupts_m.c b/arch/arm/lib/interrupts_m.c
index e4373f3781..1f6fdf2995 100644
--- a/arch/arm/lib/interrupts_m.c
+++ b/arch/arm/lib/interrupts_m.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <irq_func.h>
 
 /*
diff --git a/arch/arm/lib/reset.c b/arch/arm/lib/reset.c
index 3c4512d495..835a40e59d 100644
--- a/arch/arm/lib/reset.c
+++ b/arch/arm/lib/reset.c
@@ -21,6 +21,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <irq_func.h>
 
 __weak void reset_misc(void)
diff --git a/arch/arm/mach-at91/arm920t/reset.c b/arch/arm/mach-at91/arm920t/reset.c
index 3164182b69..d92bc57d66 100644
--- a/arch/arm/mach-at91/arm920t/reset.c
+++ b/arch/arm/mach-at91/arm920t/reset.c
@@ -14,6 +14,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_st.h>
diff --git a/arch/arm/mach-at91/arm926ejs/reset.c b/arch/arm/mach-at91/arm926ejs/reset.c
index 06b25db522..56fbbd991e 100644
--- a/arch/arm/mach-at91/arm926ejs/reset.c
+++ b/arch/arm/mach-at91/arm926ejs/reset.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_rstc.h>
diff --git a/arch/arm/mach-at91/armv7/reset.c b/arch/arm/mach-at91/armv7/reset.c
index c114dafac5..8f4c81d1af 100644
--- a/arch/arm/mach-at91/armv7/reset.c
+++ b/arch/arm/mach-at91/armv7/reset.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_rstc.h>
diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
index cd8138d702..2b4ccd4727 100644
--- a/arch/arm/mach-bcm283x/reset.c
+++ b/arch/arm/mach-bcm283x/reset.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/base.h>
 #include <asm/arch/wdog.h>
diff --git a/arch/arm/mach-davinci/reset.c b/arch/arm/mach-davinci/reset.c
index 9fbd09c77b..4e6031a593 100644
--- a/arch/arm/mach-davinci/reset.c
+++ b/arch/arm/mach-davinci/reset.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/timer_defs.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 8345b01398..7f8fdc7005 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  */
+#include <cpu_func.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index bf631b74f8..17fb8d4cf0 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <spl.h>
 #include "common.h"
 #include <dm.h>
diff --git a/arch/arm/mach-keystone/ddr3.c b/arch/arm/mach-keystone/ddr3.c
index 863ae6321b..23ff06466d 100644
--- a/arch/arm/mach-keystone/ddr3.c
+++ b/arch/arm/mach-keystone/ddr3.c
@@ -6,6 +6,7 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <common.h>
 #include <asm/arch/msmc.h>
diff --git a/arch/arm/mach-kirkwood/cpu.c b/arch/arm/mach-kirkwood/cpu.c
index 29c0e592e4..5e964af8ea 100644
--- a/arch/arm/mach-kirkwood/cpu.c
+++ b/arch/arm/mach-kirkwood/cpu.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <netdev.h>
 #include <asm/cache.h>
diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index 186f6c048a..360d94abb0 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -7,6 +7,7 @@
 
 #include <clk.h>
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <ram.h>
diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index 5a97c8cb26..c2b1b76982 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -8,6 +8,7 @@
 
 #include <clk.h>
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <ram.h>
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index d33e7f1741..bc4c92074c 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <init.h>
 #include <asm/arch/boot.h>
 #include <env.h>
diff --git a/arch/arm/mach-mvebu/armada3700/cpu.c b/arch/arm/mach-mvebu/armada3700/cpu.c
index 7c8e4cade1..c83268181b 100644
--- a/arch/arm/mach-mvebu/armada3700/cpu.c
+++ b/arch/arm/mach-mvebu/armada3700/cpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <linux/libfdt.h>
diff --git a/arch/arm/mach-omap2/omap5/hwinit.c b/arch/arm/mach-omap2/omap5/hwinit.c
index eba21647d9..30045bd505 100644
--- a/arch/arm/mach-omap2/omap5/hwinit.c
+++ b/arch/arm/mach-omap2/omap5/hwinit.c
@@ -12,6 +12,7 @@
  *	Sricharan	<r.sricharan@ti.com>
  */
 #include <common.h>
+#include <cpu_func.h>
 #include <palmas.h>
 #include <asm/armv7.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-omap2/reset.c b/arch/arm/mach-omap2/reset.c
index ea27248e85..2bbd5fcb9b 100644
--- a/arch/arm/mach-omap2/reset.c
+++ b/arch/arm/mach-omap2/reset.c
@@ -9,6 +9,7 @@
  * Sricharan R <r.sricharan@ti.com>
  */
 #include <config.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <linux/compiler.h>
diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
index 22042d0de0..6705a192ca 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <env.h>
 #include <errno.h>
diff --git a/arch/arm/mach-tegra/cmd_enterrcm.c b/arch/arm/mach-tegra/cmd_enterrcm.c
index 5247e52a5a..b2252f3621 100644
--- a/arch/arm/mach-tegra/cmd_enterrcm.c
+++ b/arch/arm/mach-tegra/cmd_enterrcm.c
@@ -25,6 +25,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <irq_func.h>
 #include <asm/arch/tegra.h>
 #include <asm/arch-tegra/pmc.h>
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index afd3c54179..68a211286f 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 
 #include <linux/arm-smccc.h>
 
diff --git a/arch/arm/mach-uniphier/reset.c b/arch/arm/mach-uniphier/reset.c
index 31685d0009..92a8b92547 100644
--- a/arch/arm/mach-uniphier/reset.c
+++ b/arch/arm/mach-uniphier/reset.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <linux/io.h>
 #include <asm/secure.h>
 
diff --git a/arch/arm/mach-zynqmp-r5/cpu.c b/arch/arm/mach-zynqmp-r5/cpu.c
index 98f63e3427..aa5de863eb 100644
--- a/arch/arm/mach-zynqmp-r5/cpu.c
+++ b/arch/arm/mach-zynqmp-r5/cpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/armv7_mpu.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/nds32/lib/interrupts.c b/arch/nds32/lib/interrupts.c
index 88cc7b98d8..1481e05500 100644
--- a/arch/nds32/lib/interrupts.c
+++ b/arch/nds32/lib/interrupts.c
@@ -10,6 +10,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <irq_func.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
diff --git a/arch/sh/cpu/sh4/cpu.c b/arch/sh/cpu/sh4/cpu.c
index f1b8df9b0b..a8d0590d51 100644
--- a/arch/sh/cpu/sh4/cpu.c
+++ b/arch/sh/cpu/sh4/cpu.c
@@ -31,7 +31,7 @@ int cleanup_before_linux (void)
 int do_reset (cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[])
 {
 	disable_interrupts();
-	reset_cpu (0);
+	reset_cpu(0);
 	return 0;
 }
 
diff --git a/arch/sh/cpu/sh4/watchdog.c b/arch/sh/cpu/sh4/watchdog.c
index 7c157bc035..1de32cd419 100644
--- a/arch/sh/cpu/sh4/watchdog.c
+++ b/arch/sh/cpu/sh4/watchdog.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/io.h>
diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c
index 3284ff0936..590e92b5a0 100644
--- a/board/BuR/brppt2/board.c
+++ b/board/BuR/brppt2/board.c
@@ -7,6 +7,7 @@
  *
  */
 #include <common.h>
+#include <cpu_func.h>
 #include <spl.h>
 #include <dm.h>
 #include <miiphy.h>
diff --git a/board/abilis/tb100/tb100.c b/board/abilis/tb100/tb100.c
index 4f8006da00..e3fbbbaa8a 100644
--- a/board/abilis/tb100/tb100.c
+++ b/board/abilis/tb100/tb100.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <netdev.h>
 #include <asm/io.h>
 
diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
index 2f97d5ce96..5017ab8d93 100644
--- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
+++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index 7fe539e4d6..dd0ebdd303 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -5,6 +5,7 @@
  * Sharma Bhupesh <bhupesh.sharma@freescale.com>
  */
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <malloc.h>
 #include <errno.h>
diff --git a/board/atmark-techno/armadillo-800eva/armadillo-800eva.c b/board/atmark-techno/armadillo-800eva/armadillo-800eva.c
index 867fa82c17..a18fb275d9 100644
--- a/board/atmark-techno/armadillo-800eva/armadillo-800eva.c
+++ b/board/atmark-techno/armadillo-800eva/armadillo-800eva.c
@@ -21,6 +21,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
 #include <asm/processor.h>
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index 440d02fdbc..d34f3ba007 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -12,6 +12,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/broadcom/bcmns2/northstar2.c b/board/broadcom/bcmns2/northstar2.c
index 1068edca59..292802f4c0 100644
--- a/board/broadcom/bcmns2/northstar2.c
+++ b/board/broadcom/bcmns2/northstar2.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2016 Broadcom Ltd.
  */
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 
diff --git a/board/cavium/thunderx/thunderx.c b/board/cavium/thunderx/thunderx.c
index 940455de5b..687ade544a 100644
--- a/board/cavium/thunderx/thunderx.c
+++ b/board/cavium/thunderx/thunderx.c
@@ -4,6 +4,7 @@
 **/
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/compulab/cm_t335/spl.c b/board/compulab/cm_t335/spl.c
index 93f834f512..6d5b15aef4 100644
--- a/board/compulab/cm_t335/spl.c
+++ b/board/compulab/cm_t335/spl.c
@@ -10,6 +10,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <errno.h>
 
 #include <asm/arch/ddr_defs.h>
diff --git a/board/freescale/imx8mm_evk/spl.c b/board/freescale/imx8mm_evk/spl.c
index 2d08f9a563..d125dc9317 100644
--- a/board/freescale/imx8mm_evk/spl.c
+++ b/board/freescale/imx8mm_evk/spl.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index cbde9f6b3c..7bc22d905f 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c b/board/freescale/imx8qm_mek/imx8qm_mek.c
index 68be0fe0cf..5f5e5fd6ab 100644
--- a/board/freescale/imx8qm_mek/imx8qm_mek.c
+++ b/board/freescale/imx8qm_mek/imx8qm_mek.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
index 671064fae2..45a7789f91 100644
--- a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
+++ b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/freescale/mx6memcal/spl.c b/board/freescale/mx6memcal/spl.c
index 75375f12c4..be551bc375 100644
--- a/board/freescale/mx6memcal/spl.c
+++ b/board/freescale/mx6memcal/spl.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/clock.h>
diff --git a/board/hisilicon/hikey/hikey.c b/board/hisilicon/hikey/hikey.c
index 28f5cf7fc4..84400090b3 100644
--- a/board/hisilicon/hikey/hikey.c
+++ b/board/hisilicon/hikey/hikey.c
@@ -4,6 +4,7 @@
  * Peter Griffin <peter.griffin@linaro.org>
  */
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <dm/platform_data/serial_pl01x.h>
diff --git a/board/hisilicon/hikey960/hikey960.c b/board/hisilicon/hikey960/hikey960.c
index eb9b99eaa9..84c26e0c14 100644
--- a/board/hisilicon/hikey960/hikey960.c
+++ b/board/hisilicon/hikey960/hikey960.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/board/hisilicon/poplar/poplar.c b/board/hisilicon/poplar/poplar.c
index 4926419a90..304f64a032 100644
--- a/board/hisilicon/poplar/poplar.c
+++ b/board/hisilicon/poplar/poplar.c
@@ -4,6 +4,7 @@
  * Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
+#include <cpu_func.h>
 #include <dm.h>
 #include <common.h>
 #include <asm/io.h>
diff --git a/board/kmc/kzm9g/kzm9g.c b/board/kmc/kzm9g/kzm9g.c
index 8148ace2fe..6ef960b06b 100644
--- a/board/kmc/kzm9g/kzm9g.c
+++ b/board/kmc/kzm9g/kzm9g.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
diff --git a/board/liebherr/display5/spl.c b/board/liebherr/display5/spl.c
index e845edf068..765463e370 100644
--- a/board/liebherr/display5/spl.c
+++ b/board/liebherr/display5/spl.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <serial.h>
 #include <spl.h>
diff --git a/board/phytium/durian/durian.c b/board/phytium/durian/durian.c
index 59f307d357..40dd27a7b0 100644
--- a/board/phytium/durian/durian.c
+++ b/board/phytium/durian/durian.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 #include <asm/io.h>
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 254af7907a..81bd8bd95b 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index 7a889646df..6c096b49a1 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
+#include <cpu_func.h>
 #include <asm/arch/sysmap-apq8096.h>
 #include <env.h>
 #include <linux/arm-smccc.h>
diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
index 10ef7f931b..70c14d9f33 100644
--- a/board/renesas/alt/alt.c
+++ b/board/renesas/alt/alt.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/board/renesas/alt/alt_spl.c b/board/renesas/alt/alt_spl.c
index 4260dff119..dbb210584d 100644
--- a/board/renesas/alt/alt_spl.c
+++ b/board/renesas/alt/alt_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index 08c5448609..7232370d6f 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/arch/mmc.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/rmobile.h>
diff --git a/board/renesas/condor/condor.c b/board/renesas/condor/condor.c
index d1cbbc3339..11fbd5b07d 100644
--- a/board/renesas/condor/condor.c
+++ b/board/renesas/condor/condor.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index 46d9f74785..7ad21f9812 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/renesas/eagle/eagle.c b/board/renesas/eagle/eagle.c
index d6240b19ef..d5f40717d4 100644
--- a/board/renesas/eagle/eagle.c
+++ b/board/renesas/eagle/eagle.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/renesas/ebisu/ebisu.c b/board/renesas/ebisu/ebisu.c
index cb7d432a15..b608c61e23 100644
--- a/board/renesas/ebisu/ebisu.c
+++ b/board/renesas/ebisu/ebisu.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/renesas/gose/gose.c b/board/renesas/gose/gose.c
index f86c9f1a63..c137da64b3 100644
--- a/board/renesas/gose/gose.c
+++ b/board/renesas/gose/gose.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/board/renesas/gose/gose_spl.c b/board/renesas/gose/gose_spl.c
index 2f94d3e76c..42a6758148 100644
--- a/board/renesas/gose/gose_spl.c
+++ b/board/renesas/gose/gose_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/grpeach/grpeach.c b/board/renesas/grpeach/grpeach.c
index 4f901eea71..ba904609ae 100644
--- a/board/renesas/grpeach/grpeach.c
+++ b/board/renesas/grpeach/grpeach.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 
diff --git a/board/renesas/koelsch/koelsch.c b/board/renesas/koelsch/koelsch.c
index 841d337f4d..ff7e458b3c 100644
--- a/board/renesas/koelsch/koelsch.c
+++ b/board/renesas/koelsch/koelsch.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/board/renesas/koelsch/koelsch_spl.c b/board/renesas/koelsch/koelsch_spl.c
index b7cdcb2216..b3530d7ce7 100644
--- a/board/renesas/koelsch/koelsch_spl.c
+++ b/board/renesas/koelsch/koelsch_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index 3cb1a56142..d6b388fead 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <env_internal.h>
 #include <malloc.h>
diff --git a/board/renesas/lager/lager_spl.c b/board/renesas/lager/lager_spl.c
index ba9b494476..d7db361b12 100644
--- a/board/renesas/lager/lager_spl.c
+++ b/board/renesas/lager/lager_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/porter/porter.c b/board/renesas/porter/porter.c
index 86f79da7fd..b9c29349cc 100644
--- a/board/renesas/porter/porter.c
+++ b/board/renesas/porter/porter.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/board/renesas/porter/porter_spl.c b/board/renesas/porter/porter_spl.c
index 7bf6823e05..026220d9e2 100644
--- a/board/renesas/porter/porter_spl.c
+++ b/board/renesas/porter/porter_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/rcar-common/gen3-spl.c b/board/renesas/rcar-common/gen3-spl.c
index 27140c5c35..d9741c1939 100644
--- a/board/renesas/rcar-common/gen3-spl.c
+++ b/board/renesas/rcar-common/gen3-spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <spl.h>
 
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 22fe9619cf..058fa6fbb6 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
index 25221e3c55..b69e7035ab 100644
--- a/board/renesas/silk/silk.c
+++ b/board/renesas/silk/silk.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <malloc.h>
 #include <dm.h>
diff --git a/board/renesas/silk/silk_spl.c b/board/renesas/silk/silk_spl.c
index 64ee75a63e..a2c397f935 100644
--- a/board/renesas/silk/silk_spl.c
+++ b/board/renesas/silk/silk_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/renesas/stout/cpld.c b/board/renesas/stout/cpld.c
index cffdc3e9d2..e6c2051bd4 100644
--- a/board/renesas/stout/cpld.c
+++ b/board/renesas/stout/cpld.c
@@ -8,6 +8,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
 #include "cpld.h"
diff --git a/board/renesas/stout/stout_spl.c b/board/renesas/stout/stout_spl.c
index 05a3ced97c..8d01efce56 100644
--- a/board/renesas/stout/stout_spl.c
+++ b/board/renesas/stout/stout_spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dm/platform_data/serial_sh.h>
 #include <asm/processor.h>
diff --git a/board/synopsys/emsdp/emsdp.c b/board/synopsys/emsdp/emsdp.c
index 5ba9f862e1..c09ed8cff8 100644
--- a/board/synopsys/emsdp/emsdp.c
+++ b/board/synopsys/emsdp/emsdp.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dwmmc.h>
 #include <malloc.h>
 
diff --git a/board/synopsys/iot_devkit/iot_devkit.c b/board/synopsys/iot_devkit/iot_devkit.c
index 9dbdc128f8..36aa8f6ae5 100644
--- a/board/synopsys/iot_devkit/iot_devkit.c
+++ b/board/synopsys/iot_devkit/iot_devkit.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <malloc.h>
 #include <dwmmc.h>
 #include <linux/libfdt.h>
diff --git a/board/technexion/pico-imx6ul/spl.c b/board/technexion/pico-imx6ul/spl.c
index 7f520beeb0..ae51113f32 100644
--- a/board/technexion/pico-imx6ul/spl.c
+++ b/board/technexion/pico-imx6ul/spl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <cpu_func.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index 8955622b81..6c432ca5a6 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -5,6 +5,7 @@
  * Author: Richard Hu <richard.hu@technexion.com>
  */
 
+#include <cpu_func.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/crm_regs.h>
diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 3e5174ef8a..aea5ca3a75 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <init.h>
 
 #include <asm/arch/clock.h>
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index d4d6eed11a..29f2cb2d45 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
 
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index adeee67643..857e9fe345 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <init.h>
 
 #include <asm/arch/clock.h>
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 1fd0f2c122..df6b44675d 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index b0914a9ead..15257b68e2 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2016-2018 Toradex AG
  */
 
+#include <cpu_func.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/ucRobotics/bubblegum_96/bubblegum_96.c b/board/ucRobotics/bubblegum_96/bubblegum_96.c
index a4c202da19..c16f117bf8 100644
--- a/board/ucRobotics/bubblegum_96/bubblegum_96.c
+++ b/board/ucRobotics/bubblegum_96/bubblegum_96.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <cpu_func.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <common.h>
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 23bb6b9623..9b6ed997f0 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
index c14dd75a26..2cde517d7a 100644
--- a/cmd/tpm_test.c
+++ b/cmd/tpm_test.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <tpm-v1.h>
 #include "tpm-user-utils.h"
 
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 39202588ae..8eff6036e7 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -7,6 +7,7 @@
 #define LOG_CATEGORY UCLASS_SYSRESET
 
 #include <common.h>
+#include <cpu_func.h>
 #include <sysreset.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/watchdog/imx_watchdog.c b/drivers/watchdog/imx_watchdog.c
index c030360c21..62bf25e9cc 100644
--- a/drivers/watchdog/imx_watchdog.c
+++ b/drivers/watchdog/imx_watchdog.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <wdt.h>
diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 313019f152..7533fc612c 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 
diff --git a/include/common.h b/include/common.h
index cf33b31499..f4a9dc325f 100644
--- a/include/common.h
+++ b/include/common.h
@@ -74,8 +74,6 @@ phys_size_t get_effective_memsize(void);
 int testdram(void);
 #endif /* CONFIG_SYS_DRAM_TEST */
 
-void	reset_cpu     (ulong addr);
-
 /* lib/uuid.c */
 #include <uuid.h>
 
diff --git a/include/cpu_func.h b/include/cpu_func.h
index 46f3d92459..f701f02bfe 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -83,5 +83,7 @@ enum {
  * @param flags		Flags to control what is done
  */
 int cleanup_before_linux_select(int flags);
+
+void reset_cpu(ulong addr);
 ;
 #endif
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index 0047998ee0..af5a878fc3 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <errno.h>
-- 
2.24.0.525.g8f36a354ae-goog

