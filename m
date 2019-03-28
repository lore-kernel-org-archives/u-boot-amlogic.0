Subject: Re: [PATCH 1/3] usb: dwc3: Add Meson G12A USB Glue
References: <20190326151537.23118-1-narmstrong@baylibre.com>
 <20190326151537.23118-2-narmstrong@baylibre.com>
 <87e9c6f0-e62c-b5aa-cddd-550c25b6d705@denx.de>
 <175f5323-db98-6ae9-7671-f5cd3e1d46a4@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <817c367c-3a29-b268-a932-b60081e24790@denx.de>
Date: Thu, 28 Mar 2019 04:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <175f5323-db98-6ae9-7671-f5cd3e1d46a4@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 3/27/19 10:12 AM, Neil Armstrong wrote:
> On 26/03/2019 16:53, Marek Vasut wrote:
>> On 3/26/19 4:15 PM, Neil Armstrong wrote:
>>> Adds support for Amlogic G12A USB Control Glue HW.
>>>
>>> The Amlogic G12A SoC Family embeds 2 USB Controllers :
>>> - a DWC3 IP configured as Host for USB2 and USB3
>>> - a DWC2 IP configured as Peripheral USB2 Only
>>>
>>> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
>>> to an USB3+PCIE Combo PHY shared with the PCIE controller.
>>>
>>> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
>>> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
>>> setups the on-chip OTG mode selection for this PHY.
>>>
>>> This driver sets the OTG capable port as Host mode by default,
>>> the switch to Device mode is to be done in a separate patch.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>
>> [...]
>>
>>> +static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
>>> +{
>>> +	int i, ret;
>>> +
>>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>> +		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
>>> +					      &priv->phys[i]);
>>> +		if (ret == -ENOENT)
>>> +			continue;
>>> +
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (i == USB3_HOST_PHY)
>>> +			priv->usb3_ports++;
>>> +		else
>>> +			priv->usb2_ports++;
>>> +	}
>>> +
>>> +	printf("%s: usb2 ports: %d\n", __func__, priv->usb2_ports);
>>> +	printf("%s: usb3 ports: %d\n", __func__, priv->usb3_ports);
>>
>> Are these prints needed ?
> 
> Nop, forgot to switch them to debug
> 
>>
>>> +	return 0;
>>> +}
>>
>> [...]
>>> +static int dwc3_meson_g12a_probe(struct udevice *dev)
>>> +{
>>> +	struct dwc3_meson_g12a *priv = dev_get_platdata(dev);
>>> +	int ret, i;
>>> +
>>> +	priv->dev = dev;
>>> +
>>> +	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = dwc3_meson_g12a_clk_init(priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = dwc3_meson_g12a_reset_init(priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = dwc3_meson_g12a_get_phys(priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>> +	ret = device_get_supply_regulator(dev, "vbus-supply",
>>> +					  &priv->vbus_supply);
>>> +	if (ret && ret != -ENOENT) {
>>> +		pr_err("Failed to get PHY regulator\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (priv->vbus_supply) {
>>> +		ret = regulator_set_enable(priv->vbus_supply, true);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +#endif
>>> +
>>> +	priv->otg_mode = usb_get_dr_mode(dev_of_offset(dev));
>>> +
>>> +	ret = dwc3_meson_g12a_usb_init(priv);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0 ; i < PHY_COUNT ; ++i) {
>>> +		if (!priv->phys[i].dev)
>>> +			continue;
>>> +
>>> +		ret = generic_phy_init(&priv->phys[i]);
>>> +		if (ret)
>>> +			goto err_phy_init;
>>> +	}
>>
>> Isn't there some function to init all the PHYs already ?
>>
> 
> I don't see any in u-boot master !
> Unlike dwc3, we need to get the phys with the names to check if
> the USB3 phy is enabled, so we can't get all possible phys.

I see, so thus far my only comment is about the missed debug prints.
Thanks!

-- 
Best regards,
Marek Vasut
