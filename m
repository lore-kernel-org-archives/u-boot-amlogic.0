Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web11.37296.1681285511776271978
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Apr 2023 00:45:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681285509;
	bh=HFomDF5/OQrXqFwHIIQzGQQh6Kg5aBmepc84BtjD7Sg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hNcJUWwRv7GGcUTHwUNf2ajDJX1XEuECL28nfRkdnBJvGCaBxMlKdLJvVSxVCox+r
	 gttKImXmCvhs4ykSDQz2GQf72qKb9MUTIbjrVdJMmolKhn8g2hCZ/zGtO17mIiCSAl
	 uGgfYWcimGmLrdcCCPziAlWNXQARdr03qiLP9RxUGgSZ6/24TNbhRfcGNswRky7VFo
	 CNvN3eZXTYLzBQWcgbIy6pzV88cdgLPy/dV6Hw2jm0JJANAOLuRV345RQYQysdeECr
	 r7gGBGk4DUMDlgIdbRtijDqY3uOQTCeDz68WQb41uV6IZ+RKYfg1XaA3gJSk40gRqu
	 Jlra1B+JvpBkA==
Message-ID: <18455f38-123c-12de-b72d-a83444cdd26a@collabora.com>
Date: Wed, 12 Apr 2023 10:45:05 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/5] phy: add support for phy-supply
References: <20230404141155.283987-1-eugen.hristev@collabora.com>
 <20230404141155.283987-3-eugen.hristev@collabora.com>
 <82da257b-28f0-a4b9-9b74-257b36067380@kwiboo.se>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <82da257b-28f0-a4b9-9b74-257b36067380@kwiboo.se>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot-amlogic@groups.io, kever.yang@rock-chips.com, neil.armstrong@linaro.org, jagan@edgeble.ai, xdrudis@tinet.cat, anarsoul@gmail.com, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 4/12/23 09:53, Jonas Karlman wrote:
> Hi Eugen,
> 
> On 2023-04-04 16:11, Eugen Hristev wrote:
>> Some phys require a phy-supply property that is a phandle to a regulator
>> that needs to be enabled for phy operations.
>> Implement basic supply lookup, enable and disabling, if DM_REGULATOR is
>> available.
> 
> Thanks for looking at this, I have now had some time to test this and it
> turned out there was some minor issues.
> 
> First, the regulator is enabled in power_on and disabled in exit. It
> should probably be disabled after power_off ops has been called.
> 
> Second, the return value is ignored, this will change the meson code to
> continue with the call to the power_on ops, before it would have stopped
> and returned early with an error from the power_on ops.

While indeed there is a change, I do not want to stop when there is an 
error with phy supply.
First, the enabling of the regulator could return EALREADY  on enable, 
or EBUSY on disable, which is not really an error, so this has to be 
treated accordingly
Second, all this time the code has lived without phy supply except for 
some few drivers, so, if now we stop and break on phy supply not 
working, we may break a lot of other boards which simply ignored phy 
supply until today.
Because of that, my whole patch has treated phy supply as basically an 
optional property which is requested, but not mandatory to continue without.

> 
> Third, there seem to be a possibility that the counts in regulator core
> can end up uneven when any of init/exit/power_on/power_off ops is NULL. >
> I created "fixup! phy: add support for phy-supply" and "phy: Keep
> balance of counts when ops is missing" at [1] during my testing,
> please feel free to fixup/squash/rework any code :-)
> 
do you want to add this second patch to my series ?

and squash the first into my patches with you as co-author ? but I will 
change a bit what you wrote, namely handling EBUSY and EALREADY e.g.

> Tested with USB (multiple usb start/reset/stop cycles) and PCIe
> (multiple pci enum) on RK3568 together with your "regulator: implement
> basic reference counter".
> 
> [1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3568-usb-v1
> 
> Regards,
> Jonas
> 
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>> ---
>>   drivers/phy/phy-uclass.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
>> index 3fef5135a9cb..475ac285df05 100644
>> --- a/drivers/phy/phy-uclass.c
>> +++ b/drivers/phy/phy-uclass.c
>> @@ -12,6 +12,7 @@
>>   #include <dm/devres.h>
>>   #include <generic-phy.h>
>>   #include <linux/list.h>
>> +#include <power/regulator.h>
>>   
>>   /**
>>    * struct phy_counts - Init and power-on counts of a single PHY port
>> @@ -29,12 +30,14 @@
>>    *              without a matching generic_phy_exit() afterwards
>>    * @list: Handle for a linked list of these structures corresponding to
>>    *        ports of the same PHY provider
>> + * @supply: Handle to a phy-supply device
>>    */
>>   struct phy_counts {
>>   	unsigned long id;
>>   	int power_on_count;
>>   	int init_count;
>>   	struct list_head list;
>> +	struct udevice *supply;
>>   };
>>   
>>   static inline struct phy_ops *phy_dev_ops(struct udevice *dev)
>> @@ -224,6 +227,12 @@ int generic_phy_init(struct phy *phy)
>>   		return 0;
>>   	}
>>   
>> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> +	device_get_supply_regulator(phy->dev, "phy-supply", &counts->supply);
>> +	if (IS_ERR(counts->supply))
>> +		dev_dbg(phy->dev, "no phy-supply property found\n");
>> +#endif
>> +
>>   	ret = ops->init(phy);
>>   	if (ret)
>>   		dev_err(phy->dev, "PHY: Failed to init %s: %d.\n",
>> @@ -272,6 +281,12 @@ int generic_phy_exit(struct phy *phy)
>>   		return 0;
>>   	}
>>   
>> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> +	if (!IS_ERR_OR_NULL(counts->supply)) {
>> +		ret = regulator_set_enable(counts->supply, false);
>> +		dev_dbg(phy->dev, "supply disable status: %d\n", ret);
>> +	}
>> +#endif
>>   	ret = ops->exit(phy);
>>   	if (ret)
>>   		dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
>> @@ -300,6 +315,13 @@ int generic_phy_power_on(struct phy *phy)
>>   		return 0;
>>   	}
>>   
>> +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> +	if (!IS_ERR_OR_NULL(counts->supply)) {
>> +		ret = regulator_set_enable(counts->supply, true);
>> +		dev_dbg(phy->dev, "supply enable status: %d\n", ret);
>> +	}
>> +#endif
>> +
>>   	ret = ops->power_on(phy);
>>   	if (ret)
>>   		dev_err(phy->dev, "PHY: Failed to power on %s: %d.\n",
> 

