Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.2575.1587391669884238346
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 07:07:50 -0700
Received: by mail-wr1-f67.google.com with SMTP id g13so10306529wrb.8
        for <u-boot-amlogic@groups.io>; Mon, 20 Apr 2020 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIcGU8RNznt1gbuHWN6zL0l/6pLaf3X0h7TAAVyUJnU=;
        b=ASh1pKttTh+91cdYSBXG8KXWKFLlG+Si5nf3ZMIyyDWhU8deK6MCnCZpjqn30RPZCm
         Y33paPbPq59ZrrZNNTRZW5sf09hu4d0J/42VriKgJ9w+V6KQProrv3c/GajoBHnjs5uu
         aemhcJ1Di/WvIb1aj1GeyOAEEMhi9+agNrpZhux7u3yQWfItTRqYUKgwBZpyfxkHew1Z
         zidaIy9/hsdhSgQkJf2RiPzzzo+c4Ul6u8+CM/7pjy9dkvNgAsg5nZf1sb4PIYr/8V4s
         Q6IJU7mJWON0jVehjzsCQBSgOdGfPGJ4sUkCZnKWdXP4l/mkT++RjjdNNM0SO8JZBiLD
         qeDA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
 <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
 <38fc9ea1-2ea4-bb83-55de-b3c12356c4eb@baylibre.com>
 <13895737-7114-fe84-bd16-8395cf050632@denx.de>
 <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
 <446a1be9-2c6e-252a-80f5-15ba936143eb@denx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <79e51bdb-f9ee-dece-5f75-580da5e8cf15@baylibre.com>
Date: Mon, 20 Apr 2020 16:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <446a1be9-2c6e-252a-80f5-15ba936143eb@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 16:03, Marek Vasut wrote:
> On 4/20/20 3:56 PM, Neil Armstrong wrote:
>> On 20/04/2020 15:52, Marek Vasut wrote:
>>> On 4/20/20 3:49 PM, Neil Armstrong wrote:
>>>> On 20/04/2020 15:47, Marek Vasut wrote:
>>>>> On 4/20/20 3:46 PM, Neil Armstrong wrote:
>>>>>> Power on/off the PHYs to enable power to the USB ports, fixing USB support
>>>>>> on Khadas VIM3/VIM3L boards.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>> ---
>>>>>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>>>>>>  1 file changed, 16 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>>> index d4453f8784..8f4a2f3f82 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>>> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>>>>>>  			goto err_phy_init;
>>>>>>  	}
>>>>>>  
>>>>>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>>>>
>>>>> Doesn't checkpatch complain about this extra space before semicolon ?
>>>>
>>>> Nop, even in --strict
>>>
>>> Shouldn't it though ? I thought this extra space was forbidden.
>>
>> No idea, this line is copied from the for loop doing the phy init,
>> itself copied from the Linux code passing all checkpatch checks.
> 
> Could you change it to for (i = 0; i < PHY_COUNT; i++) please ?

Sure

> 
>>>>>
>>>>>> +		if (!priv->phys[i].dev)
>>>>>> +			continue;
>>>>>> +
>>>>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>>>>
>>>>> Do we really need to turn on all the PHYs ?
>>>>>
>>>>
>>>> Yes
>>>
>>> Then should we have something like clk_bulk_*(), but for phys ?
>>>
>>
>> Eventually, yes, but this goes beyond a fix.
> 
> The merge window is open for quite a bit longer, so doing this in a
> generic way would be appreciated.
> 
> btw while you're at it, shouldn't the PHY_COUNT be replaced with some
> PHY count detection by reading the DT ? ( I don't have the hardware and
> I don't know the amlogic SoCs though )
> 

Hmm, the PHYs list can have some holes (i.e only the second PHY could be used on 3),
and the name of the PHY determines it's type and position (PHY1 is a special OTG phy)
this is why we loop over a fixed array and check if the PHY pointer exists.

This won't match a phy_bulk_code directly, I would still need to map the bulk PHYs to this
array for the OTG and USB3 management.

Neil
