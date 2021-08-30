Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.13948.1630309989582318665
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Aug 2021 00:53:10 -0700
Received: by mail-wm1-f49.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so8791175wma.0
        for <u-boot-amlogic@groups.io>; Mon, 30 Aug 2021 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZrLDblg+umHBGeI1VjxWmfZIEDgjzyBb0DrpQ9tl9GA=;
        b=pAifsPeau8pmEKt4bWJHt+8nBuyxzMb1ThBax/89K8fH8CeoXTWlRciY8PnSpDJcAo
         a+IGvnM601Kp6WLVmiP02SFWyQSJeoDVF27DIQuvl5G5Myl8P6hzxFl4qExvimJ8vkS3
         N2bb6bSMW/5a0b7LXs++YJxEqVMG6kE6Yg9s9gcLwawXHtrFxRuLXKHDUUbUTHG/v+av
         puNvbMjCbCSCc/tBR49+DskabKdmbSPalirXQl65TnGwozX1K9YuUStKWvAXRfbxZFdj
         AfR4pjeeMluawJnwz6V0S/+OTprtJ/wy7BT0IUZyi2tQIb81CTVUCRNq8OlCxZMONeaA
         t1oA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: meson: Add S905Y2 SOC ID
References: <20210820021836.1024-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <06547fcd-2881-3601-d02f-77df56b9a258@baylibre.com>
Date: Mon, 30 Aug 2021 09:53:06 +0200
MIME-Version: 1.0
In-Reply-To: <20210820021836.1024-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 20/08/2021 04:18, Christian Hewitt wrote:
> Add the SOC ID for the S905Y2 to board info, see below for before/after
> tested with a Radxa Zero board:
> 
> SoC:   Amlogic Meson G12A (Unknown) Revision 28:b (30:2)
> SoC:   Amlogic Meson G12A (S905Y2) Revision 28:b (30:2)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm/mach-meson/board-info.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index d16d3f194d..2421acd817 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -64,6 +64,7 @@ static const struct meson_gx_package_id {
>  	{ "A113X",  0x25, 0x37, 0xff },
>  	{ "A113D",  0x25, 0x22, 0xff },
>  	{ "S905D2", 0x28, 0x10, 0xf0 },
> +	{ "S905Y2", 0x28, 0x30, 0xf0 },
>  	{ "S905X2", 0x28, 0x40, 0xf0 },
>  	{ "A311D",  0x29, 0x10, 0xf0 },
>  	{ "S922X",  0x29, 0x40, 0xf0 },
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
