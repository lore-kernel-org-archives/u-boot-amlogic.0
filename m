Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.8645.1650634031631437350
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:27:12 -0700
Received: by mail-wr1-f52.google.com with SMTP id u3so11084006wrg.3
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=ql5dlCZstuYpsG/HA0rLLb0KV0GG/uSL30LbxYQMp8M=;
        b=G9DTYnpm/jbM9iwGW4hIs5zUlwGpIgPNVTLP1dqjwEQaU4DXzldWCbUkt0emQglBtD
         M+UjjcQD95yJu38UVlRq9zyWv8Mx4sRIAhAfGkHEZahlkqzIhNJ8j4nq5Fl+0Kz0nA5V
         ybrFaqi5Y2Okg5U1ef2BE0bqZ+Z3gHWvexYcvLlZpdVw38JUvkIJ4/vGq29bfqUgSTkY
         rJd5o8RU2HySGC7p4yaEcOA7ywB+6i7YNaJGw8Dq+OvfbIJveRNguIX++AWrkrkHPgaG
         noMg8ZoJ6Y+ytbNUo8KJ4eVMN21pDotDJt6+SlnfCrbANYR9ByBJa0mvw59jtgHQjNJg
         I5tg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <963b1e68-d826-e51a-1147-cd07a89dfeeb@baylibre.com>
Date: Fri, 22 Apr 2022 15:27:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] board: amlogic: jethub j100: enable saradc in config
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-7-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-7-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Enable ADC in board config file
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
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
