Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C0C5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:27:31 +0000 (UTC)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31208.1786372046082535384
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Aug 2026 07:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=p92thx0Q;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.179, mailfrom: funderscore@postmarketos.org)
Date: Mon, 10 Aug 2026 14:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1786372043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFWTKgsm4x09LrbEwfGnP4C7RtLN8NQkCXPO2SR6WYQ=;
	b=p92thx0Q5eC3M/l75lS5oH0LjH+1RmSEFytF/bIhZIUBeUBA9ImD4+9XsV77SQFUTAXKPK
	TJeQktyOWmLp8d7KKA0ySp0BWahSJ9gZG3OKEf9eaniJbuGH3kCRacVXVL7wZ8pB7QoDQt
	tgplYg0m3R1xEvcGmHgBzsKxhthWzFhT/8t6JZmMPI3tj6Ls455krZzYvITxfCHxcpwmT3
	gnJAdv6n84bVEiRMs6YJyG3Pc7zzPfXcIY08SUA4MxV/zMaZBahLIeuujQMliSS//ViZSw
	JWZ6lo3zF3MsXD2tKQeZBbBrjdWq87Q8leUWD7D4gbKfObniq9kGWZ9bx2pkUQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org, funderscore@postmasteros.org, u-boot-amlogic@groups.io, Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 2/4] arm: meson: add Amlogic T7 SoC family support
References: <20260806101809.72526-1-tanure@linux.com> <20260806101809.72526-3-tanure@linux.com>
In-Reply-To: <20260806101809.72526-3-tanure@linux.com>
Message-ID: <tjk5gh.17yic8cda9vwm@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 14:27:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3022

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=3Dlinux.c=
om@groups.io> wrote:
>Add initial support for the Amlogic T7 family (A311D2). U-Boot runs
>as BL33, loaded at address 0x0 and entered from the vendor BL31 at
>EL2, either uncompressed or LZ4-compressed inside the boot image (the
>BL31 decompresses it).
>
>The secure firmware writes the SCS device keys into the first page of
>the loaded BL33 image (2 KiB for the BL33 key followed by 2 KiB for
>the kernel key). Reserve that page with a boot0 hook, as the vendor
>U-Boot does, so the keys do not overwrite U-Boot's entry code.
>
>The firmware also enters BL33 with the non-secure watchdog running:
>disable it in board_init(), otherwise the board is reset about a
>minute after boot.
>
>The memory map leaves 0x05100000 - 0x09000000 unmapped: the secure
>world owns this span (the BL31 and BL32 runtime zones described in
>the upstream devicetree, plus further firmware-protected pages), and
>this matches the vendor bootloader's own map. The whole span is also
>added to the devicetree and EFI reserved memory at boot time so no
>allocation is placed in memory U-Boot cannot access.
>
>get_effective_memsize() is capped at 0xdf800000 because the top 8 MiB
>of the first DRAM bank contain pages the secure world protects at
>runtime; U-Boot and its heap must stay below them.
>
>Assisted-by: Claude:claude-fable-5

Same as on the first patch.

>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> arch/arm/include/asm/arch-meson/boot0.h | 18 +++++
> arch/arm/mach-meson/Kconfig             | 10 +++
> arch/arm/mach-meson/Makefile            |  1 +
> arch/arm/mach-meson/board-t7.c          | 97 +++++++++++++++++++++++++
> 4 files changed, 126 insertions(+)
> create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
> create mode 100644 arch/arm/mach-meson/board-t7.c
>
>diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/=
asm/arch-meson/boot0.h
>new file mode 100644
>index 00000000000..3ec085ccd64
>--- /dev/null
>+++ b/arch/arm/include/asm/arch-meson/boot0.h
>@@ -0,0 +1,18 @@
>+/* SPDX-License-Identifier: GPL-2.0+ */
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#ifndef __MESON_BOOT0_H
>+#define __MESON_BOOT0_H
>+
>+/*
>+ * The T7-family secure firmware writes the SCS device keys into the
>+ * first page of the loaded BL33 image (2048 bytes for the BL33 key
>+ * followed by 2048 bytes for the kernel key). Keep that page reserved
>+ * so the keys do not overwrite U-Boot's entry code.
>+ */
>+	b	reset
>+	.space	4096
>+
>+#endif /* __MESON_BOOT0_H */
>diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
>index c687ef822a2..40aafc0b922 100644
>--- a/arch/arm/mach-meson/Kconfig
>+++ b/arch/arm/mach-meson/Kconfig
>@@ -67,6 +67,15 @@ config MESON_A1
> 	help
> 	  Select this if your SoC is an A113L
>=20
>+config MESON_T7
>+	bool "T7"
>+	select MESON64_COMMON
>+	select ENABLE_ARM_SOC_BOOT0_HOOK
>+	imply OF_UPSTREAM
>+	help
>+	  Select this if your SoC is from the Amlogic T7 family, like
>+	  the A311D2 found on the Khadas VIM4 board.
>+

I would shorten this to:

	help
	  Select this if your SoC is an A311D2

to match other SoCs' help message.

