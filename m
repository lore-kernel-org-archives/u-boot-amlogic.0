Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.192429.1673948601152197288
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jan 2023 01:43:22 -0800
Received: by mail-wr1-f54.google.com with SMTP id bk16so29917531wrb.11
        for <u-boot-amlogic@groups.io>; Tue, 17 Jan 2023 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DH1nIgiRCOR4y1RKzEzTfXVa13g1IH+s/b48+91yyhs=;
        b=07S/KP1m9L8Xa9L4UfuKBPzprhsETyywOQwMlz1535JsyGDIhEIalxQMptEMpoQMX1
         QseSka8/jBvGTBmyZKeP/XawhQwPrSGo2yg3417IE3i2Od39b8tGiPiJl4sthE/28nTi
         pw4AcyhSW/lwZYwxkymYZBimL5U7NHkefQtOl9h2/3eGktqSW0AJyC8rLBDCh3S/d89o
         m+0+zFJzqckgesxL0/LKzooF4e1647QgjzZ7kdVzuUBU41a90OaJWf82TPvSsTOfY40L
         GNc310pA0xeMDmJ6wCAoBvdNU2CIoevJpVZeeRtbzJu5PuBIa1sxocpzlNMufAOy2X35
         O8Xg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 1/2] usb: dwc3-meson-gxl: force mode on child add/removal
In-Reply-To: <20230117-u-boot-usb-gxl-otg-dm-v1-1-2853f6d75b06@linaro.org>
References: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
 <20230117-u-boot-usb-gxl-otg-dm-v1-1-2853f6d75b06@linaro.org>
Date: Tue, 17 Jan 2023 10:43:17 +0100
Message-ID: <87tu0pmr7u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Jan 17, 2023 at 10:11, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> arch/mach-meson has some custom usb logic, in particular:
> * on board_usb_init(), we force USB_DR_MODE_PERIPHERAL
> * on board_usb_cleanup(), we force USB_DR_MODE_HOST
>
> With DM_USB_GADGET=y, board_usb_init/cleanup() are no
> longer used when we call usb_gadget_initialize().
> Instead, the generic (from udc-uclass) initialization/release is
> called, which itself calls the controller driver's probe()/remove().
>
> Therefore, enabling DM_USB_GADGET=y will mean that this mode
> switching will break.
>
> To prepare for enabling DM_USB_GADGET, perform the mode switching
> when the "amlogic,meson-g12a-usb" (dwc2) driver is
> probed()/removed() instead.
>
> This is achieved via the glue driver, which gets notified each time one
> of its children is probed()/removed.
>
> Note: this change should be harmless without DM_USB_GADGET=y
> because the amlogic-g12a-usb driver is not probed via driver model.
>
> Thanks for Mattijs for the original work at [1].
>
> [1] https://lore.kernel.org/all/20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com/
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you for mentioning me, I appreciate it.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/dwc3-meson-gxl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
> index 6c6d463203..d56f2747b6 100644
> --- a/drivers/usb/dwc3/dwc3-meson-gxl.c
> +++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
> @@ -408,6 +408,22 @@ static int dwc3_meson_gxl_remove(struct udevice *dev)
>  	return dm_scan_fdt_dev(dev);
>  }
>  
> +static int dwc3_meson_gxl_child_pre_probe(struct udevice *dev)
> +{
> +	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
> +		return dwc3_meson_gxl_force_mode(dev->parent, USB_DR_MODE_PERIPHERAL);
> +
> +	return 0;
> +}
> +
> +static int dwc3_meson_gxl_child_post_remove(struct udevice *dev)
> +{
> +	if (ofnode_device_is_compatible(dev_ofnode(dev), "amlogic,meson-g12a-usb"))
> +		return dwc3_meson_gxl_force_mode(dev->parent, USB_DR_MODE_HOST);
> +
> +	return 0;
> +}
> +
>  static const struct udevice_id dwc3_meson_gxl_ids[] = {
>  	{ .compatible = "amlogic,meson-axg-usb-ctrl" },
>  	{ .compatible = "amlogic,meson-gxl-usb-ctrl" },
> @@ -421,6 +437,8 @@ U_BOOT_DRIVER(dwc3_generic_wrapper) = {
>  	.of_match = dwc3_meson_gxl_ids,
>  	.probe = dwc3_meson_gxl_probe,
>  	.remove = dwc3_meson_gxl_remove,
> +	.child_pre_probe = dwc3_meson_gxl_child_pre_probe,
> +	.child_post_remove = dwc3_meson_gxl_child_post_remove,
>  	.plat_auto	= sizeof(struct dwc3_meson_gxl),
>  
>  };
>
> -- 
> 2.34.1
