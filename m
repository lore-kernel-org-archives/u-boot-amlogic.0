Received: from dd10532.kasserver.com (dd10532.kasserver.com [85.13.133.80])
 by mx.groups.io with SMTP id smtpd.web10.13245.1608403304187328599
 for <u-boot-amlogic@groups.io>;
 Sat, 19 Dec 2020 10:41:44 -0800
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net>
 <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net>
 <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net>
 <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net>
 <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
 <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net>
 <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
From: Otto Meier <gf435@gmx.net>
Message-ID: <0cef2d79-4f15-72c6-1308-d29eca9e49cc@gmx.net>
Date: Sat, 19 Dec 2020 19:41:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Martin,

Am 19.12.20 um 14:58 schrieb Martin Blumenstingl:
> Hi Otto,
>
> On Mon, Dec 14, 2020 at 8:34 PM Otto Meier <gf435@gmx.net> wrote:
>> Hi Martin,
>>
>> Am 13.12.20 um 19:46 schrieb Martin Blumenstingl:
>>> Hi Otto,
>>>
>>> On Mon, Dec 7, 2020 at 1:43 PM Otto Meier <gf435@gmx.net> wrote:
>>> [...]
>>>>>> So with the latest u-boot and the kernel from https://github.com/chewitt/linux/tree/amlogic-5.10.y
>>>>>> commit 725fc8df7898102f9031ba2075f763884ffa3ee8 everything is working again.
>>>>>> USB does hotplugging as expected.
>>>>> So, this fixes USB under Linux ?? It's not clear
>>> if you have time it would be great if you could figure out which of
>>> the patches from Christian's tree fixes USB hotplugging for you.
>>> Or is it fixed in Linux 5.10-rcX even without any patches?
>>>
>> The new mainline kernel 5.10.0 from Linus, without any other patches
>> does detect USB hotpluging,
>> when using u-boot DMI: Hardkernel Co., Ltd. ODROID-C2/ODROID-C2, BIOS
>> 2021.01-rc3-00039-gec79f5ce22-dirty 12/08/2020
>> and the following u-boot patch:
> [...]
>> When i use the last unpatched emmc bootable u-boot 2020.04 the kernel
>> boots, but usb hotplugging
>> does not work.
> Thank you for testing this!
>
>> Hope this describes my findings. If i can help further, please give me a
>> note.
> to be honest: I am a bit lost here. I don't understand how the BOOT_*
> pins interfere with USB.
> I also don't have any Odroid-C2 board myself so I cannot do any
> experiments myself.
> Neil, please let me know if you have any idea here.
The latest Patch from Neil in U-boot also
fixes all the problems:

This fixes the wrong usage of clrsetbits_le32(), badly setting the set argument.

Fixes: c4c726c26b ("pinctrl: meson: add pinconf support")
Reported-by: Anton Arapov<arapov@gmail.com>
Reported-by: Otto Meier<gf435@gmx.net>
Signed-off-by: Neil Armstrong<narmstrong@baylibre.com>
---
Hi Anton, Otto,

This should fix eMMC booting on Odroid-C2, could you have a quick try to confirm ?

Thanks,
Neil

  drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index d4539b02d8..5065b62436 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -216,13 +216,13 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
         }

         /* othewise, enable the bias and select level */
-       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), 1);
+       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), BIT(bit));
         ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_PULL, &reg, &bit);
         if (ret)
                 return ret;

         clrsetbits_le32(priv->reg_pull + reg, BIT(bit),
-                       param == PIN_CONFIG_BIAS_PULL_UP);
+                       (param == PIN_CONFIG_BIAS_PULL_UP ? BIT(bit) : 0));

         return 0;
  }
--
2.25.1

perhaps this gives an idea of what was wrong.
But anyhow for me the issues with U-boot and usb hotplug is solved so far.
For me this is even more i understand.


>
> Best regards,
> Martin
>
Thanks for your help.

Otto
