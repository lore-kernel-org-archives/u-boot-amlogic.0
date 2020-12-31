Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web11.20840.1609421695006792731
 for <u-boot-amlogic@groups.io>;
 Thu, 31 Dec 2020 05:34:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1609421690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16bbKRi9+W9feHIPrr71GF/UouHNYgTUtIhn0K0P+cU=;
	b=qvwGCrDTiaWT6S+NQ/xsdOzILbzOnGEp24iwOo68aZA5xqMlAkr72UGcfUnz5Uwo7b5dZq
	sfBIwk9S9sHAk/61wHGOFgieGP3QLIS5TPpWmt6XUMTAI2v1mkHmyzSTU2H46B7wyskE3r
	+CR0SP3KjWXjlFOH0c7+czdfDgAjM0w=
MIME-Version: 1.0
Date: Thu, 31 Dec 2020 14:34:49 +0100
From: Stefan Agner <stefan@agner.ch>
Subject: Re: [RFC] arm64: dts: meson: revert breaking change for eMMC detection
In-Reply-To: <1f765c74-8270-4cc6-5c48-58be51d31f49@baylibre.com>
References: <14c518aa46f3b87e7489bb1a3736ae5640262f9f.1609410832.git.stefan@agner.ch>
 <1f765c74-8270-4cc6-5c48-58be51d31f49@baylibre.com>
Message-ID: <75c24a7b6378e1b9871b8b29adbba46b@agner.ch>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: jbrunet@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 2020-12-31 11:44, Neil Armstrong wrote:
> Hi Stephan,
> 
> 
> On 31/12/2020 11:36, Stefan Agner wrote:
>> The sync of the device tree and dt-bindings from Linux v5.6-rc2
>> 11a48a5a18c6 ("Linux 5.6-rc2") causes eMMC to break for ODROID-C2.
>> Revert the offending change.
>>
>> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> It seems that eMMC on ODROID-C2 doesn't work anymore since U-Boot 2020.07. A git
>> bisect pointed to the above mentioned commit. This reverts the offending part
>> only, but is probably not the proper fix. I am not familar with the pinctrl
>> drivers, so maybe somebody with a bit more insight can come up with the proper
>> fix?
> 
> This has been fixed with
> https://patchwork.ozlabs.org/project/uboot/patch/20201214184841.237356-1-narmstrong@baylibre.com/
> 
> The fix has been merge for 2021.01 already

Hm, I thought I checked master, but maybe I did the git pull only
afterwards :-(

Sorry for the noise and thanks for the pointer!

--
Stefan

> 
> Neil
> 
>>
>> -> master without this patch
>> => mmc dev 1
>> Card did not respond to voltage select!
>>
>> -> With this patch
>> => mmc dev 1
>> switch to partitions #0, OK
>> mmc1(part 0) is current device
>>
>>  arch/arm/dts/meson-gxbb.dtsi | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/dts/meson-gxbb.dtsi b/arch/arm/dts/meson-gxbb.dtsi
>> index 234490d3ee..bb46dcd1c0 100644
>> --- a/arch/arm/dts/meson-gxbb.dtsi
>> +++ b/arch/arm/dts/meson-gxbb.dtsi
>> @@ -404,17 +404,11 @@
>>  		};
>>
>>  		emmc_pins: emmc {
>> -			mux-0 {
>> +			mux {
>>  				groups = "emmc_nand_d07",
>> -				       "emmc_cmd";
>> -				function = "emmc";
>> -				bias-pull-up;
>> -			};
>> -
>> -			mux-1 {
>> -				groups = "emmc_clk";
>> +				       "emmc_cmd",
>> +				       "emmc_clk";
>>  				function = "emmc";
>> -				bias-disable;
>>  			};
>>  		};
>>
>>
