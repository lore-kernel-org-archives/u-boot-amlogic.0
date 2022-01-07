Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.7769.1641569122137366337
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Jan 2022 07:25:22 -0800
Received: by mail-wr1-f53.google.com with SMTP id q8so11640483wra.12
        for <u-boot-amlogic@groups.io>; Fri, 07 Jan 2022 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7uXIW5mqIKb7ljXWlA9RDLIGMKgmP26bwTvxo2O0wWk=;
        b=4CMYgmRCe5mmTFRrwHFTGPRlsCa1oiGwno4g2QOwyefOR0BcQpH/hKxeASOs+e7K2d
         MogyROwxgR23IMcxhrbvLqIpaInj4c3YahsYfkBS85Ff+tnF9WknvwJ3HZvv8iBjRqEx
         bY8keFkkYU6VXZyEaS8YPCYnqdnyEOeFPSsuucrMkF79R9iDEKFK3X4HiJgBw7F5fhmT
         mAjLfVTXApxTNOOsfYyx01Le8Mld6ndIB8KirFM3vpHAQNiU9YGROsmTHhqawkj6yBJ8
         mJF1++7GIv4Vqk7bVG0S+ynOpfaRMz4DqXyksMsDjjgSHPaXPckHP+nexSK5XP2PZO+x
         EDaA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] usb: gadget: dwc2_udc_otg: set ep's desc during enable/disable
In-Reply-To: <f2b7e565-9dd1-ba71-a143-6c629694be4c@denx.de>
References: <20220106150208.1316946-1-gary.bisson@boundarydevices.com>
 <8a9ab2a9-a4fe-0b06-de58-4e225fbe13e8@baylibre.com>
 <f2b7e565-9dd1-ba71-a143-6c629694be4c@denx.de>
Date: Fri, 07 Jan 2022 16:25:18 +0100
Message-ID: <87pmp34lgh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Marek Vasut <marex@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Gary Bisson <gary.bisson@boundarydevices.com>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: lukma@denx.de, peter.chen@nxp.com, jun.li@nxp.com, peng.fan@nxp.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Gary,

Thank you for your patch.

Marek Vasut <marex@denx.de> writes:

> On 1/6/22 16:21, Neil Armstrong wrote:
>> Hi,
>> 
>> On 06/01/2022 16:02, Gary Bisson wrote:
>>> Fastboot support has been broken on platforms using dwc2 controller
>>> since the gadget gets its max packet size from it.
>>> This patch is the equivalent of 723fd5668ff which fixed the same issue
>>> but for the chipidea controller.
>>>
>>> Fixes: 27c9141b111 ("usb: gadget: fastboot: use correct max packet size")
>>>
>>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>>> ---
>>>   drivers/usb/gadget/dwc2_udc_otg.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
>>> index 2f318144421..fb10884755b 100644
>>> --- a/drivers/usb/gadget/dwc2_udc_otg.c
>>> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
>>> @@ -655,6 +655,7 @@ static int dwc2_ep_enable(struct usb_ep *_ep,
>>>   		return -ESHUTDOWN;
>>>   	}
>>>   
>>> +	_ep->desc = desc;
>>>   	ep->stopped = 0;
>>>   	ep->desc = desc;
>> 
>> Indeed the _ep and ep was confusing when looking code
>> 
>>>   	ep->pio_irqs = 0;
>>> @@ -695,6 +696,7 @@ static int dwc2_ep_disable(struct usb_ep *_ep)
>>>   	/* Nuke all pending requests */
>>>   	nuke(ep, -ESHUTDOWN);
>>>   
>>> +	_ep->desc = NULL;
>>>   	ep->desc = 0;
>>>   	ep->stopped = 1;
>>>   
>>>
>> 
>> An off-tree patch removed from our Yukawa backlog, thanks !
>> 
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
I can confirm this fixes flashing issues on VIM3/VIM3L boards when
flashing AOSP(yukawa) with fastboot.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> +CC Tom, can you pick this one for CURRENT 2022.01 release?
>
> Thank you
