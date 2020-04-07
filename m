Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web11.2356.1586227289998251186
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2020 19:41:30 -0700
Received: by mail-io1-f66.google.com with SMTP id o3so1855195ioh.2
        for <u-boot-amlogic@groups.io>; Mon, 06 Apr 2020 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jYSbr3aLUnt0eeEcKtCoJigKMNamtPpCM7ZnV2YizI=;
        b=UjJBvZfTaucM6T6/KoVUw8OKRlCcCNKQbyCG1EXiMn/YM4YJc+6M9FUvwrUGpEmZuU
         wgsXgwPwuKGuhzF5uRE6fOi4Nbm8p/+wBmb3iTeJaDohAsVfe+tfMiCPBVeA+krdKKTZ
         obZ1mCwI556zKX8vQEyuTh0iUBeT5ZDFpmJ4A=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/18] common: Drop asm/ptrace.h from common header
Date: Mon,  6 Apr 2020 20:40:26 -0600
Message-Id: <20200406203250.13.I470731da548fee846f1d7f35a1330a9de6f590c1@changeid>
In-Reply-To: <20200407024032.82983-1-sjg@chromium.org>
References: <20200407024032.82983-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Glass <sjg@chromium.org>, Alex Marginean <alexandru.marginean@nxp.com>, Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Huan Wang <alison.wang@nxp.com>, Ibai Erkiaga <ibai.erkiaga-elorza@xilinx.com>, Joe Hershberger <joe.hershberger@ni.com>, Kever Yang <kever.yang@rock-chips.com>, Luca Ceresoli <luca@lucaceresoli.net>, Lukasz Majewski <lukma@denx.de>, Mario Six <mario.six@gdsys.cc>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Miquel Raynal <miquel.raynal@bootlin.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rajan Vaja <rajan.vaja@xilinx.com>, Sergey Temerkhanov <s.temerkhanov@gmail.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Thomas Hebb <tommyhebb@gmail.com>, Thomas Schaefer <thomas.schaefer@kontron.com>, Trevor Woerner <trevor@toganlabs.com>, Udit Agarwal <udit.agarwal@nxp.com>, Vagrant Cascadian <vagrant@debian.org>, Wolfgang Denk <wd@denx.de>, Yuantian Tang <andy.tang@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Move this uncommon header out of the common header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/arm1136/mx35/timer.c       | 1 +
 arch/arm/cpu/arm926ejs/mx25/timer.c     | 1 +
 arch/arm/cpu/arm926ejs/mx27/timer.c     | 1 +
 arch/arm/cpu/arm926ejs/spear/spl.c      | 1 +
 arch/arm/cpu/arm926ejs/spear/timer.c    | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 1 +
 arch/arm/cpu/armv8/sec_firmware.c       | 1 +
 arch/arm/lib/interrupts.c               | 1 +
 arch/arm/lib/interrupts_64.c            | 1 +
 arch/arm/mach-imx/sip.c                 | 1 +
 arch/arm/mach-meson/board-common.c      | 1 +
 arch/arm/mach-meson/sm.c                | 1 +
 arch/arm/mach-mvebu/arm64-common.c      | 1 +
 arch/m68k/lib/interrupts.c              | 1 +
 arch/m68k/lib/traps.c                   | 1 +
 arch/mips/lib/traps.c                   | 1 +
 arch/powerpc/cpu/mpc83xx/interrupts.c   | 1 +
 arch/powerpc/cpu/mpc83xx/traps.c        | 1 +
 arch/powerpc/cpu/mpc85xx/interrupts.c   | 1 +
 arch/powerpc/cpu/mpc85xx/traps.c        | 1 +
 arch/powerpc/cpu/mpc86xx/interrupts.c   | 1 +
 arch/powerpc/cpu/mpc86xx/traps.c        | 1 +
 arch/powerpc/cpu/mpc8xx/interrupts.c    | 1 +
 arch/powerpc/cpu/mpc8xx/traps.c         | 1 +
 arch/powerpc/lib/interrupts.c           | 1 +
 arch/powerpc/lib/kgdb.c                 | 1 +
 arch/x86/cpu/i386/interrupt.c           | 1 +
 arch/xtensa/cpu/exceptions.c            | 1 +
 board/cavium/thunderx/atf.c             | 1 +
 board/xilinx/zynqmp/zynqmp.c            | 1 +
 cmd/bedbug.c                            | 1 +
 common/bedbug.c                         | 1 +
 common/kgdb.c                           | 1 +
 common/kgdb_stubs.c                     | 1 +
 drivers/clk/clk_versal.c                | 1 +
 drivers/firmware/firmware-zynqmp.c      | 1 +
 drivers/timer/mpc83xx_timer.c           | 1 +
 include/common.h                        | 1 -
 38 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/arm1136/mx35/timer.c b/arch/arm/cpu/arm1136/mx35/timer.c
