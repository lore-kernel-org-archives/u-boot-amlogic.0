Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.8327.1628081073823856014
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Aug 2021 05:44:34 -0700
Received: by mail-wm1-f54.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso1385443wmp.1
        for <u-boot-amlogic@groups.io>; Wed, 04 Aug 2021 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lrTwnHoERuORHpP8BmbxNQaxIFslmRzMvjQ2TSzQzHg=;
        b=j+1tb86A7NTfge67ZbX4FCyjr7UqNJspwWPsBSbvVk+2kOkkUSUrKS8BeP5dGFC6aY
         GW5p0jfFy+lkST1oF2lwROnR8XvOI4iGOg2t3kTgZ07EF0DM9AgFWXDZzBlqNSWQwD3U
         bsksGK+5Z0L84I49hzpbBiGjgn53dcVEJcRFNH16QuEheG7+yHwoRRIfkuVo10OkoWs5
         y01TNJobw2Ca/Lny3mA8DGt/sRTUwZQZLLh71TT1wLHVE+zHHtyd1owUJmt0sOsS/Qfj
         GijWUmYZDQ6OBu0GPmBNeZ0L+lYR4XqXHFfiyXP9qnTGgBE8P8AHo0Wv126ivwnAJAzI
         nrQA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: odroid-n2: fix fdtfile suffix for n2-plus
References: <20210804110107.2127-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c892e443-78f5-4a77-9d17-d83b6b2df0a8@baylibre.com>
Date: Wed, 4 Aug 2021 14:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <20210804110107.2127-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 04/08/2021 13:01, Christian Hewitt wrote:
> The N2+ dtb is meson-g12b-odroid-n2-plus.dtb, not n2_plus, so
> correct the suffix provided in the board file. Also align the
> board ident string shown during boot to match.
> 
> Fixes: 8bc780106c13 ("board: amlogic: odroid: add runtime detection of the N2/N2+/C4/HC4 variants")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  board/amlogic/odroid-n2/odroid-n2.c | 2 +-
>  configs/odroid-n2_defconfig         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index 88a60f34fe..acfd107fc5 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -48,7 +48,7 @@ static struct meson_odroid_boards {
>  	/* OdroidN2 rev 2019,2,7 */
>  	{ MESON_SOC_ID_G12B, 330 * 4, 350 * 4, "n2" },
>  	/* OdroidN2plus rev 2019,11,20 */
> -	{ MESON_SOC_ID_G12B, 410 * 4, 430 * 4, "n2_plus" },
> +	{ MESON_SOC_ID_G12B, 410 * 4, 430 * 4, "n2-plus" },
>  	/* OdroidC4 rev 2020,01,29 */
>  	{ MESON_SOC_ID_SM1,   80 * 4, 100 * 4, "c4" },
>  	/* OdroidHC4 rev 2019,12,10 */
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index bac44b61ab..1f718a3154 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -9,7 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-odroid-n2"
>  CONFIG_MESON_G12A=y
>  CONFIG_DEBUG_UART_BASE=0xff803000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> -CONFIG_IDENT_STRING=" odroid-n2/n2_plus"
> +CONFIG_IDENT_STRING=" odroid-n2/n2-plus"
>  CONFIG_DEBUG_UART=y
>  CONFIG_OF_BOARD_SETUP=y
>  # CONFIG_DISPLAY_CPUINFO is not set
> 

Indeed, thx for the fix

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

If nobody complains I'll push it at the end of the week !

Neil
