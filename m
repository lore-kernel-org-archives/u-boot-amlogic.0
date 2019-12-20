Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.7193.1576837020638941144
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:17:01 -0800
Received: by mail-wm1-f66.google.com with SMTP id f129so8622375wmf.2
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yCpCPZ//4F2++bW4/TS7ldLmdoBaNYzxvZmGfoaMios=;
        b=uDY5D/ZyR0AXVYJoEPk6ugqLv33cDERYGnNFEifKeTsakNWTHqnMtFp5LCtV8faiiz
         SlK5yTn7AA/4F9e5HIEdgc4OCy2n7gsffWFvXhy+D50NIKdFmmrAWHyceT9xMW2Ia84C
         zhsOTjcteVAPHzKumupNyTY4ugp7oma24KOv8ZdoHYrCj7SmoVNhlZRmzvADLDWyWO5p
         7BQX9Re5A8z5m9ySW/QPxvRKEklRJWBzxKet4hcgOo6BnNYagErS0THAYqzZ6/uZo+Mh
         okyOCbJblpffKQ7bnRd0zx2uoHBchQpDnCh4OGesKr+llsWOtkyodcybpmtaqBiJnaBW
         bHng==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/5] arm64: dts: meson: gxl: add i2c C pins
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
 <20191219183620.1423118-5-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <7468cc8a-e120-3934-548b-b966b0e41d4c@baylibre.com>
Date: Fri, 20 Dec 2019 11:16:57 +0100
MIME-Version: 1.0
In-Reply-To: <20191219183620.1423118-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 19/12/2019 19:36, Jerome Brunet wrote:
> Add dv18 i2c C pins on the gxl SoC
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm/dts/meson-gxl.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxl.dtsi b/arch/arm/dts/meson-gxl.dtsi
> index d5c3d78aafeb..4ef11e5381d8 100644
> --- a/arch/arm/dts/meson-gxl.dtsi
> +++ b/arch/arm/dts/meson-gxl.dtsi
> @@ -511,6 +511,15 @@
>  			};
>  		};
>  
> +		i2c_c_dv18_pins: i2c_c_dv18 {
> +			mux {
> +				groups = "i2c_sck_c_dv19",
> +				      "i2c_sda_c_dv18";
> +				function = "i2c_c";
> +				bias-disable;
> +			};
> +		};
> +
>  		eth_pins: eth_c {
>  			mux {
>  				groups = "eth_mdio",
> 


For this one and the next one, I'll prefer a sync of Linux DT from a stable tag,
either from Linux tree, or Kevin's arm-soc PR.

Neil
