Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.14074.1641498953002202855
 for <u-boot-amlogic@groups.io>;
 Thu, 06 Jan 2022 11:55:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1641498950;
	bh=vriSaTI2W/PpatWousDLsdWPLYzhyfrmBMfxmFzvh9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKiepXNvZ1rEuk1NYP1zRBpXzDLreMvaIcU0NvABQowfjwO+hj6NR+Q/Uyp+kyrHd
	 32FxUalKxPkSmVqycAPEPjWXVbRBbOsXRm7XY9rVXdeaAWhEw+XiqPcLUXrhKIWMiX
	 KArcosvvaqyAJ6YALQX/XfT70Gb6pHFfK+mTAZFI92zhfhRx8RkMSuvGgL5rXarH7H
	 BMK4LomQmtsY3TeqjXQhXcQVfTZ+WJtap0qCSgedRKlQ1qXoY4wwZFHh2zU+/F0SsV
	 FQNn7vA2MxVjLT6V+OD5zqt+uUFRikE1D6o9AIx67YLO+0SyBR8H13pwTi8xLFNHJn
	 DxpwF+KUULMlQ==
Message-ID: <f2b7e565-9dd1-ba71-a143-6c629694be4c@denx.de>
Date: Thu, 6 Jan 2022 20:55:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: dwc2_udc_otg: set ep's desc during enable/disable
References: <20220106150208.1316946-1-gary.bisson@boundarydevices.com>
 <8a9ab2a9-a4fe-0b06-de58-4e225fbe13e8@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8a9ab2a9-a4fe-0b06-de58-4e225fbe13e8@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, Gary Bisson <gary.bisson@boundarydevices.com>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: lukma@denx.de, peter.chen@nxp.com, jun.li@nxp.com, peng.fan@nxp.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 1/6/22 16:21, Neil Armstrong wrote:
> Hi,
> 
> On 06/01/2022 16:02, Gary Bisson wrote:
>> Fastboot support has been broken on platforms using dwc2 controller
>> since the gadget gets its max packet size from it.
>> This patch is the equivalent of 723fd5668ff which fixed the same issue
>> but for the chipidea controller.
>>
>> Fixes: 27c9141b111 ("usb: gadget: fastboot: use correct max packet size")
>>
>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> ---
>>   drivers/usb/gadget/dwc2_udc_otg.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
>> index 2f318144421..fb10884755b 100644
>> --- a/drivers/usb/gadget/dwc2_udc_otg.c
>> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
>> @@ -655,6 +655,7 @@ static int dwc2_ep_enable(struct usb_ep *_ep,
>>   		return -ESHUTDOWN;
>>   	}
>>   
>> +	_ep->desc = desc;
>>   	ep->stopped = 0;
>>   	ep->desc = desc;
> 
> Indeed the _ep and ep was confusing when looking code
> 
>>   	ep->pio_irqs = 0;
>> @@ -695,6 +696,7 @@ static int dwc2_ep_disable(struct usb_ep *_ep)
>>   	/* Nuke all pending requests */
>>   	nuke(ep, -ESHUTDOWN);
>>   
>> +	_ep->desc = NULL;
>>   	ep->desc = 0;
>>   	ep->stopped = 1;
>>   
>>
> 
> An off-tree patch removed from our Yukawa backlog, thanks !
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

+CC Tom, can you pick this one for CURRENT 2022.01 release?

Thank you
