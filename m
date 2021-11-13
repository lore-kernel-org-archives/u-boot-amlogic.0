Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web12.1429.1636768838941563780
 for <u-boot-amlogic@groups.io>;
 Fri, 12 Nov 2021 18:00:39 -0800
Received: by mail-oi1-f173.google.com with SMTP id s139so21198420oie.13
        for <u-boot-amlogic@groups.io>; Fri, 12 Nov 2021 18:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Un0gU8iwDhsASPn5KiXy5QabZ1lejvMeToi4Dj9wqKM=;
        b=H4AtQeoX+/hpUpHhoyWI7zFCpIla91P+2dzUy4pdxUAQJalYoi/2wBWLjqHx6yfsMp
         bUXLYTADLsTJPiJAzlgcft395BiKuvAJzkhR0oEJIEODoOp7uV8lHPLp6EOmoFHTLcFD
         wlEwBYWOWWC4GmHaT9FzqAzUK/CcuevxLVtc0=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH] pinctrl: meson: Correct the driver GPIO declaration
Date: Fri, 12 Nov 2021 19:00:34 -0700
Message-Id: <20211113020034.263468-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This should use the provided U_BOOT_DRIVER() macro so that the driver gets
added to the appropriate linker list. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7c9dcfed50f ("pinctrl: meson: rework gx pmx function")
---

 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gx.h     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
index 159f3406a20..99502d89c6c 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c
@@ -145,7 +145,7 @@ static const struct dm_gpio_ops meson_gx_gpio_ops = {
 	.direction_output = meson_gpio_direction_output,
 };
 
-const struct driver meson_gx_gpio_driver = {
+U_BOOT_DRIVER(meson_gx_gpio_driver) = {
 	.name	= "meson-gx-gpio",
 	.id	= UCLASS_GPIO,
 	.probe	= meson_gpio_probe,
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gx.h b/drivers/pinctrl/meson/pinctrl-meson-gx.h
index 4c1aa1a3002..c70c1f51c6d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gx.h
+++ b/drivers/pinctrl/meson/pinctrl-meson-gx.h
@@ -43,6 +43,6 @@ struct meson_gx_pmx_data {
 	}
 
 extern const struct pinctrl_ops meson_gx_pinctrl_ops;
-extern const struct driver meson_gx_gpio_driver;
+extern U_BOOT_DRIVER(meson_gx_gpio_driver);
 
 #endif /* __PINCTRL_MESON_GX_H__ */
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 8c01c739068..93a895c9fa7 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -439,7 +439,7 @@ struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_gxbb_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxbb_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_gxbb_periphs_banks),
-	.gpio_driver	= &meson_gx_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_gx_gpio_driver),
 };
 
 struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
@@ -452,7 +452,7 @@ struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_gxbb_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxbb_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_gxbb_aobus_banks),
-	.gpio_driver	= &meson_gx_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_gx_gpio_driver),
 };
 
 static const struct udevice_id meson_gxbb_pinctrl_match[] = {
-- 
2.34.0.rc1.387.gb447b232ab-goog

