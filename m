Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6605ACA5FA5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2907.1790705245621180671
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=X/W6LHHL;
 spf=pass (domain: brivo.com, ip: 209.85.222.182, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93c64decd21so81164085a.1
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705244; x=1791310044; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
        b=X/W6LHHLwZGZhUgG9GAPnVjaNYNQvwjYeDDbZwo+dz+eCZ0INLUyq8BgL6GMFksewQ
         ooFesH7M9rE0blk28I/eQO7RDJqHAmLWVawT4RVeYE+oul+dwYiOuHVH8Fgl/GViTISJ
         /lJB/92kaP6sjJBhanPIwKV4JC3a/Om3GQ3kVy4QfLkYtGYAYtNk155Zul58+D8Mq1zt
         uEpHMgwbl+Q/c4/RsWUONgbz/i1mHZ4QK51Am3xE7/Du6i4vvaHOksEvmYQ3S1wGNC8r
         HPC73uauhc+gYyOtnZH9ChPkJx/GOqKub0/RjQOGr28G49STgF75tmLkv0cYcDbgNlmG
         P3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705244; x=1791310044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgpZpsCumAAayqcYCfhHwv/BHePfOwBj0whUkaLwwUk=;
        b=A2Wvrbc6ahPLxao0enFak4eZmc4PXVG9S2vYovzi0nPahJhB5Zil3d03uM8QWB8hPp
         cj8hfaj87E4EuWBB5GZzhGUKqtYjdnWRUr6G9U8CL7uQhWkcr/kVFq8B5BfwYI8/MTLZ
         g1Mu4R2e+HEc93oVuMBnZd7NDjBXwuUluHjBOBt0vDYjaThEorxyIj8WcnNcus/EThkY
         R61YztMe/aIon8cNkdQOWS92qCL8hcMDXq1/0Wo+TpAhrrohbnQ3uY1asQd/bhpZPxnT
         0s+XFjbe+TZ5W/i38Ceou1D3tl1KcOmm6KKXXL8ZNmaeOy9nPTos7gXttaRQGIFXGEie
         7igw==
X-Gm-Message-State: AFuF++lotA1RKySjhNWNGzPumQTYpQWTjyBmp8Ran5DLyOT2sQ+TfRVm
	U+ooxHslDPDtThh01Go5IIyNkm3q5knYPhXucp/pvTiG0/VDwoREzkNxnMssMN7hIQ3m5CrPDDw
	2/SIlZG8Nw5WIA/ObRb+OcUPbUP7gbL4S9ZbqAHBBGHlXB3KQAgLNLA==
X-Gm-Gg: AYBFou0Na8ex6V1znKTE+oqhZhI01tbR2To8jC+mUToD8gCa0ET6g3ElZCbd2sUIhCo
	minkjsHmH3kzHwPlqW0omOpsnQ/PjqjAUmkiA0ccRAa4H71k7U9Q/casB9vhq9nESStbm7n4p1Y
	nonG0fVikWN7nrvv6j8ZCeO8VeQ8OmjjDQkLCuQ65GHdd/PIsx92SZj49ukee0tP2DOv9WVMoYO
	3telyc7j1/i/79TjsfbyDjzJbuFlOK2p+DsrC6aZgXk0bwVzbb46RyL2QOx/23f9/+xgzrLxR+F
	2IrXIGMiZuPSClwPZNTIoqCNnFbEIH4W54Lt0Z2MCUKTSQdbn9WHxPloxEx4N/GPQWZDQ4G3Vg/
	/+2G19bm+C2sRtYLbG58Xv5NmgARUzqIXKD3P/MyM2pwmL7GHrRvsAUhcQTUrxKR7jz8etTalLd
	ee9UgzSTInVY0KdsW3w7igD4XGHH+WQTr1Bpz7LBKxeQ628Npjakpp0iBtkkmedITv
X-Received: by 2002:a05:620a:2b42:b0:93c:7bc2:2599 with SMTP id af79cd13be357-93c8bf63a01mr670440685a.27.1790705244255;
        Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/9] arm64: meson: Add s4 SoC support
