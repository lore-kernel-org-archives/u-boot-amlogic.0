Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.3579.1608344917092294768
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 18:28:37 -0800
Received: by mail-wm1-f48.google.com with SMTP id v14so4433656wml.1
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 18:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBOg5FJ7PD8C7DaQdZOZDFJIW/RgrCruDONbFfj863Q=;
        b=YYU7YtfVcHpcyYKR1VfzO9+pbfY4hCBuw44Z5NR1t8EPuV5zGtXvMmyyybZqugKYyz
         bkIFGLQX0UbXlubU4cFU7j5vkQkbAp4aJOCtvb1eGCAS7L9KdBIgyI8ERcalLFBrvIeI
         071hzjDjDfoseoDYugzXNcg6DJKyNU0J8GYQk=
MIME-Version: 1.0
References: <CGME20201214112451eucas1p2ace7794301c6791761fd130c158f3d08@eucas1p2.samsung.com>
 <20201214112437.18757-1-m.szyprowski@samsung.com> <20201214112437.18757-6-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-6-m.szyprowski@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Dec 2020 19:28:21 -0700
Message-ID: <CAPnjgZ1r__n+u-q5JFP+4N4AiySOeTm2rerd-nCRC_+nG8vSNQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] cmd: button: store button state in the 'button' env
Content-Type: text/plain; charset="UTF-8"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On Mon, 14 Dec 2020 at 04:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Save examined button state in 'button' environment variable to enable
> checking button state in the scripts.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Change-Id: I78b539e1516573fcfea4401f75469291844daae4
> ---
>  cmd/button.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Can you add this to the README /docs where it talks about env vars?

>
> diff --git a/cmd/button.c b/cmd/button.c
> index 64c5a8fa046..8da911068a4 100644
> --- a/cmd/button.c
> +++ b/cmd/button.c
> @@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
>         ret = button_get_state(dev);
>         if (ret >= BUTTON_COUNT)
>                 ret = -EINVAL;
> -       if (ret >= 0)
> +       if (ret >= 0) {
>                 printf("%s\n", state_label[ret]);
> +               env_set("button", state_label[ret]);
> +       }
>
>         return ret;
>  }
> --
> 2.17.1
>

Regards,
Simon
