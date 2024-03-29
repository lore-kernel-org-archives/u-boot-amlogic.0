Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF6EC6FD1F
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 17:52:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.2133.1711734719861323710
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Mar 2024 10:52:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IOBUhEfx;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-415482308f8so10671735e9.1
        for <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711734718; x=1712339518; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjhrrgYnsho6f1EhNidfi7Gxs46121Qo+nftv0lMnmQ=;
        b=IOBUhEfxz2kj3bj1JdeyzFaZ8iNtKuw1fb16zLqj/YzVAB2lqp1nNRQsNSKI8RZHXT
         wE5NA8VU5nR2XtExZXvsOY/OdsVA87fcfNRiLApKoO0z9GWEG8G5QWpOeInUd/s4o6ZZ
         DG+SnxVbstzYjO7mr4nDFKvdxJG8HAS+daAsC2eEa1K5Pu19b9Hz+JfBUcdCfQub5vM7
         QpRPyGzW0kf0ecWYKFt3QWWSgVTUPIxX0GG4YxOvpAOximOrBo6hUKJRxId5yvAyUslP
         45TgPTZONiCG//sCi6VKyGpwaeDDjvnIqpPSmcOPOJ+GQSOY/mYDys59s6BeToGo+rOx
         hPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734718; x=1712339518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjhrrgYnsho6f1EhNidfi7Gxs46121Qo+nftv0lMnmQ=;
        b=kK54KWcv48gtJCypv5BVlzEQEHt7k+By3tHJDp0QdkUyWvlTStfDxjjtCxItNg2MBQ
         uKDsT1BRfLBCsvJIvlsTqNMMUyUUv7KkPcR4bCp0Pl5TjxmOob/X5Dnoe1LDTN8Cakin
         gEeoRai6z9Egg7vCdL/a9exlqTPtpyPtTrGDG6/qt0QpulOBwMLDrKQVZ7eoA8ZaOe43
         nNeLkd1vmBviK1Txz4H/0bMwMh/Oim1AwSTKCLaQD4T8w5Ud87DIEyASYHonYctYWDJa
         riBRW/gkdu2mKnqyhPNgwoQzByCQgN84oV6ncLuK7lp6CaJIlNQoVhww89jY8Hplcut5
         pCiA==
X-Gm-Message-State: AOJu0YxGEpIjOpmNMS7UOqxbzEv3ZWZXHAiFITQ+BhnhhYoCBslmL0Cp
	gRf20iCjKeJQjrbAxYG7Jy7VMzuSVNF9hZrEWEYxwC4O0oLGIK7uLyG0QsVZqjk=
X-Google-Smtp-Source: AGHT+IHj0Z/gQGHM6BQd05z5AusRULZHZx1BarCwdZmdiKYBLloWgQ5ax+n9OBF1HGo4sd/6r87A/A==
X-Received: by 2002:a05:600c:a07:b0:415:59b:f665 with SMTP id z7-20020a05600c0a0700b00415059bf665mr2028832wmp.26.1711734717934;
        Fri, 29 Mar 2024 10:51:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:51:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Mar 2024 18:51:51 +0100