index cb351ecf769..f2541c398d8 100644
--- a/arch/arm/cpu/arm1136/mx35/timer.c
+++ b/arch/arm/cpu/arm1136/mx35/timer.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/crm_regs.h>
+#include <asm/ptrace.h>
 
 /* General purpose timers bitfields */
 #define GPTCR_SWR       (1<<15)	/* Software reset */
diff --git a/arch/arm/cpu/arm926ejs/mx25/timer.c b/arch/arm/cpu/arm926ejs/mx25/timer.c
index 7e2698b6055..4b726d5c73f 100644
--- a/arch/arm/cpu/arm926ejs/mx25/timer.c
+++ b/arch/arm/cpu/arm926ejs/mx25/timer.c
@@ -23,6 +23,7 @@
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
+#include <asm/ptrace.h>
 
 /* nothing really to do with interrupts, just starts up a counter. */
 /* The 32KHz 32-bit timer overruns in 134217 seconds */
diff --git a/arch/arm/cpu/arm926ejs/mx27/timer.c b/arch/arm/cpu/arm926ejs/mx27/timer.c
index 193588ea10b..d6e1e09f93e 100644
--- a/arch/arm/cpu/arm926ejs/mx27/timer.c
+++ b/arch/arm/cpu/arm926ejs/mx27/timer.c
@@ -21,6 +21,7 @@
 #include <time.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
+#include <asm/ptrace.h>
 
 /* General purpose timers bitfields */
 #define GPTCR_SWR		(1 << 15)	/* Software reset	*/
diff --git a/arch/arm/cpu/arm926ejs/spear/spl.c b/arch/arm/cpu/arm926ejs/spear/spl.c
index 7b14ba05b46..08b98a2d068 100644
--- a/arch/arm/cpu/arm926ejs/spear/spl.c
+++ b/arch/arm/cpu/arm926ejs/spear/spl.c
@@ -11,6 +11,7 @@
 #include <spl.h>
 #include <version.h>
 #include <asm/io.h>
+#include <asm/ptrace.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/spr_defs.h>
 #include <asm/arch/spr_misc.h>
diff --git a/arch/arm/cpu/arm926ejs/spear/timer.c b/arch/arm/cpu/arm926ejs/spear/timer.c
index 9db1c74b369..6803c349e84 100644
--- a/arch/arm/cpu/arm926ejs/spear/timer.c
+++ b/arch/arm/cpu/arm926ejs/spear/timer.c
@@ -11,6 +11,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/spr_gpt.h>
 #include <asm/arch/spr_misc.h>
+#include <asm/ptrace.h>
 
 #define GPT_RESOLUTION	(CONFIG_SPEAR_HZ_CLOCK / CONFIG_SPEAR_HZ)
 #define READ_TIMER()	(readl(&gpt_regs_p->count) & GPT_FREE_RUNNING)
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index febb3857f2b..7bab283c399 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -15,6 +15,7 @@
 #include <vsprintf.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <asm/ptrace.h>
 #include <linux/errno.h>
 #include <asm/system.h>
 #include <fm_eth.h>
diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index 789f9ca5667..bfc0fac3eff 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -10,6 +10,7 @@
 #include <image.h>
 #include <log.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
 #include <asm/system.h>
diff --git a/arch/arm/lib/interrupts.c b/arch/arm/lib/interrupts.c
index 6dbf03b00cd..885233e0824 100644
--- a/arch/arm/lib/interrupts.c
+++ b/arch/arm/lib/interrupts.c
@@ -23,6 +23,7 @@
 #include <efi_loader.h>
 #include <irq_func.h>
 #include <asm/proc-armv/ptrace.h>
+#include <asm/ptrace.h>
 #include <asm/u-boot-arm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index dffdf57aa20..bc062dfc9f4 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -5,6 +5,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <irq_func.h>
 #include <linux/compiler.h>
 #include <efi_loader.h>
