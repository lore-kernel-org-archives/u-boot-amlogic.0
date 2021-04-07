Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.9289.1617810721610145720
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 08:52:01 -0700
Received: by mail-wr1-f53.google.com with SMTP id x15so9303904wrq.3
        for <u-boot-amlogic@groups.io>; Wed, 07 Apr 2021 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SA4yzuLOUYKXsJcyEAr28LYAgnd+YW5H955fUk2wkO0=;
        b=ZjDVk7tbAxionMCRRMla4FbwMTS3DaWFUymGY6X5zYe0okbSYJvRdJYVSkMZWrcJ9w
         z4KosvTxEOOsy3E7QdZlvp+5HPAzpY3OFqRbw1M6xrZSX3hvxOg8FFU9VGt1xezNkcMK
         JmpctBym8YQWpHcYViXw93Xoioy5yHrDrvsOGolEGz8o5N6BGKSfOZmJKFbzfLKj54rS
         4627I+SAFgci25/b4wOa+k65MeDuaetpzrCqb2dtOE4y6te99rWXxKwvsrl3/z8wd/dK
         mOKntMvQ2EiT/9gSr+0zSy/cyBoC51Bd1QuBzUe+7uUqwzB2pBO2JG5Uat01n4feDTNC
         2Osg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: odroidc2: readd PHY reset properties
References: <65880dfc6b107ab09f566edec65c6d4ccc71377f.1617806959.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ac7a4cc8-c26f-7175-3c37-461d6012daa3@baylibre.com>
Date: Wed, 7 Apr 2021 17:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <65880dfc6b107ab09f566edec65c6d4ccc71377f.1617806959.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 07/04/2021 16:49, Stefan Agner wrote:
> The sync of the device tree and dt-bindings from Linux v5.6-rc2
> 11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
> ODROID-C2. The PHY seems to need proper reset timing to be functional
> in U-Boot and Linux afterwards. Readd the old PHY reset bindings for
> dwmac until we support the new bindings in the PHY node.
> 
> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/dts/meson-gxbb-odroidc2.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
> index 70fcfb7b06..8b80bbc90b 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
> @@ -188,6 +188,10 @@
>  	phy-handle = <&eth_phy0>;
>  	phy-mode = "rgmii";
>  
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +
>  	amlogic,tx-delay-ns = <2>;
>  
>  	mdio {
> 

Thanks, it's ok but please add the changes to arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
instead, we want to keep the DT files in sync with Linux, local u-boot changes must go into
the -u-boot.dtsi files.

Neil
