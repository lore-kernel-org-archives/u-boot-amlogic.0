Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.8161.1611319333838260842
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Jan 2021 04:42:14 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210122124210euoutp0298c9a4285499e196579f955cdd627c26~cjmTul7Nb1623116231euoutp02Q
	for <u-boot-amlogic@groups.io>; Fri, 22 Jan 2021 12:42:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210122124210euoutp0298c9a4285499e196579f955cdd627c26~cjmTul7Nb1623116231euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611319330;
	bh=E/z4rq9LFX5s7O5kzPhAcwzYtuxPStLSLmMg4w2xTvc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=fkYN+jwfmRcMkBjlFlk10tupnFEcw6q99kdCEraIGZl3Ecp6wHa+u+csKy0X5FNOu
	 DIoSnIxk8SD3H2PU0dMyLn7Z4PmQ2RroQOJC28If6LIPNfW0Y7k0VBlRXwYwtT0JVx
	 pD6/phPJt+rxEIX2Dbyt9BpqfUYMJ+OccTNdmpKs=
Subject: Re: [PATCH v4 0/3] VIM3: add support for checking 'Function' button state
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <825c4df2-c1ea-9b6b-30c4-2ce834737377@samsung.com>
Date: Fri, 22 Jan 2021 13:42:10 +0100
MIME-Version: 1.0
In-Reply-To: <5a3a1b93-885a-6131-923d-33cdf8dbc589@baylibre.com>
References: <CGME20201222085638eucas1p158d91ce4a22d13623b19706b26374078@eucas1p1.samsung.com>
	<20201222085633.10194-1-m.szyprowski@samsung.com>
	<47e599d6-288c-163c-e40a-9c5d5b534bf9@baylibre.com>
	<7a32a0a8-689e-6758-2062-84a2e9bca1c1@gmx.de>
	<5a3a1b93-885a-6131-923d-33cdf8dbc589@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On 18.01.2021 13:55, Neil Armstrong wrote:
> On 18/01/2021 13:48, Heinrich Schuchardt wrote:
>> On 18.01.21 11:24, Neil Armstrong wrote:
>>> On 22/12/2020 09:56, Marek Szyprowski wrote:
>>>> Hi All,
>>>>
>>>> This patchset adds all building blocks needed for checking the 'Function'
>>>> button state in the boot script on Amlogic A311D based VIM3 board. This
>>>> button is connected to the ADC lines of the SoC, so it required to enable
>>>> meson SARADC, the clocks needed for it and a simple button-adc drivers.
>>>>
>>>> Once applied, one can use following commands in the boot scripts:
>>>> -->8---
>>>> echo Checking Func button state: \\c
>>>> if button Function
>>>> then
>>>> 	echo Selected alternative boot
>>>> 	...
>>>> fi
>>>> --->8---
>>>>
>>>> Best regards
>>>> Marek Szyprowski
>>>> Samsung R&D Institute Poland
>>>>
>>>>
>>>> Changelog:
>>>> v4:
>>>> - rebased onto uboot-amlogic/u-boot-amlogic-next and dropped merged patches
>>>> - added adc-keys bindings docs (copied from Linux kernel)
>>>> - minor code adjustments pointed by Simon
>>>> - enabled driver also in khadas-vim3l_defconfig
>>>>
>>>> v3: https://protect2.fireeye.com/v1/url?k=fc4a4b97-a3d1734e-fc4bc0d8-0cc47a3356b2-eb4ba315795a3f17&q=1&e=b660ed0e-7d37-47e8-877d-c8391317e3e0&u=https%3A%2F%2Flists.denx.de%2Fpipermail%2Fu-boot%2F2020-December%2F435072.html
>>>> - removed 'button' env variable
>>>> - extended kconfig and patch descriptions
>>>>
>>>> v2: https://protect2.fireeye.com/v1/url?k=11f0ed69-4e6bd5b0-11f16626-0cc47a3356b2-f341d16b01448534&q=1&e=b660ed0e-7d37-47e8-877d-c8391317e3e0&u=https%3A%2F%2Flists.denx.de%2Fpipermail%2Fu-boot%2F2020-December%2F434991.html
>>>> - removed Change-Id tags
>>>> - split defconfig changes into ADC and button related
>>>>
>>>> v1: https://protect2.fireeye.com/v1/url?k=7c601119-23fb29c0-7c619a56-0cc47a3356b2-55caa8afe3085a65&q=1&e=b660ed0e-7d37-47e8-877d-c8391317e3e0&u=https%3A%2F%2Flists.denx.de%2Fpipermail%2Fu-boot%2F2020-December%2F434875.html
>>>> - initial submission
>>> What's the state of the patchset ?
>> Hello Neil,
>>
>> the series is assigned to you. Patch 2 is incorrect. Patch 1 can be
>> updated to match Linux. So I suggest to set the status for the series to
>> "changes requested".
> Sure, it was more a question to Marek, but yeah I'll tag them "changes requested"

I'm sorry for the late reply, I've been busy with other stuff. I will 
try to update the adc-keys driver to use the threshold values and add 
the updated device tree bindings soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

