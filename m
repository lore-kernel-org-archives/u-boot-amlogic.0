Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web08.26619.1650871319584347751
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 00:22:00 -0700
Received: by mail-wr1-f49.google.com with SMTP id x18so19512549wrc.0
        for <u-boot-amlogic@groups.io>; Mon, 25 Apr 2022 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=kKuqzPA9i4CBLara0kRtqs1sfEFio0J1b+MMvTSBW6Y=;
        b=T0DzE+elF5z1CnLD2p/JMTGwp60XFw2av4m24WOcVmLi2ZlsniXhfxY+Lz5urOKDkq
         g7CRsWjgAWIsv39+OrNZ4gURD9MR4gp6U8aAW2hw3OipUE50r42SoswmvjTPD7gQigc6
         CzGM3r7NCTrf8xdOzDvTUq3mnHa5YlxLkCdpt9lT7vztCP6KKNY6Nb07rgqTFHBceGVX
         unrSkgs8FNHqHxtPUfkmD57olIOy31vzZIzSVCWMTvn7aRqtHMRP/epAOWmdfCB7mycg
         VWkiB0K54E7DAV/wX6Xd6orLxZhKZQHZOCi1zK+iwG3nXqojElQcGHipS7lP7e9U328h
         kPAg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <2e2747be-7486-cd0f-b247-b8729688b9cd@baylibre.com>
Date: Mon, 25 Apr 2022 09:22:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 6/6] board: amlogic: jethub j100: enable saradc in config
References: <20220424082159.757622-1-adeep@lexina.in>
 <20220424082159.757622-7-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220424082159.757622-7-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2022 10:21, Vyacheslav Bocharov wrote:
> Enable ADC in board config file
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   configs/jethub_j100_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
> index 1c6db9f6a0..a30940bf1c 100644
> --- a/configs/jethub_j100_defconfig
> +++ b/configs/jethub_j100_defconfig
> @@ -17,6 +17,7 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_OF_BOARD_SETUP=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_MISC_INIT_R=y
> +CONFIG_CMD_ADC=y
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_IMI is not set
>   CONFIG_CMD_EEPROM=y
> @@ -34,6 +35,10 @@ CONFIG_OF_CONTROL=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_MESON=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_CLK=y
> +CONFIG_CLK_MESON_AXG=y
>   CONFIG_MMC_MESON_GX=y
>   CONFIG_MTD_UBI=y
>   CONFIG_PHY_REALTEK=y

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
