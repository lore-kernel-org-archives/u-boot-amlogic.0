Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web11.19908.1577360047165444990
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 03:34:07 -0800
Received: by mail-pf1-f193.google.com with SMTP id i6so6233657pfc.1
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 03:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3fsGGUAmxsj0HlXreXOggtnyKWGs1G0VtBFDnwGlqHM=;
        b=DR9ASmAEBluXR23SMwYZ2bKtUYcPf6TnkX9XuWA6tSih17AZhkOd/1M722dlqgUvFr
         2Kb+/XPLr/ugZBszwgOlaPSsdQPtmy681ISFM5gunsyM6AckjqbwEthr9y3gx8Vh7GC6
         5scWaErg2iFEvplZtgtq3QminchQLzkfumXIqc3aeNftf6shhf6Zr0MsmGiPx15Xxki/
         xzJ05BW3VhDpO9qMPmlXBbADjAP1yNRctrllyC8QUIyuEXn0wjRY7Sf9Rd9GXTpccsHZ
         sHwZ16or0SpSgU8dmgg94I3YFl9NaDzmAXB4UDZjw9i3JXkuHWy/jQGRFToPELd4/Wuz
         94og==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 2/3] configs: meson64: enable GIC support for G12A/G12B
Date: Thu, 26 Dec 2019 11:33:52 +0000
Message-Id: <20191226113353.1757-3-linux.amoon@gmail.com>
In-Reply-To: <20191226113353.1757-1-linux.amoon@gmail.com>
References: <20191226113353.1757-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Enable GIC support for G12A/G12B platform.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

