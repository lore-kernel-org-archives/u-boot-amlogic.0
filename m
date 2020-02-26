Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
 by mx.groups.io with SMTP id smtpd.web09.9774.1582731203716426145
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 07:33:23 -0800
Received: by mail-oi1-f196.google.com with SMTP id q81so3461279oig.0
        for <u-boot-amlogic@groups.io>; Wed, 26 Feb 2020 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVtXhxiFlHeTs3xcxjNLJgHwpRkSwPHtv1FRtPm4ams=;
        b=KXAIFgrFTNwGXg3+ddfXxj2HW+xVCmX67adE08jmYd6PHuiED8OlUJCnyrsP/wi6dU
         F+OH7mQaX/rNpzQ6DZ9yvBX9f9m3RFGtE39bX//krSFm/LTB2SoFZBuDrdNbh1ZX8bJd
         0QaNM/xidpvjTvaeN2d5cDn2zMX3eJz5O1n60=
MIME-Version: 1.0
References: <20200225051021.15311-1-michael@amarulasolutions.com> <20200225051021.15311-3-michael@amarulasolutions.com>
In-Reply-To: <20200225051021.15311-3-michael@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Feb 2020 07:33:10 -0800
Message-ID: <CAPnjgZ2ypmwrPmyBFq2UXQ=_t3RxiKQJK=hBTpSU0KTbKRR3jQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: meson: Use reserving memory function without kernel linear mapping
Content-Type: text/plain; charset="UTF-8"
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Michae,

On Mon, 24 Feb 2020 at 22:10, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Memory reserved for the simple framebuffer should not be used
> and part of memory linear mapping. See
> https://patchwork.kernel.org/patch/10486131/ for more detailed
> background information and discussion.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> Changes RFC -> v1:
>         - Fix compilation issue on RFC
>         - change node name from display_reserved to display-reserved
> ---
>  drivers/video/meson/meson_vpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Is the binding file for this in U-Boot? If not can you please add it?

>
> diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
> index 4eb66398d0..5bfad05d75 100644
> --- a/drivers/video/meson/meson_vpu.c
> +++ b/drivers/video/meson/meson_vpu.c
> @@ -173,9 +173,9 @@ static void meson_vpu_setup_simplefb(void *fdt)
>          * at the end of the RAM and we strip this portion from the kernel
>          * allowed region
>          */
> -       mem_start = gd->bd->bi_dram[0].start;
> -       mem_size = gd->bd->bi_dram[0].size - meson_fb.fb_size;
> -       ret = fdt_fixup_memory_banks(fdt, &mem_start, &mem_size, 1);
> +       mem_start = meson_fb.base;
> +       mem_size = meson_fb.fb_size;
> +       ret = fdt_fixup_reserved_memory(fdt, "display-reserved", &mem_start, &mem_size);
>         if (ret) {
>                 eprintf("Cannot setup simplefb: Error reserving memory\n");
>                 return;

Needs to return an error code which needs to be checked by caller.

> --
> 2.17.1
>

Regards,
Simon
