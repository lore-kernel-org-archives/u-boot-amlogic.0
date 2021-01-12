Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web09.7580.1610449658669434754
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Jan 2021 03:07:39 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210112110735epoutp0443ea6a122e212180f785591c855e360c~Zd23zeWew2372623726epoutp04f
	for <u-boot-amlogic@groups.io>; Tue, 12 Jan 2021 11:07:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210112110735epoutp0443ea6a122e212180f785591c855e360c~Zd23zeWew2372623726epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1610449655;
	bh=5RihQxOkVPlcaLA2iM417P711AXfyfsAQc2Vt/TDvBg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=uz91Ka0nXiYsy8tcrwkYI1v4lJRw6gC9iaR5EwvtcEtDdSnf766P3vpZ5benRCjaD
	 QhoUTGNLjLYo9EZQPlCzGWeyzHPDa2unCdur/wi4VrxgcblUqWNW/NPlPOIxkARwHE
	 axUwOg0mHo8kaBwqwdN/qJEFmvksPHJCz/FneSEk=
Subject: Re: [PATCH] board: amlogic: vim3: fix setup ethernet mac from efuse
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <d8f71cfc-7f13-ef54-84d8-17a36871e460@samsung.com>
Date: Tue, 12 Jan 2021 20:08:07 +0900
MIME-Version: 1.0
In-Reply-To: <20210112050308.774189-1-art@khadas.com>
References: <CGME20210112050445epcas1p19c5a31ae23bda75d62c393433f4e89d9@epcas1p1.samsung.com>
	<20210112050308.774189-1-art@khadas.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 1/12/21 2:03 PM, Artem Lapkin wrote:
> Fix reading built-in ethernet MAC address from efuse
> 
> NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
> 
> if mac from efuse not valid we use meson_generate_serial_ethaddr
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

Doesn't need to print mac. If you have to print mac address, then fix the checkpatch error, plz.

ERROR: space required after that ',' (ctx:VxV)
#62: FILE: board/amlogic/vim3/vim3.c:174:
+                       mac_addr[0],mac_addr[1],mac_addr[2],
                                   ^
..

>  	}
>  
>  	return 0;
>  }
> +

Not need whitespace.

Best Regards,
Jaehoon Chung

> 

