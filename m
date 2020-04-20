Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web11.2229.1587390447480115370
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:47:28 -0700
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
Date: Mon, 20 Apr 2020 15:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200420134601.19863-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 4/20/20 3:46 PM, Neil Armstrong wrote:
> Power on/off the PHYs to enable power to the USB ports, fixing USB support
> on Khadas VIM3/VIM3L boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index d4453f8784..8f4a2f3f82 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>  			goto err_phy_init;
>  	}
>  
> +	for (i = 0 ; i < PHY_COUNT ; ++i) {

Doesn't checkpatch complain about this extra space before semicolon ?

> +		if (!priv->phys[i].dev)
> +			continue;
> +
> +		ret = generic_phy_power_on(&priv->phys[i]);

Do we really need to turn on all the PHYs ?
