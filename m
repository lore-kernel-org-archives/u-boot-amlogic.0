Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web12.2387.1586227275352595104
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2020 19:41:15 -0700
Received: by mail-il1-f196.google.com with SMTP id u15so1470562ilm.2
        for <u-boot-amlogic@groups.io>; Mon, 06 Apr 2020 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/w7MT2dQ6uRzSAA+tpqDK8q/21J5J3imC7g2Q91pl0A=;
        b=PyI3A+O60rJh3Eo5ORIu8iH1y6Kr0lmZTFGTOWndGa90+kBt3l9ccmO7nwjbNyMKqb
         PqQlD1nRO+ZDSOvWH6d0qT9hAe4G3ghyT5h6D2z45tw5RioD7oKtEcYEAvyu5bvj7/1+
         yvqD5ERKsDl8f86wZ81lUt3W3G7WLviWefi9A=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/18] common: Drop image.h from common header
Date: Mon,  6 Apr 2020 20:40:22 -0600
Message-Id: <20200406203250.9.I66d0cc8045a000b16ccb465bf2621e8d6fbd9052@changeid>
In-Reply-To: <20200407024032.82983-1-sjg@chromium.org>
References: <20200407024032.82983-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Glass <sjg@chromium.org>, Alex Marginean <alexandru.marginean@nxp.com>, Alexander Graf <agraf@csgraf.de>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Andreas Dannenberg <dannenberg@ti.com>, Andreas Geisreiter <ageisreiter@dh-electronics.de>, Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>, Ashish Kumar <ashish.kumar@nxp.com>, Biwen Li <biwen.li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, Breno Matheus Lima <breno.lima@nxp.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, Dirk Eibach <dirk.eibach@gdsys.cc>, Ezequiel Garcia <ezequiel@collabora.com>, Fabio Estevam <festevam@gmail.com>, Florinel Iordache <florinel.iordache@nxp.com>, Hamish Guthrie <hamish.guthrie@kistler.com>, Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ian Ray <ian.ray@ge.com>, Jagan Teki <jagan@amarulasolutions.com>, Joseph Chen <chenjh@rock-chips.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, Lukas Auer <lukas.auer@aisec.fraunhofer.de>, Marek Vasut <marek.vasut+renesas@gmail.com>, Markus Klotzbuecher <markus.klotzbuecher@kistler.com>, Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Oliver Graute <oliver.graute@kococonnector.com>, Patrick Doyle <wpdster@gmail.com>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Sam Protsenko <joe.skb7@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Thirupathaiah Annapureddy <thiruan@linux.microsoft.com>, Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>, Ye Li <ye.li@nxp.com>, mingming lee <mingming.lee@mediatek.com>, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com
List-ID: <u-boot-amlogic@groups.io>

