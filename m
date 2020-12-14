Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
 by mx.groups.io with SMTP id smtpd.web08.3473.1607978934382072958
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 12:48:54 -0800
Received: by mail-ua1-f66.google.com with SMTP id n18so5926266ual.9
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s04i7fnUUMz/vJRZ9jUDPdC3EcE04FYurzhWxZcHo9E=;
        b=veuQRnT/rVXEwmVe+sOQsrcuRAIDkEWFZ9hvfzYWqsGr+h86lxG2yXp0HA5CMhu6dS
         EYZmWG0n2uL9czDDtDhtq5veWe036BaT2LAETxLNmqSjcQwFqPyxifnAkVEwz3hW9nGJ
         gnLlIBsWSNcdLYrnhWiq9Np3rn2lR3SMC/mR5Do/La/+lgj4WdCbZFq+kgZJBec4UqGx
         asD03xu/lzyhpR/cFd6aVBAEYkoDWwkPimzWnER4ZN7r71Myya4jUjScR8s7tuQ1bpbY
         zTLRXx1k/4mZUG+TgsVpszq+yitwvYlU2KQKRgO1F9hDV3pMkOlovcpXkuoSQcQMJMvw
         UQtw==
MIME-Version: 1.0
References: <20201214184841.237356-1-narmstrong@baylibre.com>
In-Reply-To: <20201214184841.237356-1-narmstrong@baylibre.com>
From: Anton Arapov <arapov@gmail.com>
Date: Mon, 14 Dec 2020 21:48:42 +0100
Message-ID: <CAMeizLfQQAHf1cCv6GMb7WkF3=APB-O4GdNzO-=igWt+KkROzw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: fix bit manipulation of pin bias configuration
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Otto Meier <gf435@gmx.net>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

I tested it and it does fix the issue. I am able to boot from eMMC.

Thanks a lot!
Anton

On Mon, Dec 14, 2020 at 7:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the wrong usage of clrsetbits_le32(), badly setting the set argument.
>
> Fixes: c4c726c26b ("pinctrl: meson: add pinconf support")
> Reported-by: Anton Arapov <arapov@gmail.com>
> Reported-by: Otto Meier <gf435@gmx.net>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Hi Anton, Otto,
>
> This should fix eMMC booting on Odroid-C2, could you have a quick try to confirm ?
>
> Thanks,
> Neil
>
>  drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index d4539b02d8..5065b62436 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -216,13 +216,13 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
>         }
>
>         /* othewise, enable the bias and select level */
> -       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), 1);
> +       clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), BIT(bit));
>         ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_PULL, &reg, &bit);
>         if (ret)
>                 return ret;
>
>         clrsetbits_le32(priv->reg_pull + reg, BIT(bit),
> -                       param == PIN_CONFIG_BIAS_PULL_UP);
> +                       (param == PIN_CONFIG_BIAS_PULL_UP ? BIT(bit) : 0));
>
>         return 0;
>  }
> --
> 2.25.1
>
