Received: by mail-ot1-f67.google.com with SMTP id e5so8017246otk.12
        for <u-boot-amlogic@groups.io>; Sun, 21 Apr 2019 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHJM4i3uhBLD/kB1khpb7wdGrsIG86EfCcnQg5LKeXM=;
        b=K1nzZq+5HtJNm7HOdjfYwn7cFDgnGCcW6G3qdNRY5ah/kQeCkC7d/iDGN8fu54LZ9f
         IUKdaQjapoiCaOBmQhj9xVPbvNNMRDQLm5ryExYH8Rzso3tQdmllwHioucTZfe9IFIEI
         6lLAAu9/I83QLFfUJOfCwbB8lXYCEKE9KRwZw=
MIME-Version: 1.0
References: <20190417181714.1281-1-narmstrong@baylibre.com>
In-Reply-To: <20190417181714.1281-1-narmstrong@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Apr 2019 12:29:40 -0700
Message-ID: <CAPnjgZ3_XPk=C+SKOP860MHU+TUGrwrrqWLXw4faGhRf6kp6wQ@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Wed, 17 Apr 2019 at 11:17, Neil Armstrong <narmstrong@baylibre.com> wrote:
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
> This fix renames the sandbox_timer_add_offset() to a generic timer_test_add_offset()
> function defined in time.h and renames the implementation and test usages.
>
> Cc: Simon Glass <sjg@chromium.org>
> Reported-by: Tom Rini <trini@konsulko.com>
> Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/sandbox/include/asm/test.h | 8 --------
>  board/sandbox/sandbox.c         | 2 +-
>  drivers/net/sandbox.c           | 2 +-
>  drivers/timer/sandbox_timer.c   | 2 +-
>  include/regmap.h                | 2 +-
>  include/time.h                  | 8 ++++++++
>  6 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
