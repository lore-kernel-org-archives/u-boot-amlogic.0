Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D9C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:34 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74.1786986993962037367
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=Izuzl9S3;
 spf=pass (domain: brivo.com, ip: 209.85.160.171, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0cea8883so1139251cf.1
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986993; x=1787591793; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yJL5ss0VBzVj2bWTp6HWDKn9SEg50i2kaiZJGaTw1w=;
        b=Izuzl9S3UmKPl8WqoFFnkZ9+Nw5Lg5kpWVSKNULLV5/jZSQaYWKA1IIxW2D7pYTDYn
         roZJ4G6CAvGXTHFOTjSBCJre24JqQuBg+N/hP8VfTRZ5cq9U5KFUKcFgsVBMDWh9+emc
         xZprZx1kwhEyN1lzNRkWEBa2++Sg4rt0Mk+08tRnZWLd1ahTva0l4UJ4FiyFVgXfJSuk
         upV3/1/hHsbFwmgtdzAsz+7ggPSQVjG3IFpMQ7H/j4JZa0zAndgvVA94T04SUZyg6CHc
         xGFRstwnHGFlRfcVhD2NyM1qGOEdiD4qmsU9gh2ddkXw2flO+oI/38uLiKWMaexcAYqM
         qcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986993; x=1787591793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yJL5ss0VBzVj2bWTp6HWDKn9SEg50i2kaiZJGaTw1w=;
        b=A7OCXaNFmknxgTACY+AmJmUpKWPloM3yCurITRKYtHnEZk0NGxaIY2wq5VVE5WsoVy
         mHSh51J5fonsNI1lcTwvfCQG5lrlEjg6cvi1gt5LMSDljE8xu1YZ4aP2OVJIIItV8Mw3
         K/rL9Rp7Q6pdVHkaSFtzuIZvTu591HwiE5qbwovGV3XWeAH62cvPSowHtGfvhv3Mmc2S
         JUy+ogDiIo+LdLEfogNXddXn1fRYJp7BsZADGJE7sP9xX2qRi7IOjuNHY8B+gOWp3lzt
         VLFN+8jSwVs+T1fv1sJ2UEAqN8XXxuV2Bq4kJhBE/v4vWrfGhbSrHMAbOBfPBoCuVLHa
         MzrQ==
X-Gm-Message-State: AOJu0Yz83M9CgYLSFJAZUcKf2RUxg2TObDANaVKpFcKbMcWbIDrJTTIG
	elW8gZAu7Bv9/fiNfCmDBVJZ/mLk0QhTn4BJIZdGoXbRfGeuxI0TbdepGz3ax2RJdHK+mh0+zdQ
	w3zkuL3SVaYo/Fz+rXFftmxRCSbjFZrbzRbplg/PbRfe5Z24w4GfYfA==
X-Gm-Gg: AR+sD10Yz1OcUPNojV/fuznVryzQJ6Jn71xQyl5vab9ZQmyk+CYfUtTBx0QbCtqawIR
	36qS5vEiBydU2s2CrlldQwuqv5HQJ5RIz/Qyd0iRaX//+p/u5CGXYXTyTNm1UvqSkgfI7w8Ycnr
	jR2NDMd/1antbp+YuOB6zhBx6aEjbbHiWGkg/1dd1QRGcNfWDblVKcSzp4rafDLlI30QFWPYAj/
	/1pbqpvPCz443JbpkBypKVVAAujGYZQm3MfXRobRfPJG76hXDOXlbIxe6zM1Xd93plus8mc+7za
	a+3aR8DhCrrS2KXfjbqUrFtUgJmfBoW7ztwEERBxGNUnv3RGnV2CDyFGFOosWPMnWxxDkhFjQUG
	UtzXic/1g3HLKX34llTeXPBpqvPfYVkBYMT2tqm4SzZ+XetvaOD9TRJuOjaLVT9GHTHyW4CjmxO
	i2SHOotwuUtViB/8RefRhqJ3CY/o9tMRsBsTpZ4xZrfwUrrsenKod+I6u1jaaOcATSAXR7zY6Tp
	e+rlMUjlAneR0y/loWvZ5QHtlk=
X-Received: by 2002:a05:622a:181c:b0:528:317d:eaf3 with SMTP id d75a77b69052e-52dbed1f1c5mr7956411cf.6.1786986992612;
        Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 9/9] [RFT] meson: Add Khadas VIM1S support
Date: Mon, 17 Aug 2026 13:15:20 -0400
Message-ID: <20260817171623.1943847-10-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3032

This adds basic support for the Khadas VIM1S [1]. I built this config on
a custom board, and I don't even own a vim1s. Please test!

[1] https://www.khadas.com/vim1s

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 board/amlogic/q200/MAINTAINERS |  1 +
 configs/khadas-vim1s_defconfig | 80 ++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 configs/khadas-vim1s_defconfig

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index aece8d5e05c..5281e06f3cc 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -5,6 +5,7 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
 F:	include/configs/q200.h
 F:	configs/beelink-gt1-ultimate_defconfig
+F:	configs/khadas-vim1s_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
 F:	configs/libretech-s912-pc_defconfig
diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
new file mode 100644
index 00000000000..143425cd2ca
--- /dev/null
+++ b/configs/khadas-vim1s_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="q200"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x0
+CONFIG_SYS_MALLOC_LEN=0x8000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_MESON_S4=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_IDENT_STRING=" vim1s"
+# CONFIG_PSCI_RESET is not set
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+# CONFIG_DISTRO_DEFAULTS is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="root=/dev/mmcblk1p2 ro rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="load mmc 1:1 $loadaddr linux.itb && bootm"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=32
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_WDT=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_PXE=y
+# CONFIG_CMD_DATE is not set
+CONFIG_CMD_RTC=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_ISO_PARTITION=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_MESON=y
+# CONFIG_INPUT is not set
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PHY_MESON_GXL=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_S4=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1337=y
+CONFIG_RTC_DS1337_NOOSC=y
+CONFIG_BAUDRATE=888888
+CONFIG_MESON_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MESON_GXBB=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.53.0


