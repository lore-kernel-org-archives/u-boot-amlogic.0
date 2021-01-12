Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web10.5189.1610427388806465985
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 20:56:29 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210112045625epoutp0414db00968b6969582eae4700a516b1a7~ZYyzFVk852462024620epoutp04m
	for <u-boot-amlogic@groups.io>; Tue, 12 Jan 2021 04:56:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210112045625epoutp0414db00968b6969582eae4700a516b1a7~ZYyzFVk852462024620epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1610427385;
	bh=4hE8hUo/bGZ5XNIYf66WFyw4YPArYQr85T3gv4gpgI0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=DVDG311LN1VXkkoOOArykp1vxe3hNRrT7+9TuapZ8tiMxZOPVcNgQrsBX6Dx9tx2r
	 79+Uhf131BY8xq8yRWdKkcQNX0bLPULD3hLpRFX4l9l79P+taMWUkYHaf79FD/q6L2
	 fWZIkTsaV5IC5erpJdm4mWMFJLlRyWnqdXIfNMuk=
Subject: Re: [PATCH] board: amlogic: vim3: fix setup ethernet mac from efuse
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <dbfeeef6-3518-4bf4-b2f3-8fa5def466d5@samsung.com>
Date: Tue, 12 Jan 2021 13:56:51 +0900
MIME-Version: 1.0
In-Reply-To: <20210112043011.722605-1-art@khadas.com>
References: <CGME20210112043201epcas1p2eddcb51eed5f193425cacb7b5d51326e@epcas1p2.samsung.com>
	<20210112043011.722605-1-art@khadas.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, m.szyprowski@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On 1/12/21 1:30 PM, Artem Lapkin wrote:
> Fix reading built-in ethernet MAC address from efuse
> 
> NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
> 
> if mac from efuse not valid we use meson_generate_serial_ethaddr

Could you resend patch after adding u-boot mailing list?

Best Regards,
Jaehoon Chung

> 
> NOTE: remake odroid-n2.c variant from Neil Armstrong <narmstrong@baylibre.com>
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
> +	uint8_t mac_addr[MAC_ADDR_LEN];
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
> +			mac_addr[0],mac_addr[1],mac_addr[2],
> +			mac_addr[3],mac_addr[4],mac_addr[5]);
>  	}
>  
>  	return 0;
>  }
> +
> 

