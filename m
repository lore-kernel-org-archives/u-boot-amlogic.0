Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web12.2720.1577193966009271126
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Dec 2019 05:26:06 -0800
Received: by mail-pl1-f196.google.com with SMTP id b22so8468034pls.12
        for <u-boot-amlogic@groups.io>; Tue, 24 Dec 2019 05:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uHtuLMfxLcSL4dajNP+ASHQKshVZLIwES/YCcUNozQo=;
        b=aDFwuBZujncgwufi4KRkwLiOl9agMCzkZKgXWcSV6OLOSWUbFRwPECtjg+chcfxZwB
         Sgu6wsE/LYCHLqZUIXDDFAwwUcxfI882AyEv7YiWXea9CI6FpZ8XHUdpVCqQ+ihsPf4a
         HW8ImFobmT7NwAEqaUPCIqWe60LbUUDzh9A+avhiHBmB/LPuevVOOMmaYntvkT5mpvdB
         nahKD+UJ0P1UI6fakaXbvfJbSV8smmr1EfQi6FY/psPsxSMfH6hCJzmxvsNDpL8C9V8f
         CuTaF6CyTN75JkQMU84bUng8g4fqgP1qpKYIQcc2j+swUAOsLSzhhYCZmuQX2qalvoTo
         H0/w==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [U-Boot] [PATCHv2 2/3] configs: meson64: enable GIC support for G12A/G12B
Date: Tue, 24 Dec 2019 13:25:50 +0000
Message-Id: <20191224132551.1427-3-linux.amoon@gmail.com>
In-Reply-To: <20191224132551.1427-1-linux.amoon@gmail.com>
References: <20191224132551.1427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Enable GIC support for G12A/G12B platform.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
no changes
---
 include/configs/meson64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 736081277d..50707a3197 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -8,7 +8,7 @@
 #define __MESON64_CONFIG_H
 
 /* Generic Interrupt Controller Definitions */
-#if defined(CONFIG_MESON_AXG)
+#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
 #define GICD_BASE			0xffc01000
 #define GICC_BASE			0xffc02000
 #else /* MESON GXL and GXBB */
-- 
2.24.1

