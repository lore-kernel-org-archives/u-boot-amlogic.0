Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.10614.1621007187657625499
 for <u-boot-amlogic@groups.io>;
 Fri, 14 May 2021 08:46:27 -0700
Received: by mail-wm1-f45.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so8672wmn.2
        for <u-boot-amlogic@groups.io>; Fri, 14 May 2021 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGEgUy+yRNV9kYWX0eN18JOkx5WDrCCnpdFqnzhsy6Q=;
        b=nzpvYwTlEmd1XU1gIS0t1/0az8Zy4vSlNQhPYt83cC4ntRncFbo4PsqU7nhVaTZA/3
         HoX6InzRwX+MWrqzfmb57NpiIj6eebNHO28/06vY+OgG9Bp6ObwDnUNFKdgOUuxzctBI
         /+MOmHdHML/4zcUYPr0LdiQ7Xlg4UuLLa+CADE0sbahs9l8txc6/MGFky4EslfdLeopo
         6mUsCfRzE/MuMsk5tpa4X//KzqLl7PHExVe9mBZCeInkIN9/bSBXO9fVlcoEP0FcDfs9
         uZox/z7nyOh8fJJCGSeBvEmXTyXyoyMori2lp2+cAJToYDocvLRnDTSHCrznU91i98xg
         A4Tg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/8] net: designware: meson8b: add g12a compatible
References: <20210421091809.3103002-1-narmstrong@baylibre.com>
 <20210421091809.3103002-2-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <563a02e0-14a3-b793-51e7-5fc506527e22@baylibre.com>
Date: Fri, 14 May 2021 17:46:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210421091809.3103002-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 21/04/2021 11:18, Neil Armstrong wrote:
> Add support for the Meson G12A dwmac glue compatible needed after Linux 5.12 sync.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/net/dwmac_meson8b.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index c0b6ef4994..069bf1724d 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -133,6 +133,7 @@ static int dwmac_meson8b_probe(struct udevice *dev)
>  
>  static const struct udevice_id dwmac_meson8b_ids[] = {
>  	{ .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
> +	{ .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
>  	{ .compatible = "amlogic,meson-axg-dwmac", .data = (ulong)dwmac_setup_axg },
>  	{ }
>  };
> 
Thanks,

Applied to u-boot-amlogic

Neil
