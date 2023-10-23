Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E7AC00A8F
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.119339.1698064909924098989
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 05:41:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ym+NpopK;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4079ed65471so26927275e9.1
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698064908; x=1698669708; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiyiWO4X/xwjIk1NuugQoXgZGPHg9CM+5fJrkVbysmo=;
        b=ym+NpopKGyz6aC5eMo4jYYLLXmx/xPa1yeWXQUBUCFz9ij90Q9SlWGkIlsnOt883ad
         lUvtbL0LyLFbWxI94oxxbK1HAa7sNLIE6SHLiQhierD7iQYldJHpBl7/cyecby9dGwaa
         g6IjBnc8MicHMUi7kfOje/ZMPqZu1sXJhM70+tFCC7Oixa/xHzc0/xGPi6YlLlEr7sPR
         zpPrjfCMHVJy1Hn9KYS9o2POujWo5g1UbfrLKpgVJk+mdH0lY99XAQHCRXe9eDWRXtGT
         vtStsOt5rvWlQICnMDPXphpgoGqZTGOrh3CCu9+iKeS9JrbOqryq0VoifCxQFDhhEUHF
         nVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064908; x=1698669708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiyiWO4X/xwjIk1NuugQoXgZGPHg9CM+5fJrkVbysmo=;
        b=JwqgIZvNVp84MmP7ReUYRFt/FIS7Sf7ybYjWb32u+b+3RS7ukif3uiaDi93+9lRXsK
         A777ifXx0qSxstPa9E0/FlXEJcuCYPaxX1aNEUsKNx64R3AdAp3eiTRVLc7BGiNzAopz
         ZylKbAqCdmpt6Gu2y4XIUvNUPhvOD7I432IAtQ9RlgdnwRCCXqGUamqQzYZGaJWWoBQo
         xiDJJAw5A+BZSmp2dDLhU4f+9xC8WHY7awIDec56Y5d0LIUNraGSvAEkSqLSUYx8RH6Y
         tqEbk4Fefm9y+debfnA9KBQIBH4w3iDILlxsRmCYWXMCmD06I3G8bMKPCKYQJ77GjRJC
         xWzQ==
X-Gm-Message-State: AOJu0YyUOnHZbZ6gL98c63aKRPj1RRI137LhTlUMoh/csoOzHxeb5Vd7
	XUPEGpJLXOws6K9X4CUJvqWN7Q==
X-Google-Smtp-Source: AGHT+IEvEWXI6dIqqyubaSdXVpCiAsnqONZRtHjYHAk/AXRTB4TASNupTb9yyIN7Duvt4Fpi7tEOyA==
X-Received: by 2002:a05:600c:35c7:b0:406:535a:cfb4 with SMTP id r7-20020a05600c35c700b00406535acfb4mr7250920wmq.1.1698064908221;
        Mon, 23 Oct 2023 05:41:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Oct 2023 14:41:37 +0200
Subject: [PATCH 4/4] ARM: meson: enable USB DFU + RAM on Amlogic boards
 with USB Gadget
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-usb-dfu-boot-v1-4-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=21073;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jzeURTxngYUFbIhD1GsUwZIh7MJLsJqO+eabE7EKn7U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoHGjV8qy0RONoJ0gfeREiH73IWwjm+ZF10P
 LShnPNFRxeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqBwAKCRB33NvayMhJ
 0edcD/9MXgxZdV0hg9iMaBj/vO7/w3zef43S5vMH+YBkETwsSNyOZ9V0KgrCiv4XZscXwtuHMs3
 c5uq4PXbjSEARnwiiCe9IfoV2B+nYvw/0zEuuWwFOZXL4cl+jPfMmYDotWALHMzvJsgxaqKsB+o
 1uHFE/CK/2EbaNNpHSCsc0XCKCHjOY2437OIQ8a1bq8wmqLxmeOSSHhuwpYlsvgIxXtEeH4+7vH
 c5S4Qt76KDNsLfypT5oqe+SW2+zF/v5tTQ86ZnjLmw+ApkuvsfBi62bthAzW6iLhPuhl1jw2qDQ
 rgTLHcTLv19xfaTYFWtXDeFeutKoADEOvQGTzUnc5mArm0RG9cB21XG1tZstgfBelQXIJ/dDgIw
 cQJ+fY4kicGLnbi/SOi9kF9mY7cHagQ4O2IBEh3+oMqrKn0DgI70y7yTMNIizck72WZBObxoExy
 NvxY9fkGAOfHME1rZrEgLbk9AIh0EyhS7k/B64edV59J6YPA9Qw7zugP2F5n7lq8/KveHE+B0/w
 Nlzj01YPNol3/ItT3DjaMUe6P/PAaws+BCmp6l+1lLCVSAX6HtHVcuhnTMTZIEAnY3WIdjwBFzL
 Vz9GEeV+jZF6//8IqTZGp+tD1ysW8i/uoNL3xP30K5Ng3S40oYYR6YSZ2qXg8/VqbtKYMwInH4z
 FLx/CByLq5qEFNQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 12:41:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1793

