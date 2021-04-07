Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.7186.1617802273609861550
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 06:31:14 -0700
Received: by mail-wr1-f46.google.com with SMTP id x15so8801828wrq.3
        for <u-boot-amlogic@groups.io>; Wed, 07 Apr 2021 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OC1yJVEZtCyrG6ihgy02H5vNdkYLKKowaRzL6Cnmqm0=;
        b=jDz+D5VLYko1qmU6vIfgjKHR5AX7+lHmYWLxmSIbmxWRjc7l0It4g9YgLwG6/MTOiA
         uLBjlm2ZINylwU0LYLDrmfIoYO9PHkmxp8+8zn8Jm08/IpYrZGjYWhDBWKXzE/1qgpou
         n5eAew49pVq/88D9jc0B8dAIgJA06cPZxVmdCu5l1QicZscjTag2kYCwQyVa3G6/QCHX
         D/Ep9MqPvaFWT+zY1CB5sltojAhvPkPS9AqBUlIh5IATQudJJA9g7eNbfQoCpSKBCJjP
         HfvqHzOMaq+B5FfmDi3+PrgbWRZ6Wz7xPcAQ3C7NhE73lIhRjOp5ynXmAaTehLIzQCw1
         w8uQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: fix PHY deassert timing requirements
References: <ad76ec471d131339985c1f6766069ef3fd317a33.1617731144.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5a3579cd-1326-dd88-d30a-8440376e79c5@baylibre.com>
Date: Wed, 7 Apr 2021 15:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <ad76ec471d131339985c1f6766069ef3fd317a33.1617731144.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/04/2021 19:47, Stefan Agner wrote:
> The sync of the device tree and dt-bindings from Linux v5.6-rc2
> 11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
> ODROID-C2.
> 
> Meanwhile a fix to increase the reset timing has been added to Linux.
> Instead of reverting the offending commit, use the new reset timing
> from upstream Linux commit c183c406c432 ("arm64: dts: meson: fix PHY
> deassert timing requirements").
> 
> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/dts/meson-g12b-odroid-n2.dtsi | 2 +-
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts  | 2 +-
>  arch/arm/dts/meson-gxbb-odroidc2.dts   | 2 +-
>  arch/arm/dts/meson-gxm-khadas-vim2.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dtsi b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
> index 6982632ae6..39a09661c5 100644
> --- a/arch/arm/dts/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
> @@ -413,7 +413,7 @@
>  		max-speed = <1000>;
>  
>  		reset-assert-us = <10000>;
> -		reset-deassert-us = <30000>;
> +		reset-deassert-us = <80000>;

In fact, these are not used by current U-boot, support for reset/deassert in PHY node
is not yet supported in U-Boot. This first step was to switch to DM_MDIO and use the
proper Designware glue, the second step is to find how to make use of these properties.

Concerning the patch, I'll prefer you sync the DT with v5.11 instead.

Neil

>  		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>  
>  		interrupt-parent = <&gpio_intc>;
> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> index 7be3e35409..de27beafe9 100644
> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
> @@ -165,7 +165,7 @@
>  			reg = <0>;
>  
>  			reset-assert-us = <10000>;
> -			reset-deassert-us = <30000>;
> +			reset-deassert-us = <80000>;
>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>  
>  			interrupt-parent = <&gpio_intc>;
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
> index 70fcfb7b06..50de1d01e5 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
> @@ -200,7 +200,7 @@
>  			reg = <0>;
>  
>  			reset-assert-us = <10000>;
> -			reset-deassert-us = <30000>;
> +			reset-deassert-us = <80000>;
>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>  
>  			interrupt-parent = <&gpio_intc>;
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> index bff8ec2c1c..e38d9e50ca 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
> @@ -194,7 +194,7 @@
>  		reg = <0>;
>  
>  		reset-assert-us = <10000>;
> -		reset-deassert-us = <30000>;
> +		reset-deassert-us = <80000>;
>  		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>  
>  		interrupt-parent = <&gpio_intc>;
> 

