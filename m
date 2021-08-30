Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web09.14109.1630310103343842585
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Aug 2021 00:55:04 -0700
Received: by mail-wr1-f50.google.com with SMTP id x6so12879587wrv.13
        for <u-boot-amlogic@groups.io>; Mon, 30 Aug 2021 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ihqat5eH1ui12ytw3o9f1yD8UgfpycEVbQo3mkJQlgA=;
        b=aVh9GU1N3OaMC5hM+h6H9draGQT5S9VyF6cy0MxDuPb7MvvgxgFMimRy9rf3VHIVvJ
         O7HECOPndFSqHrF6JVx13XaA1UyYrptj53FF5olxIXBfUwxgJuZxE/FmxYcZ68XKCOdd
         IK/cuOBJDGGgodW0D4sZA7WWiW/tSNKFBwyvM63q/9/foj0FXP7TxBDSlCp5v8nHXQs7
         hl2EsZ1VruX68cYWdnzW8RAA5OpfdT6PghFWJTCyZy6cwh+8Dl0zarKawSXaPtDQ0d4v
         lLOiVq54Nd6pRvWIebkmDE6+282819MFJriACGh/y1dOL8wTqQ2HD3dqM/4I6bU/N+V6
         /GgA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: meson: Add S905Y2 SOC ID
References: <20210820021836.1024-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c8e6a514-b0ac-7a2c-eef7-0939c2121eb2@baylibre.com>
Date: Mon, 30 Aug 2021 09:55:01 +0200
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

Applied to u-boot-amlogic

Thanks,
Neil
