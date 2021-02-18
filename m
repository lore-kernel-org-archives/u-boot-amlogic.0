Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.8140.1613660796782543197
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Feb 2021 07:06:37 -0800
Received: by mail-wr1-f41.google.com with SMTP id n4so3377786wrx.1
        for <u-boot-amlogic@groups.io>; Thu, 18 Feb 2021 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aa7TztdoEPRwlBhg1EsleVJtuCUd09jqQ/hA2+T2zy0=;
        b=tt7BCot+BeynuiylcfRXOGxM4aUVUuiZ8D61kWDd0KmHyeVKsM7lTpmLYnKh+KFzD9
         /4/lthzWIR+1/Fvr5ANZduovVKJtnNHcZLHHREzJ3j2LrX0fClnW/dXokHuU0eMYlWon
         YTbh8ZFVZ8OklfEbrxt2zPoBokSV6FM+2OxGJjYcJxeSPSQh1StWL4ZDJ/J1c84htV1V
         1NjUBHcnS4d6rQUmX6VcSzs4AYl9xQ7dx38FE1oP3gj5S34naD/DFRTTVKnGG1wRqZrP
         FL9IPKdi1z2TPearuOtbkxYuQwUGUz2oulHtK2rxQIuB7338rRXiqmBEfq4SPE6NHgm5
         Pi1w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v7 0/5] VIM3: add support for checking 'Function' button state
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <CGME20210218103327eucas1p21cbeb2ae82a75cb350e1b1a683e30a73@eucas1p2.samsung.com>
 <20210218103318.18915-1-m.szyprowski@samsung.com>
 <b7ca684d-f2aa-0f76-ec42-0c5182a7194c@baylibre.com>
Message-ID: <a98fd38d-9f19-5151-c60a-63706ef97a86@baylibre.com>
Date: Thu, 18 Feb 2021 16:06:32 +0100
MIME-Version: 1.0
In-Reply-To: <b7ca684d-f2aa-0f76-ec42-0c5182a7194c@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 18/02/2021 11:35, Neil Armstrong wrote:
> On 18/02/2021 11:33, Marek Szyprowski wrote:
>> Hi All,
>>
>> This patchset adds all building blocks needed for checking the 'Function'
>> button state in the boot script on Amlogic A311D based VIM3 board. This
>> button is connected to the ADC line of the SoC, so it required to enable
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
>> v7:
>> - added linux,code properties to the test.dts
>>
>> v6: https://lists.denx.de/pipermail/u-boot/2021-February/441039.html
>> - added a simple sandbox test for adc-keys
>> - use of_to_plat and adc_raw_to_uV to simplify code in the adc button driver
>>
>> v5: https://lists.denx.de/pipermail/u-boot/2021-January/438751.html
>> - rebased onto latest uboot-amlogic/u-boot-amlogic-next branch
>> - synchronized adc-keys binding with the recent version from the Linux
>>   kernel
>> - updated adc-keys driver to match behavior from dt-bindings
>> - added a patch for meson-saradc driver to register vdd reference supply
>>   to the ADC framework
>>
>> v4: https://lists.denx.de/pipermail/u-boot/2020-December/435641.html
>> - rebased onto uboot-amlogic/u-boot-amlogic-next and dropped merged patches
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
>>
>>
>> Patch summary:
>>
>> Marek Szyprowski (5):
>>   dt-bindings: input: adc-keys bindings documentation
>>   button: add a simple Analog to Digital Converter device based button
>>     driver
>>   adc: meson-saradc: add support for getting reference voltage value
>>   configs: khadas-vim3(l): enable Function button support
>>   test: add a simple test for the adc-keys button driver
>>
>>  arch/sandbox/dts/test.dts                   |  27 +++-
>>  configs/khadas-vim3_defconfig               |   2 +
>>  configs/khadas-vim3l_defconfig              |   2 +
>>  configs/sandbox_defconfig                   |   1 +
>>  doc/device-tree-bindings/input/adc-keys.txt |  67 +++++++++
>>  drivers/adc/meson-saradc.c                  |  21 +++
>>  drivers/button/Kconfig                      |   8 ++
>>  drivers/button/Makefile                     |   1 +
>>  drivers/button/button-adc.c                 | 146 ++++++++++++++++++++
>>  test/dm/button.c                            |  50 ++++++-
>>  10 files changed, 322 insertions(+), 3 deletions(-)
>>  create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>>  create mode 100644 drivers/button/button-adc.c
>>
> 
> Applying to u-boot-amlogic !
> 
> Thanks,
> Neil
> 

Doesn't seem related to this patchset but one of my builder gets this error:
In file included from ../drivers/button/button-uclass.c:9:0:
973../include/button.h:37:42: warning: 'struct udevice' declared inside parameter list will not be visible outside of this definition or declaration
974  enum button_state_t (*get_state)(struct udevice *dev);
975                                          ^~~~~~~
976../include/button.h:49:51: warning: 'struct udevice' declared inside parameter list will not be visible outside of this definition or declaration
977 int button_get_by_label(const char *label, struct udevice **devp);
978                                                   ^~~~~~~
979../include/button.h:57:45: warning: 'struct udevice' declared inside parameter list will not be visible outside of this definition or declaration
980 enum button_state_t button_get_state(struct udevice *dev);
981                                             ^~~~~~~
982../drivers/button/button-uclass.c:13:5: error: conflicting types for 'button_get_by_label'
983 int button_get_by_label(const char *label, struct udevice **devp)
984     ^~~~~~~~~~~~~~~~~~~
985In file included from ../drivers/button/button-uclass.c:9:0:
986../include/button.h:49:5: note: previous declaration of 'button_get_by_label' was here
987 int button_get_by_label(const char *label, struct udevice **devp);
988     ^~~~~~~~~~~~~~~~~~~
989../drivers/button/button-uclass.c:29:21: error: conflicting types for 'button_get_state'
990 enum button_state_t button_get_state(struct udevice *dev)
991                     ^~~~~~~~~~~~~~~~
992In file included from ../drivers/button/button-uclass.c:9:0:
993../include/button.h:57:21: note: previous declaration of 'button_get_state' was here
994 enum button_state_t button_get_state(struct udevice *dev);
995                     ^~~~~~~~~~~~~~~~
996../drivers/button/button-uclass.c: In function 'button_get_state':
997../drivers/button/button-uclass.c:36:24: warning: passing argument 1 of 'ops->get_state' from incompatible pointer type [-Wincompatible-pointer-types]
998  return ops->get_state(dev);
999                        ^~~
1000../drivers/button/button-uclass.c:36:24: note: expected 'struct udevice *' but argument is of type 'struct udevice *'
1001make[3]: *** [../scripts/Makefile.build:265: drivers/button/button-uclass.o] Error 1
1002make[2]: *** [../scripts/Makefile.build:419: drivers/button] Error 2
1003make[1]: *** [/tmp/u-boot/Makefile:1791: drivers] Error 2

did I miss a dependency ?

Neil

