Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.2409.1587390997866575515
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 06:56:38 -0700
Received: by mail-wm1-f65.google.com with SMTP id t63so10136881wmt.3
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DpwGCSDojLHx9NDDq9bijNxdlErND71d/APnuSwViFI=;
        b=oXywip5CAoKInaPwGz9WUhfovq92jYbUCPx2cgZMFdmncPVqyVvfc2fNH9oDcLsfJ6
         439DAdWgKUi6bOVJMMwx/h8kSeZIE3ZDUr6vcVJwNFih2ofXH/hXOgmGscE3Sh6vLMsq
         0MPN4lsjRYX2/vhNhDiIU4O8q6YokITsRLxB3qFpTykoD09Fi7eeNugWlP7qxmUSdGpP
         3R8EiLNhPCEyLTXdUdCR6j0Ms/rzG6GgY3/9L2nI+flJlIxqAPUM8RI63Co89rBtqDYY
         C/QOcQNNw5tueVDj9RInKHOsciCef1GgLHgpQ/BRdUNKWhtADVzQsjr8iWb1z6Mo4LDD
         6uUw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
 <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
 <38fc9ea1-2ea4-bb83-55de-b3c12356c4eb@baylibre.com>
 <13895737-7114-fe84-bd16-8395cf050632@denx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
Date: Mon, 20 Apr 2020 15:56:33 +0200
MIME-Version: 1.0
In-Reply-To: <13895737-7114-fe84-bd16-8395cf050632@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 15:52, Marek Vasut wrote:
> On 4/20/20 3:49 PM, Neil Armstrong wrote:
>> On 20/04/2020 15:47, Marek Vasut wrote:
>>> On 4/20/20 3:46 PM, Neil Armstrong wrote:
>>>> Power on/off the PHYs to enable power to the USB ports, fixing USB support
>>>> on Khadas VIM3/VIM3L boards.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>> index d4453f8784..8f4a2f3f82 100644
>>>> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>>>>  			goto err_phy_init;
>>>>  	}
>>>>  
>>>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>>
>>> Doesn't checkpatch complain about this extra space before semicolon ?
>>
>> Nop, even in --strict
> 
> Shouldn't it though ? I thought this extra space was forbidden.

No idea, this line is copied from the for loop doing the phy init,
itself copied from the Linux code passing all checkpatch checks.

> 
>>>
>>>> +		if (!priv->phys[i].dev)
>>>> +			continue;
>>>> +
>>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>>
>>> Do we really need to turn on all the PHYs ?
>>>
>>
>> Yes
> 
> Then should we have something like clk_bulk_*(), but for phys ?
> 

Eventually, yes, but this goes beyond a fix.

Neil


