Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.4700.1587456586113624845
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Apr 2020 01:09:47 -0700
Received: by mail-wr1-f67.google.com with SMTP id u13so15368496wrp.3
        for <u-boot-amlogic@groups.io>; Tue, 21 Apr 2020 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+6QofAXOK+tBEB5wQTrjaOPj4A7alsxHg89rqYJruyE=;
        b=tWwwTO3gfsDAEZwN1l2wGHb4CaJ6EZqBNpIcNhD6WdDOUjqPTjiOj60/7TH8QMYTTZ
         cTZNszvXMcLHBBfJMwjujURU2+uGRYiR9NlNTxFY7w9AzbQfRUqaKnuGg6PrVOwOsAHZ
         f9ut72YmxquyVvxtKQAo7Pdum3qikIjFxi3hQlMH/s+ZdGcpxyAa7Upe1hu8mF4n74xg
         dKRqfzspfWOYLiNYGMe9LlT0ZPBDhIgJbscoPmu3G0nO+2kilrwVU9KXKq9l5ujdS3LZ
         IPuEMYzUMeYjaYEfxs8mw8oibActY+44+cB6G9rM41BblcDm5o21RQgho+xoXMVVwTn5
         44iQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
 <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
 <38fc9ea1-2ea4-bb83-55de-b3c12356c4eb@baylibre.com>
 <13895737-7114-fe84-bd16-8395cf050632@denx.de>
 <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
 <446a1be9-2c6e-252a-80f5-15ba936143eb@denx.de>
 <79e51bdb-f9ee-dece-5f75-580da5e8cf15@baylibre.com>
 <755cd6e3-6d30-71fc-ba48-e5fbb7b7c7f4@denx.de>
 <1d7313aa-cde0-be01-1a1d-0473e4f1ef79@baylibre.com>
 <e6f86557-0a3b-a21b-f66c-2362db26125c@denx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a960a909-49f3-25cc-5fd4-0755a6777f20@baylibre.com>
Date: Tue, 21 Apr 2020 10:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <e6f86557-0a3b-a21b-f66c-2362db26125c@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 17:40, Marek Vasut wrote:
> On 4/20/20 4:47 PM, Neil Armstrong wrote:
>> On 20/04/2020 16:10, Marek Vasut wrote:
>>> On 4/20/20 4:07 PM, Neil Armstrong wrote:
>>> [...]
>>>
>>>>>>>>> Doesn't checkpatch complain about this extra space before semicolon ?
>>>>>>>>
>>>>>>>> Nop, even in --strict
>>>>>>>
>>>>>>> Shouldn't it though ? I thought this extra space was forbidden.
>>>>>>
>>>>>> No idea, this line is copied from the for loop doing the phy init,
>>>>>> itself copied from the Linux code passing all checkpatch checks.
>>>>>
>>>>> Could you change it to for (i = 0; i < PHY_COUNT; i++) please ?
>>>>
>>>> Sure
>>>
>>> Thank you.
>>>
>>> ( I'm still surprised checkpatch doesn't warn about it, I was quite sure
>>> it was one of the checks at some point, hmmmmm. )
>>>
>>>>>>>>>
>>>>>>>>>> +		if (!priv->phys[i].dev)
>>>>>>>>>> +			continue;
>>>>>>>>>> +
>>>>>>>>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>>>>>>>>
>>>>>>>>> Do we really need to turn on all the PHYs ?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes
>>>>>>>
>>>>>>> Then should we have something like clk_bulk_*(), but for phys ?
>>>>>>>
>>>>>>
>>>>>> Eventually, yes, but this goes beyond a fix.
>>>>>
>>>>> The merge window is open for quite a bit longer, so doing this in a
>>>>> generic way would be appreciated.
>>>>>
>>>>> btw while you're at it, shouldn't the PHY_COUNT be replaced with some
>>>>> PHY count detection by reading the DT ? ( I don't have the hardware and
>>>>> I don't know the amlogic SoCs though )
>>>>>
>>>>
>>>> Hmm, the PHYs list can have some holes (i.e only the second PHY could be used on 3),
>>>> and the name of the PHY determines it's type and position (PHY1 is a special OTG phy)
>>>> this is why we loop over a fixed array and check if the PHY pointer exists.
>>>
>>> Um, that sounds like a vaguely familiar problem. Is that an issue with
>>> mapping between controller and a USB PHY ? Is that mapping fixed or is
>>> it configured from DT ? 
>>
>> Mapping is done via DT, all PHYs are optional depending on the board layout.
>>
>>> And then, should all PHYs really be powered on,
>>> or should only the PHY matching the currently used controller be powered
>>> on ?
>>
>> All PHYs are connected to a glue that muxes 1 PHY between DWC2 and DWC3, and
>> the other USB2 PHYs (for now 1, but previous SoCs had 2) to DWC3, the USB3 PHY
>> is muxed between PCIe to dw-pcie and DWC3.
>>
>> So we power-on only the PHYs specified in DT, thus the:
>> 	if (!priv->phys[i].dev)
>> 		continue;
>>
>> I attached the USB complex diagram if you need it.
> 
> OK, thanks for clarifying. Now, can you document this in the commit
> message, so we have this information stored somewhere for future
> reference ? This would be real useful.
> 

Yes sure.

Neil
