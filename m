Received: by mail-wr1-f66.google.com with SMTP id l2so5860194wrb.9
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tbIUgkA4Derj5vWwRcIR2xYGvH/HBHb+vu2t3vLwL/s=;
        b=cfmegml/kF+7Gr+i+LOiXC+E10UERZjlCWIkCKDRib00VSuHwVLRXZIsLGjalGpQSu
         yUJELO2UMNXKIlD/2kQTCNNkdbXqhONxs4J/1dKZrCA0PdVp2r6RhRU3OTtw3Sg1lrP/
         oApTq+o/rQRDh6Zi85tonM9oaVstJSBABswJHMw7Gcobtz0yP2tXxiazyzSbgncUsMIX
         fascPe5kfT6bHnUfWCbYtMTdpvc95eYza66v8TKKoBw/+A24s9XOmTIQmMUIukMzqvZT
         FB+ZfIFSrzlkSOXgV3Y41YjPAIlGjfMHSaHYGpHC2PogXuTdR274jKnyAVhguZFAK61z
         FfxA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] boards: amlogic-g200: remove phy reset
References: <20190528111515.1660-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <93981dc1-3673-ae57-cb9f-04786adafa92@baylibre.com>
Date: Fri, 31 May 2019 10:20:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190528111515.1660-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 28/05/2019 13:15, Neil Armstrong wrote:
> The PHY reset is now handled by the MAC driver, remove this leftover.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  board/amlogic/q200/q200.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
> index 1932c14aa2..2ea97c362e 100644
> --- a/board/amlogic/q200/q200.c
> +++ b/board/amlogic/q200/q200.c
> @@ -26,12 +26,6 @@ int misc_init_r(void)
>  
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
> -	/* Reset PHY on GPIOZ_14 */
> -	clrbits_le32(GX_GPIO_EN(3), BIT(14));
> -	clrbits_le32(GX_GPIO_OUT(3), BIT(14));
> -	mdelay(10);
> -	setbits_le32(GX_GPIO_OUT(3), BIT(14));
> -
>  	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>  		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>  					  mac_addr, EFUSE_MAC_SIZE);
> 

Applied to u-boot-amlogic