Move this uncommon header out of the common header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arc/lib/bootm.c                             | 2 ++
 arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c   | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/mp.c           | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/spl.c          | 1 +
 arch/arm/cpu/armv8/sec_firmware.c                | 2 ++
 arch/arm/lib/bootm.c                             | 1 +
 arch/arm/lib/image.c                             | 1 +
 arch/arm/lib/zimage.c                            | 1 +
 arch/arm/mach-imx/misc.c                         | 1 +
 arch/arm/mach-k3/common.c                        | 1 +
 arch/arm/mach-k3/security.c                      | 1 +
 arch/arm/mach-k3/sysfw-loader.c                  | 1 +
 arch/arm/mach-keystone/mon.c                     | 1 +
 arch/arm/mach-rockchip/misc.c                    | 1 +
 arch/arm/mach-rockchip/rk3399/rk3399.c           | 1 +
 arch/arm/mach-rockchip/spl.c                     | 1 +
 arch/arm/mach-sunxi/spl_spi_sunxi.c              | 1 +
 arch/arm/mach-zynq/spl.c                         | 1 +
 arch/arm/mach-zynqmp/spl.c                       | 1 +
 arch/m68k/lib/bootm.c                            | 1 +
 arch/microblaze/lib/bootm.c                      | 1 +
 arch/mips/lib/bootm.c                            | 1 +
 arch/mips/mach-jz47xx/jz4780/jz4780.c            | 1 +
 arch/nds32/include/asm/u-boot-nds32.h            | 2 ++
 arch/nios2/lib/bootm.c                           | 1 +
 arch/powerpc/include/asm/fsl_i2c.h               | 1 +
 arch/powerpc/lib/bootm.c                         | 1 +
 arch/riscv/lib/image.c                           | 1 +
 arch/sandbox/lib/bootm.c                         | 1 +
 arch/sh/lib/bootm.c                              | 1 +
 arch/x86/cpu/apollolake/spl.c                    | 1 +
 arch/x86/lib/spl.c                               | 1 +
 arch/x86/lib/tpl.c                               | 1 +
 board/AndesTech/ax25-ae350/ax25-ae350.c          | 1 +
 board/Arcturus/ucp1020/ucp1020.c                 | 1 +
 board/advantech/imx8qm_rom7720_a1/spl.c          | 1 +
 board/aristainetos/aristainetos.c                | 1 +
 board/dhelectronics/dh_imx6/dh_imx6.c            | 1 +
 board/emulation/qemu-riscv/qemu-riscv.c          | 1 +
 board/engicam/common/spl.c                       | 1 +
 board/freescale/b4860qds/b4860qds.c              | 1 +
 board/freescale/bsc9131rdb/bsc9131rdb.c          | 1 +
 board/freescale/bsc9132qds/bsc9132qds.c          | 1 +
 board/freescale/c29xpcie/c29xpcie.c              | 1 +
 board/freescale/corenet_ds/corenet_ds.c          | 1 +
 board/freescale/corenet_ds/eth_p4080.c           | 1 +
 board/freescale/imx8mm_evk/spl.c                 | 1 +
 board/freescale/imx8mn_evk/spl.c                 | 1 +
 board/freescale/imx8mp_evk/spl.c                 | 1 +
 board/freescale/imx8mq_evk/spl.c                 | 1 +
 board/freescale/imx8qm_mek/spl.c                 | 1 +
 board/freescale/imx8qxp_mek/spl.c                | 1 +
 board/freescale/ls1046afrwy/eth.c                | 1 +
 board/freescale/ls1046ardb/eth.c                 | 1 +
 board/freescale/lx2160a/eth_lx2160aqds.c         | 2 ++
 board/freescale/lx2160a/eth_lx2160ardb.c         | 1 +
 board/freescale/mpc8572ds/mpc8572ds.c            | 1 +
 board/freescale/mx6sabreauto/mx6sabreauto.c      | 1 +
 board/freescale/mx6sabresd/mx6sabresd.c          | 1 +
 board/freescale/p1010rdb/p1010rdb.c              | 1 +
 board/freescale/p1022ds/p1022ds.c                | 1 +
 board/freescale/p1023rdb/p1023rdb.c              | 1 +
 board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c      | 1 +
 board/freescale/p1_twr/p1_twr.c                  | 1 +
 board/freescale/p2041rdb/p2041rdb.c              | 1 +
 board/freescale/t102xqds/eth_t102xqds.c          | 1 +
 board/freescale/t102xqds/t102xqds.c              | 1 +
 board/freescale/t102xrdb/eth_t102xrdb.c          | 1 +
 board/freescale/t102xrdb/t102xrdb.c              | 1 +
 board/freescale/t1040qds/eth.c                   | 1 +
 board/freescale/t1040qds/t1040qds.c              | 1 +
 board/freescale/t104xrdb/t104xrdb.c              | 1 +
 board/freescale/t208xqds/eth_t208xqds.c          | 2 ++
 board/freescale/t208xqds/t208xqds.c              | 1 +
 board/freescale/t208xrdb/eth_t208xrdb.c          | 1 +
 board/freescale/t208xrdb/t208xrdb.c              | 1 +
 board/freescale/t4qds/eth.c                      | 2 ++
 board/freescale/t4qds/t4240emu.c                 | 1 +
 board/freescale/t4qds/t4240qds.c                 | 1 +
 board/freescale/t4rdb/eth.c                      | 1 +
 board/freescale/t4rdb/t4240rdb.c                 | 1 +
 board/gateworks/gw_ventana/gw_ventana.c          | 1 +
 board/gdsys/p1022/controlcenterd.c               | 1 +
 board/ge/bx50v3/bx50v3.c                         | 1 +
 board/highbank/highbank.c                        | 1 +
 board/keymile/kmp204x/kmp204x.c                  | 1 +
 board/liebherr/display5/display5.c               | 1 +
 board/liebherr/display5/spl.c                    | 1 +
 board/liebherr/mccmon6/spl.c                     | 1 +
 board/liebherr/xea/xea.c                         | 1 +
 board/mscc/jr2/jr2.c                             | 1 +
 board/mscc/luton/luton.c                         | 1 +
 board/mscc/ocelot/ocelot.c                       | 1 +
 board/mscc/serval/serval.c                       | 1 +
 board/mscc/servalt/servalt.c                     | 1 +
 board/renesas/rcar-common/common.c               | 1 +
 board/renesas/rcar-common/gen3-spl.c             | 1 +
 board/renesas/salvator-x/salvator-x.c            | 1 +
 board/renesas/ulcb/ulcb.c                        | 1 +
 board/solidrun/mx6cuboxi/mx6cuboxi.c             | 1 +
 board/st/stm32mp1/stm32mp1.c                     | 1 +
 board/sunxi/board.c                              | 1 +
 board/synopsys/hsdk/hsdk.c                       | 1 +
 board/technexion/pico-imx6/spl.c                 | 1 +
 board/ti/am335x/board.c                          | 1 +
 board/ti/am43xx/board.c                          | 1 +
 board/ti/am57xx/board.c                          | 1 +
 board/ti/am65x/evm.c                             | 2 ++
 board/ti/dra7xx/evm.c                            | 1 +
 board/ti/j721e/evm.c                             | 2 ++
 board/ti/ks2_evm/board.c                         | 1 +
 board/ti/ks2_evm/board_k2e.c                     | 1 +
 board/ti/ks2_evm/board_k2g.c                     | 1 +
 board/ti/ks2_evm/board_k2hk.c                    | 1 +
 board/ti/ks2_evm/board_k2l.c                     | 1 +
 board/toradex/apalis_imx6/apalis_imx6.c          | 1 +
 board/toradex/verdin-imx8mm/spl.c                | 1 +
 board/tqc/tqma6/tqma6.c                          | 1 +
 board/varisys/cyrus/cyrus.c                      | 1 +
 board/wandboard/wandboard.c                      | 1 +
 cmd/abootimg.c                                   | 1 +
 cmd/bootefi.c                                    | 1 +
 cmd/fdt.c                                        | 1 +
 cmd/fpga.c                                       | 1 +
 cmd/md5sum.c                                     | 1 +
 cmd/spl.c                                        | 1 +
 common/bootm_os.c                                | 2 ++
 common/hash.c                                    | 2 +-
 common/image-fdt.c                               | 1 +
 common/image-fit.c                               | 1 +
 common/image-sig.c                               | 2 ++
 common/image.c                                   | 1 +
 common/spl/spl_atf.c                             | 1 +
 common/spl/spl_nand.c                            | 2 ++
 common/spl/spl_net.c                             | 1 +
 common/spl/spl_nor.c                             | 1 +
 common/spl/spl_onenand.c                         | 1 +
 common/spl/spl_opensbi.c                         | 2 ++
 common/spl/spl_ram.c                             | 1 +
 common/spl/spl_spi.c                             | 1 +
 common/spl/spl_ubi.c                             | 1 +
 common/spl/spl_xip.c                             | 1 +
 common/spl/spl_ymodem.c                          | 1 +
 drivers/fastboot/fb_mmc.c                        | 1 +
 drivers/fpga/socfpga_arria10.c                   | 1 +
 drivers/i2c/muxes/i2c-mux-gpio.c                 | 1 +
 drivers/net/fm/fdt.c                             | 1 +
 drivers/net/fm/init.c                            | 1 +
 drivers/net/fsl-mc/mc.c                          | 1 +
 drivers/net/fsl_enetc.c                          | 1 +
 drivers/net/mvpp2.c                              | 1 +
 drivers/net/pfe_eth/pfe_firmware.c               | 1 +
 drivers/net/ti/keystone_net.c                    | 1 +
 drivers/phy/marvell/comphy_core.c                | 3 ++-
 drivers/pinctrl/meson/pinctrl-meson.c            | 1 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c      | 1 +
 drivers/pinctrl/pinctrl-sti.c                    | 1 +
 drivers/pinctrl/pinctrl_stm32.c                  | 1 +
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 +
 drivers/spi/fsl_qspi.c                           | 1 +
 drivers/thermal/imx_scu_thermal.c                | 1 +
 include/asm-generic/u-boot.h                     | 3 +++
 include/common.h                                 | 1 -
 include/tee/optee.h                              | 7 +++++--
 lib/libfdt/fdt_region.c                          | 1 +
 lib/libfdt/fdt_ro.c                              | 1 +
 lib/lmb.c                                        | 1 +
 net/tftp.c                                       | 1 +
 test/compression.c                               | 1 +
 test/overlay/cmd_ut_overlay.c                    | 1 +
 tools/imx8image.c                                | 1 +
 171 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 1b08ffe2857..9fa6aaf3b2d 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -5,7 +5,9 @@
 
 #include <common.h>
 #include <bootstage.h>
+#include <image.h>
 #include <irq_func.h>
+#include <lmb.h>
 #include <asm/cache.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
index 8110412da60..e73689ce269 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <fdt_support.h>
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/mp.c b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
index 4e779dde1db..4ef2a302785 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/mp.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <image.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/system.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index 2c0ce80c0ca..c0201341ea7 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -7,6 +7,7 @@
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/cache.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index 36f40a4015d..c7445e647ee 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -6,6 +6,8 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
+#include <fdt_support.h>
+#include <image.h>
 #include <asm/cache.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 37fc727601c..1d2a84a3b04 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -17,6 +17,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <hang.h>
+#include <lmb.h>
 #include <dm/root.h>
 #include <env.h>
 #include <image.h>
diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index 699bf44e702..9cf4a67406e 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <mapmem.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/lib/zimage.c b/arch/arm/lib/zimage.c
index 49305299b39..477ea94997d 100644
--- a/arch/arm/lib/zimage.c
+++ b/arch/arm/lib/zimage.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2012 Marek Vasut <marek.vasut@gmail.com>
  */
 #include <common.h>
+#include <image.h>
 
 #define	LINUX_ARM_ZIMAGE_MAGIC	0x016f2818
 #define	BAREBOX_IMAGE_MAGIC	0x00786f62
diff --git a/arch/arm/mach-imx/misc.c b/arch/arm/mach-imx/misc.c
index 31e95a9a288..6744fbda46d 100644
--- a/arch/arm/mach-imx/misc.c
+++ b/arch/arm/mach-imx/misc.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <lmb.h>
 #include <asm/arch/sys_proto.h>
 #include <linux/errno.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index aed3e14164e..041b6ea180a 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <image.h>
 #include <spl.h>
 #include "common.h"
 #include <dm.h>
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index dd7c998487f..256b0526f22 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -10,6 +10,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <hang.h>
+#include <image.h>
 #include <asm/cache.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <mach/spl.h>
diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 824cf6f8e33..0478c15f3fc 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <spl.h>
 #include <malloc.h>
 #include <remoteproc.h>
diff --git a/arch/arm/mach-keystone/mon.c b/arch/arm/mach-keystone/mon.c
index b7de9ba099d..58995d73ac8 100644
--- a/arch/arm/mach-keystone/mon.c
+++ b/arch/arm/mach-keystone/mon.c
@@ -6,6 +6,7 @@
  */
 
 #include <hang.h>
+#include <image.h>
 #include <asm/unaligned.h>
 #include <common.h>
 #include <command.h>
diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
index 6dbb9bde483..17066bcf8bc 100644
--- a/arch/arm/mach-rockchip/misc.c
+++ b/arch/arm/mach-rockchip/misc.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <env.h>
 #include <dm.h>
+#include <hash.h>
 #include <dm/uclass-internal.h>
 #include <misc.h>
 #include <u-boot/crc.h>
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index dafa142824c..3a511941080 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <fdt_support.h>
 #include <spl.h>
 #include <spl_gpio.h>
 #include <syscon.h>
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 48ab0e60c63..fb4ae3d32d4 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -7,6 +7,7 @@
 #include <debug_uart.h>
 #include <dm.h>
 #include <hang.h>
+#include <image.h>
 #include <ram.h>
 #include <spl.h>
 #include <asm/arch-rockchip/bootrom.h>
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index a3997b25901..612942025bc 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index 96ba90fb7a7..d617c7d9b01 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -5,6 +5,7 @@
 #include <common.h>
 #include <debug_uart.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 
 #include <asm/io.h>
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index 896657f51c3..1c304f1af3a 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <debug_uart.h>
+#include <image.h>
 #include <init.h>
 #include <spl.h>
 
diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index fb1170d00d7..c36ee79c923 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <env.h>
 #include <image.h>
+#include <lmb.h>
 #include <u-boot/zlib.h>
 #include <bzlib.h>
 #include <watchdog.h>
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index f7303b790fc..592ac97f827 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -15,6 +15,7 @@
 #include <fdt_support.h>
 #include <hang.h>
 #include <image.h>
+#include <lmb.h>
 #include <asm/cache.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 9be9d18ac85..8a65912ceaf 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -9,6 +9,7 @@
 #include <env.h>
 #include <image.h>
 #include <fdt_support.h>
+#include <lmb.h>
 #include <asm/addrspace.h>
 #include <asm/io.h>
 
diff --git a/arch/mips/mach-jz47xx/jz4780/jz4780.c b/arch/mips/mach-jz47xx/jz4780/jz4780.c
index 015840de256..26fcfc842c2 100644
--- a/arch/mips/mach-jz47xx/jz4780/jz4780.c
+++ b/arch/mips/mach-jz47xx/jz4780/jz4780.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/sections.h>
diff --git a/arch/nds32/include/asm/u-boot-nds32.h b/arch/nds32/include/asm/u-boot-nds32.h
index 7d39320c150..f086f34729f 100644
--- a/arch/nds32/include/asm/u-boot-nds32.h
+++ b/arch/nds32/include/asm/u-boot-nds32.h
@@ -12,6 +12,8 @@
 #ifndef _U_BOOT_NDS32_H_
 #define _U_BOOT_NDS32_H_	1
 
+#include <linux/types.h>
+
 /* for the following variables, see start.S */
 extern ulong IRQ_STACK_START;	/* top of IRQ stack */
 extern ulong FIQ_STACK_START;	/* top of FIQ stack */
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index e1891617c76..bec18fe28f6 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <image.h>
 #include <irq_func.h>
 
 #define NIOS_MAGIC 0x534f494e /* enable command line and initrd passing */
