Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web08.11446.1604928959509840163
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2020 05:36:00 -0800
Received: by mail-wr1-f65.google.com with SMTP id o15so868662wru.6
        for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2020 05:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ao3TsUzUS/lxT4SOf+jCBOjFmAS/+nuKQ79Qqh1Qu4=;
        b=l+neIJtQfCfSMS9cBmDlUYkj09cGY/7JCvNcU922JPr/7Ic4Sz8j6vWOQRN33WuSda
         c210WLYy2cSn6DjfWro1XP/MpWXSa1y0wd7jkr58XGdO3B7VypTyCqGNcldRAAa7YdQi
         ivxFb+Y5FftijnYUGN4PJyjIB+CUPqLMENLulRS6B+y8S+x1844LhAi9wOeyQtjZuIkA
         Dz06srxjqKQ93nubNUumAdLCygAGLsMzIILwZAAHxWm7Xhnxlp4Fx9qosETRzYXQ/+3w
         I4HJ5w4vFqfkPF/6AKDKhiIKJnMbi7TdEcZDUF3MufreOTjSiSEsMgk057MiVlbnqVva
         absQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] ARM: mach-meson: update SoC IDs
Date: Mon,  9 Nov 2020 14:33:55 +0100
Message-Id: <20201109133355.2794045-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Update From Linux commits
- 240051cb833b ("soc: amlogic: meson-gx-socinfo: Add A1 and A113L IDs")
- 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for VIM3L")
- fdfc6997bd08 ("soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for VIM3L")
- d16d0481e6ba ("soc: amlogic: meson-gx-socinfo: Fix S905X3 and S905D3 ID's")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-info.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 3abb27e03b..e61d1adb10 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -38,6 +38,7 @@ static const struct meson_gx_soc_id {
 	{ "G12A",   0x28 },
 	{ "G12B",   0x29 },
 	{ "SM1",    0x2b },
+	{ "A1",	    0x2c },
 };
 
 static const struct meson_gx_package_id {
@@ -65,7 +66,11 @@ static const struct meson_gx_package_id {
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "A311D",  0x29, 0x10, 0xf0 },
 	{ "S922X",  0x29, 0x40, 0xf0 },
-	{ "S905X3", 0x2b, 0x5, 0xf },
+	{ "S905D3", 0x2b, 0x4, 0xf5 },
+	{ "S905X3", 0x2b, 0x5, 0xf5 },
+	{ "S905X3", 0x2b, 0x10, 0x3f },
+	{ "S905D3", 0x2b, 0x30, 0x3f },
+	{ "A113L", 0x2c, 0x0, 0xf8 },
 };
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.25.1

