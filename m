Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ABFC61DBC
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3445.1787302275509659925
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Aug 2026 01:51:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: tanurelinux@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aebd52488cso809695e87.2
        for <u-boot-amlogic@groups.io>; Fri, 21 Aug 2026 01:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302273; x=1787907073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1BMh1FQCKfQgkMOYAGM2kVSF9egcf+N7e2yoEbuF5M=;
        b=Mj4xW5W0juW+DWO1MnNhm+pwxUh8vigG39th80uXXn2toDhhiteqLslSM2BYOtUhwU
         rSgBGadtcDmKTUvtSxUyGHqOt36WHe3JjIidmqyL79vh0sSrGZxRRB9HdHqI/KF5AILQ
         HkMn294s1nfcHwqod9ZgjPcI2szUctMB+7TXhGBUlMjIfbCz2A7+A/Rgt1uMHlBY6htc
         7Yq2DaWfatRkASauM1zjcNUuTiTbdmrj1ZmL1hyLkOOapBn1zlkJBDXBm6AHZVcv+ZG1
         gLXeYrRipmzkjrk5arC0jM5vd1V4czmPuKoaVJu/mr88IQ5R7WYca8lb/Zs0vlUG1JQd
         y/zw==
X-Forwarded-Encrypted: i=1; AHgh+RqPjfyzq0vnwo5Dcyf53MV3rI3Yh73RNXARBCDom+cmrj6squtiiHZdyEZ8JlycI6T1mm0sieT4RHtu9grCmA==@groups.io
X-Gm-Message-State: AFuF++kl0wMZnJDdWYm764sMskTm+ZiFgFWFVv8BVYc7CdJIcmHeeABp
	qRrQI1kYgb/oJofdw6+/vSVXHI+m0Mx+VqNv0cQawtIkShcA63rVOJkP+eds3Q==
X-Gm-Gg: AR+sD10NKOyZct03BSHA5am3MxEZePJ602FMrJlPme3QmEgQvScXPkK7vKAWgbz1Eoz
	d43jzyAfZi7Oest4BPDsioZFrMtgg/dO7e7TiGDWoqZx/AcZ4NyK1qSfEoZO1Vxeih9YdlegsGF
	YWnLmJx3lE8qo9N0buO5dQ4JfLycGzIlKjg/ioN9OWH+eMDfPjCiutSwD5vMT+O0hRordaoaZcn
	n1bhNmlAUTpgoQgLO62ucxf/AGAQflPudTkyGlbKw3ay+jSelufT0Azg1Ajof6Rm4KxEac9teOU
	GMpo5nhtV+NNO2t5fanQYcVUpsYd3tmN9YiZ1WwJvMGmr1GvnEd0yOKqikzv4iDnLNMvV8TDAwt
	yer+G/Gl8UjeS+2gTQywfB+atcK0jNE3hrh7ui6diOjvFAAfZuxqZqGL6ef+YTFjsYJWZRd4/VL
	5kHn/5TViUGt+5Wg33pBn9PpAsnZBFq8khi/IMxAsnNNtdRQLAqCxvswAhrYtQPNHP+2OA01rmK
	3vpw13gQj/GHwDqHquMdoxhlfLhAlDTePKdt7k=
X-Received: by 2002:a05:600c:198c:b0:499:9eb8:a1d7 with SMTP id 5b1f17b1804b1-499b844b91bmr59118505e9.9.1787301969215;
        Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:46:08 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 2/4] arm: meson: add Amlogic T7 SoC family support
Date: Fri, 21 Aug 2026 09:46:01 +0100
Message-ID: <20260821084603.25974-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3050

Add initial support for the Amlogic T7 family (A311D2). U-Boot runs
as BL33, loaded at address 0x0 and entered from the vendor BL31 at
EL2, either uncompressed or LZ4-compressed inside the boot image (the
BL31 decompresses it).

The secure firmware writes the SCS device keys into the first page of
the loaded BL33 image (2 KiB for the BL33 key followed by 2 KiB for
the kernel key). Reserve that page with a boot0 hook, as the vendor
U-Boot does, so the keys do not overwrite U-Boot's entry code.

The firmware also enters BL33 with the non-secure watchdog running:
disable it in board_init(), otherwise the board is reset about a
minute after boot.

The memory map leaves 0x05100000 - 0x09000000 unmapped: the secure
world owns this span (the BL31 and BL32 runtime zones described in
the upstream devicetree, plus further firmware-protected pages), and
this matches the vendor bootloader's own map. The whole span is also
added to the devicetree and EFI reserved memory at boot time so no
allocation is placed in memory U-Boot cannot access.

