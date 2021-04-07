Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web09.7845.1617805282755264247
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 07:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1617805277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RDxPepAi9ajaYP3F1O8XA9hAQZ1Wv8FADmy7LTVk1I=;
	b=VwQTZKAhdDOvwXWHedKo8uQmvoZdss9Wa4vFxpOaWM09Ul9Nl12nybfj8iFeli26vyaMiG
	SxjlENzZPyTUThCiKCMsSCTw6cZE0muTkTYXup5QeWrLA179WLCrQ9ysq1lZBd5wvapcBw
	pHfwql4N2CH+qzd5IkhJpXLI+PG6UkI=
MIME-Version: 1.0
Date: Wed, 07 Apr 2021 16:21:16 +0200
From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] arm64: dts: meson: fix PHY deassert timing requirements
In-Reply-To: <5a3579cd-1326-dd88-d30a-8440376e79c5@baylibre.com>
References: <ad76ec471d131339985c1f6766069ef3fd317a33.1617731144.git.stefan@agner.ch>
 <5a3579cd-1326-dd88-d30a-8440376e79c5@baylibre.com>
Message-ID: <96567ca2c6830ba388febf8399ae94f9@agner.ch>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 2021-04-07 15:31, Neil Armstrong wrote:
> Hi,
> 
> On 06/04/2021 19:47, Stefan Agner wrote:
>> The sync of the device tree and dt-bindings from Linux v5.6-rc2
>> 11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
>> ODROID-C2.
>>
>> Meanwhile a fix to increase the reset timing has been added to Linux.
>> Instead of reverting the offending commit, use the new reset timing
>> from upstream Linux commit c183c406c432 ("arm64: dts: meson: fix PHY
>> deassert timing requirements").
>>
>> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/dts/meson-g12b-odroid-n2.dtsi | 2 +-
>>  arch/arm/dts/meson-gxbb-nanopi-k2.dts  | 2 +-
>>  arch/arm/dts/meson-gxbb-odroidc2.dts   | 2 +-
>>  arch/arm/dts/meson-gxm-khadas-vim2.dts | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dtsi b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>> index 6982632ae6..39a09661c5 100644
>> --- a/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>> @@ -413,7 +413,7 @@
>>  		max-speed = <1000>;
>>
>>  		reset-assert-us = <10000>;
>> -		reset-deassert-us = <30000>;
>> +		reset-deassert-us = <80000>;
> 
> In fact, these are not used by current U-boot, support for
> reset/deassert in PHY node
> is not yet supported in U-Boot. This first step was to switch to
> DM_MDIO and use the
> proper Designware glue, the second step is to find how to make use of
> these properties.

Hm, that is strange, I have users reporting that this patch fixes the
issue on their devices. I guess it might be that the problem does not
always appear and it was just (bad) luck.

> 
> Concerning the patch, I'll prefer you sync the DT with v5.11 instead.

We have multiple reports of non-working ODROID-C2 which worked in
previous U-Boot releases:
https://github.com/home-assistant/operating-system/issues/1202

Similar reports exist in Armbian Forums as well.

Until we have proper PHY reset/deassert support, I'd suggest to revert
dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
partially then...

--
Stefan


> 
> Neil
> 
>>  		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>
>>  		interrupt-parent = <&gpio_intc>;
>> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>> index 7be3e35409..de27beafe9 100644
>> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>> @@ -165,7 +165,7 @@
>>  			reg = <0>;
>>
>>  			reset-assert-us = <10000>;
>> -			reset-deassert-us = <30000>;
>> +			reset-deassert-us = <80000>;
>>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>
>>  			interrupt-parent = <&gpio_intc>;
>> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
>> index 70fcfb7b06..50de1d01e5 100644
>> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
>> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
>> @@ -200,7 +200,7 @@
>>  			reg = <0>;
>>
>>  			reset-assert-us = <10000>;
>> -			reset-deassert-us = <30000>;
>> +			reset-deassert-us = <80000>;
>>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>
>>  			interrupt-parent = <&gpio_intc>;
>> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>> index bff8ec2c1c..e38d9e50ca 100644
>> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
>> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>> @@ -194,7 +194,7 @@
>>  		reg = <0>;
>>
>>  		reset-assert-us = <10000>;
>> -		reset-deassert-us = <30000>;
>> +		reset-deassert-us = <80000>;
>>  		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>
>>  		interrupt-parent = <&gpio_intc>;
>>
