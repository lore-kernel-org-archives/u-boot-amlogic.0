Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web10.2557.1587391423402923218
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Apr 2020 07:03:43 -0700
Subject: Re: [PATCH] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <20200420134601.19863-1-narmstrong@baylibre.com>
 <06638a20-abe1-6991-8dc9-b24f50d59bfd@denx.de>
 <38fc9ea1-2ea4-bb83-55de-b3c12356c4eb@baylibre.com>
 <13895737-7114-fe84-bd16-8395cf050632@denx.de>
 <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <446a1be9-2c6e-252a-80f5-15ba936143eb@denx.de>
Date: Mon, 20 Apr 2020 16:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <b4322b30-233c-e60c-77c4-98618bac1b5a@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 4/20/20 3:56 PM, Neil Armstrong wrote:
> On 20/04/2020 15:52, Marek Vasut wrote:
>> On 4/20/20 3:49 PM, Neil Armstrong wrote:
>>> On 20/04/2020 15:47, Marek Vasut wrote:
>>>> On 4/20/20 3:46 PM, Neil Armstrong wrote:
>>>>> Power on/off the PHYs to enable power to the USB ports, fixing USB support
>>>>> on Khadas VIM3/VIM3L boards.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>>>>>  1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>> index d4453f8784..8f4a2f3f82 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>>>>>  			goto err_phy_init;
>>>>>  	}
>>>>>  
>>>>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>>>
>>>> Doesn't checkpatch complain about this extra space before semicolon ?
>>>
>>> Nop, even in --strict
>>
>> Shouldn't it though ? I thought this extra space was forbidden.
> 
> No idea, this line is copied from the for loop doing the phy init,
> itself copied from the Linux code passing all checkpatch checks.

Could you change it to for (i = 0; i < PHY_COUNT; i++) please ?

>>>>
>>>>> +		if (!priv->phys[i].dev)
>>>>> +			continue;
>>>>> +
>>>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>>>
>>>> Do we really need to turn on all the PHYs ?
>>>>
>>>
>>> Yes
>>
>> Then should we have something like clk_bulk_*(), but for phys ?
>>
> 
> Eventually, yes, but this goes beyond a fix.

The merge window is open for quite a bit longer, so doing this in a
generic way would be appreciated.

btw while you're at it, shouldn't the PHY_COUNT be replaced with some
PHY count detection by reading the DT ? ( I don't have the hardware and
I don't know the amlogic SoCs though )