get_effective_memsize() is capped at 0xdf800000 because the top 8 MiB
of the first DRAM bank contain pages the secure world protects at
runtime; U-Boot and its heap must stay below them.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm/include/asm/arch-meson/boot0.h | 18 ++++++
 arch/arm/include/asm/arch-meson/t7.h    | 25 ++++++++
 arch/arm/mach-meson/Kconfig             |  9 +++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-t7.c          | 82 +++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/include/asm/arch-meson/t7.h
 create mode 100644 arch/arm/mach-meson/board-t7.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..3ec085ccd64
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#ifndef __MESON_BOOT0_H
+#define __MESON_BOOT0_H
+
+/*
+ * The T7-family secure firmware writes the SCS device keys into the
+ * first page of the loaded BL33 image (2048 bytes for the BL33 key
+ * followed by 2048 bytes for the kernel key). Keep that page reserved
+ * so the keys do not overwrite U-Boot's entry code.
+ */
+	b	reset
+	.space	4096
+
+#endif /* __MESON_BOOT0_H */
diff --git a/arch/arm/include/asm/arch-meson/t7.h b/arch/arm/include/asm/arch-meson/t7.h
new file mode 100644
index 00000000000..e0a90329082
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/t7.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#ifndef __T7_H__
+#define __T7_H__
+
+#include <linux/bitops.h>
+
+#define T7_WDT_CTRL		0xfe002100
+#define T7_WDT_CTRL_EN		BIT(18)
+
+/*
+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
+ * and BL32 runtime zones (also described as reserved-memory in the
+ * upstream devicetree) and further firmware-protected pages, and is
+ * left unmapped in the T7 memory map. Reserve the whole span so nothing
+ * (EFI allocations, boot-time relocations) is ever placed in memory
+ * U-Boot cannot access.
+ */
+#define T7_SECMON_RSVMEM_START	0x05000000UL
+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
+
+#endif /* __T7_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..1a8bab8391f 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,14 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_T7
+	bool "T7"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply OF_UPSTREAM
+	help
+	  Select this if your SoC is an A311D2
+
 endchoice
 
 config SYS_SOC
@@ -91,6 +99,7 @@ config SYS_BOARD
 	default "q200" if MESON_GXM
 	default "s400" if MESON_AXG
 	default "u200" if MESON_G12A
+	default "vim4" if MESON_T7
 	default ""
 	help
 	  This option contains information about board name.
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 08a24d4b24f..dc2bc0ceecb 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -17,3 +17,4 @@ endif
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
+obj-$(CONFIG_MESON_T7) += board-t7.o
diff --git a/arch/arm/mach-meson/board-t7.c b/arch/arm/mach-meson/board-t7.c
new file mode 100644
index 00000000000..c2725a4304f
--- /dev/null
+++ b/arch/arm/mach-meson/board-t7.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/mem.h>
+#include <asm/arch/t7.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/*
+	 * The secure firmware boots BL33 with the watchdog running,
+	 * disable it.
+	 */
+	writel(readl(T7_WDT_CTRL) & ~T7_WDT_CTRL_EN, T7_WDT_CTRL);
+
+	return 0;
+}
+
+void meson_init_reserved_memory(void *fdt)
+{
+	meson_board_add_reserved_memory(fdt, T7_SECMON_RSVMEM_START,
+					T7_SECMON_RSVMEM_SIZE);
+}
+
+int meson_get_boot_device(void)
+{
+	return -ENOSYS;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	/*
+	 * The top 8 MiB of the first DRAM bank contain pages the secure
+	 * world protects at runtime, keep U-Boot below them.
+	 */
+	return min(gd->ram_size, (phys_size_t)0xdf800000);
+}
+
+static struct mm_region t7_mem_map[] = {
+	{
+		/* DRAM below the secure monitor reserved zone */
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x05100000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/*
+		 * DRAM between the secure monitor reserved zone and the
+		 * end of the first bank. 0x05100000 - 0x09000000 is
+		 * protected by the secure world and must not be mapped.
+		 */
+		.virt = 0x09000000UL,
+		.phys = 0x09000000UL,
+		.size = 0xd7000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Peripherals, GIC, ... */
+		.virt = 0xe0000000UL,
+		.phys = 0xe0000000UL,
+		.size = 0x20000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = t7_mem_map;
-- 
2.55.0


