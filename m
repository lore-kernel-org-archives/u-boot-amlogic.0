Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web09.37657.1635724037547172221
 for <u-boot-amlogic@groups.io>;
 Sun, 31 Oct 2021 16:47:17 -0700
Received: by mail-oi1-f175.google.com with SMTP id k8so9470452oik.7
        for <u-boot-amlogic@groups.io>; Sun, 31 Oct 2021 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+F1/6TtXqtH9pHjRE+i1KyJds59pE13DNdg5qjlZUBw=;
        b=H2qxwCRLd/tVT7jd9Tf+2QArgfYZyeBSw70QClYUcWS89wH5QASsuLunggr4NbGLep
         R6n/AvyKgIygOWvrHoqcAhD7QWSNUn3u01W+budTFxIgcKu/CWa0Q1C79HCDWu98dypE
         pvlwiRxnLDNY6KQT8TkwIHNHBXzyGij36zSFk=
MIME-Version: 1.0
References: <20211015101501.4091141-1-art@khadas.com>
In-Reply-To: <20211015101501.4091141-1-art@khadas.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Oct 2021 17:47:04 -0600
Message-ID: <CAPnjgZ0rtxoH9U+rwW6YmmHAzLTdov_khKR9cu=HwrCsWymnPg@mail.gmail.com>
Subject: Re: [PATCH] image: fix select_ramdisk for raw initrd
Content-Type: text/plain; charset="UTF-8"
To: Artem Lapkin <email2tema@gmail.com>
Cc: trini@konsulko.com, narmstrong@baylibre.com, TWarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On Fri, 15 Oct 2021 at 04:15, Artem Lapkin <email2tema@gmail.com> wrote:
>
> Problem
>
> We have unbootable raw initrd images because, select_ramdisk for raw
> initrd images ignore submited select addr and setup rd_datap value to 0
>
> Solution: setup rd_datap value from select
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  common/image-board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Do we need this patch as well as the other one? If so, can you combine them?

Also, is it possible to drop the assignment to rd_addr at the top of
the function?

>
> diff --git a/common/image-board.c b/common/image-board.c
> index e7660352e9..e3c6ea806a 100644
> --- a/common/image-board.c
> +++ b/common/image-board.c
> @@ -439,7 +439,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
>                                 end = strchr(select, ':');
>                         if (end) {
>                                 *rd_lenp = hextoul(++end, NULL);
> -                               *rd_datap = rd_addr;
> +                               *rd_datap = hextoul(select, NULL);
>                                 processed = true;
>                         }
>                 }
> --
> 2.25.1
>

Regards,
Simon
