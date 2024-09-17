Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05669C3601F
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 12:34:59 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.19742.1726576493821759550
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Sep 2024 05:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tohctgSx;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374bfc395a5so3595357f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726576492; x=1727181292; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJrg2ShcpGeoJr2BRuQhpu5iq0h9WOCdFu465pSgpys=;
        b=tohctgSxn+VCs70bgnwrMdryi7bWb5FEnGQJsFNBUnrignO9kUvPh7+HyxZG+Wow3e
         SLpUHQsF7Ui2050EYRT+Gq/88EuHGjVi8+zWtxSXVZ59D9Tegvq5bbz/Q7CNYzODoUle
         2boc5n94GlUIX1gX0SlFGtS+4FEoVY02rV7GaxlpIo/dfSNncuh1YF4A23EyrR8QfxtA
         zOTGTMEZOlXOWY3yt7SOgN0Vu8v8KP/CUDf9h5pK2U4A5x7IeE5r/dfNefzw/p7fAQsA
         GS2k7JA/guSzQblOojGC2cH9cdqzOLq2DPxzdjLpPfavvmMjWyuQNsqqLyeaN2j6KgI1
         /jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726576492; x=1727181292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJrg2ShcpGeoJr2BRuQhpu5iq0h9WOCdFu465pSgpys=;
        b=bY+z2qYZyHugOErDK4eVOnVATQtRob0sDKxk1aS9OIDfzV1FbgAD88uIIzmhIqwGCQ
         T9NZUk6f1UwblO3+yYvbH2VhsKrDi2QVwaLjpEZwvLFEbpr1LYbCEnV4PsDv+3BYI+tu
         46q50jHtaOH6FFRMTIeWh5qtgywC2cYcI8y3jcP2lmigGqpHugcg3LQuccvgDe9Wx/+s
         ByXjpMXkGQaNSWi7vgX89wPXXopb0vhqelyYe79z5VfaDmv4Eab+H0u6JwNwpZ4qjk7q
         7YbmKu8PwcZlY3xi+uhOLEYUTTGHmpzYCJ5aNXkDqlV4SzqQKjVZKWpzZC8/uuZeDTa2
         Pl4w==
X-Gm-Message-State: AOJu0Yyrvrv43cEKDI/YC9ynMmf2R86K+06B9RpYiyxiPBK5viVzjwG4
	dXgLvHdplp80yKe85ByKGIv8j8lbY0LRUuuv74/vDnxcYsNx3bo2vqxQZ8JuAAk=
X-Google-Smtp-Source: AGHT+IEr3EoxWGvHuhBYbo6cZ7OYOEf8eCwZvMmcd9BgvhEnuAoSmpX4Weip1PZM2N41klJ/Uu1sFA==
X-Received: by 2002:a05:6000:1249:b0:374:c400:8556 with SMTP id ffacd0b85a97d-378c27a8a80mr10214214f8f.11.1726576492079;
        Tue, 17 Sep 2024 05:34:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Sep 2024 14:34:46 +0200
Subject: [PATCH v2 2/2] board: libre-computer: aml-s805x-cc: Enable capsule
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-2-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3593;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zPvetaBnOXIbwLciZ582jmJJxdSfwJxTLM7x5mHwgFs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdoaNLyaTdYxEmyzmMqLRFS57XgKpKPFqjoKcxS
 LiH0Vh+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3aAAKCRB33NvayMhJ0XsLD/
 oCm3/Imtrd3QplxZRmxzJ/Lx58OEbwSkyn4FY+0zY2adP4e8WfoFkVM7fooJjvODV44c4tkJrxuIkm
 h1pdCD0C5Pva7yLHEKBSDfHcV5fzoTT1hAdVv5vYGdrAoOHK1mkqbjpxtRFyaMKeiGiZb6ZzMSRvA+
 LzoZwHcmnYjlbAvlsyYtDaqh9qQPBwzFYhnnQ9oJ9PcJ3iZeVGycKIgp4TKRPcKeP3UxIQ9d8HBEV1
 5+TJarMPT7Jaa2xgoKM2bVcKDPcp2mVeysC8R3hNHCorKnY+MSPNI3Zu20eYVx1xuMBvnLi2Pl5q+g
 60B1jM5H6xHL5jMU84w1IUiZgluXm0iH/O/mr/3eUMmhWHjoAWzAzt6jxIrfu1M5SPcd9a6X1luxzk
 E+m4qI4A1czl4kCv5ZQAVDrrblAnP1s/icb/U1IUkgPj0UPeUHROepsOm2ou0F8Tx+kiiHBe9x00X/
 ecFDDRx6xR7Jsr6pxvkR8eppJf8XRqqQmVMEq6Mc/QvjAZvDfafuyRaDaFPJId9FM97rzuQNSVFMkn
 x5UNKAPSGAyt5fwJcDtLUXKd3HzPYH9bx6bNntvDXa1eZjcU839MBMl4WFB9Zrkpz2rON4/rtluhJd
 tlqXY5wE/fnSBSMyg6BHNeEgKZAwYA8gFRnPaFEw/Id2CAnqC6s5xT+UrS3w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 12:34:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2393

Since the aml-s805-cc works well using EFI, and now the capsule updates
backend has been merged, let's enable the missing configs and add
the required structures to support it.

The GUID is dynamically generated for the board, to get it:
=> efidebug capsule esrt
========================================
ESRT: fw_resource_count=1
ESRT: fw_resource_count_max=1
ESRT: fw_resource_version=1
[entry 0]==============================
ESRT: fw_class=B8079027-9B2C-57D4-86AA-CC782ADA598C
ESRT: fw_type=unknown
ESRT: fw_version=0
ESRT: lowest_supported_fw_version=0
ESRT: capsule_flags=0
ESRT: last_attempt_version=0
ESRT: last_attempt_status=success
========================================

On the host (with the aml_encrypt_gxl result binary):
$ eficapsule --guid B8079027-9B2C-57D4-86AA-CC782ADA598C -i 1 u-boot.bin u-boot.cap

On the board (from USB disk containing u-boot.cap at root):
=> load usb 0:1 $kernel_addr_r u-boot.cap
=> efidebug capsule update $kernel_addr_r

The binary will then be flashed on the SPI.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 24 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index ae9834c0bf8..94cf5b4361f 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
+#include <efi_loader.h>
 #include <asm/io.h>
 #include <asm/arch/gx.h>
 #include <asm/arch/sm.h>
@@ -19,6 +20,29 @@
 #define EFUSE_MAC_OFFSET	52
 #define EFUSE_MAC_SIZE		6
 
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"AML_S805X_AC_BOOT",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (strcmp(interface, "ram") == 0)
+		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
+	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE + 1];
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 11d9795e05d..7763a14f203 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -35,6 +35,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
 CONFIG_CMD_DFU=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -42,6 +43,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -49,6 +51,8 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -98,3 +102,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
2.34.1


