Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.8617.1650633983785288105
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:26:24 -0700
Received: by mail-wr1-f49.google.com with SMTP id b19so11029585wrh.11
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=5ys2IaZLshsCrMecW+65lRijl3MJANIdfhTIhne35/s=;
        b=8CoUf35QaVnEhcZInKE2B6CyyN1CcilQ41SKoFs3I9my6GINKQpht38jZOmE6RujVv
         AhroFMgWBjwf54Z5i2mSxGPSOrm53O5HafZhedos8NyIFUOn3F8ghLAPzEfb1vzlCGBV
         z8hbV6loENIDeIQoth02u2kGu6whDDuYPMcIfMp9iTUrzGcqXE8tuXZY78R3FTcByZi9
         YMCRwy7+4BHcNmhNW1MtHJN0LQJG2332Jk57+DDksOX0pzMFBmcGqOs9ZOm0hXYiEIn/
         qI664svh2YMHOo8SxZr4VeFH5ZSk6T1hD+CYZ+ROFEoIlQ+lKArYMhn2xofZV5p+QFAq
         aVdA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <4bb9a066-97ef-35e2-d5d8-2953b8717f97@baylibre.com>
Date: Fri, 22 Apr 2022 15:26:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] adc: meson-saradc: add AXG variant
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-5-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-5-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Add support for the SARADC variant found on the AXG SoCs family.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/adc/meson-saradc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
> index 1a45a3a265..37023512f0 100644
> --- a/drivers/adc/meson-saradc.c
> +++ b/drivers/adc/meson-saradc.c
> @@ -737,6 +737,8 @@ static const struct udevice_id meson_saradc_ids[] = {
>   	  .data = (ulong)&gxl_saradc_data },
>   	{ .compatible = "amlogic,meson-g12a-saradc",
>   	  .data = (ulong)&gxl_saradc_data },
> +	{ .compatible = "amlogic,meson-axg-saradc",
> +	  .data = (ulong)&gxl_saradc_data },
>   	{ }
>   };
>   

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
