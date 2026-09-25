Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CBC98324
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8355.1790343752484972320
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 06:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=IS4pyHtV;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49febbce9afso5989495e9.3
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790343751; x=1790948551; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
        b=IS4pyHtVW9bkC8KThA/u/vquiIK9tVPA7237AhsJvEUgFSJpIsKfqpMvGKQg2xmNNd
         fPi7xi/8tH5ofrRL9OiKGBlGTtiKC4LdIlgiiQn9OzXSdTIk/AGc/ltRgLE+LINkECJh
         GZ5OGUwblPglcFTprB7aJWuJSuSAN66n7TqgtTiyDKIOTMvDxLOTlHXPSIwkgAF6w8PN
         PAZh0WRDnhXbcqbz/GxbR3UFvFuNo1lE3Cv6PsEQr5Mi1FE2RjZ7QHUdWCEYnCJk/80j
         75Jh9u6yKFAfqMeN/BM1mtSYmwZEHe7SHgi4xkefAmPnXDGZwxEQ8cIx/Ck+LDcumc8p
         SHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343751; x=1790948551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
        b=KcL1t5CWM4bvrOf61jrFdLkHMawYa8P3Lm5mhv5EWhV13NFja17rkabsHX1xFnCXet
         iudjgCNOeA3SR+EaIeYOTIEqJcK0NMsmQOvDTwbmIdOnF3Kh3LDGF2074k314L/Y4TXk
         7w7F3QliXWRkjE0aNQvE9hzyEuy8fNinymic7oKfUCU7vofs12Lh79f9uLNTyfkQEAA8
         Z+RshJH3HZqWO9pXsvRdkl3nkihuLdFJeBZF2+NEpcMaAe/RS7qoUmrSut0ngORj5oNO
         zJrmypgzRFQWe+3vsiCFgmh1Jy0BN/AAwtlyjIyME5zPojEnmgRJbBLwjpAI/bGTyPBX
         oHJQ==
X-Gm-Message-State: AFuF++lUaIIszNDpb1f5WgVQkBzEFi9xxJudp4dlxMUGZlX01DLVJdab
	cqKPgoE7XxgqoEgUZvFh1rGZAVipK3XGWcS7RfuMWkUFcFX4CoRqDUMYmJcioGQ2Ioe2aLdPSiO
	xiqgHgGo=
X-Gm-Gg: AYBFou0dKZ+2H7D0YtiTWm837doK67uVDJImkXfY1wsHPq9cMS6rFsv9HrF8AmVEh0Y
	kf5z/ryT9KacqzCzqPKTBqNsfqhMNp2JzxkwqAavXDZQLZ1hytnD/OplmizZRZ3bbrlrMxsstSw
	tAzEfL7u41F96kqsED1Dc6ZwE8QvVszTA0ZCoCLsp0Rd/2LM4gK7jGFEaIzeKdpAJN7N9PgIzZM
	Aa77mSLMmMjzTrnKQHyPuMJRdTuyYbWF5z9RX8mNe916l+UpZBrLxiecRonVHwokLgvzYV+T3wd
	1iWeVF/Bl38pG+/UV3lUOKnHHtDK4mnQD6pIEB0vYaZMyfvLKBORS1HetMNIV+R7NYNVjYbc3dt
	ESKMhpBhLDMYfPvR/tKsGIjE4DYkSsB4Rj+mWSLuyGTi2Pxt3Z4Ow0Zr4EUy1t7A1SHk4z9LPyw
	OsYFG/jRfnvjOkkRdXVge+NCZwJbzBo+MxYVSt8GEhYtXsfyfjQLRzUHnzrCwd
X-Received: by 2002:a05:600c:c16d:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49fe66d6c90mr100600895e9.15.1790343750695;
        Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:24 +0200
