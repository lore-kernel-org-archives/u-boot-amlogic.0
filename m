Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.26160.1683291416713099177
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=0V6TvQe8eyL3ff13NZG+eB+UzFzivQIKMU2f74ME1Aw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZxfDJ6jGLRc2UOjA5EdylOkJYieDUzWbEAA/zWVs1Ni8ZoFomy7nUQgWtoLmBS44p
	 noGtaHGfRuXaLhtiO7K04hdoQ5KDYolDONXUXaXUXfgr+zXC0wHuYZDEVVDJ5clDge
	 sslfdi5Mga0+XUcR1onXAFiAY31/KhJmBoZHdt6rYVZC/G2WzQ8bnOrBu5hFuynzh9
	 oHsyN+hsm5UOquSicWOCbpxpgdyHSfIu7YSbyCTa05s8zw/PqlyuMwjOxIGKCmJX7s
	 YbFCDZHezIFfo4NMMwTPFwIcSuURRy1rrd8oDV4j/aQIHMq/6jtFhnsHN2hWp0D4AG
	 GUPtSdluy8DgQ==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 3/5] ARM: meson: add A1 support
Date: Fri, 5 May 2023 15:56:37 +0300
Message-ID: <20230505125639.3605-4-ivprusov@sberdevices.ru>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, Evgeny Bachinin <eabachinin@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add support for Amlogic A1 SoC family.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Signed-off-by: Evgeny Bachinin <eabachinin@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/a1.h | 20 ++++++++++
 arch/arm/mach-meson/Kconfig          |  6 +++
 arch/arm/mach-meson/Makefile         |  1 +
 arch/arm/mach-meson/board-a1.c       | 59 ++++++++++++++++++++++++++++
 include/configs/meson64.h            |  3 ++
 5 files changed, 89 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/a1.h
 create mode 100644 arch/arm/mach-meson/board-a1.c

diff --git a/arch/arm/include/asm/arch-meson/a1.h b/arch/arm/include/asm/ar=
ch-meson/a1.h
new file mode 100644
index 0000000000..86d1a68de8
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/a1.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@sberdevices.ru>
+ */
+
+#ifndef __MESON_A1_H__
+#define __MESON_A1_H__
+
+#define A1_SYSCTRL_BASE			0xfe005800
+
+/* SYSCTRL registers */
+#define A1_SYSCTRL_ADDR(off)		(A1_SYSCTRL_BASE + ((off) << 2))
+
+#define A1_SYSCTRL_SEC_STATUS_REG4	A1_SYSCTRL_ADDR(0xc4)
+
+#define A1_SYSCTRL_MEM_SIZE_MASK	0xFFFF0000
+#define A1_SYSCTRL_MEM_SIZE_SHIFT	16
+
+#endif /* __MESON_A1_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 6cba2c40dd..519ed563c0 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -51,6 +51,12 @@ config MESON_G12A
 	help
 	  Select this if your SoC is an S905X/D2
=20
+config MESON_A1
+	bool "A1"
+	select MESON64_COMMON
+	help
+	  Select this if your SoC is an A113L
+
 endchoice
=20
 config SYS_SOC
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index a9e4046f80..535b0878b9 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -6,3 +6,4 @@ obj-y +=3D board-common.o sm.o board-info.o
 obj-$(CONFIG_MESON_GX) +=3D board-gx.o
 obj-$(CONFIG_MESON_AXG) +=3D board-axg.o
 obj-$(CONFIG_MESON_G12A) +=3D board-g12a.o
+obj-$(CONFIG_MESON_A1) +=3D board-a1.o
diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.=
c
new file mode 100644
index 0000000000..967bb67182
--- /dev/null
+++ b/arch/arm/mach-meson/board-a1.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ */
+
+#include <common.h>
+#include <asm/arch/a1.h>
+#include <asm/arch/boot.h>
+#include <asm/armv8/mmu.h>
+#include <asm/io.h>
+#include <linux/compiler.h>
+#include <linux/sizes.h>
+
+phys_size_t get_effective_memsize(void)
+{
+	return ((readl(A1_SYSCTRL_SEC_STATUS_REG4) & A1_SYSCTRL_MEM_SIZE_MASK)
+		>> A1_SYSCTRL_MEM_SIZE_SHIFT) * SZ_1M;
+}
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
+static struct mm_region a1_mem_map[] =3D {
+	{
+		.virt =3D 0x00000000UL,
+		.phys =3D 0x00000000UL,
+		.size =3D 0x80000000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt =3D 0x80000000UL,
+		.phys =3D 0x80000000UL,
+		.size =3D 0x7FE00000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			PTE_BLOCK_NON_SHARE |
+			PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/*
+		 * This mem region contains in/out shared memory with bl31,
+		 * hence it's marked as NORMAL memory type
+		 */
+		.virt =3D 0xFFE00000UL,
+		.phys =3D 0xFFE00000UL,
+		.size =3D 0x00200000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map =3D a1_mem_map;
diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 9244601284..801cdae470 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -11,6 +11,9 @@
 #if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
 #define GICD_BASE			0xffc01000
 #define GICC_BASE			0xffc02000
+#elif defined(CONFIG_MESON_A1)
+#define GICD_BASE			0xff901000
+#define GICC_BASE			0xff902000
 #else /* MESON GXL and GXBB */
 #define GICD_BASE			0xc4301000
 #define GICC_BASE			0xc4302000
--=20
2.34.1

