Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.12135.1583142727660991563
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:52:08 -0800
Received: by mail-wr1-f66.google.com with SMTP id j16so11717114wrt.3
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGaio8MgQbEuHSEb1hTwXQiUHz18fZ4buunw/Wx9OJQ=;
        b=SksERBHha77uG2r00GQr5uJ6i07awQhAcxjo6RmUgy8OsdspY/o1eGGvfqUz8bbyGK
         N+JsiMKfkro/WZkjJGmmhi9+9AdZKa/fy2LivxFr0qsqPHabj0U+WveR6JAB7ezllN03
         bR2a1lUT5KQe0isoo8+vstBOgUlOn8+nKyZweMI/JGGmm5Q2eq72uLp2PtfE3yFAnW4e
         K/2cEup9lZLf/VOb72/AMHsfFY1sMBie43L7aVDPxy9BNVr+0RgTnM/+zYyXvierY+NE
         y+9nF56VnQ3tUMmrYlj/SoeIqQyIUAdhNuO8iPqTbiIjl5EgNgZbT51sW2cbjKiPcZMK
         g6zQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: meson: add libretech-pc support
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <20200227112738.494579-1-jbrunet@baylibre.com>
 <20200227112738.494579-7-jbrunet@baylibre.com>
 <d9397867-7071-a387-95d8-fb4ecc9bba96@baylibre.com>
