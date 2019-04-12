Received: by mail-oi1-f195.google.com with SMTP id y84so7862851oia.12
        for <u-boot-amlogic@groups.io>; Fri, 12 Apr 2019 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8L5n1vvOE4y5Vn+c9Dp0XdxQs72KqcMRbdm8TfzUXA=;
        b=ofNOQeOW4uVX6wnwR7t7SKA8KJlftBRgOvTMeBoBydCM5114mfW3bIIdihWRdEthkh
         cKdT0OhoIrjwuaDUt2gb26qEqPWODu74jM76iN52LBo7NU3X2+KwJGfai5Lncm6Czk3w
         JGz6f4FW1AgyoJ3APGT14aPZDgJYlcfxI0YQo=
MIME-Version: 1.0
References: <20190411151204.27316-1-narmstrong@baylibre.com>
In-Reply-To: <20190411151204.27316-1-narmstrong@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Apr 2019 07:09:27 -0600
Message-ID: <CAPnjgZ3k_GGivhpUf6DgBJoU6A7pLA1TC=OyTdQmfnT7OsK6Ww@mail.gmail.com>
Subject: Re: [PATCH] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 11 Apr 2019 at 09:12, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When fixing sandbox test for regmap_read_poll_timeout(), the
> sandbox_timer_add_offset was introduced but only defined in sandbox code
> thus generating warnings when used out of sandbox :
>
> include/regmap.h:289:2: note: in expansion of macro 'regmap_read_poll_timeout_test'
> regmap_read_poll_timeout_test(map, addr, val, cond, sleep_us, \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/spi/meson_spifc.c:169:8: note: in expansion of macro 'regmap_read_poll_timeout'
> ret = regmap_read_poll_timeout(spifc->regmap, REG_SLAVE, data,
>         ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/spi/meson_spifc.c: In function 'meson_spifc_txrx':
> include/regmap.h:277:4: warning: implicit declaration of function 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]
>
> This simply adds an empty static inline sandbox_timer_add_offset()
> implementation that will be dropped by the compiler optimization routines.
>
> Cc: Simon Glass <sjg@chromium.org>
> Reported-by: Tom Rini <trini@konsulko.com>
> Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/regmap.h | 4 ++++
>  1 file changed, 4 insertions(+)
>

This is OK with me, but I wonder if it would be better to change the code:

if (IS_ENABLED(CONFIG_SANDBOX) && test_add_time) \
   sandbox_timer_add_offset(test_add_time); \

to something like

   do_test_add_time(test_add_time);

where do_test_add_time() is defined above as either a sandbox call, or empty?

The reason I say this is it seems a bit weird to define a function
called sandbox_... in non-sandbox code.

> diff --git a/include/regmap.h b/include/regmap.h
> index 8359c511d2..144cffbcc0 100644
> --- a/include/regmap.h
> +++ b/include/regmap.h
> @@ -239,6 +239,10 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
>  #define regmap_get(map, type, member, valp) \
>         regmap_range_get(map, 0, type, member, valp)
>
> +#ifndef CONFIG_SANDBOX
> +static inline void sandbox_timer_add_offset(unsigned long offset) { }
> +#endif
> +
>  /**
>   * regmap_read_poll_timeout - Poll until a condition is met or a timeout occurs
>   *
> --
> 2.21.0
>

Regards,
Simon