diff --git a/arch/powerpc/include/asm/fsl_i2c.h b/arch/powerpc/include/asm/fsl_i2c.h
index fbf32b9a07a..73105fa8e48 100644
--- a/arch/powerpc/include/asm/fsl_i2c.h
+++ b/arch/powerpc/include/asm/fsl_i2c.h
@@ -14,6 +14,7 @@
 #define _ASM_FSL_I2C_H_
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 typedef struct fsl_i2c_base {
 
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 1cef75c4bef..8aec8c9fd3b 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -12,6 +12,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <init.h>
+#include <lmb.h>
 #include <watchdog.h>
 #include <command.h>
 #include <image.h>
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index 7357d3b07d6..91b7f1624e9 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <mapmem.h>
 #include <errno.h>
 #include <linux/sizes.h>
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index d38c3164c12..d1d460b84a4 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <bootstage.h>
+#include <image.h>
 #include <asm/io.h>
 
 #define	LINUX_ARM_ZIMAGE_MAGIC	0x016f2818
diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index 2896e45f0df..5f14a04ab41 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -9,6 +9,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <image.h>
 #include <asm/byteorder.h>
 #include <asm/zimage.h>
 
diff --git a/arch/x86/cpu/apollolake/spl.c b/arch/x86/cpu/apollolake/spl.c
index a555e6c0d38..1cf7cebff52 100644
--- a/arch/x86/cpu/apollolake/spl.c
+++ b/arch/x86/cpu/apollolake/spl.c
@@ -7,6 +7,7 @@
 #include <binman_sym.h>
 #include <bootstage.h>
 #include <dm.h>
+#include <image.h>
 #include <malloc.h>
 #include <spi.h>
 #include <spl.h>
diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 90baec2a175..e34529bd98a 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -8,6 +8,7 @@
 #include <debug_uart.h>
 #include <dm.h>
 #include <hang.h>
+#include <image.h>
 #include <irq_func.h>
 #include <malloc.h>
 #include <spl.h>
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 34804b53cca..f9dcf32d733 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -7,6 +7,7 @@
 #include <debug_uart.h>
 #include <dm.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/cpu.h>
 #include <asm/mtrr.h>
diff --git a/board/AndesTech/ax25-ae350/ax25-ae350.c b/board/AndesTech/ax25-ae350/ax25-ae350.c
index 920d43ecc69..da5bc5b1f12 100644
--- a/board/AndesTech/ax25-ae350/ax25-ae350.c
+++ b/board/AndesTech/ax25-ae350/ax25-ae350.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <flash.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #if defined(CONFIG_FTMAC100) && !defined(CONFIG_DM_ETH)
diff --git a/board/Arcturus/ucp1020/ucp1020.c b/board/Arcturus/ucp1020/ucp1020.c
index dfa1fd4f153..240e8041379 100644
--- a/board/Arcturus/ucp1020/ucp1020.c
+++ b/board/Arcturus/ucp1020/ucp1020.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <env.h>
 #include <hwconfig.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/advantech/imx8qm_rom7720_a1/spl.c b/board/advantech/imx8qm_rom7720_a1/spl.c
index 3f31a8f9c3d..6863da82d6e 100644
--- a/board/advantech/imx8qm_rom7720_a1/spl.c
+++ b/board/advantech/imx8qm_rom7720_a1/spl.c
@@ -4,6 +4,7 @@
  */
 #include <common.h>
 #include <dm.h>
+#include <image.h>
 #include <spl.h>
 #include <fsl_esdhc.h>
 
diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 70671039c28..5095cf65d13 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -9,6 +9,7 @@
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  */
 
+#include <image.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 33ce7e8ff11..cb2f6da76f6 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <dm.h>
 #include <eeprom.h>
+#include <image.h>
 #include <init.h>
 #include <dm/device-internal.h>
 #include <asm/arch/clock.h>
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index cbce5ffe6e3..c40f8388bc6 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <env.h>
 #include <fdtdec.h>
+#include <image.h>
 #include <spl.h>
 #include <init.h>
 #include <virtio_types.h>
diff --git a/board/engicam/common/spl.c b/board/engicam/common/spl.c
index a9820a9028e..6359fb32234 100644
--- a/board/engicam/common/spl.c
+++ b/board/engicam/common/spl.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <serial.h>
 #include <spl.h>
 
diff --git a/board/freescale/b4860qds/b4860qds.c b/board/freescale/b4860qds/b4860qds.c
index e7f684bfb3a..037a8beb64d 100644
--- a/board/freescale/b4860qds/b4860qds.c
+++ b/board/freescale/b4860qds/b4860qds.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <irq_func.h>
 #include <netdev.h>
diff --git a/board/freescale/bsc9131rdb/bsc9131rdb.c b/board/freescale/bsc9131rdb/bsc9131rdb.c
index 30e7a1f7ed9..871d066d681 100644
--- a/board/freescale/bsc9131rdb/bsc9131rdb.c
+++ b/board/freescale/bsc9131rdb/bsc9131rdb.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/cache.h>
diff --git a/board/freescale/bsc9132qds/bsc9132qds.c b/board/freescale/bsc9132qds/bsc9132qds.c
index 89742dfedb8..6870674f7a4 100644
--- a/board/freescale/bsc9132qds/bsc9132qds.c
+++ b/board/freescale/bsc9132qds/bsc9132qds.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/processor.h>
diff --git a/board/freescale/c29xpcie/c29xpcie.c b/board/freescale/c29xpcie/c29xpcie.c
index 17292936b76..74502c6d18e 100644
--- a/board/freescale/c29xpcie/c29xpcie.c
+++ b/board/freescale/c29xpcie/c29xpcie.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/processor.h>
diff --git a/board/freescale/corenet_ds/corenet_ds.c b/board/freescale/corenet_ds/corenet_ds.c
index 66eea32e077..f0c7bed68f0 100644
--- a/board/freescale/corenet_ds/corenet_ds.c
+++ b/board/freescale/corenet_ds/corenet_ds.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/corenet_ds/eth_p4080.c b/board/freescale/corenet_ds/eth_p4080.c
index b1989bcbc23..5892bbd62ca 100644
--- a/board/freescale/corenet_ds/eth_p4080.c
+++ b/board/freescale/corenet_ds/eth_p4080.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
diff --git a/board/freescale/imx8mm_evk/spl.c b/board/freescale/imx8mm_evk/spl.c
index 5d17f397cb6..d067489df72 100644
--- a/board/freescale/imx8mm_evk/spl.c
+++ b/board/freescale/imx8mm_evk/spl.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index 7aed14c52b6..95e02e9b262 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
index 0b20668e2b3..c3b523d55e8 100644
--- a/board/freescale/imx8mp_evk/spl.c
+++ b/board/freescale/imx8mp_evk/spl.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <errno.h>
diff --git a/board/freescale/imx8mq_evk/spl.c b/board/freescale/imx8mq_evk/spl.c
index e442510f44d..eafadc691b3 100644
--- a/board/freescale/imx8mq_evk/spl.c
+++ b/board/freescale/imx8mq_evk/spl.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <hang.h>
+#include <image.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
diff --git a/board/freescale/imx8qm_mek/spl.c b/board/freescale/imx8qm_mek/spl.c
index cb4006eb2a4..c5c07089a2c 100644
--- a/board/freescale/imx8qm_mek/spl.c
+++ b/board/freescale/imx8qm_mek/spl.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <image.h>
 #include <spl.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/freescale/imx8qxp_mek/spl.c b/board/freescale/imx8qxp_mek/spl.c
index cb4006eb2a4..c5c07089a2c 100644
--- a/board/freescale/imx8qxp_mek/spl.c
+++ b/board/freescale/imx8qxp_mek/spl.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <image.h>
 #include <spl.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
diff --git a/board/freescale/ls1046afrwy/eth.c b/board/freescale/ls1046afrwy/eth.c
index 3f7c35b5c95..09a692be1dc 100644
--- a/board/freescale/ls1046afrwy/eth.c
+++ b/board/freescale/ls1046afrwy/eth.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 #include <common.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <asm/io.h>
 #include <netdev.h>
diff --git a/board/freescale/ls1046ardb/eth.c b/board/freescale/ls1046ardb/eth.c
index 6ffd4aec3e4..f3b1dcd306d 100644
--- a/board/freescale/ls1046ardb/eth.c
+++ b/board/freescale/ls1046ardb/eth.c
@@ -3,6 +3,7 @@
  * Copyright 2016 Freescale Semiconductor, Inc.
  */
 #include <common.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <asm/io.h>
 #include <netdev.h>
diff --git a/board/freescale/lx2160a/eth_lx2160aqds.c b/board/freescale/lx2160a/eth_lx2160aqds.c
index 6500649d7b9..8b86e44c902 100644
--- a/board/freescale/lx2160a/eth_lx2160aqds.c
+++ b/board/freescale/lx2160a/eth_lx2160aqds.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <hwconfig.h>
 #include <command.h>
 #include <net.h>
@@ -20,6 +21,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <fsl-mc/fsl_mc.h>
 #include <fsl-mc/ldpaa_wriop.h>
+#include <linux/libfdt.h>
 
 #include "../common/qixis.h"
 
diff --git a/board/freescale/lx2160a/eth_lx2160ardb.c b/board/freescale/lx2160a/eth_lx2160ardb.c
index aeb989a638b..21fb559250c 100644
--- a/board/freescale/lx2160a/eth_lx2160ardb.c
+++ b/board/freescale/lx2160a/eth_lx2160ardb.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <malloc.h>
diff --git a/board/freescale/mpc8572ds/mpc8572ds.c b/board/freescale/mpc8572ds/mpc8572ds.c
index b7e0eeded52..13cfe159ae1 100644
--- a/board/freescale/mpc8572ds/mpc8572ds.c
+++ b/board/freescale/mpc8572ds/mpc8572ds.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/freescale/mx6sabreauto/mx6sabreauto.c
index 33da3914d3e..829e42f6771 100644
--- a/board/freescale/mx6sabreauto/mx6sabreauto.c
+++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
@@ -6,6 +6,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx6sabresd/mx6sabresd.c
index d46dcd4b8a7..8d24af0a99e 100644
--- a/board/freescale/mx6sabresd/mx6sabresd.c
+++ b/board/freescale/mx6sabresd/mx6sabresd.c
@@ -5,6 +5,7 @@
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  */
 
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/freescale/p1010rdb/p1010rdb.c
index ea9d04e4b99..ef8b4916100 100644
--- a/board/freescale/p1010rdb/p1010rdb.c
+++ b/board/freescale/p1010rdb/p1010rdb.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/processor.h>
diff --git a/board/freescale/p1022ds/p1022ds.c b/board/freescale/p1022ds/p1022ds.c
index 33edff9727d..244a053d7a4 100644
--- a/board/freescale/p1022ds/p1022ds.c
+++ b/board/freescale/p1022ds/p1022ds.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/freescale/p1023rdb/p1023rdb.c b/board/freescale/p1023rdb/p1023rdb.c
index 5321e26a9cf..13df3e86379 100644
--- a/board/freescale/p1023rdb/p1023rdb.c
+++ b/board/freescale/p1023rdb/p1023rdb.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index eb51ee9fd93..1c0b85a1fbd 100644
--- a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <hang.h>
 #include <hwconfig.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/freescale/p1_twr/p1_twr.c b/board/freescale/p1_twr/p1_twr.c
index 6d0e1b1ffa0..8e1522a6045 100644
--- a/board/freescale/p1_twr/p1_twr.c
+++ b/board/freescale/p1_twr/p1_twr.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <hwconfig.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/freescale/p2041rdb/p2041rdb.c b/board/freescale/p2041rdb/p2041rdb.c
index 95ed0ef429e..076e63a3573 100644
--- a/board/freescale/p2041rdb/p2041rdb.c
+++ b/board/freescale/p2041rdb/p2041rdb.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t102xqds/eth_t102xqds.c b/board/freescale/t102xqds/eth_t102xqds.c
index 1820419511b..4a3be4c5690 100644
--- a/board/freescale/t102xqds/eth_t102xqds.c
+++ b/board/freescale/t102xqds/eth_t102xqds.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
diff --git a/board/freescale/t102xqds/t102xqds.c b/board/freescale/t102xqds/t102xqds.c
index e42337e47a4..8c5da0bfdff 100644
--- a/board/freescale/t102xqds/t102xqds.c
+++ b/board/freescale/t102xqds/t102xqds.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t102xrdb/eth_t102xrdb.c b/board/freescale/t102xrdb/eth_t102xrdb.c
index d40b5901080..dbf25a237d1 100644
--- a/board/freescale/t102xrdb/eth_t102xrdb.c
+++ b/board/freescale/t102xrdb/eth_t102xrdb.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
diff --git a/board/freescale/t102xrdb/t102xrdb.c b/board/freescale/t102xrdb/t102xrdb.c
index eee09a57019..601c2ecadfa 100644
--- a/board/freescale/t102xrdb/t102xrdb.c
+++ b/board/freescale/t102xrdb/t102xrdb.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t1040qds/eth.c b/board/freescale/t1040qds/eth.c
index 3f10e420a01..b349b77951b 100644
--- a/board/freescale/t1040qds/eth.c
+++ b/board/freescale/t1040qds/eth.c
@@ -10,6 +10,7 @@
  */
 
 #include <common.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/fsl_serdes.h>
diff --git a/board/freescale/t1040qds/t1040qds.c b/board/freescale/t1040qds/t1040qds.c
index 92dd9237ec7..d29218d2915 100644
--- a/board/freescale/t1040qds/t1040qds.c
+++ b/board/freescale/t1040qds/t1040qds.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t104xrdb/t104xrdb.c b/board/freescale/t104xrdb/t104xrdb.c
index dc3b59d26f9..a156d2ee09a 100644
--- a/board/freescale/t104xrdb/t104xrdb.c
+++ b/board/freescale/t104xrdb/t104xrdb.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <hwconfig.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t208xqds/eth_t208xqds.c b/board/freescale/t208xqds/eth_t208xqds.c
index e178d7f2927..2151ede7f91 100644
--- a/board/freescale/t208xqds/eth_t208xqds.c
+++ b/board/freescale/t208xqds/eth_t208xqds.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
@@ -27,6 +28,7 @@
 #include "../common/qixis.h"
 #include "../common/fman.h"
 #include "t208xqds_qixis.h"
+#include <linux/libfdt.h>
 
 #define EMI_NONE	0xFFFFFFFF
 #define EMI1_RGMII1	0
diff --git a/board/freescale/t208xqds/t208xqds.c b/board/freescale/t208xqds/t208xqds.c
index 79cc1543f95..737c6a2c5a4 100644
--- a/board/freescale/t208xqds/t208xqds.c
+++ b/board/freescale/t208xqds/t208xqds.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t208xrdb/eth_t208xrdb.c b/board/freescale/t208xrdb/eth_t208xrdb.c
index 669bc1efefb..db4718128dc 100644
--- a/board/freescale/t208xrdb/eth_t208xrdb.c
+++ b/board/freescale/t208xrdb/eth_t208xrdb.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
diff --git a/board/freescale/t208xrdb/t208xrdb.c b/board/freescale/t208xrdb/t208xrdb.c
index b5c20112d0e..24f0d0764ce 100644
--- a/board/freescale/t208xrdb/t208xrdb.c
+++ b/board/freescale/t208xrdb/t208xrdb.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t4qds/eth.c b/board/freescale/t4qds/eth.c
index d93d75950cb..8a9f631e8da 100644
--- a/board/freescale/t4qds/eth.c
+++ b/board/freescale/t4qds/eth.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
@@ -26,6 +27,7 @@
 #include <hwconfig.h>
 #include "../common/qixis.h"
 #include "../common/fman.h"
+#include <linux/libfdt.h>
 
 #include "t4240qds_qixis.h"
 
diff --git a/board/freescale/t4qds/t4240emu.c b/board/freescale/t4qds/t4240emu.c
index 104b40a1109..8f2032acc7b 100644
--- a/board/freescale/t4qds/t4240emu.c
+++ b/board/freescale/t4qds/t4240emu.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/freescale/t4qds/t4240qds.c b/board/freescale/t4qds/t4240qds.c
index 5608774afd1..1d449afb2a3 100644
--- a/board/freescale/t4qds/t4240qds.c
+++ b/board/freescale/t4qds/t4240qds.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <irq_func.h>
 #include <netdev.h>
diff --git a/board/freescale/t4rdb/eth.c b/board/freescale/t4rdb/eth.c
index 3321ce1ea1c..4c896c8a90d 100644
--- a/board/freescale/t4rdb/eth.c
+++ b/board/freescale/t4rdb/eth.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <asm/mmu.h>
diff --git a/board/freescale/t4rdb/t4240rdb.c b/board/freescale/t4rdb/t4240rdb.c
index 8015666eccd..d801f2c7a1b 100644
--- a/board/freescale/t4rdb/t4240rdb.c
+++ b/board/freescale/t4rdb/t4240rdb.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <i2c.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/gateworks/gw_ventana/gw_ventana.c b/board/gateworks/gw_ventana/gw_ventana.c
index 6c818643192..1443ef91ef4 100644
--- a/board/gateworks/gw_ventana/gw_ventana.c
+++ b/board/gateworks/gw_ventana/gw_ventana.c
@@ -33,6 +33,7 @@
 #include <mtd_node.h>
 #include <netdev.h>
 #include <pci.h>
+#include <linux/libfdt.h>
 #include <power/pmic.h>
 #include <power/ltc3676_pmic.h>
 #include <power/pfuze100_pmic.h>
diff --git a/board/gdsys/p1022/controlcenterd.c b/board/gdsys/p1022/controlcenterd.c
index 14e3e25c18d..b39b0b60022 100644
--- a/board/gdsys/p1022/controlcenterd.c
+++ b/board/gdsys/p1022/controlcenterd.c
@@ -24,6 +24,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <pci.h>
diff --git a/board/ge/bx50v3/bx50v3.c b/board/ge/bx50v3/bx50v3.c
index 69cd0a1bc76..6f7f752a8dc 100644
--- a/board/ge/bx50v3/bx50v3.c
+++ b/board/ge/bx50v3/bx50v3.c
@@ -5,6 +5,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
+#include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/highbank/highbank.c b/board/highbank/highbank.c
index f7f2e2c5259..ffde1161d0b 100644
--- a/board/highbank/highbank.c
+++ b/board/highbank/highbank.c
@@ -7,6 +7,7 @@
 #include <ahci.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <netdev.h>
 #include <scsi.h>
diff --git a/board/keymile/kmp204x/kmp204x.c b/board/keymile/kmp204x/kmp204x.c
index 0a6cf1fd29a..21afbc7f39a 100644
--- a/board/keymile/kmp204x/kmp204x.c
+++ b/board/keymile/kmp204x/kmp204x.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/liebherr/display5/display5.c b/board/liebherr/display5/display5.c
index 85ca777c1d2..a362d25c01a 100644
--- a/board/liebherr/display5/display5.c
+++ b/board/liebherr/display5/display5.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <fdt_support.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
diff --git a/board/liebherr/display5/spl.c b/board/liebherr/display5/spl.c
index 765463e3707..0f5eab79b57 100644
--- a/board/liebherr/display5/spl.c
+++ b/board/liebherr/display5/spl.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <image.h>
 #include <serial.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/board/liebherr/mccmon6/spl.c b/board/liebherr/mccmon6/spl.c
index 08d2b56d54b..8ed8e032956 100644
--- a/board/liebherr/mccmon6/spl.c
+++ b/board/liebherr/mccmon6/spl.c
@@ -5,6 +5,7 @@
  *         Richard Hu <hakahu@gmail.com>
  */
 
+#include <image.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 1a9c05275f8..95c90640668 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -14,6 +14,7 @@
  */
 
 #include <common.h>
+#include <fdt_support.h>
 #include <net.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/board/mscc/jr2/jr2.c b/board/mscc/jr2/jr2.c
index 067907ba52c..b240c7649ce 100644
--- a/board/mscc/jr2/jr2.c
+++ b/board/mscc/jr2/jr2.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <led.h>
diff --git a/board/mscc/luton/luton.c b/board/mscc/luton/luton.c
index e614058d10f..acc26157c77 100644
--- a/board/mscc/luton/luton.c
+++ b/board/mscc/luton/luton.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <led.h>
diff --git a/board/mscc/ocelot/ocelot.c b/board/mscc/ocelot/ocelot.c
index ad227a41693..5fbd8fc6cde 100644
--- a/board/mscc/ocelot/ocelot.c
+++ b/board/mscc/ocelot/ocelot.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
diff --git a/board/mscc/serval/serval.c b/board/mscc/serval/serval.c
index 6c6dbf2bfff..ed1aea55cc2 100644
--- a/board/mscc/serval/serval.c
+++ b/board/mscc/serval/serval.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <led.h>
diff --git a/board/mscc/servalt/servalt.c b/board/mscc/servalt/servalt.c
index 71891f6fe38..d0e6016b9af 100644
--- a/board/mscc/servalt/servalt.c
+++ b/board/mscc/servalt/servalt.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/io.h>
 #include <led.h>
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 37f8a46d7e5..5a6aa8255b3 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <asm/arch/rmobile.h>
+#include <linux/libfdt.h>
 
 #ifdef CONFIG_RCAR_GEN3
 
diff --git a/board/renesas/rcar-common/gen3-spl.c b/board/renesas/rcar-common/gen3-spl.c
index d9741c19398..a3e2aebe776 100644
--- a/board/renesas/rcar-common/gen3-spl.c
+++ b/board/renesas/rcar-common/gen3-spl.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <image.h>
 #include <asm/io.h>
 #include <spl.h>
 
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 058fa6fbb61..30427e54fae 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -9,6 +9,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <image.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index bcae6ff67ca..5d701a98c64 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <malloc.h>
 #include <netdev.h>
 #include <dm.h>
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 262f6640d9d..a2d7b1a1c8f 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -14,6 +14,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 11c11b91c77..00823d2874e 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
+#include <fdt_support.h>
 #include <g_dnl.h>
 #include <generic-phy.h>
 #include <hang.h>
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 6afea6ef42e..e210824b4ef 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <env.h>
 #include <hang.h>
+#include <image.h>
 #include <init.h>
 #include <mmc.h>
 #include <axp_pmic.h>
diff --git a/board/synopsys/hsdk/hsdk.c b/board/synopsys/hsdk/hsdk.c
index 66135ad2a9a..44d95951988 100644
--- a/board/synopsys/hsdk/hsdk.c
+++ b/board/synopsys/hsdk/hsdk.c
@@ -8,6 +8,7 @@
 #include <config.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <image.h>
 #include <init.h>
 #include <irq_func.h>
 #include <asm/cache.h>
diff --git a/board/technexion/pico-imx6/spl.c b/board/technexion/pico-imx6/spl.c
index bafe9ba6b7a..983f98beec3 100644
--- a/board/technexion/pico-imx6/spl.c
+++ b/board/technexion/pico-imx6/spl.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index c6de8602d08..56fe171aa75 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
+#include <image.h>
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 87c7ef6b3f5..923b224e4c1 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -9,6 +9,7 @@
 
 #include <common.h>
 #include <eeprom.h>
+#include <image.h>
 #include <dm/uclass.h>
 #include <env.h>
 #include <fdt_support.h>
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index c80a458c125..8720eb87a55 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 9d96710f056..346f745bb07 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -9,6 +9,8 @@
 
 #include <common.h>
 #include <dm.h>
+#include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index 8f595989507..acf7ff16917 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <spl.h>
 #include <net.h>
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index f918c81f5b6..a1e1915b21f 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -8,6 +8,8 @@
  */
 
 #include <common.h>
+#include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index 6554c0eb118..8595b20e872 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -10,6 +10,7 @@
 #include "board.h"
 #include <env.h>
 #include <hang.h>
+#include <image.h>
 #include <init.h>
 #include <spl.h>
 #include <exports.h>
diff --git a/board/ti/ks2_evm/board_k2e.c b/board/ti/ks2_evm/board_k2e.c
index ecd4a42df40..350cc68e490 100644
--- a/board/ti/ks2_evm/board_k2e.c
+++ b/board/ti/ks2_evm/board_k2e.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index c6a14a05546..21f002e3b1a 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -9,6 +9,7 @@
 #include <eeprom.h>
 #include <env.h>
 #include <hang.h>
+#include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/ti-common/keystone_net.h>
diff --git a/board/ti/ks2_evm/board_k2hk.c b/board/ti/ks2_evm/board_k2hk.c
index 4c0acd627f2..1eb6cd761e2 100644
--- a/board/ti/ks2_evm/board_k2hk.c
+++ b/board/ti/ks2_evm/board_k2hk.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
diff --git a/board/ti/ks2_evm/board_k2l.c b/board/ti/ks2_evm/board_k2l.c
index e49d8b34823..5ff11ee0d62 100644
--- a/board/ti/ks2_evm/board_k2l.c
+++ b/board/ti/ks2_evm/board_k2l.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
 #include <asm/ti-common/keystone_net.h>
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 3b5eabec775..d338dc5f694 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <image.h>
 #include <init.h>
 #include <net.h>
 
diff --git a/board/toradex/verdin-imx8mm/spl.c b/board/toradex/verdin-imx8mm/spl.c
index a5dc5408205..f6556acca69 100644
--- a/board/toradex/verdin-imx8mm/spl.c
+++ b/board/toradex/verdin-imx8mm/spl.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mm_pins.h>
diff --git a/board/tqc/tqma6/tqma6.c b/board/tqc/tqma6/tqma6.c
index c8ddc2c1f85..843dd763d5c 100644
--- a/board/tqc/tqma6/tqma6.c
+++ b/board/tqc/tqma6/tqma6.c
@@ -14,6 +14,7 @@
 #include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <linux/errno.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/board/varisys/cyrus/cyrus.c b/board/varisys/cyrus/cyrus.c
index 13429072c79..a42910f6000 100644
--- a/board/varisys/cyrus/cyrus.c
+++ b/board/varisys/cyrus/cyrus.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <init.h>
 #include <netdev.h>
 #include <linux/compiler.h>
diff --git a/board/wandboard/wandboard.c b/board/wandboard/wandboard.c
index b879c80cd86..b338a527010 100644
--- a/board/wandboard/wandboard.c
+++ b/board/wandboard/wandboard.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 670bcb3aaa8..15e727f4a2d 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -6,6 +6,7 @@
 
 #include <android_image.h>
 #include <common.h>
+#include <image.h>
 #include <mapmem.h>
 
 #define abootimg_addr() \
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index aaed5755059..380daf09a15 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -13,6 +13,7 @@
 #include <efi_selftest.h>
 #include <env.h>
 #include <errno.h>
+#include <image.h>
 #include <malloc.h>
 #include <linux/libfdt.h>
 #include <linux/libfdt_env.h>
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 25a6ed40d20..8e8de1cd555 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <asm/global_data.h>
diff --git a/cmd/fpga.c b/cmd/fpga.c
index b1c7b5453b3..563528ca5e6 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -13,6 +13,7 @@
 #include <fpga.h>
 #include <fs.h>
 #include <gzip.h>
+#include <image.h>
 #include <malloc.h>
 
 static long do_fpga_get_device(char *arg)
diff --git a/cmd/md5sum.c b/cmd/md5sum.c
index 63cbae0364c..4e30334951a 100644
--- a/cmd/md5sum.c
+++ b/cmd/md5sum.c
@@ -10,6 +10,7 @@
 #include <common.h>
 #include <command.h>
 #include <env.h>
+#include <image.h>
 #include <mapmem.h>
 #include <u-boot/md5.h>
 #include <asm/io.h>
diff --git a/cmd/spl.c b/cmd/spl.c
index 56051b8a4be..61256f4830f 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <cmd_spl.h>
 #include <env.h>
+#include <image.h>
 #include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/common/bootm_os.c b/common/bootm_os.c
index 44023532e13..8599bc8ca37 100644
--- a/common/bootm_os.c
+++ b/common/bootm_os.c
@@ -11,6 +11,8 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <image.h>
+#include <lmb.h>
 #include <linux/libfdt.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/common/hash.c b/common/hash.c
index 2cf763575f9..810854ce0f5 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -23,10 +23,10 @@
 #else
 #include "mkimage.h"
 #include <time.h>
-#include <image.h>
 #endif /* !USE_HOSTCC*/
 
 #include <hash.h>
+#include <image.h>
 #include <u-boot/crc.h>
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
diff --git a/common/image-fdt.c b/common/image-fdt.c
index 3002948b6b0..270732278e6 100644
--- a/common/image-fdt.c
+++ b/common/image-fdt.c
@@ -14,6 +14,7 @@
 #include <env.h>
 #include <errno.h>
 #include <image.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <linux/libfdt.h>
 #include <mapmem.h>
diff --git a/common/image-fit.c b/common/image-fit.c
index 0fef0a918da..68d85de6554 100644
--- a/common/image-fit.c
+++ b/common/image-fit.c
@@ -11,6 +11,7 @@
 #ifdef USE_HOSTCC
 #include "mkimage.h"
 #include <time.h>
+#include <linux/libfdt.h>
 #include <u-boot/crc.h>
 #else
 #include <linux/compiler.h>
diff --git a/common/image-sig.c b/common/image-sig.c
index 6563effcf34..387268d975e 100644
--- a/common/image-sig.c
+++ b/common/image-sig.c
@@ -5,7 +5,9 @@
 
 #ifdef USE_HOSTCC
 #include "mkimage.h"
+#include <fdt_support.h>
 #include <time.h>
+#include <linux/libfdt.h>
 #else
 #include <common.h>
 #include <malloc.h>
diff --git a/common/image.c b/common/image.c
index dea66cf0d4d..99fcf96f063 100644
--- a/common/image.c
+++ b/common/image.c
@@ -11,6 +11,7 @@
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <asm/cache.h>
 #include <u-boot/crc.h>
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index bc2921c552d..b83e3bb54ae 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -13,6 +13,7 @@
 #include <atf_common.h>
 #include <cpu_func.h>
 #include <errno.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/cache.h>
 
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 5f8a111a2f0..e81279aa1b9 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -5,6 +5,8 @@
  */
 #include <common.h>
 #include <config.h>
+#include <fdt_support.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <nand.h>
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index 30c050c0b3e..a9b6b07ab30 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <env.h>
 #include <errno.h>
+#include <image.h>
 #include <spl.h>
 #include <net.h>
 #include <linux/libfdt.h>
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index b1e79b9ded6..2737dc9bff6 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <spl.h>
 
 static ulong spl_nor_load_read(struct spl_load_info *load, ulong sector,
diff --git a/common/spl/spl_onenand.c b/common/spl/spl_onenand.c
index ee30f328e60..8ba3d4027a0 100644
--- a/common/spl/spl_onenand.c
+++ b/common/spl/spl_onenand.c
@@ -9,6 +9,7 @@
  */
 #include <common.h>
 #include <config.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/io.h>
 #include <onenand_uboot.h>
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index a136073fdbb..4a8053f0434 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -9,9 +9,11 @@
 #include <cpu_func.h>
 #include <errno.h>
 #include <hang.h>
+#include <image.h>
 #include <spl.h>
 #include <asm/smp.h>
 #include <opensbi.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 954e91a0045..80572ceec2d 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -11,6 +11,7 @@
  */
 #include <common.h>
 #include <binman_sym.h>
+#include <image.h>
 #include <mapmem.h>
 #include <spl.h>
 #include <linux/libfdt.h>
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 288dbb5fa98..7a374bbfcc3 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -9,6 +9,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <errno.h>
diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index 0cb50808827..de6a63bd2d4 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <config.h>
+#include <image.h>
 #include <nand.h>
 #include <onenand_uboot.h>
 #include <ubispl.h>
diff --git a/common/spl/spl_xip.c b/common/spl/spl_xip.c
index 1af4da87255..f8572780184 100644
--- a/common/spl/spl_xip.c
+++ b/common/spl/spl_xip.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <spl.h>
 
 static int spl_xip(struct spl_image_info *spl_image,
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 8500ee8ba5d..414e62176bc 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -10,6 +10,7 @@
  */
 #include <common.h>
 #include <gzip.h>
+#include <image.h>
 #include <spl.h>
 #include <xyzModem.h>
 #include <asm/u-boot.h>
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index c666eb0f29b..94fab4e5e0e 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -12,6 +12,7 @@
 #include <fb_mmc.h>
 #include <flash.h>
 #include <image-sparse.h>
+#include <image.h>
 #include <part.h>
 #include <mmc.h>
 #include <div64.h>
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index 2853581b975..6a3ad6a9690 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
  */
+#include <image.h>
 #include <asm/io.h>
 #include <asm/arch/fpga_manager.h>
 #include <asm/arch/reset_manager.h>
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 0575bd8937f..83dcb402133 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -17,6 +17,7 @@
 #include <fdtdec.h>
 #include <i2c.h>
 #include <linux/errno.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/net/fm/fdt.c b/drivers/net/fm/fdt.c
index a6b0d87415f..242d27a34ea 100644
--- a/drivers/net/fm/fdt.c
+++ b/drivers/net/fm/fdt.c
@@ -4,6 +4,7 @@
  */
 #include <asm/io.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <fsl_qe.h>	/* For struct qe_firmware */
 #include <u-boot/crc.h>
 
diff --git a/drivers/net/fm/init.c b/drivers/net/fm/init.c
index 1ff405bf5b7..c0e5a02db76 100644
--- a/drivers/net/fm/init.c
+++ b/drivers/net/fm/init.c
@@ -10,6 +10,7 @@
 #include <fsl_mdio.h>
 #ifdef CONFIG_FSL_LAYERSCAPE
 #include <asm/arch/fsl_serdes.h>
+#include <linux/libfdt.h>
 #else
 #include <asm/fsl_serdes.h>
 #endif
diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 07bbcc9b231..966e9c75eb7 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <errno.h>
+#include <image.h>
 #include <malloc.h>
 #include <linux/bug.h>
 #include <asm/io.h>
diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 2fa27c7b6ec..2a66c2e5f9b 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
+#include <fdt_support.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <net.h>
diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 29067194cb1..1e0db6c8c7a 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -34,6 +34,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/compat.h>
+#include <linux/libfdt.h>
 #include <linux/mbus.h>
 #include <asm-generic/gpio.h>
 #include <fdt_support.h>
diff --git a/drivers/net/pfe_eth/pfe_firmware.c b/drivers/net/pfe_eth/pfe_firmware.c
index 13112d9c1a3..dbb69a0c595 100644
--- a/drivers/net/pfe_eth/pfe_firmware.c
+++ b/drivers/net/pfe_eth/pfe_firmware.c
@@ -10,6 +10,7 @@
  * files.
  */
 
+#include <image.h>
 #include <malloc.h>
 #include <net/pfe_eth/pfe_eth.h>
 #include <net/pfe_eth/pfe_firmware.h>
diff --git a/drivers/net/ti/keystone_net.c b/drivers/net/ti/keystone_net.c
index 4baeeb83f10..ecd6df9e451 100644
--- a/drivers/net/ti/keystone_net.c
+++ b/drivers/net/ti/keystone_net.c
@@ -21,6 +21,7 @@
 #include <asm/ti-common/keystone_net.h>
 #include <asm/ti-common/keystone_serdes.h>
 #include <asm/arch/psc_defs.h>
+#include <linux/libfdt.h>
 
 #include "cpsw_mdio.h"
 
diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
index 244beef18dd..27bff27ff7e 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -8,10 +8,11 @@
 #include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
+#include <asm/io.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <asm/io.h>
+#include <linux/libfdt.h>
 
 #include "comphy_core.h"
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 7fbe2810a29..535f491d495 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -13,6 +13,7 @@
 #include <fdt_support.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/libfdt.h>
 #include <linux/sizes.h>
 #include <asm/gpio.h>
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 6e0bcae9912..b9fb46815b9 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -32,6 +32,7 @@
 #include <asm/gpio.h>
 #include <asm/system.h>
 #include <asm/io.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/pinctrl-sti.c b/drivers/pinctrl/pinctrl-sti.c
index f0cd845fea5..14fcad5aadb 100644
--- a/drivers/pinctrl/pinctrl-sti.c
+++ b/drivers/pinctrl/pinctrl-sti.c
@@ -14,6 +14,7 @@
 #include <syscon.h>
 #include <asm/io.h>
 #include <dm/pinctrl.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 9926235b52e..32038cea8fa 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -9,6 +9,7 @@
 #include <dm/lists.h>
 #include <dm/pinctrl.h>
 #include <linux/err.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 0fd0416b180..386a13ed876 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -9,6 +9,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <fdtdec.h>
+#include <linux/libfdt.h>
 
 #include "pinctrl-rockchip.h"
 
diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 8e2a09df366..c17b2e30d7e 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <asm/io.h>
+#include <linux/libfdt.h>
 #include <linux/sizes.h>
 #include <linux/iopoll.h>
 #include <dm.h>
diff --git a/drivers/thermal/imx_scu_thermal.c b/drivers/thermal/imx_scu_thermal.c
index 7e17377b696..ec908199f86 100644
--- a/drivers/thermal/imx_scu_thermal.c
+++ b/drivers/thermal/imx_scu_thermal.c
@@ -11,6 +11,7 @@
 #include <dm/device-internal.h>
 #include <dm/device.h>
 #include <asm/arch/sci/sci.h>
+#include <linux/libfdt.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
index eee84f49bb1..6f749736f18 100644
--- a/include/asm-generic/u-boot.h
+++ b/include/asm-generic/u-boot.h
@@ -23,6 +23,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/types.h>
+#include <linux/types.h>
+
 typedef struct bd_info {
 	unsigned long	bi_memstart;	/* start of DRAM memory */
 	phys_size_t	bi_memsize;	/* size	 of DRAM memory in bytes */
diff --git a/include/common.h b/include/common.h
index fd3e2de4cce..a87c0628806 100644
--- a/include/common.h
+++ b/include/common.h
@@ -28,7 +28,6 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <linux/kernel.h>
-#include <image.h>
 #include <log.h>
 #include <asm/u-boot.h> /* boot information for Linux kernel */
 #include <asm/global_data.h>	/* global data used for startup functions */
diff --git a/include/tee/optee.h b/include/tee/optee.h
index 121b30a3030..affa937da08 100644
--- a/include/tee/optee.h
+++ b/include/tee/optee.h
@@ -10,6 +10,7 @@
 #define _OPTEE_H
 
 #include <linux/errno.h>
+#include <image.h>
 
 #define OPTEE_MAGIC             0x4554504f
 #define OPTEE_VERSION           1
@@ -28,14 +29,16 @@ struct optee_header {
 	uint32_t paged_size;
 };
 
-static inline uint32_t optee_image_get_entry_point(const image_header_t *hdr)
+static inline uint32_t
+optee_image_get_entry_point(const struct image_header *hdr)
 {
 	struct optee_header *optee_hdr = (struct optee_header *)(hdr + 1);
 
 	return optee_hdr->init_load_addr_lo;
 }
 
-static inline uint32_t optee_image_get_load_addr(const image_header_t *hdr)
+static inline uint32_t
+optee_image_get_load_addr(const struct image_header *hdr)
 {
 	return optee_image_get_entry_point(hdr) - sizeof(struct optee_header);
 }
diff --git a/lib/libfdt/fdt_region.c b/lib/libfdt/fdt_region.c
index 7e9fa9272e8..4af5f77e1b9 100644
--- a/lib/libfdt/fdt_region.c
+++ b/lib/libfdt/fdt_region.c
@@ -5,6 +5,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <fdt_support.h>
 #include <linux/libfdt_env.h>
 
 #ifndef USE_HOSTCC
diff --git a/lib/libfdt/fdt_ro.c b/lib/libfdt/fdt_ro.c
index be03aea9eb0..241b60856c1 100644
--- a/lib/libfdt/fdt_ro.c
+++ b/lib/libfdt/fdt_ro.c
@@ -3,6 +3,7 @@
  * libfdt - Flat Device Tree manipulation
  * Copyright (C) 2006 David Gibson, IBM Corporation.
  */
+#include <fdt_support.h>
 #include <linux/libfdt_env.h>
 
 #ifndef USE_HOSTCC
diff --git a/lib/lmb.c b/lib/lmb.c
index 07b9308adf2..2f0e495edf2 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <image.h>
 #include <lmb.h>
 #include <malloc.h>
 
diff --git a/net/tftp.c b/net/tftp.c
index 585eb6ef0cb..118439b1b82 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -11,6 +11,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <image.h>
+#include <lmb.h>
 #include <mapmem.h>
 #include <net.h>
 #include <net/tftp.h>
diff --git a/test/compression.c b/test/compression.c
index 63f929fa4bd..bceb2c273c7 100644
--- a/test/compression.c
+++ b/test/compression.c
@@ -7,6 +7,7 @@
 #include <bootm.h>
 #include <command.h>
 #include <gzip.h>
+#include <image.h>
 #include <lz4.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/test/overlay/cmd_ut_overlay.c b/test/overlay/cmd_ut_overlay.c
index d0083fd6bee..c8d41a4dca2 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/overlay/cmd_ut_overlay.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <errno.h>
 #include <fdt_support.h>
+#include <image.h>
 #include <malloc.h>
 
 #include <linux/sizes.h>
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 1b428c3b2fd..133780f5eaa 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -6,6 +6,7 @@
  */
 
 #include "imx8image.h"
+#include <image.h>
 
 static int p_idx;
 static int sector_size;
-- 
2.26.0.292.g33ef6b2f38-goog