Subject: [PATCH 1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-1-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 13:42:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3096

Android support for VIM3 and VIM3L is maintained with the A/B layout
used by the AOSP builds. Remove the unused non-A/B defconfigs and
their MAINTAINERS entries.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS         |   2 -
 configs/khadas-vim3_android_defconfig  | 122 ---------------------------------
 configs/khadas-vim3l_android_defconfig | 122 ---------------------------------
 3 files changed, 246 deletions(-)

diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
index c5f8d9cc5ce..a9b977646c5 100644
--- a/board/amlogic/vim3/MAINTAINERS
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -4,10 +4,8 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim3/
 F:	configs/khadas-vim3_defconfig
-F:	configs/khadas-vim3_android_defconfig
 F:	configs/khadas-vim3_android_ab_defconfig
 F:	configs/khadas-vim3l_defconfig
-F:	configs/khadas-vim3l_android_defconfig
 F:	configs/khadas-vim3l_android_ab_defconfig
 F:	doc/board/amlogic/khadas-vim3.rst
 F:	doc/board/amlogic/khadas-vim3l.rst
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
deleted file mode 100644
index 1d518581605..00000000000
--- a/configs/khadas-vim3_android_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_BOARD="vim3"
-CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
-CONFIG_ARCH_MESON=y
-CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_LEN=0x08000000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_DM_RESET=y
-CONFIG_MESON_G12A=y
-CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_DEBUG_UART_BASE=0xff803000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_IDENT_STRING=" khadas-vim3"
-CONFIG_PCI=y
-CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTMETH_ANDROID=y
-# CONFIG_BOOTMETH_EXTLINUX is not set
-# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
-# CONFIG_BOOTMETH_EFILOADER is not set
-# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
-# CONFIG_BOOTMETH_VBE is not set
-CONFIG_OF_BOARD_SETUP=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
-CONFIG_SYS_MAXARGS=32
-# CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-# CONFIG_CMD_LOADS is not set
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_SF_TEST=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ADC=y
-CONFIG_SARADC_MESON=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_ADC=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x6000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MESON=y
-CONFIG_MMC_MESON_GX=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_DM_MDIO=y
-CONFIG_DM_MDIO_MUX=y
-CONFIG_ETH_DESIGNWARE_MESON8B=y
-CONFIG_MDIO_MUX_MESON_G12A=y
-CONFIG_PHY_REALTEK=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_MESON=y
-CONFIG_MESON_G12A_USB_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MESON_G12A=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_EE_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_MESON_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MESON_SPIFC=y
-CONFIG_SYSINFO=y
-CONFIG_SYSINFO_SMBIOS=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_MESON_G12A=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
-CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP16 is not set
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_VIDEO_MESON=y
-CONFIG_VIDEO_DT_SIMPLEFB=y
-CONFIG_SPLASH_SCREEN=y
-CONFIG_SPLASH_SCREEN_ALIGN=y
-CONFIG_VIDEO_BMP_RLE8=y
-CONFIG_BMP_16BPP=y
-CONFIG_BMP_24BPP=y
-CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
deleted file mode 100644
index 37a1d86a233..00000000000
--- a/configs/khadas-vim3l_android_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_BOARD="vim3"
-CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
-CONFIG_ARCH_MESON=y
-CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_LEN=0x08000000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_DM_RESET=y
-CONFIG_MESON_G12A=y
-CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_DEBUG_UART_BASE=0xff803000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_IDENT_STRING=" khadas-vim3l"
-CONFIG_PCI=y
-CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTMETH_ANDROID=y
-# CONFIG_BOOTMETH_EXTLINUX is not set
-# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
-# CONFIG_BOOTMETH_EFILOADER is not set
-# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
-# CONFIG_BOOTMETH_VBE is not set
-CONFIG_OF_BOARD_SETUP=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
-CONFIG_SYS_MAXARGS=32
-# CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-# CONFIG_CMD_LOADS is not set
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_SF_TEST=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ADC=y
-CONFIG_SARADC_MESON=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_ADC=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x6000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MESON=y
-CONFIG_MMC_MESON_GX=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_DM_MDIO=y
-CONFIG_DM_MDIO_MUX=y
-CONFIG_ETH_DESIGNWARE_MESON8B=y
-CONFIG_MDIO_MUX_MESON_G12A=y
-CONFIG_PHY_REALTEK=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_MESON=y
-CONFIG_MESON_G12A_USB_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MESON_G12A=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_EE_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_MESON_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MESON_SPIFC=y
-CONFIG_SYSINFO=y
-CONFIG_SYSINFO_SMBIOS=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_MESON_G12A=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
-CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP16 is not set
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_VIDEO_MESON=y
-CONFIG_VIDEO_DT_SIMPLEFB=y
-CONFIG_SPLASH_SCREEN=y
-CONFIG_SPLASH_SCREEN_ALIGN=y
-CONFIG_VIDEO_BMP_RLE8=y
-CONFIG_BMP_16BPP=y
-CONFIG_BMP_24BPP=y
-CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y

-- 
2.34.1


