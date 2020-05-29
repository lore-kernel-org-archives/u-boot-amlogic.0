Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.32857.1590753208347901322
 for <u-boot-amlogic@groups.io>;
 Fri, 29 May 2020 04:53:28 -0700
Received: by mail-wm1-f67.google.com with SMTP id r15so3100936wmh.5
        for <u-boot-amlogic@groups.io>; Fri, 29 May 2020 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvyLpMsM5v9utMRsX32kcaIJ4REYP7e1eANF1qdV96Q=;
        b=Cz5B/ryFEgfivzcK5MRil6qBnkt/bzuAQ4wuCri0Y4nQrYNo42E5kbR4VybXg+bPee
         DekOKHuc2zHtkZrGHAKhKBy/NDgU2EV9zdn/S2y7WxiHkIqCdvQBZid9ylvqHKKAGXEY
         6g3IFQvqApG+bhkf9hE5gZPe2e9jnoIYRIx38iPkasIeyxvQNNkRsBjrlRfPNQh/YJ7L
         oRnW5j2t848bUkBrLBxE/zpKbC4WD9veNLgwpouQG3WO4bpBDwoWk/9QOZuFadi9ZRfy
         QfPTPa5XTECqrI6S0YexCv4y4Hak3F5d8WzdSYzcKCsklWcKv52/mfXrI9/3AHktTKP+
         ChzQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm: dts: meson-gxl: fix USB gadget by adding missing nodes for U-Boot
References: <20200528134727.32534-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5c617836-d8ee-0f13-8ea2-bb0193b5bc6f@baylibre.com>
Date: Fri, 29 May 2020 13:53:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200528134727.32534-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Jerome Brunet <jbrunet@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 28/05/2020 15:47, Neil Armstrong wrote:
> The khadas-vim, khadas-vim2, libretech-ac & libretech-*-pc boards were missing
> DT tweak to enable USB gadget.
> Add them to their -u-boot.dtsi files and include the right gxl-u-boot.dtsi.
> 
> Fixes: a19e8a0f03 ("arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot")
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 6 +++++-
>  arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi | 6 +++++-
>  arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi   | 4 ++++
>  arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi        | 6 +++++-
>  arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi  | 6 +++++-
>  5 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> index c35158d7e9..474a3e1604 100644
> --- a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> @@ -4,4 +4,8 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxl-u-boot.dtsi"
> +
> +&dwc2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
> index c35158d7e9..474a3e1604 100644
> --- a/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
> @@ -4,4 +4,8 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxl-u-boot.dtsi"
> +
> +&dwc2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> index 39270ea71c..474a3e1604 100644
> --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
> @@ -5,3 +5,7 @@
>   */
>  
>  #include "meson-gxl-u-boot.dtsi"
> +
> +&dwc2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> index bec9e05b09..7aecf2696b 100644
> --- a/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
> @@ -4,7 +4,7 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxl-u-boot.dtsi"
>  
>  / {
>  	aliases {
> @@ -12,6 +12,10 @@
>  	};
>  };
>  
> +&dwc2 {
> +	status = "okay";
> +};
> +
>  &sd_emmc_c {
>  	status = "okay";
>  	pinctrl-0 = <&emmc_pins>;
> diff --git a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
> index c35158d7e9..474a3e1604 100644
> --- a/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
> @@ -4,4 +4,8 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> -#include "meson-gx-u-boot.dtsi"
> +#include "meson-gxl-u-boot.dtsi"
> +
> +&dwc2 {
> +	status = "okay";
> +};
> 

Applied to u-boot-amlogic
