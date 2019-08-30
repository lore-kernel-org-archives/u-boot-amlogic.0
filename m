Received: by mail-wr1-f65.google.com with SMTP id y8so6708633wrn.10
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XT2UTkZX5X67YKJlauy4mlmVtcw6Sry0jvAu+4RL1GY=;
        b=nyWvUWhT3hATRSaKTvRCmEO1HVnUgaC6o9/oAOAfxKNPOZDt62mBORjdiKAWAAYwvA
         e8VoakRl135gMZYvOKwJXvemxJtY7a9hn9F1WYFbXVAS8zyQKedLEsOXLIK4bfUd/4kp
         dpBIkF0CbfnIRv3Qb2YxKWIzOCsgxHwmS+P6JuC/YowFLihch79beyjQ2bkm3fyiuks+
         V03sZLTlj0o5+IbSKf7h1MwedD63PfMtOLnI3htKqno09u+5r5LCGrgvHyTUSh7ZxIg8
         lG/RwVKkkhn7hFQDGVruUupMlJcVL+P/Ma+p2bVPa6kiXkDCVOfCUeosPpvGlLw/wvce
         XyHg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 6/8] arm: meson: board-g12a: Setup VPU in fdt
Date: Fri, 30 Aug 2019 14:09:26 +0200
Message-Id: <20190830120928.23890-7-narmstrong@baylibre.com>
In-Reply-To: <20190830120928.23890-1-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

If VIDEO_MESON is enabled, we need to setup the fdt for the framebuffer.

Call meson_vpu_rsv_fb() which reserves the framebuffer memory region for
EFI, and sets up simple-framebuffer nodes if simplefb support is
enabled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index 546b9f6039..24786df6cd 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -9,6 +9,7 @@
 #include <asm/arch/eth.h>
 #include <asm/arch/g12a.h>
 #include <asm/arch/mem.h>
+#include <asm/arch/meson-vpu.h>
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
@@ -57,6 +58,10 @@ void meson_init_reserved_memory(void *fdt)
 	/* Add BL32 reserved zone */
 	if (bl32_start && bl32_size)
 		meson_board_add_reserved_memory(fdt, bl32_start, bl32_size);
+
+#if defined(CONFIG_VIDEO_MESON)
+	meson_vpu_rsv_fb(fdt);
+#endif
 }
 
 phys_size_t get_effective_memsize(void)
-- 
2.22.0

