Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.3894.1622101035892380358
 for <u-boot-amlogic@groups.io>;
 Thu, 27 May 2021 00:37:16 -0700
Received: by mail-wr1-f54.google.com with SMTP id f11so268402wrq.1
        for <u-boot-amlogic@groups.io>; Thu, 27 May 2021 00:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U2PUFxkzzba2X+axUNweE95salOcLiR5kdD9CtJuHW0=;
        b=oFFvjfF09M9YgifOIdhmv7opwXNrdjNAtOhB5o5XEsK9bf/MQ+YJUZwibGOAkWoHxz
         uV//bkfutiW0iqANXITBLE2k1MON4Qg6jDy619XT5NvsP/g1aIwpcgALm58GH1zOYtJ+
         eDthSf2U4bzqHb/HaN1r61Trr+DNQOOmdaxwYHZiPP1eROAJwlYctb6BfcM22gkyB6Ps
         2XNhHvXSKL7znHID4gk4PpEe6Txnx3JNEx186M67tEqFbv3OTbdmizD6T3VbdQB10D4H
         PHzjOBxJBUWa4KYH1mhYtYkPazslfJw4X939P0KEgWnwlF9mNdVPPADyHqbUxAGDndf+
         /uuQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] DTS: khadas-vim2 spi-flash change spi-max-frequency
References: <20210527072059.3965223-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8a9e1b17-47ff-1e09-adfa-175d5265cf5a@baylibre.com>
Date: Thu, 27 May 2021 09:37:11 +0200
MIME-Version: 1.0
In-Reply-To: <20210527072059.3965223-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 27/05/2021 09:20, Artem Lapkin wrote:
> change max freq to 104Mhz for SPI-NOR flash
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  arch/arm/dts/meson-gxm-khadas-vim2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> index bff8ec2c1c..e2bd9c7c81 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> @@ -341,7 +341,7 @@
>  		#size-cells = <1>;
>  		compatible = "winbond,w25q16", "jedec,spi-nor";
>  		reg = <0>;
> -		spi-max-frequency = <3000000>;
> +		spi-max-frequency = <104000000>;
>  	};
>  };
>  
> 

Please add the change in the arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dts file instead.

Thanks,
Neil
