Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.19442.1609411457731690874
 for <u-boot-amlogic@groups.io>;
 Thu, 31 Dec 2020 02:44:18 -0800
Received: by mail-wm1-f49.google.com with SMTP id c133so7047561wme.4
        for <u-boot-amlogic@groups.io>; Thu, 31 Dec 2020 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYUqg5fvfaAjCXaSHNkpRe8tt/J0xFl6SdPFaKUUlKw=;
        b=be/szRozSLVhbWydCaFrKPr0yjn4F4aeK/1w0UKRSLJYRYOz8HjUgF2aBoLCo70lTc
         /72fEXwZQlLm3VyjT8sNb+yPFXwPZ8/ZpnGlQ/hfqntJRlgcP7w/rUI6v3oHwq07zZq9
         rJ5swj8UVZQF/pIIbE6fCn0kX5bXGaO+WvFNgRu8jx6zIKiSPYrBIUOHvA0c11pzhYjs
         HeTZN4A41MjUTRWINx95ojNd+GrLuF1/YYy1VprfmICmkW6jC5h6N7ZGTFxFrR+giA20
         jnNxdDYBgO+nCpPnTJv9eU4FVb8H7NS+CW/Da8ACbX6d1QvjWmh3A5F+3WsuZcne/Bx+
         6J5w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [RFC] arm64: dts: meson: revert breaking change for eMMC detection
References: <14c518aa46f3b87e7489bb1a3736ae5640262f9f.1609410832.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1f765c74-8270-4cc6-5c48-58be51d31f49@baylibre.com>
Date: Thu, 31 Dec 2020 11:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <14c518aa46f3b87e7489bb1a3736ae5640262f9f.1609410832.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>, jbrunet@baylibre.com
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Stephan,


On 31/12/2020 11:36, Stefan Agner wrote:
> The sync of the device tree and dt-bindings from Linux v5.6-rc2
> 11a48a5a18c6 ("Linux 5.6-rc2") causes eMMC to break for ODROID-C2.
> Revert the offending change.
> 
> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> It seems that eMMC on ODROID-C2 doesn't work anymore since U-Boot 2020.07. A git
> bisect pointed to the above mentioned commit. This reverts the offending part
> only, but is probably not the proper fix. I am not familar with the pinctrl
> drivers, so maybe somebody with a bit more insight can come up with the proper
> fix?

This has been fixed with https://patchwork.ozlabs.org/project/uboot/patch/20201214184841.237356-1-narmstrong@baylibre.com/

The fix has been merge for 2021.01 already

Neil

> 
> -> master without this patch
> => mmc dev 1
> Card did not respond to voltage select!
> 
> -> With this patch
> => mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
> 
>  arch/arm/dts/meson-gxbb.dtsi | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-gxbb.dtsi b/arch/arm/dts/meson-gxbb.dtsi
> index 234490d3ee..bb46dcd1c0 100644
> --- a/arch/arm/dts/meson-gxbb.dtsi
> +++ b/arch/arm/dts/meson-gxbb.dtsi
> @@ -404,17 +404,11 @@
>  		};
>  
>  		emmc_pins: emmc {
> -			mux-0 {
> +			mux {
>  				groups = "emmc_nand_d07",
> -				       "emmc_cmd";
> -				function = "emmc";
> -				bias-pull-up;
> -			};
> -
> -			mux-1 {
> -				groups = "emmc_clk";
> +				       "emmc_cmd",
> +				       "emmc_clk";
>  				function = "emmc";
> -				bias-disable;
>  			};
>  		};
>  
> 

