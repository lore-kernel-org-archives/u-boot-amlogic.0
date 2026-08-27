Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB0C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:52:31 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.265.1787845942865246993
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:52:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=i6oK1ZZO;
 spf=pass (domain: brivo.com, ip: 209.85.219.45, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90c522298d2so893836d6.2
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1787845942; x=1788450742; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxS+oCp/6T0s1ymrtyu/LN6tc12yDwrQPBWfMg5vL3U=;
        b=i6oK1ZZOFkDWknGLTDuVWxpeEMPci39k7s8NYSr40jZNkUMPHpA0wjBP22OrUqAjvJ
         KLtj/5FH3BJ5ud94mF89sb4HGgOgVLYapX9eWlzPUmnKEaFMEsfcsC/6JQ3Oq5epyeAQ
         79wmo+27ZUM4rgSshH1NY+C7lVN0yxiE7De+RDfqjiNSQhuoJYepE7HzEoa+VsV3/us/
         4g4C4eTMP3GhR2xn4VxHgUGpWbCGBvA10VpQmiyzg+hUezUaoZLQc8/cw5vq8OFlnhpt
         cFJmf0e3zi7YsAKgXqUZpeihlY2DVSgnLHHxWhTJJXPY2sxnENhXcpqE360m+y8p9i4P
         zAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845942; x=1788450742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxS+oCp/6T0s1ymrtyu/LN6tc12yDwrQPBWfMg5vL3U=;
        b=hOO9zNigxoVh5ehtWOxuuuGGWOy+Cskx7gV3oMq2FAOxcRuR1p42YCWmfiPWiiySIm
         9mP0dcJRUFpFroI52jl2OZmR1HsDrnWn5wqLAyx2M4PjzZkV23AgKiCE3cjveWOCDjm0
         DSYLxORqIZZxdWCd2wtCw+gpLM8AtR4HaSVLtC0bTgnzURdchRTcNXOOxttC2XvEFupz
         gbJI8e/66FZqRdou90JjvPDZVOatyM6rivWacFdoN4Q6ngBYPfb5lrbhLp0zaLR+c3wi
         RoJeTcOttgoV8wJZINASkuHMbUpozZf1B7kTAv3THp8kcuy1o2/0p9XUCX6aVbWPO4IH
         oqNg==
X-Gm-Message-State: AFuF++n1iQ5uD+zlQ9XYi1t5q8GsXLjZhdQYbif00wOEvRzqCHsfsJz8
	OsJrbpKsLbbp5nB6wD3sGiHFps9M156INnYBpL2sa3E84clipoj0OkblDHdCzRphhb+HJTroz98
	A3YIO1Cd/J7pNF61ttK6oXtJK/melK/XdoCse2hIxjHeoXZNDY5b4BK0JNTq3NNwR5DdMBw==
X-Gm-Gg: AR+sD10EMqF/M/iOOTi2I+jvzGWL5awkv7ixm9hHtrBAhtXYkav+LvIAfK4UDbSIUsl
	f6TCdf3x+5DmOSig/PdmWSkiZWsvdUBmiBQ6eGHScSh+XbguW1afd88kDM2HIGHZHe6/7KoGe7k
	fz4wgMdZG//YJbOtLHHeoqCubhMOuGQ6bNebVNSMH3sMFnWL0MYXeEMmzk7gayoIjn+2MklhI5+
	7W2H45pGEzeT55U9C2pnFZIi1RMzw8k7rPeGzaR6g2BvxMEb6CCE/P+Gv3ObfSSN00XXkijLlvl
	nvmknc6jDkIBFqFe1IblDW4q3RGqKlWBk4z6S4oHoIh7WLFQLMDBmJeXhaHBVV7NxtN8Ep4Gvqp
	y2UUVi+AFGExenOSfD4dWUSjUUdndQYSnulnaPDbcePBnH1MTjaXn3lwowK512QUQfb6z3+GS/n
	RWWEZz0ZZF+cyJI8p83jCZ0oYGBSU4AdmacUEqUGnqH7s8BqW3+Gb2Uyim7JzaT66m9d63ynI7+
	jq+
X-Received: by 2002:a05:6214:4497:b0:90c:d3be:7466 with SMTP id 6a1803df08f44-90ce0c4294bmr2741536d6.12.1787845941469;
        Thu, 27 Aug 2026 08:52:21 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73fc28dsm19619976d6.34.2026.08.27.08.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:52:21 -0700 (PDT)
Message-ID: <2cdfec51-294d-43c3-832c-e49ac5fde186@brivo.com>
Date: Thu, 27 Aug 2026 11:52:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] [RFT] meson: Add Khadas VIM1S support
To: Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-10-sanderson@brivo.com>
 <5a690fd2-d02c-42fb-9113-658df02d44f1@linaro.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <5a690fd2-d02c-42fb-9113-658df02d44f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:52:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3083



