Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.7991.1608018747427591503
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 23:52:27 -0800
Received: by mail-wm1-f67.google.com with SMTP id q75so17523299wme.2
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 23:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LI3RSJBrszumLb/6jiuUGX6PignWJjyaTbH4+rBrucc=;
        b=c/xkk3gk/LvzbaNsiu3AmwDIPuDqBsmrrNuF5y7whqkK8RZAFLXwOElicZoTQzAyW4
         +2gh4esOdo4zoyJNERgvY8Yjy4usBHBYE/wGxEtZVE3wYJ5/nCsFiNZZH9dRkltcIjgK
         Xzh790PveMWZtVpLIT9s59K8G7J2iyhpQ4fcH9h9rEywXosivglnLxw3Wvg8yX67lQM1
         6h03+Xn8vzKyy6OQ1Ifwoi9FdDUmONDFCBtpZJr4+89x1vmFXPClnu1Yj+Pteb1a9v7+
         sRJh4leUGF5vWuj/AWLwhc+moijLslLRaqfQA2tyMn88U647R1KpOzILGzcd7IcedsLP
         6GcA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] pinctrl: meson: fix bit manipulation of pin bias configuration
References: <20201214184841.237356-1-narmstrong@baylibre.com>
 <CAMeizLfQQAHf1cCv6GMb7WkF3=APB-O4GdNzO-=igWt+KkROzw@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <7cb32a35-d836-ee7e-9966-b5fab1c440c3@baylibre.com>
Date: Tue, 15 Dec 2020 08:52:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAMeizLfQQAHf1cCv6GMb7WkF3=APB-O4GdNzO-=igWt+KkROzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anton Arapov <arapov@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Otto Meier <gf435@gmx.net>
List-ID: <u-boot-amlogic@groups.io>

On 14/12/2020 21:48, Anton Arapov wrote:
> Hi Neil,
> 
> I tested it and it does fix the issue. I am able to boot from eMMC.
> 
> Thanks a lot!
> Anton
> 
> On Mon, Dec 14, 2020 at 7:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This fixes the wrong usage of clrsetbits_le32(), badly setting the set argument.
>>
>> Fixes: c4c726c26b ("pinctrl: meson: add pinconf support")
>> Reported-by: Anton Arapov <arapov@gmail.com>
>> Reported-by: Otto Meier <gf435@gmx.net>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Hi Anton, Otto,
>>
>> This should fix eMMC booting on Odroid-C2, could you have a quick try to confirm ?
>>
>> Thanks,
>> Neil
>>
>>  drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
>> index d4539b02d8..5065b62436 100644
>> --- a/drivers/pinctrl/meson/pinctrl-meson.c
>> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
>> @@ -216,13 +216,13 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
>>         }
>>
>>         /* othewise, enable the bias and select level */
>> -       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), 1);
>> +       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), BIT(bit));
>>         ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_PULL, &reg, &bit);
>>         if (ret)
>>                 return ret;
>>
>>         clrsetbits_le32(priv->reg_pull + reg, BIT(bit),
>> -                       param == PIN_CONFIG_BIAS_PULL_UP);
>> +                       (param == PIN_CONFIG_BIAS_PULL_UP ? BIT(bit) : 0));
>>
>>         return 0;
>>  }
>> --
>> 2.25.1
>>

Thanks for testing !

Applied to u-boot-amlogic

Neil
