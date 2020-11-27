Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web08.21165.1606494933001936770
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Nov 2020 08:35:33 -0800
Received: by mail-wr1-f66.google.com with SMTP id e7so6187690wrv.6
        for <u-boot-amlogic@groups.io>; Fri, 27 Nov 2020 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Xll8stSAnsTnOT6wpylZwh15xr5heWI/88Aw2G7lco=;
        b=ov2FZAYcj96Di+hBe/L9O7W5eD66w3TD5d1nkIX2Pa27xNVrooW+KX/omHI8ZcEUIu
         fo9zhWhAWKBwLDz97XnUHoEbl3uPnGZtfpsSBceqK5BAEoxk8its+f3O09Edw9/lBxlJ
         r7GB3jcwL/K71GgZdR6G4Iqwk7NAYXYPBOfioN+6H2PdDKNg6CJiFK0ZBfAI+4+Ftds9
         kTZqzX4qXhj92x4qVIGK1NMfSOKOMNzWdLR7ud9nxAv8fpXIdobRDm/JpoBHIXfc6zhK
         nMdy6rs72zNhPFacqnDOJy4CKuWhzCpWeDrlpptv9psSbZ+Esbh86pPzM4TyFZtLV3th
         w6LQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: meson: isolate loading of socinfo
References: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <837bbfcd-5d53-2928-a8c3-899e3496525e@baylibre.com>
Date: Fri, 27 Nov 2020 17:35:14 +0100
MIME-Version: 1.0
In-Reply-To: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
List-ID: <u-boot-amlogic@groups.io>

On 27/11/2020 17:28, Stefan Agner wrote:
> Move loading of socinfo into a separate function so the value can be
> reused later.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> 
>  arch/arm/mach-meson/board-info.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index e61d1adb10..a0bcf38f29 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -131,7 +131,7 @@ static void print_board_model(void)
>  	printf("Model: %s\n", model ? model : "Unknown");
>  }
>  
> -int show_board_info(void)
> +static unsigned int get_socinfo(void)
>  {
>  	struct regmap *regmap;
>  	int nodeoffset, ret;
> @@ -163,8 +163,20 @@ int show_board_info(void)
>  		return 0;
>  	}
>  
> +	return socinfo;
> +}
> +
> +int show_board_info(void)
> +{
> +	unsigned int socinfo;
> +
>  	/* print board information */
>  	print_board_model();
> +
> +	socinfo = get_socinfo();
> +	if (!socinfo)
> +		return 0;
> +
>  	printf("SoC:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
>  	       socinfo_to_soc_id(socinfo),
>  	       socinfo_to_package_id(socinfo),
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applying it u-boot-amlogic-next

Thanks !

Neil
