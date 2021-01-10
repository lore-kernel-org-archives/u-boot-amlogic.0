Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web12.25913.1610318773863578923
 for <u-boot-amlogic@groups.io>;
 Sun, 10 Jan 2021 14:46:14 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210110224610epoutp04c8287929d6ca2d8443ba1012439990d9~ZAGPoH1Vk0283902839epoutp04b
	for <u-boot-amlogic@groups.io>; Sun, 10 Jan 2021 22:46:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210110224610epoutp04c8287929d6ca2d8443ba1012439990d9~ZAGPoH1Vk0283902839epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1610318770;
	bh=olXwcfeuawSBeKQU8eMDqPBtD+1eT0/7H1jM/KhYshQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=LptE79a6a0x/scPk3bZnL2ItxQ1OGUhwUiXfqNdl8FyVvcMSiHOI3mxVc9RY7Jrtx
	 TXZ2j7+sshI0xklD+ElrQvYmg9Twwihx3pblZbwFUdA1SeKIXtk2F1B+aBgM5BotPX
	 ldKhVLwmEswGuoJiqsDlJAfWeQr/Yqw8O5jKtn1s=
Subject: Re: [PATCH] board: amlogic: vim3: ethernet mac fixed from serial
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <7675a623-ca60-a071-1add-aa03bfc92216@samsung.com>
Date: Mon, 11 Jan 2021 07:46:37 +0900
MIME-Version: 1.0
In-Reply-To: <20210108054323.1449108-1-art@khadas.com>
References: <CGME20210108124343epcas1p46dccb0f4dd6dad4bc177a560f4b1cb26@epcas1p4.samsung.com>
	<20210108054323.1449108-1-art@khadas.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 1/8/21 2:43 PM, Artem Lapkin wrote:
> Fixed randomly generated ethernet mac address!
> 
> Used meson_generate_serial_ethaddr for generate mac address from
> board serial number, if ethaddr variable not defined.

AFAIK, it's fixed with Marek's patch

https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/

Best Regards,
Jaehoon CHung

> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 09ef39ff30..0315eaf569 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -133,5 +133,14 @@ int misc_init_r(void)
>  {
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
> +	u8 mac_addr[6];
> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> +		meson_generate_serial_ethaddr();
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
> +		printf("[i] serial eth mac %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			mac_addr[0],mac_addr[1],mac_addr[2],
> +			mac_addr[3],mac_addr[4],mac_addr[5]);
> +	}
> +
>  	return 0;
>  }
> 

