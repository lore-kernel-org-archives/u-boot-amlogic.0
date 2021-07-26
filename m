Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web12.26989.1627285027316304764
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Jul 2021 00:37:07 -0700
Received: by mail-wm1-f43.google.com with SMTP id u15so1297601wmj.1
        for <u-boot-amlogic@groups.io>; Mon, 26 Jul 2021 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nR+tWuvqAE7rxz+tpjl8HQh2a1no3WRSsOdKB2QrJeU=;
        b=dLIYZcJJcgZ0dmjdRSkDGxSvk7tTpGdYWNwrfTc4nGJJPB57mppV4PCam+ewrzTGXK
         W9RwQopjOzoccyAOUj6GCAS+jEPDC9Yok3zydUPADKeXq0BFntWwpKihZ/ElkAgk7XIt
         TPz027hoCYWAHnq01Q4FsOsMr47ndxMpWkpRYvDg6Lq/QrcGJ/Qq1Bf06WyJls0Zj7YP
         A66hgV/U+pQSFM3WoSQsNWCiYKaHUAgp5O5G2SnW629GbZb0o0VFQLKge+HKUVJw2NDe
         lxBz9URPPGNAUevjrHbZJlyeB1dncwnU3q0LKr2ygIHsUNEwDXdEcLpjQ6D4p3D88jVz
         O2gA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] dts: khadas vim series: Use devicetree for SMBIOS settings
References: <20210715050026.2940786-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <080543bf-e2ed-5706-70ed-1bd1dbd4fa96@baylibre.com>
Date: Mon, 26 Jul 2021 09:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <20210715050026.2940786-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Subject should be: "[PATCH] ARM: dts: meson: Use devicetree for SMBIOS settings for Khadas VIM boards"

with that:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

On 15/07/2021 07:00, Artem Lapkin wrote:
> Khadas vim series: Use devicetree for SMBIOS settings
> Add settings and enable the default sysinfo driver so that these can come
> from the device tree.
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  | 23 +++++++++++++++++++
>  .../meson-gxl-s905x-khadas-vim-u-boot.dtsi    | 23 +++++++++++++++++++
>  .../arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi | 21 +++++++++++++++++
>  .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    | 23 +++++++++++++++++++
>  4 files changed, 90 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
> index 489efa15..fcd6f053 100644
> --- a/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
> +++ b/arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi
> @@ -6,3 +6,26 @@
>  
>  #include "meson-g12-common-u-boot.dtsi"
>  #include "meson-khadas-vim3-u-boot.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "khadas";
> +				product = "VIM3";
> +			};
> +
> +			baseboard {
> +				manufacturer = "khadas";
> +				product = "VIM3";
> +			};
> +
> +			chassis {
> +				manufacturer = "khadas";
> +				product = "VIM3";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> index 39270ea7..20e36d1b 100644
> --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> @@ -5,3 +5,26 @@
>   */
>  
>  #include "meson-gxl-u-boot.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "khadas";
> +				product = "VIM";
> +			};
> +
> +			baseboard {
> +				manufacturer = "khadas";
> +				product = "VIM";
> +			};
> +
> +			chassis {
> +				manufacturer = "khadas";
> +				product = "VIM";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> index c1763336..41480c9a 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> @@ -10,6 +10,27 @@
>  	aliases {
>  		spi0 = &spifc;
>  	};
> +
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "khadas";
> +				product = "VIM2";
> +			};
> +
> +			baseboard {
> +				manufacturer = "khadas";
> +				product = "VIM2";
> +			};
> +
> +			chassis {
> +				manufacturer = "khadas";
> +				product = "VIM2";
> +			};
> +		};
> +	};
>  };
>  
>  &sd_emmc_c {
> diff --git a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
> index a591c0c9..06b81f23 100644
> --- a/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
> +++ b/arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi
> @@ -6,3 +6,26 @@
>  
>  #include "meson-sm1-u-boot.dtsi"
>  #include "meson-khadas-vim3-u-boot.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "khadas";
> +				product = "VIM3L";
> +			};
> +
> +			baseboard {
> +				manufacturer = "khadas";
> +				product = "VIM3L";
> +			};
> +
> +			chassis {
> +				manufacturer = "khadas";
> +				product = "VIM3L";
> +			};
> +		};
> +	};
> +};
> 

