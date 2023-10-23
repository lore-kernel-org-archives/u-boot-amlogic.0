Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF2C25B41
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:51 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.119786.1698064907403953679
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 05:41:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eH9RuIbw;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4084f682d31so23822375e9.2
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698064906; x=1698669706; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMURHiIMuvHq6Kw4J7lcqajqwHiu01aF73QQKnBSid0=;
        b=eH9RuIbwuy/SGKtPJwd+KwTL8bpeF3cb9T5EFW5QbQKpPTCu8ghzl2Ckvk5Z6vbDPP
         M9VMeCnxNXTR5pLxELFAFJ4KiXi3oRkmS/hmzSYt/H/Lo8+1JtdTkT0st9FruJ6NIop+
         jL7ZaKBBFYkgk1Emy4MW5qU8mGEIkVzzebYp8itPpH6tLaevpdqtuigKm8VdzBY9FTbN
         Fu9YL9oc8+V7STMtCmeqBPV3v6b2U4mhvryHPUDnH9JzU4KNNwU4vM7QM+20rHWAHPUl
         AEpzy3mdCeyAnm0AkGK8FvXCCUkxs+G/Ay7zLL6PmI3EHgE+RsVBUzgqvbXtNQCbzH+7
         SA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064906; x=1698669706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMURHiIMuvHq6Kw4J7lcqajqwHiu01aF73QQKnBSid0=;
        b=fI1r8BntZ0Gx+teOLdRAfoNz66fnLJOPAai1EgkJxwAcDEpWhRaayyGllHza3GWnBQ
         //pWAFRAnb3nYG8irj4kCpZc6X8aWxhoLGNMaxUHqrj4MUapir8I6UEdI/Gw2MQqwqCF
         W0SGlrFTQRbsZ8xIbJkG3FVEZ1AiSlVI+3ZVmceB3Jr04eLtBLMh77+T0jVpNyWBZgwG
         nWOSRNn4kXaEn8501fWGHv7awvnNaT7Gzaw5APjDNjqb+ZzEsufzHxidzUt+q9dC1Je1
         ASiyOHw6wUoc/eXjrR1plrq/wPVoY50jzM5ftQRe5CKu4DxjBFPaoX334iaN4BGaVGvh
         UK/Q==
X-Gm-Message-State: AOJu0Yzk2VzH+/9ndsRsk0UIGG+qpsTdypzFfFIoifl/T/tvaq+3uGK9
	+Nboptgj6Z90nz7irg4mROV1Sw==
X-Google-Smtp-Source: AGHT+IG0FK1tcd9I9ZP6GLZP6qtcQgxvbYnR0nk0wPs+oHT0xmk9fa2CKj4GRcgTpI7Y7zBtz/Ri3Q==
X-Received: by 2002:a05:600c:4714:b0:406:7d74:a29b with SMTP id v20-20020a05600c471400b004067d74a29bmr7082414wmo.13.1698064905788;
        Mon, 23 Oct 2023 05:41:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Oct 2023 14:41:34 +0200
