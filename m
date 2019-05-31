Received: by mail-wr1-f67.google.com with SMTP id d9so5900665wrx.0
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ScLVSL2eyGs36/ElWJWqWPGCxi9S95LUYttgUdVVUJk=;
        b=Gu9Qo7aq7DX4byLy6Llf+R95wiIDXp94fooFe1N5SVWu/BAF+r9Dc8YMJRcmhHF/PW
         1YT3xYzeJxqvu1wIQvxtSobkpyPLqk1x3m+bEUWp0M4n6TB6r1nb2iayWcFK5W2YZPr1
         obf86UtUQcNsFsszyycq07NaHBYWwvrre0owPMtcHJDyrir1Ek2gSNb++jN9iK3j5Ett
         Ez46yzjPb3gDvN+bQhL+neVMId2xJ6ZATI/x7Js76KzUKyAW0thRvI0zQZwITtdniSE2
         Y+ofxukfmIY26Hq/cILTLugTwHUp+HeoOgw0h/nIkpbgysE3o0Crc25ZkgErKtNCH6MT
         /4jQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: meson-gx: Reset GXL/GXM to external PHY when not using internal PHY
References: <20190528111319.1244-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <33ee3d0d-5235-a9d0-bdc5-42bb0635cf4d@baylibre.com>
Date: Fri, 31 May 2019 10:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190528111319.1244-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 28/05/2019 13:13, Neil Armstrong wrote:
> When using External PHY, reset the mux to use the external PHY in case U-Boot
> was chainloaded from a misconfigured bootloader.
> 
> Fixes: 33e3378091 ("ARM: meson: rework soc arch file to prepare for new SoC")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-meson/board-gx.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index e41552db52..2b0614b79b 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -112,6 +112,11 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
>  			     GX_ETH_REG_0_TX_RATIO(4) |
>  			     GX_ETH_REG_0_PHY_CLK_EN |
>  			     GX_ETH_REG_0_CLK_EN);
> +
> +		/* Reset to external PHY */
> +		if(!IS_ENABLED(CONFIG_MESON_GXBB))
> +			writel(0x2009087f, GX_ETH_REG_3);
> +
>  		break;
>  
>  	case PHY_INTERFACE_MODE_RMII:
> @@ -119,11 +124,13 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
>  		out_le32(GX_ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
>  					 GX_ETH_REG_0_CLK_EN);
>  
> -		/* Use GXL RMII Internal PHY */
> -		if (IS_ENABLED(CONFIG_MESON_GXL) &&
> -		    (flags & MESON_USE_INTERNAL_RMII_PHY)) {
> -			writel(0x10110181, GX_ETH_REG_2);
> -			writel(0xe40908ff, GX_ETH_REG_3);
> +		/* Use GXL RMII Internal PHY (also on GXM) */
> +		if (!IS_ENABLED(CONFIG_MESON_GXBB)) {
> +			if ((flags & MESON_USE_INTERNAL_RMII_PHY)) {
> +				writel(0x10110181, GX_ETH_REG_2);
> +				writel(0xe40908ff, GX_ETH_REG_3);
> +			} else
> +				writel(0x2009087f, GX_ETH_REG_3);
>  		}
>  
>  		break;
> 

Applied to u-boot-amlogic