diff --git a/arch/arm/mach-imx/sip.c b/arch/arm/mach-imx/sip.c
index a4f0ab48863..6cb8179ee8c 100644
--- a/arch/arm/mach-imx/sip.c
+++ b/arch/arm/mach-imx/sip.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 
 unsigned long call_imx_sip(unsigned long id, unsigned long reg0,
 			   unsigned long reg1, unsigned long reg2,
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 3a7cffcab31..9d8668b2de4 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -10,6 +10,7 @@
 #include <asm/arch/boot.h>
 #include <env.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 #include <linux/libfdt.h>
 #include <linux/err.h>
 #include <asm/arch/mem.h>
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index e6da4de5343..dd660769e2c 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <asm/arch/sm.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <dm.h>
diff --git a/arch/arm/mach-mvebu/arm64-common.c b/arch/arm/mach-mvebu/arm64-common.c
index 2896d6b0611..a888f740efc 100644
--- a/arch/arm/mach-mvebu/arm64-common.c
+++ b/arch/arm/mach-mvebu/arm64-common.c
@@ -8,6 +8,7 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 #include <linux/libfdt.h>
 #include <linux/sizes.h>
 #include <pci.h>
diff --git a/arch/m68k/lib/interrupts.c b/arch/m68k/lib/interrupts.c
index ddc91993a14..1caef61d20e 100644
--- a/arch/m68k/lib/interrupts.c
+++ b/arch/m68k/lib/interrupts.c
@@ -12,6 +12,7 @@
 #include <watchdog.h>
 #include <asm/processor.h>
 #include <asm/immap.h>
+#include <asm/ptrace.h>
 
 #define	NR_IRQS		(CONFIG_SYS_NUM_IRQS)
 
diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index 2ccd55add0c..c49141f376d 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -12,6 +12,7 @@
 #include <watchdog.h>
 #include <command.h>
 #include <asm/processor.h>
+#include <asm/ptrace.h>
 
 
 extern void _exc_handler(void);
diff --git a/arch/mips/lib/traps.c b/arch/mips/lib/traps.c
index 265bd8383bb..196e82a5016 100644
--- a/arch/mips/lib/traps.c
+++ b/arch/mips/lib/traps.c
@@ -11,6 +11,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mpc83xx/interrupts.c
index 8d525dc8373..d04f31df502 100644
--- a/arch/powerpc/cpu/mpc83xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
@@ -11,6 +11,7 @@
 #include <irq_func.h>
 #include <mpc83xx.h>
 #include <asm/processor.h>
+#include <asm/ptrace.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/cpu/mpc83xx/traps.c b/arch/powerpc/cpu/mpc83xx/traps.c
index 1c6c38b15f1..c3cc119d654 100644
--- a/arch/powerpc/cpu/mpc83xx/traps.c
+++ b/arch/powerpc/cpu/mpc83xx/traps.c
@@ -12,6 +12,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <command.h>
 #include <kgdb.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/cpu/mpc85xx/interrupts.c b/arch/powerpc/cpu/mpc85xx/interrupts.c
index e9da9c0d48f..4ad762683fb 100644
--- a/arch/powerpc/cpu/mpc85xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc85xx/interrupts.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_POST
 #include <post.h>
 #endif
+#include <asm/ptrace.h>
 
 void interrupt_init_cpu(unsigned *decrementer_count)
 {
diff --git a/arch/powerpc/cpu/mpc85xx/traps.c b/arch/powerpc/cpu/mpc85xx/traps.c
index bc2fc93e110..f37a45e2694 100644
--- a/arch/powerpc/cpu/mpc85xx/traps.c
+++ b/arch/powerpc/cpu/mpc85xx/traps.c
@@ -20,6 +20,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <command.h>
 #include <init.h>
 #include <irq_func.h>
diff --git a/arch/powerpc/cpu/mpc86xx/interrupts.c b/arch/powerpc/cpu/mpc86xx/interrupts.c
index 033ca327f00..5a916600ed6 100644
--- a/arch/powerpc/cpu/mpc86xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc86xx/interrupts.c
@@ -24,6 +24,7 @@
 #ifdef CONFIG_POST
 #include <post.h>
 #endif
+#include <asm/ptrace.h>
 
 void interrupt_init_cpu(unsigned *decrementer_count)
 {
diff --git a/arch/powerpc/cpu/mpc86xx/traps.c b/arch/powerpc/cpu/mpc86xx/traps.c
index 79bab913676..c0161e3379c 100644
--- a/arch/powerpc/cpu/mpc86xx/traps.c
+++ b/arch/powerpc/cpu/mpc86xx/traps.c
@@ -14,6 +14,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <command.h>
 #include <init.h>
 #include <kgdb.h>
diff --git a/arch/powerpc/cpu/mpc8xx/interrupts.c b/arch/powerpc/cpu/mpc8xx/interrupts.c
index 3efe8956ec5..eef1951f2fd 100644
--- a/arch/powerpc/cpu/mpc8xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc8xx/interrupts.c
@@ -12,6 +12,7 @@
 #include <asm/cpm_8xx.h>
 #include <asm/processor.h>
 #include <asm/io.h>
+#include <asm/ptrace.h>
 
 /************************************************************************/
 
diff --git a/arch/powerpc/cpu/mpc8xx/traps.c b/arch/powerpc/cpu/mpc8xx/traps.c
index 899bcd86188..56794b08a15 100644
--- a/arch/powerpc/cpu/mpc8xx/traps.c
+++ b/arch/powerpc/cpu/mpc8xx/traps.c
@@ -16,6 +16,7 @@
  */
 
 #include <common.h>
+#include <asm/ptrace.h>
 #include <command.h>
 #include <asm/processor.h>
 
diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index 64ee0cc2102..73f270002cf 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -14,6 +14,7 @@
 #ifdef CONFIG_LED_STATUS
 #include <status_led.h>
 #endif
+#include <asm/ptrace.h>
 
 #ifndef CONFIG_MPC83XX_TIMER
 #ifndef CONFIG_SYS_WATCHDOG_FREQ
diff --git a/arch/powerpc/lib/kgdb.c b/arch/powerpc/lib/kgdb.c
index 4a3e26cffc0..8727d18884c 100644
--- a/arch/powerpc/lib/kgdb.c
+++ b/arch/powerpc/lib/kgdb.c
@@ -1,6 +1,7 @@
 #include <common.h>
 #include <command.h>
 #include <kgdb.h>
+#include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <asm/processor.h>
 
diff --git a/arch/x86/cpu/i386/interrupt.c b/arch/x86/cpu/i386/interrupt.c
index 4c7e9ea2151..387fb9703c4 100644
--- a/arch/x86/cpu/i386/interrupt.c
+++ b/arch/x86/cpu/i386/interrupt.c
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/lapic.h>
 #include <asm/processor-flags.h>
+#include <asm/ptrace.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/xtensa/cpu/exceptions.c b/arch/xtensa/cpu/exceptions.c
index 3b8f4a36d3e..cf9af4326a2 100644
--- a/arch/xtensa/cpu/exceptions.c
+++ b/arch/xtensa/cpu/exceptions.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <command.h>
 #include <irq_func.h>
+#include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/regs.h>
 
diff --git a/board/cavium/thunderx/atf.c b/board/cavium/thunderx/atf.c
index f01ead4e235..64aa198765f 100644
--- a/board/cavium/thunderx/atf.c
+++ b/board/cavium/thunderx/atf.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <asm/ptrace.h>
 
 #include <asm/system.h>
 #include <cavium/thunderx_svc.h>
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 76758237c00..4f8a0453f46 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -22,6 +22,7 @@
 #include <asm/arch/psu_init_gpl.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <asm/ptrace.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <usb.h>
diff --git a/cmd/bedbug.c b/cmd/bedbug.c
index b5dad4ba11d..182838bed38 100644
--- a/cmd/bedbug.c
+++ b/cmd/bedbug.c
@@ -6,6 +6,7 @@
 #include <cli.h>
 #include <command.h>
 #include <console.h>
+#include <asm/ptrace.h>
 #include <linux/ctype.h>
 #include <net.h>
 #include <bedbug/type.h>
diff --git a/common/bedbug.c b/common/bedbug.c
index 42ecf61eff6..18a35ca23ef 100644
--- a/common/bedbug.c
+++ b/common/bedbug.c
@@ -1,6 +1,7 @@
 /* $Id$ */
 
 #include <common.h>
+#include <asm/ptrace.h>
 
 #include <linux/ctype.h>
 #include <bedbug/bedbug.h>
diff --git a/common/kgdb.c b/common/kgdb.c
index 312e14960aa..4493a159198 100644
--- a/common/kgdb.c
+++ b/common/kgdb.c
@@ -88,6 +88,7 @@
  ****************************************************************************/
 
 #include <common.h>
+#include <asm/ptrace.h>
 
 #include <kgdb.h>
 #include <command.h>
diff --git a/common/kgdb_stubs.c b/common/kgdb_stubs.c
index c061126bed2..66aed7cea1c 100644
--- a/common/kgdb_stubs.c
+++ b/common/kgdb_stubs.c
@@ -11,6 +11,7 @@
 #include <cpu_func.h>
 #include <kgdb.h>
 #include <serial.h>
+#include <asm/ptrace.h>
 
 int (*debugger_exception_handler)(struct pt_regs *);
 
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 649012053b0..d0bc9f5fa90 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <log.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 1bba763b64c..2dd737d6a0d 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
+#include <asm/ptrace.h>
 
 #if defined(CONFIG_ZYNQMP_IPI)
 #include <mailbox.h>
diff --git a/drivers/timer/mpc83xx_timer.c b/drivers/timer/mpc83xx_timer.c
index 3ef56f144e8..186fe2b45ac 100644
--- a/drivers/timer/mpc83xx_timer.c
+++ b/drivers/timer/mpc83xx_timer.c
@@ -14,6 +14,7 @@
 #include <time.h>
 #include <timer.h>
 #include <watchdog.h>
+#include <asm/ptrace.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/include/common.h b/include/common.h
index b698e35fec1..395d1d39018 100644
--- a/include/common.h
+++ b/include/common.h
@@ -24,7 +24,6 @@
 #include <linux/printk.h>
 #include <linux/string.h>
 #include <linux/stringify.h>
-#include <asm/ptrace.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <linux/kernel.h>
-- 
2.26.0.292.g33ef6b2f38-goog