Subject: [PATCH 1/4] ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all
 configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-usb-dfu-boot-v1-1-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23932;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hRFrcrx/lDwzzcS+u56hlWqOrmaGcoq+kSFjIjKKjpE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoGHHqHcsKImeJVL4uESsnJlHOUUY+/wpvQM
 DgM7eF/1wCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqBgAKCRB33NvayMhJ
 0ey6D/9fbze9GYeiNW8mz2GhyoWcZS7oqO8CDBFUCoOfOchkkOMD7TBsH2tnewTwxDFJPcP4lbo
 sNbhUkedg0uARw2dx8Wx/9QcXuOOHnSIj4TipBQMuqEAO+Tm3UVpJmyj+OQqIz6Erw1DyrmZAq6
 TbH5gZLW9oQHwmrUoR0i7JRzka8CZAzohCG73+6fSKahIcX/fpUfKiCo5ePqNlizs2Gg//UxLbW
 aRKXnqbG0pO/tGrATUopgqApZopBBaF39L7A9WGk2uhqzkg1qiC4YfiSwKov99BLzQn1H6ED1Np
 QnG+t66fC6QuIesrb+TwcY2BOScdHDufY9Yvsi9DCtaAnFFQx5zuQosSs1Ov3mKBkl8/7ct88DT
 G3QL7P8repJR2ZYryRVuCEuY5akkXqMo13BoVy0mjGuMgZLTW3ei1PZbT6YJus42rBaD9u6wvp3
 JR4+tR1c4cSbo1KXZ00wykfEQPioA0TuDliQKvYBphn34AvAe+NlwCn0ZCCOL6RMzggy7PTgfly
 HuiZGykjnauismCw0zM1UZZO6Oq2Ci/WCDkq0ctRmEcys4S5nHQkESSOYMUydE8ECOeZJKtAOPw
 fdhCruYm42SoDsI5BBF269JtyN456+TCngHPX3qDVDhF3JmLoso6GNojgf9TmkOwPiRaS3NQMox
 BPlCEaqQgRnMb8Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 12:41:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1790

Allow all boards to boot with a fitImage, but keep support for
Legacy image format for now.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/bananapi-cm4-cm4io_defconfig      | 4 ++++
 configs/bananapi-m2-pro_defconfig         | 4 ++++
 configs/bananapi-m2s_defconfig            | 4 ++++
 configs/bananapi-m5_defconfig             | 4 ++++
 configs/beelink-gsking-x_defconfig        | 4 ++++
 configs/beelink-gt1-ultimate_defconfig    | 4 ++++
 configs/beelink-gtking_defconfig          | 4 ++++
 configs/beelink-gtkingpro_defconfig       | 4 ++++
 configs/jethub_j100_defconfig             | 4 ++++
 configs/jethub_j80_defconfig              | 4 ++++
 configs/khadas-vim2_defconfig             | 4 ++++
 configs/khadas-vim3_android_ab_defconfig  | 4 ++++
 configs/khadas-vim3_android_defconfig     | 4 ++++
 configs/khadas-vim3_defconfig             | 4 ++++
 configs/khadas-vim3l_android_ab_defconfig | 4 ++++
 configs/khadas-vim3l_android_defconfig    | 4 ++++
 configs/khadas-vim3l_defconfig            | 4 ++++
 configs/khadas-vim_defconfig              | 4 ++++
 configs/libretech-ac_defconfig            | 4 ++++
 configs/libretech-cc_defconfig            | 4 ++++
 configs/libretech-cc_v2_defconfig         | 4 ++++
 configs/libretech-s905d-pc_defconfig      | 4 ++++
 configs/libretech-s912-pc_defconfig       | 4 ++++
 configs/nanopi-k2_defconfig               | 4 ++++
 configs/odroid-c2_defconfig               | 4 ++++
 configs/odroid-c4_defconfig               | 4 ++++
 configs/odroid-go-ultra_defconfig         | 4 ++++
 configs/odroid-hc4_defconfig              | 4 ++++
 configs/odroid-n2_defconfig               | 4 ++++
 configs/odroid-n2l_defconfig              | 4 ++++
 configs/p200_defconfig                    | 4 ++++
 configs/p201_defconfig                    | 4 ++++
 configs/p212_defconfig                    | 4 ++++
 configs/radxa-zero2_defconfig             | 4 ++++
 configs/radxa-zero_defconfig              | 4 ++++
 configs/s400_defconfig                    | 4 ++++
 configs/sei510_defconfig                  | 4 ++++
 configs/sei610_defconfig                  | 4 ++++
 configs/u200_defconfig                    | 4 ++++
 configs/videostrong-kii-pro_defconfig     | 4 ++++
 configs/wetek-core2_defconfig             | 4 ++++
 configs/wetek-hub_defconfig               | 4 ++++
 configs/wetek-play2_defconfig             | 4 ++++
 43 files changed, 172 insertions(+)

diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index bb43cc41e5..5fa4b8952a 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -17,6 +17,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 4f8cec9956..6c16953383 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING="bpi-m2-pro"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index 3dd8ddcdca..eb3bb17c9a 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -18,6 +18,10 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 696d2fcc5c..0895af81be 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING="bpi-m5"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index c022097390..8cd0cff6ce 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" beelink"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index c0d22c4147..5156dedca8 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" beelink-gt1"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 42e1ba6560..a5ab9593c9 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" beelink"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index a3713326c1..a130479903 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" beelink"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index 549d5514f7..0fe8e8f0ae 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -18,6 +18,10 @@ CONFIG_IDENT_STRING=" jethubj100"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index df9b8f3aed..f1e0503137 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -18,6 +18,10 @@ CONFIG_IDENT_STRING=" jethubj80"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 38b9b2b71c..d465e7a494 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" khadas-vim2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ccd6f6f8a0..8b8367d2da 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -19,6 +19,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 5c3d565971..db85044aea 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -19,6 +19,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index d611124325..2340fbfc3a 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -18,6 +18,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 0d6de80013..b2bcb43b83 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -19,6 +19,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 827752f243..0725070dd9 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -19,6 +19,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index f959d33689..ee31c05a13 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -18,6 +18,10 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 6a9e851616..812baca63c 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" khadas-vim"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 0fa7f3de79..4ed04fa518 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -19,6 +19,10 @@ CONFIG_IDENT_STRING=" libretech-ac"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index dee03b3c5f..24d2aaf51f 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" libretech-cc"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 628c6bab38..fd0323a9b6 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -18,6 +18,10 @@ CONFIG_IDENT_STRING=" libretech-cc-v2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 1c8787c8ab..0901ce1b4e 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -19,6 +19,10 @@ CONFIG_IDENT_STRING=" libretech-s905d-pc"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index 170492eb3f..bc63374869 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -18,6 +18,10 @@ CONFIG_IDENT_STRING=" libretech-s912-pc"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index ef101cf430..41dbf7981f 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -15,6 +15,10 @@ CONFIG_IDENT_STRING=" nanopi-k2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 9481cbc42b..5f9f323e06 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -15,6 +15,10 @@ CONFIG_IDENT_STRING=" odroid-c2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 315dc5cadb..99fa61f069 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" odroid-c4/hc4"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index fb8ce5ccad..077c773cee 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" odroid-go-ultra"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index b2507150c7..2c53f6377c 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -19,6 +19,10 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index e55de380a4..16a1b532f1 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" odroid-n2/n2-plus"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 983ac883ec..2ea07552ac 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -17,6 +17,10 @@ CONFIG_IDENT_STRING=" odroid-n2l"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index 42e7eb855e..cd579ef5f1 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -15,6 +15,10 @@ CONFIG_IDENT_STRING=" p200"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index 5c983751d0..b2f0a0ccdb 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" p201"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 2fcf3b30f4..b90391d9b5 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" p212"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index b1aa3c27f8..365a438c8f 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" radxa-zero2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 23f30f6b11..0eba5f5c8a 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" radxa-zero"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 9a7d520f90..0e2ca70da3 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" s400"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 63e4ebe649..e3e1b157d7 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -21,6 +21,10 @@ CONFIG_IDENT_STRING=" sei510"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run load_logo"
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index ff7bcb330e..b417b5db56 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -21,6 +21,10 @@ CONFIG_IDENT_STRING=" sei610"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run load_logo"
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index a841a66363..3f57e62d46 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" u200"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 4a2ff34385..3eda8f14a2 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -14,6 +14,10 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" kii-pro"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index 324062e4fa..b4134098cb 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -16,6 +16,10 @@ CONFIG_IDENT_STRING=" wetek-core2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index 4091a19713..fd92b041e7 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -14,6 +14,10 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" wetek-hub"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index 3ef4390900..b887419a6b 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -14,6 +14,10 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" wetek-play2"
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y

-- 
2.34.1