Date: Tue, 29 Sep 2026 14:06:23 -0400
Message-ID: <20260929180721.3440839-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3104

Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
similar to other recent SoCs, with the exception of a workaround for
some BL2 (mis)behavior. Memory for ATF/TEE is expected to be reserved in
the board devicetree, so we don't reserve it in board-s4.c.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- Add S4 to meson board info
- Add DEBUG_UART defaults
- Extend initial padding to 4096 to match what Amlogic does

 arch/arm/include/asm/arch-meson/boot0.h | 12 ++++++
 arch/arm/mach-meson/Kconfig             |  7 ++++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-info.c        |  2 +
 arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
 drivers/serial/Kconfig                  |  2 +
 6 files changed, 74 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..d098786e5f1
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Brivo Systems LLC
+ */
+b reset
+/*
+ * BL2 copies some keys to the start of DRAM, clobbering anything in the first
+ * 4k aside from the initial instruction. I measured the actual data clobbered
+ * as 1076 bytes, but I suspect the amount depends on the configuration, so
+ * just go with what amlogic does.
+ */
+.skip 4096
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..91d1e8342e0 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,13 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_S4
+	bool "S4"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	help
+	  Select this if your SoC is an S905Y4/S905W2/S805X2
+
 endchoice
 
 config SYS_SOC
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 08a24d4b24f..2157c35c2d5 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -17,3 +17,4 @@ endif
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
+obj-$(CONFIG_MESON_S4) += board-s4.o
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index d3807dc787d..379f6a42c22 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -40,6 +40,7 @@ static const struct meson_gx_soc_id {
 	{ "G12B",   0x29 },
 	{ "SM1",    0x2b },
 	{ "A1",	    0x2c },
+	{ "S4",     0x37 },
 };
 
 static const struct meson_gx_package_id {
@@ -73,6 +74,7 @@ static const struct meson_gx_package_id {
 	{ "S905X3", 0x2b, 0x10, 0x3f },
 	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
+	{ "S905Y4", 0x37, 0x03, 0xff },
 };
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
new file mode 100644
index 00000000000..7d0bea9924f
--- /dev/null
+++ b/arch/arm/mach-meson/board-s4.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ */
+
+#include <asm/armv8/mmu.h>
+#include <asm/io.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+
+void meson_init_reserved_memory(__maybe_unused void *fdt)
+{
+}
+
+int meson_get_boot_device(void)
+{
+	return -ENOSYS;
+}
+
+static struct mm_region s4_mem_map[] = {
+	{
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 0x7FE00000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/*
+		 * This mem region contains in/out shared memory with bl31,
+		 * hence it's marked as NORMAL memory type
+		 */
+		.virt = 0xFFE00000UL,
+		.phys = 0xFFE00000UL,
+		.size = 0x00200000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = s4_mem_map;
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d663ff..909e5e4c5f5 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -537,6 +537,7 @@ config DEBUG_UART_BASE
 	default 0xe0000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
 	default 0xff000000 if DEBUG_UART_PL011 && ARCH_VERSAL
 	default 0xf1920000 if DEBUG_UART_PL011 && (ARCH_VERSAL_NET || ARCH_VERSAL2)
+	default 0xfe07a000 if DEBUG_UART_MESON && MESON_S4
 	help
 	  This is the base address of your UART for memory-mapped UARTs.
 
@@ -573,6 +574,7 @@ config DEBUG_UART_CLOCK
 	default 100000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
 	default 50000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
 	default 100000000 if DEBUG_UART_PL011 && (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
+	default 24000000 if DEBUG_UART_MESON && MESON_S4
 	help
 	  The UART input clock determines the speed of the internal UART
 	  circuitry. The baud rate is derived from this by dividing the input
-- 
2.53.0


