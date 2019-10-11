Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.1854.1570808044218832497
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:04 -0700
Received: by mail-wm1-f68.google.com with SMTP id m18so10659785wmc.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MofgDhNbEhJwFWNdYjWwZPNVpyZI7oqdGd1seHwLcR4=;
        b=JpUErQ0KMTrYsNF1Tq+P7qZwNG+h/zITPxQumXchpQwEy56QiaplAi+PUG1tZl26Av
         wB6xeWtkJ+oFdOkWJ80UzbNLvQcieA52S8aENfqLusx3lES76A9csZg4CsDPq1I75J1E
         W+c7JE8KnfgKI7XJy6uoCiQHUMpHCb04/OYI2//41T8QtHQvnub/162P9i6Il+nuct9/
         fSPne8e+9hksshogmmFt1JeyIQ6ssKj8uWFVNzXynOowPgk7lM4v9kmzpKlbY41WO71j
         JiAvUhCGTiC/b2JaWoHuE/1iJf/cWuFI91IjvnfoIbnIXimO5G4h0eYii96MXuUyleo+
         Nyog==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/8] ARM: meson: add SM1 SoC id
Date: Fri, 11 Oct 2019 17:33:51 +0200
Message-Id: <20191011153358.29739-2-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add the missing IDs to detect the SM1 S905X3 SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 9571b5a189..0d3b40a249 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -34,6 +34,7 @@ static const struct meson_gx_soc_id {
 	{ "TXHD",   0x27 },
 	{ "G12A",   0x28 },
 	{ "G12B",   0x29 },
+	{ "SM1",    0x2b },
 };
 
 static const struct meson_gx_package_id {
@@ -61,6 +62,7 @@ static const struct meson_gx_package_id {
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "A311D",  0x29, 0x10, 0xf0 },
 	{ "S922X",  0x29, 0x40, 0xf0 },
+	{ "S905X3", 0x2b, 0x5, 0xf },
 };
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.22.0

