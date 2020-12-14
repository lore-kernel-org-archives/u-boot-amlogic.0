Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web09.880.1607971810028132901
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:50:10 -0800
Received: by mail-wr1-f68.google.com with SMTP id w5so13749278wrm.11
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/8rfHy0LD2oskqsJRupjPnTKwntuWUAxmZZXp6Q+Jc=;
        b=TLuqED3DO0bZvElNKVBi9QElldTlvKkCqIkf2phQmWw50O+Gg7AdNLJslqmAHWPVaf
         VCn+ih3cbnBQS4Hwfi9zM0mjO+ONav5QWJkEb432QLRvYaTZDUEivRQTbsFh2KDGujuG
         kI8S3VNIT4joY2hU873/NQWq7JOG0VTf030oc9wUzhXhupRXV/Hbqrwz9OQC37/W1CGT
         RVf437QW8/GJX0NPWPPJFMab+6OEE7C4kgmrA1JOWVHkyRwcjL9Y1sHIb2NKFqDRfeFw
         2fS422LIrz2L9seZco+kr8nW5661Ws8t/yYxu0dG3ahNY2Gkh2MDYFspM3wGivsx8F3U
         L5Mw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: always configure dr-mode
References: <CGME20201214113427eucas1p203c6afe2f9af60e5bfb5ccc04dd966d5@eucas1p2.samsung.com>
 <20201214113419.19103-1-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d824896d-ec17-6209-c96a-5add01f35aa1@baylibre.com>
Date: Mon, 14 Dec 2020 19:50:05 +0100
MIME-Version: 1.0
In-Reply-To: <20201214113419.19103-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 14/12/2020 12:34, Marek Szyprowski wrote:
> dwc3_meson_g12a_force_mode() sets the dr-mode of the USB PHY. However
> it skips setting the mode if it matches the one done during driver probe
> (stored in private structure). This fails if the mode has been changed
> to other value and then back to initial one. Fix this by configuring the
> dr-mode always, regadless of the one set at the driver probe).
> 
> This fixes operation of USB gadget based drivers when they are initialized
> for the second time.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 6567502cdd1..6f0bac2a00c 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -269,9 +269,6 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
>  	if (!priv->phys[USB2_OTG_PHY].dev)
>  		return -EINVAL;
>  
> -	if (mode == priv->otg_mode)
> -		return 0;
> -
>  	if (mode == USB_DR_MODE_HOST)
>  		debug("%s: switching to Host Mode\n", __func__);
>  	else
> 

Thanks,

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot-amlogic

Neil
