Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web09.37656.1635724037451543903
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Oct 2021 16:47:17 -0700
Received: by mail-ot1-f46.google.com with SMTP id v19-20020a9d69d3000000b00555a7318f31so10826541oto.9
        for <u-boot-amlogic@groups.io>; Sun, 31 Oct 2021 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC+q94Us7eKdC/82xCy99rAIjwpqhCCk/V2VH1gvcbY=;
        b=DajtX+oibrlYn8IuwAhQJnQ0XF8z0HDrcQBrh2uDQVFRz85HP3kekohsHsg9RBPS7E
         ge+BpWBcVs+3R2HrAvw8MZMlNe1h9j/nP0xD00d7bqXv7gy2sUf6m6zwm8xIouhzZ/1c
         3t6GQ+xZgkKQFTNOVHzwquNhotgK5DJ/ekFA8=
MIME-Version: 1.0
References: <20211016051915.4157293-1-art@khadas.com>
In-Reply-To: <20211016051915.4157293-1-art@khadas.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Oct 2021 17:47:02 -0600
Message-ID: <CAPnjgZ1om_it=7hec5B9pXxZBeqZDiMQ2MNC4kkhXcHupTFAYg@mail.gmail.com>
Subject: Re: [PATCH] image-board: fix wrong implementation ram disk address setup from cmdline
Content-Type: text/plain; charset="UTF-8"
To: Artem Lapkin <email2tema@gmail.com>
Cc: trini@konsulko.com, narmstrong@baylibre.com, TWarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On Fri, 15 Oct 2021 at 23:19, Artem Lapkin <email2tema@gmail.com> wrote:
>
> Problem
>
> Wrong implementation logic: ramdisk cmdline image address always ignored!
> Next block { rd_addr = hextoul(select, NULL) } unusable for raw initrd.
>
> We have unbootable raw initrd images because, select_ramdisk for raw
> initrd images ignore submited select addr and setup rd_datap value to 0
>
> Come-from: https://patchwork.ozlabs.org/project/uboot/patch/20211015101501.4091141-1-art@khadas.com/
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  common/image-board.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Fixes: f33a2c1bd0f ("image: Remove #ifdefs from select_ramdisk()")

(I believe, can you confirm?)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/common/image-board.c b/common/image-board.c
> index e7660352e9..e7063016ef 100644
> --- a/common/image-board.c
> +++ b/common/image-board.c
> @@ -333,7 +333,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
>
>         if (select) {
>                 ulong default_addr;
> -               bool done = true;
> +               bool done = false;
>
>                 if (CONFIG_IS_ENABLED(FIT)) {
>                         /*
> @@ -351,13 +351,13 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
>                                            &fit_uname_config)) {
>                                 debug("*  ramdisk: config '%s' from image at 0x%08lx\n",
>                                       fit_uname_config, rd_addr);
> +                               done = true;
>                         } else if (fit_parse_subimage(select, default_addr,
>                                                       &rd_addr,
>                                                       &fit_uname_ramdisk)) {
>                                 debug("*  ramdisk: subimage '%s' from image at 0x%08lx\n",
>                                       fit_uname_ramdisk, rd_addr);
> -                       } else {
> -                               done = false;
> +                               done = true;
>                         }
>                 }
>                 if (!done) {
> --
> 2.25.1
>