On 8/27/26 11:40 AM, Neil Armstrong wrote:
> On 8/17/26 19:15, Sean Anderson wrote:
>> This adds basic support for the Khadas VIM1S [1]. I built this config on
>> a custom board, and I don't even own a vim1s. Please test!
>>
>> [1] https://www.khadas.com/vim1s
>>
>> Signed-off-by: Sean Anderson <sanderson@brivo.com>
>> ---
>>
>>   board/amlogic/q200/MAINTAINERS |  1 +
>>   configs/khadas-vim1s_defconfig | 80 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>   create mode 100644 configs/khadas-vim1s_defconfig
>>
>> diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
>> index aece8d5e05c..5281e06f3cc 100644
>> --- a/board/amlogic/q200/MAINTAINERS
>> +++ b/board/amlogic/q200/MAINTAINERS
>> @@ -5,6 +5,7 @@ L:    u-boot-amlogic@groups.io
>>   F:    board/amlogic/q200/
>>   F:    include/configs/q200.h
>>   F:    configs/beelink-gt1-ultimate_defconfig
>> +F:    configs/khadas-vim1s_defconfig
>>   F:    configs/khadas-vim2_defconfig
>>   F:    configs/libretech-s905d-pc_defconfig
>>   F:    configs/libretech-s912-pc_defconfig
>> diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
>> new file mode 100644
>> index 00000000000..143425cd2ca
>> --- /dev/null
>> +++ b/configs/khadas-vim1s_defconfig
>> @@ -0,0 +1,80 @@
>> +CONFIG_ARM=y
>> +CONFIG_SYS_BOARD="q200"
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_TEXT_BASE=0x0
>> +CONFIG_SYS_MALLOC_LEN=0x8000000
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
>> +CONFIG_ENV_SIZE=0x10000
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_MESON_S4=y
>> +CONFIG_SYS_LOAD_ADDR=0x1000000
>> +CONFIG_IDENT_STRING=" vim1s"
>> +# CONFIG_PSCI_RESET is not set
>> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
>> +CONFIG_REMAKE_ELF=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_SIGNATURE=y
>> +CONFIG_FIT_VERBOSE=y
>> +# CONFIG_BOOTSTD is not set
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_SUPPORT_RAW_INITRD=y
>> +# CONFIG_DISTRO_DEFAULTS is not set
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_BOOTARGS=y
>> +CONFIG_BOOTARGS="root=/dev/mmcblk1p2 ro rootwait"
>> +CONFIG_USE_BOOTCOMMAND=y
>> +CONFIG_BOOTCOMMAND="load mmc 1:1 $loadaddr linux.itb && bootm"
> 
> Why not leave the default boot command ?

This is just what I used for testing. I can remove it for v2.

>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_MISC_INIT_R=y
>> +CONFIG_HUSH_PARSER=y
>> +CONFIG_SYS_MAXARGS=32
>> +# CONFIG_CMD_BDI is not set
>> +CONFIG_CMD_CLK=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PART=y
>> +CONFIG_CMD_WDT=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_DHCP=y
>> +CONFIG_CMD_MII=y
>> +CONFIG_CMD_PING=y
>> +CONFIG_CMD_PXE=y
>> +# CONFIG_CMD_DATE is not set
>> +CONFIG_CMD_RTC=y
>> +CONFIG_CMD_SYSBOOT=y
>> +CONFIG_CMD_EXT2=y
>> +CONFIG_CMD_EXT4=y
>> +CONFIG_CMD_FAT=y
>> +CONFIG_CMD_FS_GENERIC=y
>> +CONFIG_ISO_PARTITION=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_OF_UPSTREAM=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
>> +CONFIG_SYS_I2C_MESON=y
>> +# CONFIG_INPUT is not set
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_DM_MDIO=y
>> +CONFIG_DM_MDIO_MUX=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_ETH_DESIGNWARE_MESON8B=y
>> +CONFIG_MDIO_MUX_MESON_G12A=y
>> +CONFIG_PHY_MESON_GXL=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_S4=y
>> +CONFIG_DM_RTC=y
>> +CONFIG_RTC_DS1337=y
>> +CONFIG_RTC_DS1337_NOOSC=y
>> +CONFIG_BAUDRATE=888888
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_WDT=y
>> +CONFIG_WDT_MESON_GXBB=y
>> +# CONFIG_TOOLS_MKEFICAPSULE is not set
> 


