Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F3C5AD7B
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 08:11:19 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16172.1786011888936128750
 for <u-boot-amlogic@groups.io>;
 Thu, 06 Aug 2026 03:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: tanurelinux@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so268827566b.3
        for <u-boot-amlogic@groups.io>; Thu, 06 Aug 2026 03:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011887; x=1786616687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yeC6Hqt5s4JnHR3bsVVzmr7CkvTOTeNRKCd3sW6T7gA=;
        b=C1nDVrk+rXNSREUskzt4hpPXxbehiP1ooH7VBd9K0BIVkTG/U9UuBlHfbpI95DelSn
         NAmZkK7A3+QbQlmQ8w3QlVy2GtHtnkCFRQ/lv8BAIol/l1EhkPkjnctA5JqnnkcP6x0R
         YM5GGYHBr2LkLjUs4gcQP+h7wxtofIg+Gw6tlENv+BEJ8mdHbFd7+eon/IOnQsQATbaQ
         i8YXBTBzt1Zle3hmoXUAUPbyfEQ349c+bP4PTJrgtDJCoRcME/EGJCwNTQHvGFLQU5v+
         r9qPvHrGA0xDBZNVR5HRkMFVz0BAdoTTi1LndLg58DEy+ZlUyJ68zEaxZrsZUy8iKt7b
         Wgnw==
X-Forwarded-Encrypted: i=1; AHgh+Roy29G0nIGeVg2jBJPXtkjrpwwEXZUXlDr6LkVByd7RwEgDl+y3Jbi68hsgDh/EAT/etCDFbOgInuiSi7ftQQ==@groups.io
X-Gm-Message-State: AOJu0YyVX+xmn3FE3JTIxeoxVJ5calmkfOYB4bbD80Uv0cCfaFvKQsi7
	6ZGzlmDkjiA2fnJBlhDZpP4e85Bvgj3zPRL2/NRh2zv/vI2mDeVoPsf6x54YYg==
X-Gm-Gg: AR+sD13GVN5nInnzlIIldexr5DBWdTfUquFtRn9X3m7zCRE7jYBvGr0iABiHY5H3DH3
	NHH9QmUEbJipfTYA7JQN14OsYIPH+dtVfvAASyG9tLzIerJH8R4JZoW4WKLPfacQ8hjJQAv1DwO
	b/62E6UtJwW3qjtmphD1lO2udGQDle2sAWKZjBz8kRCHgdaEe7AtN1F5GfzBvX9TTfS0OeJzM63
	QExLxldmFYv71BjGvwg7zSp8pY8XxqxwN5in0Lq6AsWU56zZ89YF4/SQZdKquMCgiH0TEtTwMsV
	PQE9I6blbmlvNsKMj/v4APiFkdQaoOQ1s1JZJ1fUpZqZ2+KKtHI1sUfjl7srt3FW/T9YSmKKeIV
	0vXHk7bLaeEV9FxdYxn3EXh/IdPTPkAa0OPVaRqEow6igpVf3jpDxsYlJugBdWjB7iMKHoAf9T+
	EdAHVzfRfVskkHjPk1XooquAP6pli9V+ipkCK2K+cZ15r/MW32vjnxepnznSHFGAz/Uu8MW06Cv
	PPtb5YO0WYpC2aHFfeGDyWYXo1KkyKt2Vm9aQ==
X-Received: by 2002:a05:600c:12c8:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4994e7baae6mr121733175e9.10.1786011494559;
        Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io,
	Lucas Tanure <tanure@linux.com>
Subject: [PATCH 2/4] arm: meson: add Amlogic T7 SoC family support
Date: Thu,  6 Aug 2026 11:18:07 +0100
Message-ID: <20260806101809.72526-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 08:11:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3015

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
 arch/arm/include/asm/arch-meson/boot0.h | 18 +++++
 arch/arm/mach-meson/Kconfig             | 10 +++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-t7.c          | 97 +++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
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
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index c687ef822a2..40aafc0b922 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -67,6 +67,15 @@ config MESON_A1
 	help
 	  Select this if your SoC is an A113L
 
+config MESON_T7
+	bool "T7"
+	select MESON64_COMMON
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply OF_UPSTREAM
+	help
+	  Select this if your SoC is from the Amlogic T7 family, like
+	  the A311D2 found on the Khadas VIM4 board.
+
 endchoice
 
 config SYS_SOC
@@ -91,6 +100,7 @@ config SYS_BOARD
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
index 00000000000..a6ccec25c0e
--- /dev/null
+++ b/arch/arm/mach-meson/board-t7.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/boot.h>
+#include <asm/arch/mem.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define T7_WDT_CTRL		0xfe002100
+#define T7_WDT_CTRL_EN		BIT(18)
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
+/*
+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
+ * and BL32 runtime zones (also described as reserved-memory in the
+ * upstream devicetree) and further firmware-protected pages, and is
+ * left unmapped in t7_mem_map below. Reserve the whole span so nothing
+ * (EFI allocations, boot-time relocations) is ever placed in memory
+ * U-Boot cannot access.
+ */
+#define T7_SECMON_RSVMEM_START	0x05000000UL
+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
+
+void meson_init_reserved_memory(__maybe_unused void *fdt)
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