Subject: [PATCH v2 4/5] dts: meson-g12a: Switch to using upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-u-boot-of-upstream-v2-4-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14062;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3LwbmNpWlg5H5nvc8XRDOkA7qKxKvwZIOvLVUg0nTLI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+3fW7NOyFgP4fBYUJobmJiXRUfpoMzsKpHTgVO
 3EQhw0WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/twAKCRB33NvayMhJ0XUXD/
 wOxyv3P8Be2kyKrRg2EelwAlr/NJ5nCYtMKqLmuqii/SiT+58EDr2lR2MlK5gbYdEDNci09+t8OKRB
 uobZvyfJLZ06r6prrpp300QzXLvM0Kfwcs3URv4AT/AaLuev1ZQW5xgjgiPXjj2uOgYIEXO+TaH6cS
 nqieGzzrHO/7TP3XtYZW/Sv8um8V8z6EQHbXPdsZMoX8WlZwxAea1p3F4EJAlwaCm1eHNz0a1QuB7b
 dnvZvK4GCggnIBwnlXOXBckpiL4HrS/Inz8L8AKlvpR5asDEYLpyMl7ObJbz7+TgzJlgjCu4uMsEd+
 8u3yFOoSHEIMYO9Dv5PGnsOL5aIpSfZMuO/LGyMujEy5qGnBPGdCQ5E7b4y8YM8nE//h252QBwRKcy
 oCMH6bN95649Q/XH+A0ej+5BHFCTOswlV/dwlXi0rMHs491TI0zVROP9nGSKBpYBmKgw/LDoIiwcUk
 aU6paU5yPE591K5fDmpxkdhNoIsZdhDq/YG0tBZ+dtSAEOtg0R1LPSxo8AZPJlyXQ7JSHOp8ZNxru0
 A7LnrZpRc0IaPQlxZE+ATS4tAJGCloFsH9NGAgKSJ6BYD351uRIqESKr2cy9rOumOn80ngFGts+mS/
 FL7OpHl4rDU4P5vrnGijZUchUQSFkoz3AuYsRc7UHRh/V7apMDfY20O5en4w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 17:52:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2259

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Cc: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Viacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig               | 1 +
 configs/bananapi-cm4-cm4io_defconfig      | 2 +-
 configs/bananapi-m2-pro_defconfig         | 2 +-
 configs/bananapi-m2s_defconfig            | 2 +-
 configs/bananapi-m5_defconfig             | 2 +-
 configs/beelink-gsking-x_defconfig        | 2 +-
 configs/beelink-gtking_defconfig          | 2 +-
 configs/beelink-gtkingpro_defconfig       | 2 +-
 configs/khadas-vim3_android_ab_defconfig  | 2 +-
 configs/khadas-vim3_android_defconfig     | 2 +-
 configs/khadas-vim3_defconfig             | 2 +-
 configs/khadas-vim3l_android_ab_defconfig | 2 +-
 configs/khadas-vim3l_android_defconfig    | 2 +-
 configs/khadas-vim3l_defconfig            | 2 +-
 configs/odroid-c4_defconfig               | 2 +-
 configs/odroid-go-ultra_defconfig         | 2 +-
 configs/odroid-hc4_defconfig              | 2 +-
 configs/odroid-n2_defconfig               | 2 +-
 configs/odroid-n2l_defconfig              | 2 +-
 configs/radxa-zero2_defconfig             | 2 +-
 configs/radxa-zero_defconfig              | 2 +-
 configs/sei510_defconfig                  | 2 +-
 configs/sei610_defconfig                  | 2 +-
 configs/u200_defconfig                    | 2 +-
 24 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 1d837ae0f3..7570f48e25 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -53,6 +53,7 @@ config MESON_AXG
 config MESON_G12A
 	bool "G12A"
 	select MESON64_COMMON
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905X/D2
 
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index 116147fc9a..cb78dabc13 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-bananapi-cm4-cm4io"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-bananapi-cm4-cm4io"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 755bccb4a7..196bc4077d 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m2-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m2-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index af8daced62..7b137d5e1c 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-bananapi-m2s"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-bananapi-m2s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 6de5d5fe7b..99ed7c9669 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-bananapi-m5"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-bananapi-m5"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 99e36e970a..c1e60ede4a 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gsking-x"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gsking-x"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 5c21d8eeab..0b644f0e34 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 37bb4cde79..a694617a96 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gtking-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-gtking-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ee62fe36d4..37b8d6a925 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index cecbe50617..55d59dd481 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 5df4b92143..32579b8ac3 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index ec4e0dc72e..95e70275cc 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 206f8defca..6372d11989 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index de8fdd83cc..b9f4690045 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index fe1f861258..4ef1e68166 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-c4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 49d628b76a..06437fe3ae 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-go-ultra"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-go-ultra"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 7720ab5eb8..60233fb9ce 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-hc4"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-hc4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 9694f04a66..a4cc766f84 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 673e0cffb2..3f657d1881 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2l"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2l"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index b795681b3f..92e0a8833c 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-radxa-zero2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-radxa-zero2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 103ff8a321..5179c58dad 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-radxa-zero"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-radxa-zero"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index c4a49fbd6f..791979e744 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-sei510"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-sei510"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index ae254c62f2..ce5374319b 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xFFFF0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-sei610"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-sei610"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 21c90e7678..879ae0defa 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-u200"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12a-u200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y

-- 
2.34.1


