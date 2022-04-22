Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web08.8447.1650633950107658445
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:25:50 -0700
Received: by mail-wm1-f53.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso7991700wma.0
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=3np+vf/IKV6JpYE2omQV3LekgmoSzHj0wxgBgsOlkxs=;
        b=MdBfPrsHDU74F8jle/PimTsS5tAp6bUq0CNR8qpPdqJitZAaj80PhrdMYnC6t3Kf/v
         uCvVmVV8Sw9FnCV91qJaE4EQkhx757xPdDWZlyOD0o+VVHYqR5zm5A3yd7Y58LeMOvre
         lsN8cxqhDlFTOSVQ8prEnFhIrAvLaSwx8g6+VStljQDnvSWwojyuiXWqvDEJnF4IxDrl
         GK5gpZZxSNtO5yLiKm3oGCpR8G0ZZGNKzGm9vpD3r1sAbgZQ24n4JJ6TIK3t/UmZTYTg
         wNd9Z9+2Rt4Ge0CkEb36U4toZ7PQ+UgU3BBQULXhilYeuD9JMxbaPiiDXLdNjZ1sK1dh
         bWiw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <a019264f-f61f-11c1-223d-837d88dc595e@baylibre.com>
Date: Fri, 22 Apr 2022 15:25:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] clk: meson: fix driver name for g12a-ao clocks
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-3-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-3-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Update the clk-g12a-ao driver from "axg" to "g12a"
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/clk/meson/g12a-ao.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 0148529e04..17b11eb52a 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -73,7 +73,7 @@ static const struct udevice_id meson_clk_ids[] = {
>   	{ }
>   };
>   
> -U_BOOT_DRIVER(meson_clk_axg) = {
> +U_BOOT_DRIVER(meson_clk_g12a_ao) = {
>   	.name		= "meson_clk_g12a_ao",
>   	.id		= UCLASS_CLK,
>   	.of_match	= meson_clk_ids,

This must have given weird errors :-p

Thanks for fixing this !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
