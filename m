Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.9139.1582098569043087263
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Feb 2020 23:49:29 -0800
Received: by mail-wr1-f66.google.com with SMTP id w15so26967834wru.4
        for <u-boot-amlogic@groups.io>; Tue, 18 Feb 2020 23:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5PV3T1/VEO7/qdn/JjX/N3ldLDBmi80Jc/fZjnOadu0=;
        b=wPLMoHTlEiL+bxIqwAMoQh5jnvX5t5gEeYgx6WsvpEo0G5BUVNE31Xjm6CHi9XO3wj
         G2ZOvF+1aLiZyM4S6Rwy3zSajoW4+IXn5V6/1hawdrgT94MmuZutKDpN0ilJJlnAiyLC
         gysriXyfP6EvogeYWKf3Z905XdWMwZ1wLtSsZH7jfAnsJe2M3rOzoI7cTE5ceiVjDNlx
         LVwjVwT5qWjnAPJukPHg9pDD2vCgvFefvyarQOW/b/itH/xS5XvO4D8j+CtEJR7+TCnb
         Et8wU7th06WkWx2nY0J9glJbULh5LDz4yk6ui6UEJhoZ/rFXk6zN0f76VLu+oR8HTASX
         YO+w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 09/10] usb: Use ofnode as usb_get_dr_mode() parameter
References: <20200219015447.19392-1-kever.yang@rock-chips.com>
 <20200219015447.19392-10-kever.yang@rock-chips.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a7131adf-7e14-57ba-5769-8b7882aae4b1@baylibre.com>
Date: Wed, 19 Feb 2020 08:49:25 +0100
MIME-Version: 1.0
In-Reply-To: <20200219015447.19392-10-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Adam Ford <aford173@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 19/02/2020 02:54, Kever Yang wrote:
> ofnode is more common and no need to convert to offset after we migrate
> other API to use ofnode.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  drivers/usb/cdns3/core.c           | 2 +-
>  drivers/usb/common/common.c        | 7 +++----
>  drivers/usb/dwc3/dwc3-generic.c    | 6 +++---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
>  drivers/usb/gadget/dwc2_udc_otg.c  | 5 ++---
>  drivers/usb/host/dwc3-sti-glue.c   | 2 +-
>  drivers/usb/host/ehci-mx6.c        | 2 +-
>  drivers/usb/host/xhci-dwc3.c       | 3 +--
>  drivers/usb/musb-new/ti-musb.c     | 2 +-
>  include/linux/usb/otg.h            | 4 ++--
>  10 files changed, 16 insertions(+), 19 deletions(-)
> 

[...]

> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index a55def5aba..4300f711a9 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -7,7 +7,7 @@
>   */
>  
>  #include <common.h>
> -#include <linux/libfdt.h>
> +#include <dm.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ch9.h>
>  
> @@ -20,13 +20,12 @@ static const char *const usb_dr_modes[] = {
>  	[USB_DR_MODE_OTG]		= "otg",
>  };
>  
> -enum usb_dr_mode usb_get_dr_mode(int node)
> +enum usb_dr_mode usb_get_dr_mode(ofnode node)
>  {
> -	const void *fdt = gd->fdt_blob;
>  	const char *dr_mode;
>  	int i;
>  
> -	dr_mode = fdt_getprop(fdt, node, "dr_mode", NULL);
> +	dr_mode = ofnode_read_string(node, "dr_mode");
>  	if (!dr_mode) {
>  		pr_err("usb dr_mode not found\n");
>  		return USB_DR_MODE_UNKNOWN;
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index ced0f53bfd..7178f12b47 100644

[..]

> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 832bcd70ff..d4453f8784 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -393,7 +393,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>  	}
>  #endif
>  
> -	priv->otg_mode = usb_get_dr_mode(dev_of_offset(dev));
> +	priv->otg_mode = usb_get_dr_mode(dev->node);
>  
>  	ret = dwc3_meson_g12a_usb_init(priv);
>  	if (ret)

For drivers/usb/dwc3/dwc3-meson-g12a.c:
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
