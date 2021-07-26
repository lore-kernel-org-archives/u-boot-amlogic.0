Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.27085.1627285101247951287
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Jul 2021 00:38:21 -0700
Received: by mail-wm1-f51.google.com with SMTP id z8-20020a1c4c080000b029022d4c6cfc37so7490354wmf.5
        for <u-boot-amlogic@groups.io>; Mon, 26 Jul 2021 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RlrJhJDsGRyCjI1zVJxSh96rWjZmaU6a6a/vRVLAZU=;
        b=gDaEFWe8hwT1d2VP77NgxWrNCkfkXdIJm5VqOLmytcS58i56cSA/lJLOJIEiaZ20o0
         st1MuqGrXxvg0eu/KuzsukB7wWtuXM7ud9e3j+7ADQUlB9b6+9i6v/8g/rDXvqmD2t65
         fGgPGL5MdppZ02pkuWePAgMlj3rkkPMU5oHcTYFEq40l2YpMbXyYR6N8EIaFsyI53sRB
         RJXO1OXL84NF41JZxCJrvjcNVnGpu49/45GrcFdZaFvUw8rvjkl7jeYtzPyLibUblQtx
         QYeztxplGe6u5JgbbEEEXgnxW6eg8aMuHdu5zOaIe5wxOuft/MEPcGWj3410YxNDS7qQ
         HX7g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: designware: improve ethernet DMA reset
References: <20210721061910.776977-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <18a83243-3a80-1ab2-ea4f-04351120fb10@baylibre.com>
Date: Mon, 26 Jul 2021 09:38:18 +0200
MIME-Version: 1.0
In-Reply-To: <20210721061910.776977-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>, joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 21/07/2021 08:19, Artem Lapkin wrote:
> Problem: uboot ethernet always have "DMA reset timeout" after
> linux usage, detected on VIM2 VIM3 VIM3L amlogic devices,
> mainline uboot and mainline linux > 5.1? .
> 
> How-to reproduce:
> 
> 1) Poweron device => ethernet uboot work fine.
> 2) Linux start and ethernet interface up and same works.
> 3) Reboot to uboot again and we cant use ethernet anymore.
> uboot always have "DMA reset timeout" inside designware_eth_init()
> only poweroff/poweron cycle can solve this problem.
> 
> Solution: add phy_reset() into waiting DMA reset cycle,
> this insertion doesn't break normal behaviour (maybe).
> 
> Note: same need explore real problem why its happens! because this 
> patch may be just hack.

Interesting, maybe add this phy_reset() call only if the GPIO reset is not available ?

Neil

> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/net/designware.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 5d92257e..6485c46d 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -371,6 +371,7 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
>  	struct eth_dma_regs *dma_p = priv->dma_regs_p;
>  	unsigned int start;
>  	int ret;
> +	int phy_reset_force = 0;
>  
>  	writel(readl(&dma_p->busmode) | DMAMAC_SRST, &dma_p->busmode);
>  
> @@ -389,6 +390,9 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
>  			printf("DMA reset timeout\n");
>  			return -ETIMEDOUT;
>  		}
> +		// forced phy reset after 0.2s can help with DMAMAC_SRST
> +		if (phy_reset_force++ == 2)
> +			phy_reset(priv->phydev);
>  
>  		mdelay(100);
>  	};
> 

