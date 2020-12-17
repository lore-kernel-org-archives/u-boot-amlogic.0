Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.5279.1608194634868645204
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Dec 2020 00:43:55 -0800
Received: by mail-wr1-f52.google.com with SMTP id y17so25681277wrr.10
        for <u-boot-amlogic@groups.io>; Thu, 17 Dec 2020 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gh2+US+uuh5r4zSXVd9YcAl2gV/2GttdJ/CDnt1OtvY=;
        b=qkB0UwhM13b0+TZxSc2EF7y75I53JUBiSAXNUuxULIjtTMfsJEEZssU/WPr8bCCrdg
         nOGcMRmpAbDwuBWieF8stC+rKQstTlRZVOg9RbrUuaNmAGD/D9m2UNT4zeYWQDPO4qBD
         UdXwk/KEfDI90K/+jvRRVE3y72Ph+JHUW4kLMHGapxN1dUCnmMn7JA2ZF4tAoJ6H2q/N
         dcx9pw6JQ2SuTI0lm3ZrWOyZ5NqDcWI5HeAMml6G9WZn6wruLk6L2AsF83pTfhRheWAp
         +PXfiXLBFxk5CSudbS3zx37HqyrrGNKcauTttk/DUJA56jKkLtsycnP1jeXWUDD0NxVh
         wiDw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: read ethernet MAC address from efuse
References: <CGME20201217072655eucas1p123aa0a548e4de21a8ac580dbc990c760@eucas1p1.samsung.com>
 <20201217072642.1319-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <449d0947-d1b1-b79f-cd49-4566f5b8d2fd@baylibre.com>
Date: Thu, 17 Dec 2020 09:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <20201217072642.1319-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 17/12/2020 08:26, Marek Szyprowski wrote:
> Add the board specific code for reading built-in ethernet MAC address
> from efuse.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  board/amlogic/vim3/vim3.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 09ef39ff30..a36df61583 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -11,6 +11,7 @@
>  #include <net.h>
>  #include <asm/io.h>
>  #include <asm/arch/eth.h>
> +#include <asm/arch/sm.h>
>  #include <i2c.h>
>  #include "khadas-mcu.h"
>  
> @@ -129,9 +130,27 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>  	return 0;
>  }
>  
> +#define EFUSE_MAC_OFFSET	0
> +#define EFUSE_MAC_SIZE		6
> +
>  int misc_init_r(void)
>  {
> +	uint8_t mac_addr[EFUSE_MAC_SIZE];
> +	ssize_t len;
> +
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> +		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> +					  mac_addr, EFUSE_MAC_SIZE);
> +		if (len != EFUSE_MAC_SIZE)
> +			return 0;
> +
> +		if (is_valid_ethaddr(mac_addr))
> +			eth_env_set_enetaddr("ethaddr", mac_addr);
> +		else
> +			meson_generate_serial_ethaddr();
> +	}
> +
>  	return 0;
>  }
> 

Thx, I wasn't aware Khadas flashed the MAC address in the fuse

I'll do a quick test on my boards.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