Enable DFU as an alternate USB boot method when script wasn't
uploaded, this fixes USB full boot on G12/SM1 boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/ad401_defconfig                | 2 ++
 configs/bananapi-cm4-cm4io_defconfig   | 2 ++
 configs/bananapi-m2-pro_defconfig      | 2 ++
 configs/bananapi-m2s_defconfig         | 2 ++
 configs/bananapi-m5_defconfig          | 2 ++
 configs/beelink-gsking-x_defconfig     | 2 ++
 configs/beelink-gt1-ultimate_defconfig | 2 ++
 configs/beelink-gtking_defconfig       | 2 ++
 configs/beelink-gtkingpro_defconfig    | 2 ++
 configs/jethub_j100_defconfig          | 2 ++
 configs/jethub_j80_defconfig           | 2 ++
 configs/khadas-vim2_defconfig          | 2 ++
 configs/khadas-vim3_defconfig          | 2 ++
 configs/khadas-vim3l_defconfig         | 2 ++
 configs/khadas-vim_defconfig           | 2 ++
 configs/libretech-ac_defconfig         | 2 ++
 configs/libretech-cc_defconfig         | 2 ++
 configs/libretech-cc_v2_defconfig      | 2 ++
 configs/libretech-s905d-pc_defconfig   | 2 ++
 configs/libretech-s912-pc_defconfig    | 2 ++
 configs/odroid-c4_defconfig            | 2 ++
 configs/odroid-go-ultra_defconfig      | 2 ++
 configs/odroid-hc4_defconfig           | 2 ++
 configs/odroid-n2_defconfig            | 2 ++
 configs/odroid-n2l_defconfig           | 2 ++
 configs/radxa-zero2_defconfig          | 2 ++
 configs/radxa-zero_defconfig           | 2 ++
 configs/s400_defconfig                 | 2 ++
 configs/sei510_defconfig               | 2 ++
 configs/sei610_defconfig               | 2 ++
 configs/u200_defconfig                 | 2 ++
 configs/wetek-core2_defconfig          | 2 ++
 32 files changed, 64 insertions(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index b9aca3ab0d..c78014ef93 100644
--- a/configs/ad401_defconfig
+++ b/configs/ad401_defconfig
@@ -21,6 +21,7 @@ CONFIG_BOOTCOMMAND="run storeboot"
 CONFIG_SYS_PROMPT="ad401 # "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADB is not set
@@ -34,6 +35,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_LED=y
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index 5fa4b8952a..116147fc9a 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -41,6 +42,7 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 6c16953383..2a3958b0fd 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -37,6 +38,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index eb3bb17c9a..405ce3a93a 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -28,6 +28,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -40,6 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 0895af81be..6de5d5fe7b 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -37,6 +38,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 8cd0cff6ce..99e36e970a 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -36,6 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index 5156dedca8..1313dde92f 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -27,6 +27,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -37,6 +38,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index a5ab9593c9..5c21d8eeab 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -36,6 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index a130479903..37bb4cde79 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -36,6 +37,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index 0fe8e8f0ae..1e6d5c713b 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -30,6 +30,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_RANDOM_UUID=y
 CONFIG_CMD_I2C=y
@@ -43,6 +44,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index f1e0503137..b370e5d1d4 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_RANDOM_UUID=y
 CONFIG_CMD_I2C=y
@@ -44,6 +45,7 @@ CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index d465e7a494..28e9052245 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -28,6 +28,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -40,6 +41,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 2340fbfc3a..5df4b92143 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -28,6 +28,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
@@ -45,6 +46,7 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index ee31c05a13..de8fdd83cc 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -28,6 +28,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
@@ -45,6 +46,7 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index 812baca63c..d27ab6f590 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -28,6 +28,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -38,6 +39,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 4ed04fa518..bc17b423a2 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -45,6 +46,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index 24d2aaf51f..baa9b1b3db 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -27,6 +27,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -37,6 +38,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index fd0323a9b6..ba74b241ab 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -30,6 +30,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -41,6 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 0901ce1b4e..cd138d696e 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -43,6 +44,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index bc63374869..dabb4ca4ec 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -30,6 +30,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -42,6 +43,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 99fa61f069..fe1f861258 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -38,6 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 077c773cee..bc0bf9b896 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -26,6 +26,7 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -41,6 +42,7 @@ CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
+CONFIG_DFU_RAM=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MESON=y
 CONFIG_MMC_MESON_GX=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 2c53f6377c..4316811588 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -29,6 +29,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -45,6 +46,7 @@ CONFIG_SARADC_MESON=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 16a1b532f1..9694f04a66 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -38,6 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_MDIO=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 2ea07552ac..673e0cffb2 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -27,6 +27,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -38,6 +39,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MESON_G12A_USB_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index 365a438c8f..e9415762ff 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -36,6 +37,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 0eba5f5c8a..103ff8a321 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -36,6 +37,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index 0e2ca70da3..8e22c95f88 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -35,6 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_ETH_DESIGNWARE_MESON8B=y
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index e3e1b157d7..c4a49fbd6f 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_BCB=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 # CONFIG_CMD_LOADS is not set
@@ -53,6 +54,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index b417b5db56..ae254c62f2 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_BCB=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 # CONFIG_CMD_LOADS is not set
@@ -53,6 +54,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 3f57e62d46..21c90e7678 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -26,6 +26,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -35,6 +36,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index b4134098cb..9bf3de9e7a 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -27,6 +27,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -37,6 +38,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
+CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y

-- 
2.34.1


