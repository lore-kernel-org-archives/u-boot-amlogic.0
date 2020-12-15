Received: from dd10532.kasserver.com (dd10532.kasserver.com [85.13.133.80])
 by mx.groups.io with SMTP id smtpd.web08.8886.1608025865603881768
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 01:51:05 -0800
Subject: Re: [PATCH] pinctrl: meson: fix bit manipulation of pin bias configuration
References: <20201214184841.237356-1-narmstrong@baylibre.com>
 <CAMeizLfQQAHf1cCv6GMb7WkF3=APB-O4GdNzO-=igWt+KkROzw@mail.gmail.com>
 <7cb32a35-d836-ee7e-9966-b5fab1c440c3@baylibre.com>
From: Otto Meier <gf435@gmx.net>
Message-ID: <a5f92fe2-ea3c-ea01-8d4d-217688794122@gmx.net>
Date: Tue, 15 Dec 2020 10:51:00 +0100
MIME-Version: 1.0
In-Reply-To: <7cb32a35-d836-ee7e-9966-b5fab1c440c3@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
To: Neil Armstrong <narmstrong@baylibre.com>, Anton Arapov <arapov@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

I tested it also with newest U-boot DMI: Hardkernel Co., Ltd. 
ODROID-C2/ODROID-C2, BIOS 2021.01-rc3-00134-gf40825e18e-dirty 12/15/2020

and it definitly fixes the emmc boot issue.


Am 15.12.20 um 08:52 schrieb Neil Armstrong:
> On 14/12/2020 21:48, Anton Arapov wrote:
>> Hi Neil,
>>
>> I tested it and it does fix the issue. I am able to boot from eMMC.
>>
>> Thanks a lot!
>> Anton
>>
>> On Mon, Dec 14, 2020 at 7:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> This fixes the wrong usage of clrsetbits_le32(), badly setting the set argument.
>>>
>>> Fixes: c4c726c26b ("pinctrl: meson: add pinconf support")
>>> Reported-by: Anton Arapov <arapov@gmail.com>
>>> Reported-by: Otto Meier <gf435@gmx.net>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>> Hi Anton, Otto,
>>>
>>> This should fix eMMC booting on Odroid-C2, could you have a quick try to confirm ?
>>>
>>> Thanks,
>>> Neil
>>>
>>>   drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
>>> index d4539b02d8..5065b62436 100644
>>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>>> @@ -216,13 +216,13 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
>>>          }
>>>
>>>          /* othewise, enable the bias and select level */
>>> -       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), 1);
>>> +       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), BIT(bit));
>>>          ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_PULL, &reg, &bit);
>>>          if (ret)
>>>                  return ret;
>>>
>>>          clrsetbits_le32(priv->reg_pull + reg, BIT(bit),
>>> -                       param == PIN_CONFIG_BIAS_PULL_UP);
>>> +                       (param == PIN_CONFIG_BIAS_PULL_UP ? BIT(bit) : 0));
>>>
>>>          return 0;
>>>   }
>>> --
>>> 2.25.1
>>>
> Thanks for testing !
>
> Applied to u-boot-amlogic
>
> Neil
>
Thank you very much for this correct fix.

Best regards
Otto


