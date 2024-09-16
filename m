Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31057C3ABA2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.4803.1726479716361453637
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 02:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=b1xPdVG0;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so41757575e9.1
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726479715; x=1727084515; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXhkHhavhOUcV2XIl92zcF8hBcWoeJ6wr38Qdh/V28Q=;
        b=b1xPdVG0i5XdWrKxF3tfeiI6j/mx1du/EkAP0aotO+jykKw9V5J1sydL3jfjiwlLys
         oaB6g8LJkYvUjwvU+813ZU/vLu+Yjaj8EC3AgaP/M0FeLwX7HdNxtQQ1bG6ce9MFhfXG
         0kFRI1B/qzr+q89g8+7Tbuyn+ss+qz4gA9TPSIdKmqcpaT1gjVnO6KlJ/kyELuOlPY2m
         PO9/KylOi9/qAGOVIQhmy2HZlArbioNqsOiXWiy9LbuyXVm4OQlw239f1Jwn0RQrf2IG
         UB+Jk1Zo3mEZN9E9hY2ig0JiiQgTHXPsKFAKx8B54q/2/AuCMBROHrVtnSlF6QEIl7fY
         HASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726479715; x=1727084515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXhkHhavhOUcV2XIl92zcF8hBcWoeJ6wr38Qdh/V28Q=;
        b=YgTU2vwtb8rwTLIdpRkKSLzkGnplMRrJf5tVAAcuLEcR/c3S+Erbr3BnMZTtKCHxOT
         lFFpunR7jGGGhfWzW969i2ikOTnN2ngJ7iFa/+RUig/78rpNn89p2XGYbrzCjFtcG6lD
         je507VLyZnFwp3q86o2AS4K4rST+S57sdEJTWn+3QPMCZUa7au4UJ2bAcpzWm3Ie3dTf
         4f3n2Ok+sEL0ltdEHlPAYHipLgfIThFxoOPl2Fj+na3q0IdbrrJ2fcsV6t1PkMZsGWVi
         eRdARl0nRb//lzpHkfIFgvDiTWn4NeTde/ju8G2VaIi2goDSV3Nl9wQCHwPBZrC2rOZX
         lHPw==
X-Gm-Message-State: AOJu0YwIQ06xnWNxc0UjbNa//HiQOxd45zUuUUB3ZfVYsjGr0gZQXNO/
	eKfwecbW7auoCjqUGmeLDYIJJi+SlLC7P2ZOnmz/EURXGaOi39cKCPcBnhwIQ4HWWmmXiWGSS40
	u
X-Google-Smtp-Source: AGHT+IHWCqwszPvczoyY20PL+XKIgrm8QOpBjniOe6+r8Mt1/HsjHZtEYDaXmULLQ6oTQ270T2KyQg==
X-Received: by 2002:a05:600c:1d84:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42cdb539e84mr125983195e9.13.1726479714619;
        Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 11:41:49 +0200
Subject: [PATCH 2/2] board: libre-computer: aml-s805-cc: Enable capsule
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=o7r6FW1caQIgnnPyt9ucbd3e0OvrsME6kk385uYnm8s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1f/bRi8MTXgfCO9XfMI3zP0d4Fh9YyBpxnieIV
 bcvwU66JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XwAKCRB33NvayMhJ0UmVEA
 DFEv63ttwwp/xr0NKOPjXDwI7urvHYtxgmSbTq3jnrhcKaeN89YfahBOxGq5YyfuilaXfVBqerhwY1
 IG1N1wSPrd3jb+vU8nbqBsdjZWjQZ13CprhT3sHIZ7WiPf1lpdejQhvCWXLqPiQVu32OpQ5pUXftIU
 Lgs4leNMP+dLgaAE7Ez8tqqM94R5p/UOaLARW5JfzLwIBzJZMWNZqQa/u/kEacLS+7lfiuShdcgeVA
 FQjtC+vwPjGXZvmRuK5OU37uztah4jzY4ndY23Ujrj2FC/U7QRJeLkXFeveObER+zVA1k2lFhRnmjY
 96F74W70pWFVkFHSP/i+9XlQUy7s/gAIOzgHPkOMuolFK4vgObDu4rEDulxR2f8yldOB/GnAmfuan+
 sa/ZTFI6iBegLZpWpQ1SQwiiieA0aJJ3+BrVF1zBeuHTAusXwSsN0EnwC5baiHxdkv+X3MaeC4oCC/
 tdLutDtvi92fwhtlV1MrosKaCBJv8qcsKT77T0ucxKv5iyNu4FnjNp/UUVwUQ0sppFmc7mrHm+1p2B
 Rr7xZcCSGXLQgHiwLcOy+J55sMcscbLs5QeosHedc6Acpxzq8uZOmYzBYlqQ2zVbcqAxYq2TegSuE1
 Xm9KkMNM8dy61lr6IbiZkTGif/Ffp0UZVlJbykYDPVamOuEFbAx55PnwmNJQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 09:42:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2389

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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 14 ++++++++++++++
 configs/libretech-ac_defconfig                   |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index ae9834c0bf8..ba14df54967 100644
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
@@ -19,6 +20,19 @@
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
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE + 1];
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 11d9795e05d..f146a495654 100644
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
@@ -49,6 +51,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -98,3 +101,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
2.34.1


