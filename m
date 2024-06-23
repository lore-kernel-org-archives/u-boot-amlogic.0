Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2309C3065E
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web11.125721.1719174643107503018
 for <u-boot-amlogic@groups.io>;
 Sun, 23 Jun 2024 13:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=Pd+tROpi;
 spf=pass (domain: chromium.org, ip: 209.85.166.49, mailfrom: sjg@chromium.org)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ebdb5d9915so138364239f.1
        for <u-boot-amlogic@groups.io>; Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719174642; x=1719779442; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
        b=Pd+tROpiCqb9xY2z4kJZ1sNc7vSj4yrVHfsR2fMwud4PJSFPJXUFUAKblqniKy6MaW
         vxHQ6Z8idSFd1Ar+RGdOuHjGdDKPajE9AwhNsvy8dlxzH49Un6WNLaCp6AxGE+89Kdaq
         kmWTj+UO/kxzkOPqiw/fupNoYy4QXf0Bu+V5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719174642; x=1719779442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1lgyE0323kxHzqwAr6nvI90PDCPp9kU72jIBe8uLY=;
        b=XP6SDfU/0t6b1By9KRut/4W65iVO6bWcoa0CtIvF16C2JSwe3W7XnhRNn7oNRLQZYW
         Adz2ofaQdyifzBOLR/xGcuxmkg5M8xSIOkXIyosCwjO+YIjDerq7PoRPrTDVObcAgX6E
         jBKKhCx5xhG5//L2Et5oYG2DvlHbbb51LXa2E8vVnPyeyk75o1g1ZGPIewVZ32kGpyKH
         I2ZDKAVPmr7swqfMt+HiK/SfC5zL15Qu9mjWlOGyCUvgRSrb6KAXnT1cesTkPOs34yIx
         Gxagp+g5G1w/4r9Cg+kpNlGt7RBGS4CFCg/qOQn7D9dbtYZAJwOFAs0Sxn7vwB/UIkoW
         mY9g==
X-Forwarded-Encrypted: i=1; AJvYcCUPiyCrX5yPI2KQAIbZ/t9RvbfurfBVtEY37Rs9n1mGVovOuBO8rbOd20RovBXoNSuOrQ+IM+gwHw8WQJwa5+WlpholLBAevsA=
X-Gm-Message-State: AOJu0Yy4FjGIvizmTYWIwmDII0PiUA7jce+AJ6KYbQN7htTooMia6xSA
	oiQrFlbmrggDuF4hMdTNGIamQAlf1LEOg057vdXfi5fHPP7KS0NbHQCoj2Cg8g==
X-Google-Smtp-Source: AGHT+IE7rOLpp2AelnhD22UJwqptSga16Q1uTfEp2DgRww7QnNCc0zWyQgG5LtQWxXQa5UB80vNG5g==
X-Received: by 2002:a05:6602:13d5:b0:7e1:a7e8:eecb with SMTP id ca18e2360f4ac-7f3a74be807mr273672739f.6.1719174642356;
        Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 07/14] meson: Correct driver declaration for meson_axg_gpio
Date: Sun, 23 Jun 2024 14:30:26 -0600
Message-Id: <20240623203033.1566505-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2322

This should use the driver macros so that the driver appears in the
linker list. Fix this.

Fixes: 8587839f19d ("pinctrl: meson: add axg support")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson-axg.h     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index 52c726cf038..15ebd574ef1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -179,7 +179,7 @@ static const struct dm_gpio_ops meson_axg_gpio_ops = {
 	.direction_output = meson_gpio_direction_output,
 };
 
-const struct driver meson_axg_gpio_driver = {
+U_BOOT_DRIVER(meson_axg_gpio) = {
 	.name	= "meson-axg-gpio",
 	.id	= UCLASS_GPIO,
 	.probe	= meson_gpio_probe,
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 94e09cd3f8a..ed3f92b2d75 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -939,7 +939,7 @@ struct meson_pinctrl_data meson_axg_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_axg_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_axg_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_axg_periphs_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_axg_periphs_pmx_banks_data,
 };
 
@@ -953,7 +953,7 @@ struct meson_pinctrl_data meson_axg_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_axg_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_axg_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_axg_aobus_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_axg_aobus_pmx_banks_data,
 };
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.h b/drivers/pinctrl/meson/pinctrl-meson-axg.h
index c8d2b3af036..a6581bab500 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.h
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.h
@@ -61,6 +61,6 @@ struct meson_pmx_axg_data {
 	}
 
 extern const struct pinctrl_ops meson_axg_pinctrl_ops;
-extern const struct driver meson_axg_gpio_driver;
+extern U_BOOT_DRIVER(meson_axg_gpio);
 
 #endif /* __PINCTRL_MESON_AXG_H__ */
diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 24f47f82558..67114df6824 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1253,7 +1253,7 @@ static struct meson_pinctrl_data meson_g12a_periphs_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_g12a_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_g12a_periphs_functions),
 	.num_banks	= ARRAY_SIZE(meson_g12a_periphs_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_g12a_periphs_pmx_banks_data,
 };
 
@@ -1267,7 +1267,7 @@ static struct meson_pinctrl_data meson_g12a_aobus_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson_g12a_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_g12a_aobus_functions),
 	.num_banks	= ARRAY_SIZE(meson_g12a_aobus_banks),
-	.gpio_driver	= &meson_axg_gpio_driver,
+	.gpio_driver	= DM_DRIVER_REF(meson_axg_gpio),
 	.pmx_data	= &meson_g12a_aobus_pmx_banks_data,
 };
 
-- 
2.34.1


