Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0711C61CE3
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:34 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64.1786986989621407217
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=HEt0rR2/;
 spf=pass (domain: brivo.com, ip: 209.85.222.182, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e512a9a6bso164643085a.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986988; x=1787591788; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dU4nGrOCs5k9OFxI21N/JRkk8KfChc5jPzMDlD8OPaA=;
        b=HEt0rR2/WuxKnQ0OJMzz41rU7pPdl87JMBV76yKWPVzWCQjkx635zz6w4F5lmIh0WR
         FatUJtW2+Gb8s85PcGflZQZ3QFyPFgZofW6XJ1t/ano0mcuoKDodIRMlKt48YPfEcU4e
         5J37272uEW8kWt1dJ+54XsqK/SEzMcYhHdTZrXNvDDIOQOnNqRGfQmXbq9UGYTGcGmdp
         8KVFF9rrjqeP1WkE8IrD8z49ebX58nSQC1/G21LlnJ1t3Jyx2JM9RymxtSSmeL+bdjn6
         GRci88t0E7MjEvlCL8bDFkPqS2Y8ixvzI7aw2Dx4feW5DEYMMpo7ZEvoKOzwuNHLmcG7
         PMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986988; x=1787591788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dU4nGrOCs5k9OFxI21N/JRkk8KfChc5jPzMDlD8OPaA=;
        b=qFzpBeKNLxvO58t036yMFsH/VhLb9MVmDa4DcKF9yRFGEvYkShRf54p+2ckvGsOJCo
         GqAvzdopt4XnmOr4ZVyVM2WlvaNJoFCzYesSi0w/8qdZMAxUtcOUqmoH0N1D+xnWc4Ix
         I8B5GeR2+mJxACM85S4gKSj8jIHRbTKV6Wu9N4O1E5QtO+FypFFMhIQtw9RlDOYi+q9V
         1fyKpiznATzx9SUeX+rpAYDAjlKTCS3KhBPxXTOgBQl3YfXeL9pbT7yz36izlAXad1gc
         Hu5lxY+jklToXuZOdwPd1FwoOUoH53GuRj2bpcqI/Z+JrIb0hftAtbBRNh4fRbopbmRd
         35fw==
X-Gm-Message-State: AOJu0YwhWu/C+k4OzN6oW/7IxKb1ACqs9g0xa39/qQjD3xrc3ecG09db
	aLx71vs5RwOibxCcK0f3qEs/SBg6jWuC1png08Atny/wMr63BhvFa0xlXU9ZfqfBuqffacYwjQ5
	LTeOZ+v9EgZLJwLOQYZE3jLQKF+x+W+62Rkn//x3l+tZXAAncV5WdBQ==
X-Gm-Gg: AR+sD11SisxN9fVtDymPPZ7GxcPMaRQy9MGkbmHq/HiQSeC1k3qrMw1Qoap6WdVhUgY
	BqmuGUdh7ALMhUL9FSWEYmS6dqziIgTH0927r7kXSU7GAzjLu11ZaEAIilG0NW/NT/oL4JQ7oJu
	kFF8HKacEsZQeTAvb2CvQNu1U3fYVmhTqmIxdViV/uVn3hHTieefSuw5oOeJeldozj4X909sqp4
	6rSPh7JeT9ncarOG+IePwdXXuxTiRRH4GwPOkZ4B08o2ya1+ZZY7CzKDnsGl0syGI24d5ZcZ4/m
	VpGKwB+l3hrmg7e4DwGK2kmdrrxgdrO7wLvfbViP/24nXyVz0TAl6WqbZgYielVVAPwuHzSUevK
	/LT47Gp50enznoHRxz4qIE7nHwxyDmNwYqeRdGJTDbph6pFTsg7JEiVEAP1+718M29PG5FuX/+u
	GkCYXvwcbumLsdrKCjAt+OCYTcRiCuob5sRYj5CSGB369+hUisEAUYRCxwmdC6cMjZeeqtpkVu3
	TMoszBgbRXQkmzbcUGi/9o1LEmuBuU6DZ1lMqU=
X-Received: by 2002:a05:620a:800f:b0:936:41fe:2350 with SMTP id af79cd13be357-93704b1a810mr288061685a.4.1786986986613;
        Mon, 17 Aug 2026 10:16:26 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/9] arm64: meson: Add s4 SoC support
Date: Mon, 17 Aug 2026 13:15:12 -0400
Message-ID: <20260817171623.1943847-2-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3031

Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
similar to other recent SoCs, with the exception of a workaround for
some BL2 (mis)behavior.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
 arch/arm/mach-meson/Kconfig             |  7 ++++
 arch/arm/mach-meson/Makefile            |  1 +
 arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c

diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
new file mode 100644
index 00000000000..7338171be15
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/boot0.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Brivo Systems LLC
+ */
+b reset
+#if IS_ENABLED(CONFIG_MESON_S4)
+/*
+ * BL2 copies some keys to the start of DRAM, clobbering anything in the first
+ * 2k aside from the initial instruction. I measured the actual data clobbered
+ * as 1076 bytes, but I suspect the amount depends on the configuration, so
+ * just go with what amlogic does.
+ */
+.skip 2048
+#endif
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
-- 
2.53.0


