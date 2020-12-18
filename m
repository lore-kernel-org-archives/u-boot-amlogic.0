Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mx.groups.io with SMTP id smtpd.web10.7674.1608284551307510803
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:42:32 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201218094214euoutp01640fbb5cf1fe067d44d80b4d653fd260~RxkM7kk3b0613206132euoutp01U
	for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 09:42:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201218094214euoutp01640fbb5cf1fe067d44d80b4d653fd260~RxkM7kk3b0613206132euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608284534;
	bh=Z2nUEdG/rngLbbgZBmxhN+XwcViLaTWsLWV9q+YzPFQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=OwYqZsnLFd4CkSomHXtnT1gC93JeYVfhsZuPnEeWGwwgY7AFL2vFl1azJNuhexzUE
	 p0RnaK129CXR7u83ZRiAYEX3mXkCe6laZhUPWfLP6rX3hRn38xNsJcZ7faaAUwHwxJ
	 u+bM+RmxPhu2oftPhUzDPBH2om6LSI/mIsWA0M8w=
Subject: Re: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7d86442a-4de9-d7c5-c997-8d1f17fcb7a5@samsung.com>
Date: Fri, 18 Dec 2020 10:42:09 +0100
MIME-Version: 1.0
In-Reply-To: <eea5161b-c5bc-3804-5f88-318052c29a31@baylibre.com>
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com>
	<20201217090624.14902-1-m.szyprowski@samsung.com>
	<0c53e06e-afa4-2308-7d5d-ba08b1d0caf3@baylibre.com>
	<b006ae83-3a27-f0dd-c905-5ac7f41be067@samsung.com>
	<eea5161b-c5bc-3804-5f88-318052c29a31@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, tobetter <tobetter@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On 18.12.2020 10:24, Neil Armstrong wrote:
> On 18/12/2020 10:11, Marek Szyprowski wrote:
>> On 18.12.2020 09:36, Neil Armstrong wrote:
>>> On 17/12/2020 10:06, Marek Szyprowski wrote:
>>>> For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
>>>> pin to the input (high impedance?) mode, otherwise the board is stuck
>>>> in the middle of loading early stages of the bootloader from SD card.
>>> Did you try taking the regulator-tflash_vdd and doing a disable/enable sequence
>>> to reset the card ?
>>>
>>> The GPIOAO_3 has a default pull-up, so I don't see why moving it to input could change
>>> anything.
>>>
>>> So maybe simply doing a 0->1 transition could do the same, using the regulator
>>> would be much better.
>>>
>>> Can't we add "shutdown" or equivalent method to  the mmc driver that could do this
>>> directly with the vdd regulator ?
>> Yes, I've tried all combinations of playing this that GPIO and regulator
>> that came to my mind. Switching pin to the input is the only one I've
>> found working.
> Thanks for the dumps !
>
> Could you try switching the tflash_vdd to opendrain like :
>
> --->8---
>
> --- a/arch/arm/dts/meson-sm1-odroid-c4.dts
> +++ b/arch/arm/dts/meson-sm1-odroid-c4.dts
> @@ -52,7 +52,7 @@
>                  regulator-min-microvolt = <3300000>;
>                  regulator-max-microvolt = <3300000>;
>
> -               gpio = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +               gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
>                  enable-active-high;
>                  regulator-always-on;
>          };
>
> --->8---
>
> This should leave the pin in input to achieve high state, and solve the issue.
>
Right, this fixed the issue! Thanks!

Do you want me to submit it as a patch to uboot and mainline Linux 
kernel or do you want to handle it by yourself?

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

