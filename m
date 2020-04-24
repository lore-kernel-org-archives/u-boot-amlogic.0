Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.1227.1587712704186778101
 for <u-boot-amlogic@groups.io>;
 Fri, 24 Apr 2020 00:18:25 -0700
Received: by mail-wr1-f68.google.com with SMTP id d15so7856998wrx.3
        for <u-boot-amlogic@groups.io>; Fri, 24 Apr 2020 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GuzgNOax9FGdgCOdZ+htNCljFj+CSx0/ivxNU6oU4X0=;
        b=jUj+O8LbWEYKjtp72bVXGqLEwFT9FOytzDTmMm7UsdNINJaRdYa4Ft1IR007+raeTW
         wQM3TbBTKEE4Xd/KQMrRx0jDDAPi2XmrGCdokj5c+6ceC1I1FLf7AcZ7Q+rkIMyUlS0n
         3mKwNS+wX7mdmAatWC6fwxzz8xbF0LUfu90DI1U6AbBuZH+m8/WOgtOyWdx3Qbv5QV9g
         LWGNz4qdY22kYgOBLffX7KfH8ob7lS8t9v2DUGWgHxu74rYzYstoBaV88bhmsq/r3cVM
         SpmTl3AjK+utd8jvVzH8RcaQ3pgKfKQ4CVBIlB8MpBEYeCqA3pTLWDPAmVy3c58C7tfw
         gnTg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <1607C7CBC1E2C0D1.18995@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6e979b17-78ab-c8ad-afc5-a058a26516a8@baylibre.com>
Date: Fri, 24 Apr 2020 09:18:20 +0200
MIME-Version: 1.0
In-Reply-To: <1607C7CBC1E2C0D1.18995@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, marex@denx.de
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 21/04/2020 10:17, Neil Armstrong via groups.io wrote:
> Power on/off the PHYs to enable power to the USB ports, fixing USB support
> on Khadas VIM3/VIM3L boards.
> 
> The G12A USB complex has at least 2 USB2 PHYs, but one is muxed between the
> DWC2 and DWC3 controller and the other one directly connected to the DWC3
> controller. The USB3+PCIe combo PHY is muxed between the DWC3 controller
> and a DW-PCIE controller.
> All PHYs are optional, but it's type (usb2/usb3) and position are important
> to determine it's capabilities, thus they are stored in a fixed size
> array and the phy-name determines it's position, it's position determining
> it's type and functionnalities.
> This is why we need to loop over the array to power on all the DT provided
> PHYs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Changes since v1:
> - removed extra space before semicolon
> - added clarification in commit message
> 
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index d4453f8784..de964d6c10 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>  			goto err_phy_init;
>  	}
>  
> +	for (i = 0; i < PHY_COUNT; ++i) {
> +		if (!priv->phys[i].dev)
> +			continue;
> +
> +		ret = generic_phy_power_on(&priv->phys[i]);
> +		if (ret)
> +			goto err_phy_init;
> +	}
> +
>  	return 0;
>  
>  err_phy_init:
> @@ -430,6 +439,13 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
>  
>  	clk_release_all(&priv->clk, 1);
>  
> +	for (i = 0; i < PHY_COUNT; ++i) {
> +		if (!priv->phys[i].dev)
> +			continue;
> +
> +		 generic_phy_power_off(&priv->phys[i]);
> +	}
> +
>  	for (i = 0 ; i < PHY_COUNT ; ++i) {
>  		if (!priv->phys[i].dev)
>  			continue;
> 

Applied to u-boot-amlogic
