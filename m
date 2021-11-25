Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.5985.1637799238331191144
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Nov 2021 16:13:58 -0800
Received: by mail-ot1-f54.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso6871966otr.2
        for <u-boot-amlogic@groups.io>; Wed, 24 Nov 2021 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI8qH4lybsMadvElGRnOdOqGhiMOe1/aSwzpOL1JlKE=;
        b=FK595AqTuxUXTzzk1qSECiieIgWhSejD8Aqhm+uXUcCLG1h7HTtCyvDR+/9EDBz8rE
         ecELrDtCttefOSNyfbw62lwooIJAXQdEW+EMnC4yx0+dIUEWoLx1dRlFFGFO2oB7h/GM
         7tzXJYVvCh/s73zASX8vIRSUOrZx2871gCIMg=
MIME-Version: 1.0
References: <20211119043647.1251416-1-art@khadas.com> <20211119043647.1251416-2-art@khadas.com>
In-Reply-To: <20211119043647.1251416-2-art@khadas.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Nov 2021 17:13:06 -0700
Message-ID: <CAPnjgZ0ejPwkwDua9exAU=bLgUUUFVVBcczftxwYSGGeRzrCzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] env: setenv add resolve value option
Content-Type: text/plain; charset="UTF-8"
To: Artem Lapkin <email2tema@gmail.com>
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, TWarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On Thu, 18 Nov 2021 at 21:37, Artem Lapkin <email2tema@gmail.com> wrote:
>
> Add possibility setup env variable with additional resolving vars inside
> value.
>
> Usage examples:
>
> => setenv a hello; setenv b world; setenv c '${a} ${b}'
> => setenv -r d '${c}! ${a}...'
> => printenv d
> d=hello world! hello...
>
> /* internal usage example */
> env_resolve("d", "${c}! ${a}...");
> /* d="hello world! hello..." */
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
> V2 changes:
> _ fix comments style
> _ add comment include/exports.h
> _ remake strcpy to strdup
> _ env_resolve minimize
> ---
>  cmd/nvedit.c       | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  include/_exports.h |  1 +
>  include/env.h      | 11 +++++++++++
>  include/exports.h  |  2 ++
>  4 files changed, 56 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
