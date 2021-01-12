Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8707.1610457719278743016
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Jan 2021 05:22:00 -0800
Received: by mail-wm1-f44.google.com with SMTP id e25so2117896wme.0
        for <u-boot-amlogic@groups.io>; Tue, 12 Jan 2021 05:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YpZ7ohjVWVsriq7tWPGh2t0M2ctmJ8A2GoI8ypMP7wA=;
        b=1jM+MO77lH3wi9y2vohDYvzieueREyyFo8EovNFsncKtBJZ+VgsrMNeCBhNMY3Bqal
         zSVNE+DFdyFjdD4iHuWKs+vzlb/Ll6c5it/qHx02ez/nQGMalOyltoDiyoElj0Y4luYJ
         yntc+12TgVOGWU43c7RRLC+9syp19VP/N+FnpazGexwPD+NkYnOAmALY9cvImxVfyd5U
         koY2EQOfHD3SBdeT2Z0bGxgZLoVofJMuYjaQngZpIIdRZWoX3wzB0ifAOpRSi7S3aXuf
         4iWqvyT0gL1Va6v7w6Ou/Qmf2xVS4t++RawZYSKybxq7K8W9jpF6M2RlkxnStcZiqErQ
         e1TQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: fix setup ethernet mac from efuse
References: <20210112114212.1427365-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <7ec3f4d4-295e-5862-008d-bec83fffaeac@baylibre.com>
Date: Tue, 12 Jan 2021 14:21:55 +0100
MIME-Version: 1.0
In-Reply-To: <20210112114212.1427365-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On 12/01/2021 12:42, Artem Lapkin wrote:
> Fix reading built-in ethernet MAC address from efuse
> 
> NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
> 
> if mac from efuse not valid we use meson_generate_serial_ethaddr
> 
> NOTE: remake odroid-n2.c from Neil Armstrong <narmstrong@baylibre.com>
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 824fff8262..87d9fe1f02 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -139,26 +139,42 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>  }
>  
>  #define EFUSE_MAC_OFFSET	0
> -#define EFUSE_MAC_SIZE		6
> +#define EFUSE_MAC_SIZE		12
> +#define MAC_ADDR_LEN		6
>  
>  int misc_init_r(void)
>  {
> -	uint8_t mac_addr[EFUSE_MAC_SIZE];
> +	u8 mac_addr[MAC_ADDR_LEN];
> +	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>  	ssize_t len;
>  
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
>  	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>  		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> -					  mac_addr, EFUSE_MAC_SIZE);
> +					  efuse_mac_addr, EFUSE_MAC_SIZE);
>  		if (len != EFUSE_MAC_SIZE)
>  			return 0;
>  
> +		/* MAC is stored in ASCII format, 1bytes = 2characters */
> +		for (int i = 0; i < 6; i++) {
> +			tmp[0] = efuse_mac_addr[i * 2];
> +			tmp[1] = efuse_mac_addr[i * 2 + 1];
> +			tmp[2] = '\0';
> +			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
> +		}
> +
>  		if (is_valid_ethaddr(mac_addr))
>  			eth_env_set_enetaddr("ethaddr", mac_addr);
>  		else
>  			meson_generate_serial_ethaddr();
> +
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
> +		printf("[i] setup onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n",
> +		       mac_addr[0], mac_addr[1], mac_addr[2],
> +		       mac_addr[3], mac_addr[4], mac_addr[5]);


Yes, it's not necessary to print the MAC, I'll drop while applying.

>  	}
>  
>  	return 0;
>  }
> +
> 

Applying to u-boot-amlogic

Neil