Message-ID: <c1a60140-e340-96fd-3011-187538cfdf75@baylibre.com>
Date: Mon, 2 Mar 2020 10:52:05 +0100
MIME-Version: 1.0
In-Reply-To: <d9397867-7071-a387-95d8-fb4ecc9bba96@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 02/03/2020 10:34, Neil Armstrong wrote:
> On 27/02/2020 12:27, Jerome Brunet wrote:
>> Add support for the Amlogic based libretech-pc platform.
>> This platform comes with 2 variant, based on the s905d or s912 SoC.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm/dts/Makefile                         |  2 +
>>  .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |  7 ++
>>  .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |  7 ++
>>  configs/libretech-s905d-pc_defconfig          | 71 +++++++++++++++++++
>>  configs/libretech-s912-pc_defconfig           | 71 +++++++++++++++++++
>>  include/configs/libretech-pc.h                | 17 +++++
>>  6 files changed, 175 insertions(+)
>>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>>  create mode 100644 configs/libretech-s905d-pc_defconfig
>>  create mode 100644 configs/libretech-s912-pc_defconfig
>>  create mode 100644 include/configs/libretech-pc.h
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 3b8dc2f56fd2..45120d8f20ce 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -137,7 +137,9 @@ dtb-$(CONFIG_ARCH_MESON) += \
>>  	meson-gxl-s805x-libretech-ac.dtb \
>>  	meson-gxl-s905x-libretech-cc.dtb \
>>  	meson-gxl-s905x-khadas-vim.dtb \
>> +	meson-gxl-s905d-libretech-pc.dtb \
>>  	meson-gxm-khadas-vim2.dtb \
>> +	meson-gxm-s912-libretech-pc.dtb \
>>  	meson-axg-s400.dtb \
>>  	meson-g12a-u200.dtb \
>>  	meson-g12a-sei510.dtb \
>> diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..c35158d7e9ee
>> --- /dev/null
>> +++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>> @@ -0,0 +1,7 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include "meson-gx-u-boot.dtsi"
>> diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..c35158d7e9ee
>> --- /dev/null
>> +++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>> @@ -0,0 +1,7 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include "meson-gx-u-boot.dtsi"
>> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
>> new file mode 100644
>> index 000000000000..0dbacf60046a
>> --- /dev/null
>> +++ b/configs/libretech-s905d-pc_defconfig
>> @@ -0,0 +1,71 @@
>> +CONFIG_ARM=y
>> +CONFIG_SYS_CONFIG_NAME="libretech-pc"
>> +CONFIG_SYS_BOARD="q200"
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_SYS_TEXT_BASE=0x01000000
>> +CONFIG_MESON_GXL=y
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_DEBUG_UART_BASE=0xc81004c0
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_IDENT_STRING=" libretech-s905d-pc"
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_PREBOOT="usb start"
>> +CONFIG_MISC_INIT_R=y
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +# CONFIG_CMD_BDI is not set
>> +# CONFIG_CMD_IMI is not set
>> +CONFIG_CMD_ADC=y
>> +CONFIG_CMD_GPIO=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_SF=y
>> +CONFIG_CMD_SF_TEST=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905d-libretech-pc"
>> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DM_KEYBOARD=y
>> +CONFIG_DM_MMC=y
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_MTD=y
>> +CONFIG_DM_SPI_FLASH=y
>> +CONFIG_SPI_FLASH=y
>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH=y
>> +CONFIG_ETH_DESIGNWARE=y
>> +CONFIG_PHY=y
>> +CONFIG_MESON_GXL_USB_PHY=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_GXL=y
>> +CONFIG_POWER_DOMAIN=y
>> +CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_DEBUG_UART_MESON=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_DEBUG_UART_SKIP_INIT=y
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_SPI=y
>> +CONFIG_DM_SPI=y
>> +CONFIG_MESON_SPIFC=y
>> +CONFIG_USB=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_XHCI_DWC3=y
>> +CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_KEYBOARD=y
>> +CONFIG_DM_VIDEO=y
>> +CONFIG_SYS_WHITE_ON_BLACK=y
>> +CONFIG_VIDEO_MESON=y
>> +CONFIG_VIDEO_DT_SIMPLEFB=y
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
>> new file mode 100644
>> index 000000000000..63b44b389be6
>> --- /dev/null
>> +++ b/configs/libretech-s912-pc_defconfig
>> @@ -0,0 +1,71 @@
>> +CONFIG_ARM=y
>> +CONFIG_SYS_CONFIG_NAME="libretech-pc"
>> +CONFIG_SYS_BOARD="q200"
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_SYS_TEXT_BASE=0x01000000
>> +CONFIG_MESON_GXM=y
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_DEBUG_UART_BASE=0xc81004c0
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_IDENT_STRING=" libretech-s912-pc"
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_PREBOOT=y
>> +CONFIG_PREBOOT="usb start"
>> +CONFIG_MISC_INIT_R=y
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +# CONFIG_CMD_BDI is not set
>> +# CONFIG_CMD_IMI is not set
>> +CONFIG_CMD_ADC=y
>> +CONFIG_CMD_GPIO=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_SF=y
>> +CONFIG_CMD_SF_TEST=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-s912-libretech-pc"
>> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DM_KEYBOARD=y
>> +CONFIG_DM_MMC=y
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_MTD=y
>> +CONFIG_DM_SPI_FLASH=y
>> +CONFIG_SPI_FLASH=y
>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH=y
>> +CONFIG_ETH_DESIGNWARE=y
>> +CONFIG_PHY=y
>> +CONFIG_MESON_GXL_USB_PHY=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_GXL=y
>> +CONFIG_POWER_DOMAIN=y
>> +CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_DEBUG_UART_MESON=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_DEBUG_UART_SKIP_INIT=y
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_SPI=y
>> +CONFIG_DM_SPI=y
>> +CONFIG_MESON_SPIFC=y
>> +CONFIG_USB=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_XHCI_DWC3=y
>> +CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_KEYBOARD=y
>> +CONFIG_DM_VIDEO=y
>> +CONFIG_SYS_WHITE_ON_BLACK=y
>> +CONFIG_VIDEO_MESON=y
>> +CONFIG_VIDEO_DT_SIMPLEFB=y
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> diff --git a/include/configs/libretech-pc.h b/include/configs/libretech-pc.h
>> new file mode 100644
>> index 000000000000..182eba519d51
>> --- /dev/null
>> +++ b/include/configs/libretech-pc.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Configuration for LibreTech AC
>> + *
>> + * Copyright (C) 2020 Baylibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#ifndef __CONFIG_H
>> +#define __CONFIG_H
>> +
>> +#define CONFIG_ENV_SECT_SIZE	0x10000
>> +#define CONFIG_ENV_OFFSET	(-0x10000)
>> +
>> +#include <configs/meson64.h>
>> +
>> +#endif /* __CONFIG_H */
>>
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

The defconfig fails with :
scripts/kconfig/conf  --syncconfig Kconfig
.config:164:warning: symbol value '' invalid for ENV_SECT_SIZE
.config:165:warning: symbol value '' invalid for ENV_OFFSET

for both configs on master.

Neil
