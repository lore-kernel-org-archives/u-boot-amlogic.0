Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web11.2767.1587392016728869312
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 07:13:37 -0700
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
 <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
 <38fc9ea1-2ea4-bb83-55de-b3c12356c4eb@baylibre.com>
 <13895737-7114-fe84-bd16-8395cf050632@denx.de>
 <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
 <446a1be9-2c6e-252a-80f5-15ba936143eb@denx.de>
 <79e51bdb-f9ee-dece-5f75-580da5e8cf15@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <755cd6e3-6d30-71fc-ba48-e5fbb7b7c7f4@denx.de>
Date: Mon, 20 Apr 2020 16:10:36 +0200
MIME-Version: 1.0
In-Reply-To: <79e51bdb-f9ee-dece-5f75-580da5e8cf15@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 4/20/20 4:07 PM, Neil Armstrong wrote:
[...]

>>>>>> Doesn't checkpatch complain about this extra space before semicolon ?
>>>>>
>>>>> Nop, even in --strict
>>>>
>>>> Shouldn't it though ? I thought this extra space was forbidden.
>>>
>>> No idea, this line is copied from the for loop doing the phy init,
>>> itself copied from the Linux code passing all checkpatch checks.
>>
>> Could you change it to for (i = 0; i < PHY_COUNT; i++) please ?
> 
> Sure

Thank you.

( I'm still surprised checkpatch doesn't warn about it, I was quite sure
it was one of the checks at some point, hmmmmm. )

>>>>>>
>>>>>>> +		if (!priv->phys[i].dev)
>>>>>>> +			continue;
>>>>>>> +
>>>>>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>>>>>
>>>>>> Do we really need to turn on all the PHYs ?
>>>>>>
>>>>>
>>>>> Yes
>>>>
>>>> Then should we have something like clk_bulk_*(), but for phys ?
>>>>
>>>
>>> Eventually, yes, but this goes beyond a fix.
>>
>> The merge window is open for quite a bit longer, so doing this in a
>> generic way would be appreciated.
>>
>> btw while you're at it, shouldn't the PHY_COUNT be replaced with some
>> PHY count detection by reading the DT ? ( I don't have the hardware and
>> I don't know the amlogic SoCs though )
>>
> 
> Hmm, the PHYs list can have some holes (i.e only the second PHY could be used on 3),
> and the name of the PHY determines it's type and position (PHY1 is a special OTG phy)
> this is why we loop over a fixed array and check if the PHY pointer exists.

Um, that sounds like a vaguely familiar problem. Is that an issue with
mapping between controller and a USB PHY ? Is that mapping fixed or is
it configured from DT ? And then, should all PHYs really be powered on,
or should only the PHY matching the currently used controller be powered
on ?

> This won't match a phy_bulk_code directly, I would still need to map the bulk PHYs to this
> array for the OTG and USB3 management.

OK
