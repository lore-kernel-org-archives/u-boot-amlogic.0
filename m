Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.5327.1570629846596660588
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2019 07:04:07 -0700
Received: by mail-wm1-f68.google.com with SMTP id 7so2776994wme.1
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2019 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJxlGXMNI9WHs701zJGunoPuSLZc8ZTjyMlVAYx66Lk=;
        b=zP3BGPs2Vw495288Ij26s5hTA9wQaGZOsHerDIgYyC/fD+vR2x2SXDC5NC2dfioajP
         tsBHCH5WMK38KLvZrrm6xkbf5QGy+IoLAKWhPuJ4iWtj0iNz7921cNesyjndlhsBvOXT
         yylaxYZ+mogL8l3TWKX10YhZhyrC5PvzSDVxWbW8eKan9QxEwllMZvhJGZXAtM6gi3B/
         D4TZiBj+2Gy9mVQc8gg6BeEldpyRINtKexpaGrBIuKu8QKlf0Hhc+QEJxRLTUWjMTJSB
         Bn0WHe2vGkF7eTGQ4GaHli1iDkLWCGoBjIA94Q5N0kOq5sYAgWt7fI16VtqLhp8WqNY8
         SLIg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 4/4] arm: meson: Recognize A311D SoC
Date: Wed,  9 Oct 2019 16:03:57 +0200
Message-Id: <20191009140357.27279-5-narmstrong@baylibre.com>
In-Reply-To: <20191009140357.27279-1-narmstrong@baylibre.com>
References: <20191009140357.27279-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: afaerber@suse.de, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Andreas Färber <afaerber@suse.de>

Values imported from Linux driver, but in correct numeric order.

Khadas VIM3 prints: Amlogic Meson G12B (A311D) Revision 29:b (10:2)

Cc: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index ea32c01d11..9571b5a189 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -59,6 +59,7 @@ static const struct meson_gx_package_id {
 	{ "A113D",  0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
+	{ "A311D",  0x29, 0x10, 0xf0 },
 	{ "S922X",  0x29, 0x40, 0xf0 },
 };
 
-- 
2.22.0

