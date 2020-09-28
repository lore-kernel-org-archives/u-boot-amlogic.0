Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.31581.1601278846878122357
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Sep 2020 00:40:47 -0700
Received: by mail-wr1-f67.google.com with SMTP id s12so26888wrw.11
        for <u-boot-amlogic@groups.io>; Mon, 28 Sep 2020 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S3ouTGt0KaBZCD3WCwOgbNAAQ91aTmUiJ8JsMe0pDf0=;
        b=MY8ObMZ6F2IjVaGGEpedu0fH45hGQuhGP2WUHNFoIjuNAk42CoxkC8BFprAUoYHYKS
         +8Zr0Ce5IuysHSaidVBbqrDpyXhHGgXWbQ0jN8Mh/eRjnLtdvnKZmJopZQ+2rO/zmigA
         YQgzqQg9hWQALWorFIiOD9BukAfz6ZYEKMexNpVtX5lur6SS1K80OWXQR74PmOZ+xfCK
         F6OMeETe8HJK+04QfqujY5qG4GqV8/xG/iBV28sFLei+MdtZQ/7chCsTjH7BFx8lwJMb
         hJ7ltgxud0l86QiJNpQeliQ8qLxy9uSA+8f32Eq/5zLmOXYyLDwuGg3pga4RqylHQUbo
         a+OQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: s400: generate unique mac address from SoC serial
References: <20200910085039.25785-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <27046589-69a2-b7ee-4d49-12ae99514cb8@baylibre.com>
Date: Mon, 28 Sep 2020 09:40:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200910085039.25785-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/09/2020 10:50, Neil Armstrong wrote:
> Enable unique mac address generation from SoC serial on S400 board.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  board/amlogic/s400/s400.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/board/amlogic/s400/s400.c b/board/amlogic/s400/s400.c
> index 7e2f0cdae3..b081942dcc 100644
> --- a/board/amlogic/s400/s400.c
> +++ b/board/amlogic/s400/s400.c
> @@ -18,5 +18,7 @@ int misc_init_r(void)
>  {
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
> +	meson_generate_serial_ethaddr();
> +
>  	return 0;
>  }
> 

Applied to u-boot-amlogic-next
