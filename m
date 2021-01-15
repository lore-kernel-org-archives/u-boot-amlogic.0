Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.1229.1610698522527103186
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 00:15:23 -0800
Received: by mail-wr1-f44.google.com with SMTP id d26so8299012wrb.12
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 00:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xfGl50Lx/GH1GoizXENbmNtJCE2rus+1bfXTQ6o5nhA=;
        b=gOPiRdLwiAkOtxPi/f/N6eh0i9vka6o03oYuFkfUYBPlHhIsspTDMfyG0K4qEVD1hg
         UycW9Y5Vei39qffJ7YYfJDbVmmn1WE4OZNbh63FrAmg1BuMTjkfUNH0/dit88wzboR+V
         yLIb8Aek/eqzdsm89lGVaLYLEF6JF5Gwu9GiWGbmq2Yg+XTHkXKOWyTSuod1YeOoqPF9
         vVPd7Z8Mmzz/bavtZtbgmLdEnyNEnRrKtUVEr9ABC+GKWxfg0cOiiWj+BmeIkST/P1MZ
         nGeSOlFutlXKron+k0rvi6qAJ6zkcr/yRctfQIvWOEBuukJXqkmXSH51Ywu7GbpV4vT0
         QfNg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: fix meson-khadas-vim3-u-boot.dtsi
References: <20210115051558.469734-1-art@khadas.com>
 <20210115051558.469734-3-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0aa51879-43da-d249-09c3-b32e601224b6@baylibre.com>
Date: Fri, 15 Jan 2021 09:15:19 +0100
MIME-Version: 1.0
In-Reply-To: <20210115051558.469734-3-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, hs@denx.de, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,


On 15/01/2021 06:15, Artem Lapkin wrote:
> Add missed include meson-g12-common-u-boot.dtsi
> 
> PROBLEM: missed hdmi video setup for VIM3 and VIM3L boards
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> index 81fd5be378..5d6444cbac 100644
> --- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> +++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> @@ -10,6 +10,8 @@
>  	};
>  };
>  
> +#include "meson-g12-common-u-boot.dtsi"
> + 

It's not necessary since already included in:
arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi:#include "meson-g12-common-u-boot.dtsi"
and
arch/arm/dts/meson-sm1-u-boot.dtsi:#include "meson-g12-common-u-boot.dtsi"

What u-boot version are you using ?
Please check u-boot-master and my u-boot-amlogic and u-boot-amlogic-next branches on https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic before posting !

Thanks,
Neil