> endchoice
>=20
> config SYS_SOC
>@@ -91,6 +100,7 @@ config SYS_BOARD
> 	default "q200" if MESON_GXM
> 	default "s400" if MESON_AXG
> 	default "u200" if MESON_G12A
>+	default "vim4" if MESON_T7
> 	default ""
> 	help
> 	  This option contains information about board name.
>diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
>index 08a24d4b24f..dc2bc0ceecb 100644
>--- a/arch/arm/mach-meson/Makefile
>+++ b/arch/arm/mach-meson/Makefile
>@@ -17,3 +17,4 @@ endif
> obj-$(CONFIG_MESON_AXG) +=3D board-axg.o
> obj-$(CONFIG_MESON_G12A) +=3D board-g12a.o
> obj-$(CONFIG_MESON_A1) +=3D board-a1.o
>+obj-$(CONFIG_MESON_T7) +=3D board-t7.o
>diff --git a/arch/arm/mach-meson/board-t7.c b/arch/arm/mach-meson/board-=
t7.c
>new file mode 100644
>index 00000000000..a6ccec25c0e
>--- /dev/null
>+++ b/arch/arm/mach-meson/board-t7.c
>@@ -0,0 +1,97 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#include <init.h>
>+#include <asm/arch/boot.h>
>+#include <asm/arch/mem.h>
>+#include <asm/armv8/mmu.h>
>+#include <asm/global_data.h>
>+#include <asm/io.h>
>+#include <linux/bitops.h>
>+#include <linux/compiler.h>
>+#include <linux/errno.h>
>+#include <linux/kernel.h>
>+
>+DECLARE_GLOBAL_DATA_PTR;
>+
>+#define T7_WDT_CTRL		0xfe002100
>+#define T7_WDT_CTRL_EN		BIT(18)
>+

These should probably go in a header file? E.g. asm/arch/t7.h?

>+int board_init(void)
>+{
>+	/*
>+	 * The secure firmware boots BL33 with the watchdog running,
>+	 * disable it.
>+	 */
>+	writel(readl(T7_WDT_CTRL) & ~T7_WDT_CTRL_EN, T7_WDT_CTRL);

In the future it might make sense to write a proper watchdog driver.
Though I'm also guilty for doing it this way in U-Boot SPL gxbb/gxl (I
think eventually I'll remove this handling there and have U-Boot
proper manage the watchdog).

Then you can drop this board_init() function entirely. With that said
I won't feel bad if you keep it that way for now.

>+
>+	return 0;
>+}
>+
>+/*
>+ * The secure world owns 0x05000000 - 0x09000000: it contains the BL31
>+ * and BL32 runtime zones (also described as reserved-memory in the
>+ * upstream devicetree) and further firmware-protected pages, and is
>+ * left unmapped in t7_mem_map below. Reserve the whole span so nothing
>+ * (EFI allocations, boot-time relocations) is ever placed in memory
>+ * U-Boot cannot access.
>+ */
>+#define T7_SECMON_RSVMEM_START	0x05000000UL
>+#define T7_SECMON_RSVMEM_SIZE	0x04000000UL
>+

This too, should probably go in a header file.

>+void meson_init_reserved_memory(__maybe_unused void *fdt)
>+{

Why __maybe_unused ?

>+	meson_board_add_reserved_memory(fdt, T7_SECMON_RSVMEM_START,
>+					T7_SECMON_RSVMEM_SIZE);
>+}
>+
>+int meson_get_boot_device(void)
>+{
>+	return -ENOSYS;
>+}
>+
>+phys_size_t get_effective_memsize(void)
>+{
>+	/*
>+	 * The top 8 MiB of the first DRAM bank contain pages the secure
>+	 * world protects at runtime, keep U-Boot below them.
>+	 */
>+	return min(gd->ram_size, (phys_size_t)0xdf800000);
>+}
>+
>+static struct mm_region t7_mem_map[] =3D {
>+	{
>+		/* DRAM below the secure monitor reserved zone */
>+		.virt =3D 0x00000000UL,
>+		.phys =3D 0x00000000UL,
>+		.size =3D 0x05100000UL,
>+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>+			 PTE_BLOCK_INNER_SHARE
>+	}, {
>+		/*
>+		 * DRAM between the secure monitor reserved zone and the
>+		 * end of the first bank. 0x05100000 - 0x09000000 is
>+		 * protected by the secure world and must not be mapped.
>+		 */
>+		.virt =3D 0x09000000UL,
>+		.phys =3D 0x09000000UL,
>+		.size =3D 0xd7000000UL,
>+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>+			 PTE_BLOCK_INNER_SHARE
>+	}, {
>+		/* Peripherals, GIC, ... */
>+		.virt =3D 0xe0000000UL,
>+		.phys =3D 0xe0000000UL,
>+		.size =3D 0x20000000UL,
>+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>+			 PTE_BLOCK_NON_SHARE |
>+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>+	}, {
>+		/* List terminator */
>+		0,
>+	}
>+};
>+
>+struct mm_region *mem_map =3D t7_mem_map;
>--=20
>2.55.0
>
>
>
>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>Groups.io Links: You receive all messages sent to this group.
>View/Reply Online (#3015): https://groups.io/g/u-boot-amlogic/message/30=
15
>Mute This Topic: https://groups.io/mt/120681747/8399868
>Group Owner: u-boot-amlogic+owner@groups.io
>Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postm=
arketos.org]
>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
Best regards,
Ferass

