Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF83EC27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 14:37:47 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.166.1718136149506366643
 for <u-boot-amlogic@groups.io>;
 Tue, 11 Jun 2024 13:02:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=h2yOE1oi;
 spf=pass (domain: chromium.org, ip: 209.85.166.174, mailfrom: sjg@chromium.org)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3758fbc25f3so14894885ab.3
        for <u-boot-amlogic@groups.io>; Tue, 11 Jun 2024 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718136149; x=1718740949; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf2T4EoOgEH5RJRfr6RU1JO8qUpBjihP5i6QW2xcyjQ=;
        b=h2yOE1oidL5Jnn2OphZN88nAhfGD2SwRQb2z9tXL9H8xEig4uP5beb606rZAlq1G3g
         K3dPy4BDcd5uVp44f0zDJAPcp4SRKMNblq6KqQpzBHXbj98zj36iHdBEjtnpn8tEy+xF
         hX+DJIZwlUX6t+FBDaauMbxJGFgnJfNpm8z8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136149; x=1718740949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf2T4EoOgEH5RJRfr6RU1JO8qUpBjihP5i6QW2xcyjQ=;
        b=Q8Gpm85xdzqVZHb4OMsPomfVuRALMCEJME8AqyhiUYcnz1fn31eL2vCnHrCM5i4t6l
         2jVYDP7CrqFSqgTbT7neABwA5lA0sFB+ZcQPGTYTZ9e/XPtofes/O9pL8JZKRcKKdrNw
         ja4QTQvBBZEzCtM39HY7pDN7qizCapWAlOxmBeZBnDTXlZ74JgZ1Cbja8E4dvIpuzTN8
         TrC/1vSMrGhrU/kQQFYTntgWxrqiF4nSF+BYql83+4L5cc4tbqdOaZTBcsjcxMXFeh29
         nfqpBOULnwy9/rvh8+JIDVbK2UAUomQcQ0cd0xNWgtmMIUFRL66/VPAhVLHOPXdv8NZM
         lI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLudb8G2YHuPbdSvpDw48cPQwoxJSfjYNocpN1TCcUfIR5eVrzmV9fcITuijt8yn70BaWetqlwbFsj9rcwzcMB5jLzb9OKbic=
X-Gm-Message-State: AOJu0YxeFIkZ7Wg609nHAWhsKCMDjf1mUnLG7CmywuDxfZykbdhHEL2R
	AOQNwpJX4cYoVZqT6xdwz482VJPk7Djx5muDj125Y99gi/cfqkT8UNK7HCAg3Q==
X-Google-Smtp-Source: AGHT+IEgSBtCT5zVxwq3XgJLg68nPLcdS6qLNF9VBoT46G4+sLMYy12e9VkY8oD7/qKDBKZEdDcsQg==
X-Received: by 2002:a05:6e02:1487:b0:374:a412:3d95 with SMTP id e9e14a558f8ab-3758035f491mr152648375ab.20.1718136148668;
        Tue, 11 Jun 2024 13:02:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:02:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 18/42] meson: Correct driver declaration for meson_axg_gpio
Date: Tue, 11 Jun 2024 14:01:32 -0600
Message-Id: <20240611200156.2245525-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 14:37:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2292

This should use the driver macros so that the driver appears in the
linker list. Fix this.

Fixes: 8587839f19d ("pinctrl: meson: add axg support")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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


