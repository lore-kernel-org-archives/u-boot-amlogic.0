Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.6257.1636812444513481778
 for <u-boot-amlogic@groups.io>;
 Sat, 13 Nov 2021 06:07:24 -0800
Received: by mail-oi1-f180.google.com with SMTP id bf8so23914376oib.6
        for <u-boot-amlogic@groups.io>; Sat, 13 Nov 2021 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRqehDfL1pX1AzgZ3QYTaQ7y/fWBA0IKO8+kDxZmUoQ=;
        b=Dx1BMWSUB9xJCFW4tf/b+XxGgtkRFp39XehqRzCbXbT6aHFEpMcBE4YFjGZCeTDAe6
         CjVG+0CqOf5hs20PaO1ysqY7w0U7vC8mYUI3ZG4h9DdNz00L0eJHsogPrJcA/BevJuUk
         ID96RUkOBgMw++j7OazwuNoFH3FhaaiOSt3pg=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] pinctrl: meson: Correct the driver GPIO declaration
Date: Sat, 13 Nov 2021 07:07:15 -0700
Message-Id: <20211113140716.371496-1-sjg@chromium.org>
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

Changes in v2:
- Fix the gxl driver also

 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gx.h     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c   | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 51a0b4c5cad..a44145e2d4e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -701,7 +701,7 @@ struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_gxl_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxl_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_gxl_periphs_banks),
-	.gpio_driver	= &meson_gx_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_gx_gpio_driver),
 };
 
 struct meson_pinctrl_data meson_gxl_aobus_pinctrl_data = {
@@ -714,7 +714,7 @@ struct meson_pinctrl_data meson_gxl_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_gxl_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxl_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_gxl_aobus_banks),
-	.gpio_driver	= &meson_gx_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_gx_gpio_driver),
 };
 
 static const struct udevice_id meson_gxl_pinctrl_match[] = {
-- 
2.34.0.rc1.387.gb447b232ab-goog

