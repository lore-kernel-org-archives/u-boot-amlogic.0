Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.10102.1579695349173092445
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Jan 2020 04:15:49 -0800
Received: by mail-wr1-f67.google.com with SMTP id c9so7001515wrw.8
        for <u-boot-amlogic@groups.io>; Wed, 22 Jan 2020 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S5YdbbbhGiBVQE56SEM/QfKm6W8Lus6WbsYJBMWEsCI=;
        b=aVlnDcRQw/+ioq5LzQMMTtv6DTwoWo/Rc2N/5qZyHqnwNgj9cB4WWpyjUeUnZXFs/3
         TovYfIXHgXDeWR82g68zv3UZaQiKFgXRgX0t5qdmLhvdo5hshFsQZdiaYXBMPx6dONn0
         eaw2qS92jvVQTNT0m6PezWrRjUyzuGjM8nMUjtUF4EwkGIfyH31C2K/MbZ8A4J0XeLfr
         7qsFDz2eQE/wG4EoibVsok0g4NZa8d9Tf7PFUbzBdEyd7rlf/D3VnZM4tB/41avv97Ih
         10AHmi11Y9xQWZ3B4a243nZplxMjw3U+q+DEbj/gB04mGMjKa3RG3Er+6bbr2Xlz+N7W
         VHVg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [Patchv4 3/3] arm: dts: Add cd-gpio for eMMC
References: <20200122120620.8699-1-linux.amoon@gmail.com>
 <20200122120620.8699-4-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <faba2774-f2ba-b5a3-9356-18c589afc974@baylibre.com>
Date: Wed, 22 Jan 2020 13:15:46 +0100
MIME-Version: 1.0
In-Reply-To: <20200122120620.8699-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 22/01/2020 13:06, Anand Moon wrote:
> Add cd-gpio property for eMMC node.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch in this series
> ---
>  arch/arm/dts/meson-g12b-odroid-n2.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dts b/arch/arm/dts/meson-g12b-odroid-n2.dts
> index 888429b1cc..23ec14abe7 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2.dts
> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dts
> @@ -449,6 +449,7 @@
>  	max-frequency = <200000000>;
>  	disable-wp;
>  
> +	cd-gpios = <&gpio GPIOH_7 GPIO_ACTIVE_LOW>; /* eMMC_nDET */
>  	mmc-pwrseq = <&emmc_pwrseq>;
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&flash_1v8>;
> 

If it's missing, submit it to linux-amlogic and move it to the -u-boot.dtsi file.

Neil
