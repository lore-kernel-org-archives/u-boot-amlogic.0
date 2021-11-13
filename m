Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web11.6266.1636812510435719526
 for <u-boot-amlogic@groups.io>;
 Sat, 13 Nov 2021 06:08:30 -0800
Received: by mail-ua1-f53.google.com with SMTP id v3so24766274uam.10
        for <u-boot-amlogic@groups.io>; Sat, 13 Nov 2021 06:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBeP1ZTqfwduWATnkfSNKYeJkCA2ncPJdjIKL/ODFRg=;
        b=JSWM4rBinKCJBjgnuxUUtO1roIDVg5CeGtmZySPfOXA6nNi1qqmbm5Zh3bG7v1u/Zv
         kN3oMxSh+p7OUw+qVWhE5hdMeghgiSs850GdSJoBrIaPfro3q4xQB3F4A3jxWKTVYe2i
         2g950XUnJ1aTVWCBhCNFSuYh9DSKdiDYSl+ZU=
MIME-Version: 1.0
References: <20211113020034.263468-1-sjg@chromium.org> <20211113040834.GV24579@bill-the-cat>
In-Reply-To: <20211113040834.GV24579@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Nov 2021 07:08:18 -0700
Message-ID: <CAPnjgZ0mGRXYo7bw5rXq9ESPWFOmdo1XqPewSOGynfHV_VEQ8A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: Correct the driver GPIO declaration
Content-Type: text/plain; charset="UTF-8"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

On Fri, 12 Nov 2021 at 21:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 12, 2021 at 07:00:34PM -0700, Simon Glass wrote:
>
> > This should use the provided U_BOOT_DRIVER() macro so that the driver gets
> > added to the appropriate linker list. Fix it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 7c9dcfed50f ("pinctrl: meson: rework gx pmx function")
>
> Doesn't build for me:
> /home/trini/work/u-boot/u-boot/drivers/pinctrl/meson/pinctrl-meson-gxl.c:704:28:
> error: 'meson_
> gx_gpio_driver' undeclared here (not in a function); did you mean
> 'meson_gpio_probe'?
>   704 |         .gpio_driver    = &meson_gx_gpio_driver,
>         |                            ^~~~~~~~~~~~~~~~~~~~
>               |                            meson_gpio_probe
>
> For libretech-cc

Oh I only fixed one driver and was building odroid-c2 (just a guess).
I will send v2 that works with 'buildman meson'.

Regards,
Simon
