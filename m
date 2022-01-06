Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.9930.1641482475965742922
 for <u-boot-amlogic@groups.io>;
 Thu, 06 Jan 2022 07:21:16 -0800
Received: by mail-wr1-f54.google.com with SMTP id r9so3663986wrg.0
        for <u-boot-amlogic@groups.io>; Thu, 06 Jan 2022 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x83SKdw94IFEu8QKm0tZCAocafq6zLK6WhbESHEOCRU=;
        b=Pv2NgIeyQnA6tZ6tQS2W6xJTfPF8JvlWivY/dlOvGsXPtcLYu8Ae/BFrpVWn5t51lL
         cwp5p3h9EZJD/j3PfP0V2GsMm1jkkSsFawJPAf8lGZS/oQ/ALpLkFpTlj8UMbBxuUthS
         AQg1pIvnnEF/fvMue4FeLHSgwt6a4FzYaln1ebAwlfyIE7cGHhFUOkyDa4to9+2vIdZp
         sO7iUJ0s8B/lk4XGJRZTYw0m2M4ZXzAfJ7dlvuDmdvH0D9ThoTtH+47vLQZMc6TvMxy7
         JHf8At7cUgWU1tR8KOsAW2Wm+D2Am5xBcRfnDOYWGNWAzTIEXpcjkTFQ4keD0u/E4tL9
         v0xQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: gadget: dwc2_udc_otg: set ep's desc during enable/disable
References: <20220106150208.1316946-1-gary.bisson@boundarydevices.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8a9ab2a9-a4fe-0b06-de58-4e225fbe13e8@baylibre.com>
Date: Thu, 6 Jan 2022 16:21:12 +0100
MIME-Version: 1.0
In-Reply-To: <20220106150208.1316946-1-gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gary Bisson <gary.bisson@boundarydevices.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, marex@denx.de, peter.chen@nxp.com, jun.li@nxp.com, peng.fan@nxp.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/01/2022 16:02, Gary Bisson wrote:
> Fastboot support has been broken on platforms using dwc2 controller
> since the gadget gets its max packet size from it.
> This patch is the equivalent of 723fd5668ff which fixed the same issue
> but for the chipidea controller.
> 
> Fixes: 27c9141b111 ("usb: gadget: fastboot: use correct max packet size")
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
>  drivers/usb/gadget/dwc2_udc_otg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 2f318144421..fb10884755b 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -655,6 +655,7 @@ static int dwc2_ep_enable(struct usb_ep *_ep,
>  		return -ESHUTDOWN;
>  	}
>  
> +	_ep->desc = desc;
>  	ep->stopped = 0;
>  	ep->desc = desc;

Indeed the _ep and ep was confusing when looking code

>  	ep->pio_irqs = 0;
> @@ -695,6 +696,7 @@ static int dwc2_ep_disable(struct usb_ep *_ep)
>  	/* Nuke all pending requests */
>  	nuke(ep, -ESHUTDOWN);
>  
> +	_ep->desc = NULL;
>  	ep->desc = 0;
>  	ep->stopped = 1;
>  
> 

An off-tree patch removed from our Yukawa backlog, thanks !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
