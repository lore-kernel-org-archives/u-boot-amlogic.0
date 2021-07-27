Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.8595.1627374827035362910
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:33:47 -0700
Received: by mail-wr1-f52.google.com with SMTP id l4so14164695wrs.4
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZI9pj5OBGk8o116wGXyX6Dmg5L9tHbv5KW32q3fI7eQ=;
        b=z7+e/31K4pQBUFr+Va28DlcfdWaWrDbCACtcYvhcdJLzPjxcpSP0xFIW8/tgWV5Ctt
         BS5jPe3UaifbT9pJDzdICDdJVCYu80qhNSXseks8PsO5q5dlqXXfvqT+eacXovTQRjXW
         JDcI4X8JyktgE9XjYV5HMgGEUAiFNeDAh+O0gH6+mlNMnCGHqQj0H/pycMokJ6qoMJym
         YogYMOh5OEDvsA/zrETHkVLDgPtcfNURBL5AWEib1TsmR70pyj1yqR33ZukhBQR7wZtv
         6+mmeKC6IVdeUfyfYEfGTK4adMdl8e34Rse5OcrGpA88FCjXg0l3g67lSFdERWlWQGZ2
         shEw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: dts: meson: Use devicetree for SMBIOS settings for Khadas VIM boards
References: <20210727012319.1024276-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6cff934d-8f44-88e1-a106-8d4f0882a1c1@baylibre.com>
Date: Tue, 27 Jul 2021 10:33:44 +0200
MIME-Version: 1.0
In-Reply-To: <20210727012319.1024276-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 27/07/2021 03:23, Artem Lapkin wrote:
> Khadas vim series: Use devicetree for SMBIOS settings
> Add settings and enable the default sysinfo driver so that these can come
> from the device tree.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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



Applied to u-boot-amlogic,

Thanks,
Neil

