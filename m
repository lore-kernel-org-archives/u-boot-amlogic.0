Received: by mail-wm1-f65.google.com with SMTP id s3so5872759wms.2
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2019 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yFMPg819m2A+XZPMJKaPb/Xbwb3R5TF4CYbOeVtgWY=;
        b=jLAFGBAwg5VBDU9zmDMrdh9tU2xb/QU/S7/nCi6hJ5kVHq8rs54Lh9uQBmQqx6YaTP
         jS9bjddWlcCJ4uJdwj9J6LIkMQu+Tzms96LLE50VpLGHvXPoDF0mlmLYxr2n6sjl+sOt
         fRVxA+Rc8tqk9ADZn7PQ4LyyjppRzWDvy1pOPsj1woT8FirpW6DWluaqzQPWqCyTMMmm
         J7Al3ZIXOmVMKh3Pm4vf2Yuoy4e4uPL88MwnvYrO7DYH6+yz5mMr7Ne5zddRmbRw3vtW
         XokL+HxUYCYMWktQLqeWwO92QT+qM2xiZr4tUiPlzPEYBMQbtl4c3Xxz/aswoCg57chZ
         8UJw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/3] ARM: meson: sm: Add secure monitor calls to retrieve SoC serial number
Date: Wed, 12 Jun 2019 11:49:06 +0200
Message-Id: <20190612094908.24858-2-narmstrong@baylibre.com>
In-Reply-To: <20190612094908.24858-1-narmstrong@baylibre.com>
References: <20190612094908.24858-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Secure Monitor interface permits retrieving the SoC Serial Number,
add a function to retrieve it.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/sm.h |  1 +
 arch/arm/mach-meson/sm.c             | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
index 83d6441803..a5bac5abda 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -7,5 +7,6 @@
 #define __MESON_SM_H__
 
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
+int meson_sm_get_serial(void *buffer, size_t size);
 
 #endif /* __MESON_SM_H__ */
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index a07b46895d..05b7f0bdf2 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -6,12 +6,14 @@
  */
 
 #include <common.h>
+#include <asm/arch/sm.h>
 #include <linux/kernel.h>
 
 #define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
 #define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
 #define FN_EFUSE_READ			0x82000030
 #define FN_EFUSE_WRITE			0x82000031
+#define FN_CHIP_ID			0x82000044
 
 static void *shmem_input;
 static void *shmem_output;
@@ -53,3 +55,25 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size)
 
 	return regs.regs[0];
 }
+
+#define SM_CHIP_ID_LENGTH	119
+#define SM_CHIP_ID_OFFSET	4
+#define SM_CHIP_ID_SIZE		12
+
+int meson_sm_get_serial(void *buffer, size_t size)
+{
+	struct pt_regs regs;
+
+	meson_init_shmem();
+
+	regs.regs[0] = FN_CHIP_ID;
+	regs.regs[1] = 0;
+	regs.regs[2] = 0;
+
+	smc_call(&regs);
+
+	memcpy(buffer, shmem_output + SM_CHIP_ID_OFFSET,
+	       min_t(size_t, size, SM_CHIP_ID_SIZE));
+
+	return 0;
+}
-- 
2.21.0

