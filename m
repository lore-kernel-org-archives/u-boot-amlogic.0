Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.67853.1679561561920601197
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:52:42 -0700
Received: by mail-wm1-f44.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so625663wmb.5
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561560;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uX5+EAiKsGT9sluLIN06JKeRP+MvBK3QL/psIZnk0Sc=;
        b=E3vGviFn/xckBXUMuGxf9uSu7bGjURm+Kod0KAj3sII9zOgWyeT63vxQdcpoAneDw9
         o2IZmuc/sGdH1tW3reYGdkUCmZPehYXr4C3U4MzER7gvZrA0FErate2vna8saZDHUpra
         6xtrNM64h55kTM98k+YSOQNG3edyPoBtlxwM3h6z4+knjupLTqP1OqA3AcqpLWc2gO++
         gyCg/8Ak1+YTofBqQRrQCIMctqXpeHWDWEZz6OSw4aExRM96l09mHT28tlqDBh4VdXub
         PM1dN2ilFFYTmyVcB1h37IWHf0+u6mp8pCGptbKQqyq4pzy3Yjv59/lNeNPWydtaywIe
         QmTg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <28326108-e43b-3aeb-43b0-18342faa4b9c@linaro.org>
Date: Thu, 23 Mar 2023 09:52:39 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 12/13] boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <174EF9F0421CB2CD.22739@groups.io>
 <61A15528-D55A-413A-ACCC-CFCE6422DFCA@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <61A15528-D55A-413A-ACCC-CFCE6422DFCA@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com
Cc: u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 08:04, Christian Hewitt wrote:
> 
> 
>> On 23 Mar 2023, at 10:54 am, Christian Hewitt via groups.io <christianshewitt=gmail.com@groups.io> wrote:
>>
>> Add configurations for the WeTek Hub and WeTek Play2 boards along
>> with files for the wetek-gxbb board family to ensure the ethernet
>> MAC is correctly discovered. Set myself as the maintainer for the
>> board family.
> 
> ^ should read just "Add configurations for the WeTek Hub and WeTek Play2
> boards” as the board-family changes were dropped (not needed). I can
> send a v2 for this patch alone (or would you prefer the series?)

Please send a v2 of the whole serie including the doc fixes!

Thanks,
Neil

