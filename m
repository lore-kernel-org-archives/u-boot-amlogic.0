Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
 by mx.groups.io with SMTP id smtpd.web12.1891.1588183500874705791
 for <u-boot-amlogic@groups.io>;
 Wed, 29 Apr 2020 11:05:01 -0700
Received: by mail-oi1-f195.google.com with SMTP id q204so2609179oia.13
        for <u-boot-amlogic@groups.io>; Wed, 29 Apr 2020 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOA3EWEtevX/OFIYlvFprQuQ0kvIenbiH2P9o9sLtLY=;
        b=ayWNwVqpOzbnTyOUK9bAhxqrN2mlgkMXSH8w+hDYcFi62lHsc7p/L5mXeNdlXkg5d2
         fAf/6foDLNpNIYydaH2gzMxDrGa3MtUBmqR1m1M/MXqaC49pT6V1xuezflMB1JjvP4Tn
         aPNtH+GES22Lzwd3gjbXJODieymtlU9uu3D9w=
MIME-Version: 1.0
References: <20200429080634.355-1-narmstrong@baylibre.com>
In-Reply-To: <20200429080634.355-1-narmstrong@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2020 12:04:46 -0600
Message-ID: <CAPnjgZ03-q+Li0t1xpLaPnKquX-Rts9Jp6uD77iaxvb6cfY4sQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: emulate open drain & open source in dm_gpio_set_value()
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Patrick Delaunay <patrick.delaunay@st.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 29 Apr 2020 at 02:06, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Handle the GPIOD_OPEN_DRAIN & GPIOD_OPEN_SOURCE flags to emulate open drain
> and open source by setting the GPIO line as input depending on the
> requested value.
>
> The behaviour is taken from the Linux gpiolib.
>
> It notably permits enabling a GPIO regulator used as Open Drain on the
> Amlogic G12A/g12B/SM1 platforms for HDMI output feature.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpio/gpio-uclass.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Can you update the GPIO test please?

Regards,
Simon
