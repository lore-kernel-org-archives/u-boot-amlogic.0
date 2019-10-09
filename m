Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.5221.1570629845960344796
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2019 07:04:06 -0700
Received: by mail-wm1-f67.google.com with SMTP id 5so2783104wmg.0
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2019 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2wZQNMasDv6oE0wzr37QP4NvbwnLC1sLck3J3jcfp8=;
        b=2KsLIyU7d63bF9Sg+KN52k1Lm3+CrpndSHGCdZIue0baCxRZSXx5sf3MYV36J3cgdy
         dUYD7jMB7Jg9+4j5CYNcz0BMb0bvu3F2FExPQWe68qN9ut/HME0Huwic5a71bqlS4VFD
         Et7Si8nVCoBlyMggNe+oJt3LvUCPs7PSt+mofASV1c7vC8vqegyfNnriX+WPT/RBTDkf
         gJ/SNaw3+Qf53OhZQrZtpNCAtHr3NjxbymCNa2dAYKTCMfttlvCmjZvIg6tZbZ89l7U7
         V8UB+R44uhvTQzrG/TnZsrpldgX4sLqU8sQ8oYQ0oc3PeUqmu1DdurpVwAGzVi07Grxn
         75LA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 3/4] arm: meson: Tidy SoC information output
Date: Wed,  9 Oct 2019 16:03:56 +0200
Message-Id: <20191009140357.27279-4-narmstrong@baylibre.com>
In-Reply-To: <20191009140357.27279-1-narmstrong@baylibre.com>
References: <20191009140357.27279-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: afaerber@suse.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Andreas Färber <afaerber@suse.de>

Write SoC instead of Soc. The Linux driver is not affected.

Fixes: f41d723b9f ("ARM: meson: display Amlogic SoC Information")
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index ba248e8ff6..ea32c01d11 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -154,7 +154,7 @@ int show_board_info(void)
 
 	/* print board information */
 	print_board_model();
-	printf("Soc:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
+	printf("SoC:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
 	       socinfo_to_soc_id(socinfo),
 	       socinfo_to_package_id(socinfo),
 	       socinfo_to_major(socinfo),
-- 
2.22.0