> 
> Christian
> 
>>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> board/amlogic/p200/MAINTAINERS |  2 +
>> configs/wetek-hub_defconfig    | 70 ++++++++++++++++++++++++++++++++++
>> configs/wetek-play2_defconfig  | 70 ++++++++++++++++++++++++++++++++++
>> 3 files changed, 142 insertions(+)
>> create mode 100644 configs/wetek-hub_defconfig
>> create mode 100644 configs/wetek-play2_defconfig
>>
>> diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
>> index 33ca3df5c6..264218e3be 100644
>> --- a/board/amlogic/p200/MAINTAINERS
>> +++ b/board/amlogic/p200/MAINTAINERS
>> @@ -7,6 +7,8 @@ F:	board/amlogic/p200/
>> F:	configs/nanopi-k2_defconfig
>> F:	configs/odroid-c2_defconfig
>> F:	configs/p200_defconfig
>> +F:	configs/wetek-hub_defconfig
>> +F:	configs/wetek-play2_defconfig
>> F:	doc/board/amlogic/p200.rst
>> F:	doc/board/amlogic/nanopi-k2.rst
>> F:	doc/board/amlogic/odroid-c2.rst
>> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
>> new file mode 100644
>> index 0000000000..634833f7fe
>> --- /dev/null
>> +++ b/configs/wetek-hub_defconfig
>> @@ -0,0 +1,70 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_TEXT_BASE=0x01000000
>> +CONFIG_SYS_LOAD_ADDR=0x1000000
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_ENV_SIZE=0x2000
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DEBUG_UART_BASE=0xc81004c0
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_IDENT_STRING=" wetek-hub"
>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>> +CONFIG_OF_BOARD_SETUP=y
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_MISC_INIT_R=y
>> +# CONFIG_CMD_BDI is not set
>> +# CONFIG_CMD_IMI is not set
>> +CONFIG_CMD_ADC=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_MESON=y
>> +CONFIG_DM_MMC=y
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH=y
>> +CONFIG_ETH_DESIGNWARE_MESON8B=y
>> +CONFIG_PHY=y
>> +CONFIG_MESON_GXBB_USB_PHY=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_GXBB=y
>> +CONFIG_POWER_DOMAIN=y
>> +CONFIG_MESON_EE_POWER_DOMAIN=y
>> +CONFIG_DM_REGULATOR=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_DEBUG_UART_SKIP_INIT=y
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_SYSINFO=y
>> +CONFIG_SYSINFO_SMBIOS=y
>> +CONFIG_USB=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB_DWC2=y
>> +CONFIG_USB_KEYBOARD=y
>> +CONFIG_VIDEO=y
>> +# CONFIG_VIDEO_BPP8 is not set
>> +# CONFIG_VIDEO_BPP16 is not set
>> +CONFIG_SYS_WHITE_ON_BLACK=y
>> +CONFIG_VIDEO_MESON=y
>> +CONFIG_VIDEO_DT_SIMPLEFB=y
>> +CONFIG_SPLASH_SCREEN=y
>> +CONFIG_SPLASH_SCREEN_ALIGN=y
>> +CONFIG_VIDEO_BMP_RLE8=y
>> +CONFIG_BMP_16BPP=y
>> +CONFIG_BMP_24BPP=y
>> +CONFIG_BMP_32BPP=y
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
>> new file mode 100644
>> index 0000000000..6d33b09a94
>> --- /dev/null
>> +++ b/configs/wetek-play2_defconfig
>> @@ -0,0 +1,70 @@
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_TEXT_BASE=0x01000000
>> +CONFIG_SYS_LOAD_ADDR=0x1000000
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_ENV_SIZE=0x2000
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DEBUG_UART_BASE=0xc81004c0
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_IDENT_STRING=" wetek-play2"
>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>> +CONFIG_OF_BOARD_SETUP=y
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_MISC_INIT_R=y
>> +# CONFIG_CMD_BDI is not set
>> +# CONFIG_CMD_IMI is not set
>> +CONFIG_CMD_ADC=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> +CONFIG_NET_RANDOM_ETHADDR=y
>> +CONFIG_SARADC_MESON=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_MESON=y
>> +CONFIG_DM_MMC=y
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH=y
>> +CONFIG_ETH_DESIGNWARE_MESON8B=y
>> +CONFIG_PHY=y
>> +CONFIG_MESON_GXBB_USB_PHY=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_GXBB=y
>> +CONFIG_POWER_DOMAIN=y
>> +CONFIG_MESON_EE_POWER_DOMAIN=y
>> +CONFIG_DM_REGULATOR=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_DEBUG_UART_SKIP_INIT=y
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_SYSINFO=y
>> +CONFIG_SYSINFO_SMBIOS=y
>> +CONFIG_USB=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB_DWC2=y
>> +CONFIG_USB_KEYBOARD=y
>> +CONFIG_VIDEO=y
>> +# CONFIG_VIDEO_BPP8 is not set
>> +# CONFIG_VIDEO_BPP16 is not set
>> +CONFIG_SYS_WHITE_ON_BLACK=y
>> +CONFIG_VIDEO_MESON=y
>> +CONFIG_VIDEO_DT_SIMPLEFB=y
>> +CONFIG_SPLASH_SCREEN=y
>> +CONFIG_SPLASH_SCREEN_ALIGN=y
>> +CONFIG_VIDEO_BMP_RLE8=y
>> +CONFIG_BMP_16BPP=y
>> +CONFIG_BMP_24BPP=y
>> +CONFIG_BMP_32BPP=y
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> -- 
>> 2.34.1
>>
>>
>>
>>
>>
>>
> 
> 
> 
> 
> 
> 

