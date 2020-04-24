Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.2274.1587719019113483502
 for <u-boot-amlogic@groups.io>;
 Fri, 24 Apr 2020 02:03:40 -0700
Received: by mail-wr1-f66.google.com with SMTP id t14so9805981wrw.12
        for <u-boot-amlogic@groups.io>; Fri, 24 Apr 2020 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bg9B6nBlFykFS0I35TITvFdL34QqnL3cjGaH3Fx2MB4=;
        b=hkruR2qcHGA2H/YcrN5C0r+F6o0DSa+dJrsWAlkZtChiLiHvXUK1X7tGoqb4DKrbON
         /NKOBiriBW3OxCh82t1j42f4q6qIaOEDAdtZCzIiUoX2b6jaL9wQfPkowxN9qJ1451F3
         sDs+hxz35iCmguE2PjBhzijzIi0W7Uu1cA44XzmoywKNA2+0Fi16zlJQO4OZtjOuszFh
         DwXWa7FhCtsxYT8HG8VCFA1qoDg+QXAiyIKfRub42iMyjGx8e1kNmmh5KCT8/wOd6b5M
         TQpXNgxPq2P7ADGI+Wok4UTHBOboG7IQCCx5qkEGaBWq2y5ZZ3OvrcGtavOCBQ994JnO
         /brg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] usb: dwc3-meson-g12a: add power-on/off of the PHYs
References: <1607C7CBC1E2C0D1.18995@groups.io>
 <6e979b17-78ab-c8ad-afc5-a058a26516a8@baylibre.com>
 <79e5c252-cac4-1be3-d40d-82fd10ee6234@denx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <54e0d868-cf56-938a-bdeb-6ac94775d247@baylibre.com>
Date: Fri, 24 Apr 2020 11:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <79e5c252-cac4-1be3-d40d-82fd10ee6234@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2020 09:41, Marek Vasut wrote:
> On 4/24/20 9:18 AM, Neil Armstrong wrote:
>> On 21/04/2020 10:17, Neil Armstrong via groups.io wrote:
>>> Power on/off the PHYs to enable power to the USB ports, fixing USB support
>>> on Khadas VIM3/VIM3L boards.
>>>
>>> The G12A USB complex has at least 2 USB2 PHYs, but one is muxed between the
>>> DWC2 and DWC3 controller and the other one directly connected to the DWC3
>>> controller. The USB3+PCIe combo PHY is muxed between the DWC3 controller
>>> and a DW-PCIE controller.
>>> All PHYs are optional, but it's type (usb2/usb3) and position are important
>>> to determine it's capabilities, thus they are stored in a fixed size
>>> array and the phy-name determines it's position, it's position determining
>>> it's type and functionnalities.
>>> This is why we need to loop over the array to power on all the DT provided
>>> PHYs.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>> Changes since v1:
>>> - removed extra space before semicolon
>>> - added clarification in commit message
>>>
>>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>> index d4453f8784..de964d6c10 100644
>>> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
>>> @@ -408,6 +408,15 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>>>  			goto err_phy_init;
>>>  	}
>>>  
>>> +	for (i = 0; i < PHY_COUNT; ++i) {
>>> +		if (!priv->phys[i].dev)
>>> +			continue;
>>> +
>>> +		ret = generic_phy_power_on(&priv->phys[i]);
>>> +		if (ret)
>>> +			goto err_phy_init;
>>> +	}
>>> +
>>>  	return 0;
>>>  
>>>  err_phy_init:
>>> @@ -430,6 +439,13 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
>>>  
>>>  	clk_release_all(&priv->clk, 1);
>>>  
>>> +	for (i = 0; i < PHY_COUNT; ++i) {
>>> +		if (!priv->phys[i].dev)
>>> +			continue;
>>> +
>>> +		 generic_phy_power_off(&priv->phys[i]);
>>> +	}
>>> +
>>>  	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>>  		if (!priv->phys[i].dev)
>>>  			continue;
>>>
>>
>> Applied to u-boot-amlogic
> 
> Did you apply V1 or V2 ?
> 

v2

Neil
