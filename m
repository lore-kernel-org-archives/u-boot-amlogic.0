Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.36270.1640680464893149419
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Dec 2021 00:34:25 -0800
Received: by mail-oi1-f179.google.com with SMTP id t204so23053379oie.7
        for <u-boot-amlogic@groups.io>; Tue, 28 Dec 2021 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqavyuqbBtsK+G2R/BMpDgs2005DUJyvvtHmh9Ru2Js=;
        b=CbDWp0NpBDaDbAlB5UBu/wteHlijFJcsZhS2j3P2rj+cCzsZLo6MOq6SZXH/IpAknD
         5EdTQ82gdc52mViOT7wW3peTiea70pC/rNpGAIh+c1XAVY05va+XwMKBLK4AE24c8Pyu
         rteZ4cuZz0tnqdxTWAZzg2QqNyle3rOm4jiws=
MIME-Version: 1.0
References: <20211222171114.3091780-1-seanga2@gmail.com> <20211222171114.3091780-6-seanga2@gmail.com>
In-Reply-To: <20211222171114.3091780-6-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Dec 2021 01:34:01 -0700
Message-ID: <CAPnjgZ3=Ucnib3jO+mZJ6J0-T5v=cL6gWUnjbsgw7J=vXYkW_Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: Add clk_get_by_name_optional
Content-Type: text/plain; charset="UTF-8"
To: Sean Anderson <seanga2@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Lukasz Majewski <lukma@denx.de>, Dario Binacchi <dariobin@libero.it>, Neil Armstrong <narmstrong@baylibre.com>, Michal Simek <monstr@monstr.eu>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Wed, 22 Dec 2021 at 10:11, Sean Anderson <seanga2@gmail.com> wrote:
>
> This adds a helper function for clk_get_by_name in cases where the clock is
> optional. Hopefully this helps point driver writers in the right direction.
> Also convert some existing users.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>
> (no changes since v1)
>
>  drivers/clk/clk_zynq.c  |  5 +++--
>  drivers/rng/meson-rng.c |  4 ++--
>  include/clk.h           | 24 ++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
