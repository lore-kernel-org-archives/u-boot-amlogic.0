Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.34118.1610373552311439693
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 05:59:13 -0800
Received: by mail-wm1-f44.google.com with SMTP id a6so13897547wmc.2
        for <u-boot-amlogic@groups.io>; Mon, 11 Jan 2021 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OpDin3VAP8G6fRDOjfSUArAyVAIvP8CUmNXUfOHGNDA=;
        b=QttGY7qXk1LyO0JDCrpLmrF37D7AJLP4sgXEB3PVjLbvRGQOyBrNJDqlTMWqAMvqbL
         GQB+9oYsse5kAr9uBrQDHVMLl2Wi5+Kxg4SingvVONRCrfMLE2nRY4FANQMyAl9xmzCc
         f9F7dwwLV136PdhxUGxhXiKcxw6Jqv5lHUbWM8zrCwjFJ7qbya4EOnayq02XHcs9738A
         dvDracSuVN14LXaqMkdL+Hr47qZiBLOOmKmuoACqlFGk1r90lVp3m4wa5MrGmKYipmQu
         7GVyy1knQUEAm+J1vIef0TPRQQhwaNuXSGYZKCGEaPRWAt/FjH+KgV5waV7hDhp8Ri3T
         wNFw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: setup ethernet mac from efuse
References: <20210111111929.504886-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <406660b1-89fd-e402-6e8d-aa358acce96c@baylibre.com>
Date: Mon, 11 Jan 2021 14:59:08 +0100
MIME-Version: 1.0
In-Reply-To: <20210111111929.504886-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, m.szyprowski@samsung.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On 11/01/2021 12:19, Artem Lapkin wrote:
> Add the board specific code for reading built-in ethernet MAC address from efuse
> 
> NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
> 
> if mac from efuse not valid we use meson_generate_serial_ethaddr
> 
> NOTE: remake odroid-n2.c variant from Neil Armstrong <narmstrong@baylibre.com>

So the patch from Marek (https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/) doesn't work ?
Are you sure the MAC is stored in ASCII like Odroid-N2 ?

Please look at my u-boot-amlogic-next tree I will push this week for the next u-boot release:
https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-next

Neil

> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 09ef39ff30..c5d19cc17b 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -11,9 +11,14 @@
>  #include <net.h>
>  #include <asm/io.h>
>  #include <asm/arch/eth.h>
> +#include <asm/arch/sm.h>
>  #include <i2c.h>
>  #include "khadas-mcu.h"
>  
> +#define EFUSE_MAC_OFFSET	0
> +#define EFUSE_MAC_SIZE		12
> +#define MAC_ADDR_LEN		6
> +
>  /*
>   * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>   * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> @@ -131,7 +136,37 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>  
>  int misc_init_r(void)
>  {
> +	u8 mac_addr[MAC_ADDR_LEN];
> +	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
> +	ssize_t len;
> +
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> +
> +		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET, efuse_mac_addr, EFUSE_MAC_SIZE);
> +		if (len != EFUSE_MAC_SIZE)
> +			return 0;
> +
> +		/* MAC is stored in ASCII format, 1bytes = 2characters */
> +		for (int i = 0; i < 6; i++) {
> +			tmp[0] = efuse_mac_addr[i * 2];
> +			tmp[1] = efuse_mac_addr[i * 2 + 1];
> +			tmp[2] = '\0';
> +			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
> +		}
> +
> +		if (is_valid_ethaddr(mac_addr))
> +			eth_env_set_enetaddr("ethaddr", mac_addr);
> +		else
> +			meson_generate_serial_ethaddr();
> +
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
> +		printf("[i] setup onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			mac_addr[0],mac_addr[1],mac_addr[2],
> +			mac_addr[3],mac_addr[4],mac_addr[5]);
> +
> +	}
> +
>  	return 0;
>  }
> 

