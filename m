Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.7950.1617805771221323315
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 07:29:32 -0700
Received: by mail-wm1-f46.google.com with SMTP id p19so9143794wmq.1
        for <u-boot-amlogic@groups.io>; Wed, 07 Apr 2021 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LPAXXaXHl60Zf0rWJl/Hn2WypEIXEmrvMDMe/YJHCss=;
        b=bb0duCtS7quj45ftRfL9kzZehApEx+6T+NhiP4kZbOlaWscto9mDU2jPYcmIQHpSlG
         Yezx00anqlwBOY17Rfww/8anBfdy12sjMMG6EMF8yMwwK4SJNmYhUBmHb5Tl6jzcXxth
         6GIRRBmvtEYAnO3XavyIBjK/zJ3zsp4I32Jbn1CkH0e4qfLakVOEr/lSVm6GV+xg/AAl
         7s/BnvQiS43quQr1BEmYUGS7H2DHkwKNsiZwujYJxz6NA7r3ZwEBYLnzvDkbWeQqdc3x
         PbUrFgJVxufW95gXW4K+iamNkdhTRnbixDs2U7hRQpA8Jj8285nIC0o1x4FWymAmwW54
         UrVQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: fix PHY deassert timing requirements
References: <ad76ec471d131339985c1f6766069ef3fd317a33.1617731144.git.stefan@agner.ch>
 <5a3579cd-1326-dd88-d30a-8440376e79c5@baylibre.com>
 <96567ca2c6830ba388febf8399ae94f9@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f1e36a4b-a3c6-ede9-ad8d-c310624823f4@baylibre.com>
Date: Wed, 7 Apr 2021 16:29:27 +0200
MIME-Version: 1.0
In-Reply-To: <96567ca2c6830ba388febf8399ae94f9@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 07/04/2021 16:21, Stefan Agner wrote:
> On 2021-04-07 15:31, Neil Armstrong wrote:
>> Hi,
>>
>> On 06/04/2021 19:47, Stefan Agner wrote:
>>> The sync of the device tree and dt-bindings from Linux v5.6-rc2
>>> 11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
>>> ODROID-C2.
>>>
>>> Meanwhile a fix to increase the reset timing has been added to Linux.
>>> Instead of reverting the offending commit, use the new reset timing
>>> from upstream Linux commit c183c406c432 ("arm64: dts: meson: fix PHY
>>> deassert timing requirements").
>>>
>>> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>  arch/arm/dts/meson-g12b-odroid-n2.dtsi | 2 +-
>>>  arch/arm/dts/meson-gxbb-nanopi-k2.dts  | 2 +-
>>>  arch/arm/dts/meson-gxbb-odroidc2.dts   | 2 +-
>>>  arch/arm/dts/meson-gxm-khadas-vim2.dts | 2 +-
>>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/meson-g12b-odroid-n2.dtsi b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>>> index 6982632ae6..39a09661c5 100644
>>> --- a/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>>> +++ b/arch/arm/dts/meson-g12b-odroid-n2.dtsi
>>> @@ -413,7 +413,7 @@
>>>  		max-speed = <1000>;
>>>
>>>  		reset-assert-us = <10000>;
>>> -		reset-deassert-us = <30000>;
>>> +		reset-deassert-us = <80000>;
>>
>> In fact, these are not used by current U-boot, support for
>> reset/deassert in PHY node
>> is not yet supported in U-Boot. This first step was to switch to
>> DM_MDIO and use the
>> proper Designware glue, the second step is to find how to make use of
>> these properties.
> 
> Hm, that is strange, I have users reporting that this patch fixes the
> issue on their devices. I guess it might be that the problem does not
> always appear and it was just (bad) luck.
> 
>>
>> Concerning the patch, I'll prefer you sync the DT with v5.11 instead.
> 
> We have multiple reports of non-working ODROID-C2 which worked in
> previous U-Boot releases:
> https://github.com/home-assistant/operating-system/issues/1202
> 
> Similar reports exist in Armbian Forums as well.
> 
> Until we have proper PHY reset/deassert support, I'd suggest to revert
> dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
> partially then...

Reverting this is clearly not a solution, the intermediate solution is to
put back the previous reset properties like it was done for multiple boards
like in arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi :

==========================================================================
diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
index 90087b00db..f1e6914351 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
@@ -29,6 +29,12 @@
        };
 };

+&ethmac {
+        snps,reset-gpio = <&gpio GPIOZ_14 0>;
+        snps,reset-delays-us = <0 10000 1000000>;
+        snps,reset-active-low;
+};
+
 &usb0 {
        status = "disabled";
 };
==========================================================================

Neil
> 
> --
> Stefan
> 
> 
>>
>> Neil
>>
>>>  		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>>
>>>  		interrupt-parent = <&gpio_intc>;
>>> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> index 7be3e35409..de27beafe9 100644
>>> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> @@ -165,7 +165,7 @@
>>>  			reg = <0>;
>>>
>>>  			reset-assert-us = <10000>;
>>> -			reset-deassert-us = <30000>;
>>> +			reset-deassert-us = <80000>;
>>>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>>
>>>  			interrupt-parent = <&gpio_intc>;
>>> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> index 70fcfb7b06..50de1d01e5 100644
>>> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> @@ -200,7 +200,7 @@
>>>  			reg = <0>;
>>>
>>>  			reset-assert-us = <10000>;
>>> -			reset-deassert-us = <30000>;
>>> +			reset-deassert-us = <80000>;
>>>  			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>>
>>>  			interrupt-parent = <&gpio_intc>;
>>> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> index bff8ec2c1c..e38d9e50ca 100644
>>> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> @@ -194,7 +194,7 @@
>>>  		reg = <0>;
>>>
>>>  		reset-assert-us = <10000>;
>>> -		reset-deassert-us = <30000>;
>>> +		reset-deassert-us = <80000>;
>>>  		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
>>>
>>>  		interrupt-parent = <&gpio_intc>;
>>>

