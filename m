Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by mx.groups.io with SMTP id smtpd.web09.32672.1610974133105809236
 for <u-boot-amlogic@groups.io>;
 Mon, 18 Jan 2021 04:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1610974126;
	bh=6fr2bkMKxUHxAMKRLP3bwN8Jj+YZParXiVJk3QcPxJQ=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=DGbE4x0mp71q6s3ur7LfPrPZWWqfYuiHcneM0FwThPlI4LL3JTcE8PPgrNux9vTn7
	 lxIrLUxYyIMg088S26jtNk2SnAAkHeHwzECYpJJ7ItVyfOk7OyDZAu3KuXK4ZjdtnM
	 olN2vDzI2zufc58jQO8e6t8K1SKUKhuK4hdJAWkg=
Subject: Re: [PATCH v4 0/3] VIM3: add support for checking 'Function' button state
References: <CGME20201222085638eucas1p158d91ce4a22d13623b19706b26374078@eucas1p1.samsung.com>
 <20201222085633.10194-1-m.szyprowski@samsung.com>
 <47e599d6-288c-163c-e40a-9c5d5b534bf9@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <7a32a0a8-689e-6758-2062-84a2e9bca1c1@gmx.de>
Date: Mon, 18 Jan 2021 13:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <47e599d6-288c-163c-e40a-9c5d5b534bf9@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 18.01.21 11:24, Neil Armstrong wrote:
> Hi,
>
> On 22/12/2020 09:56, Marek Szyprowski wrote:
>> Hi All,
>>
>> This patchset adds all building blocks needed for checking the 'Functio=
n'
>> button state in the boot script on Amlogic A311D based VIM3 board. This
>> button is connected to the ADC lines of the SoC, so it required to enab=
le
>> meson SARADC, the clocks needed for it and a simple button-adc drivers.
>>
>> Once applied, one can use following commands in the boot scripts:
>> -->8---
>> echo Checking Func button state: \\c
>> if button Function
>> then
>> 	echo Selected alternative boot
>> 	...
>> fi
>> --->8---
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
>>
>>
>> Changelog:
>> v4:
>> - rebased onto uboot-amlogic/u-boot-amlogic-next and dropped merged pat=
ches
>> - added adc-keys bindings docs (copied from Linux kernel)
>> - minor code adjustments pointed by Simon
>> - enabled driver also in khadas-vim3l_defconfig
>>
>> v3: https://lists.denx.de/pipermail/u-boot/2020-December/435072.html
>> - removed 'button' env variable
>> - extended kconfig and patch descriptions
>>
>> v2: https://lists.denx.de/pipermail/u-boot/2020-December/434991.html
>> - removed Change-Id tags
>> - split defconfig changes into ADC and button related
>>
>> v1: https://lists.denx.de/pipermail/u-boot/2020-December/434875.html
>> - initial submission
>
> What's the state of the patchset ?

Hello Neil,

the series is assigned to you. Patch 2 is incorrect. Patch 1 can be
updated to match Linux. So I suggest to set the status for the series to
"changes requested".

Best regards

Heinrich

>
> Neil
>
>>
>>
>> Patch summary:
>>
>> Marek Szyprowski (3):
>>   dt-bindings: input: adc-keys bindings documentation
>>   button: add a simple Analog to Digital Converter device based button
>>     driver
>>   configs: khadas-vim3(l): enable Function button support
>>
>>  configs/khadas-vim3_defconfig               |   2 +
>>  configs/khadas-vim3l_defconfig              |   2 +
>>  doc/device-tree-bindings/input/adc-keys.txt |  49 ++++++++
>>  drivers/button/Kconfig                      |   8 ++
>>  drivers/button/Makefile                     |   1 +
>>  drivers/button/button-adc.c                 | 121 ++++++++++++++++++++
>>  6 files changed, 183 insertions(+)
>>  create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>>  create mode 100644 drivers/button/button-adc.c
>>
>

