Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web08.6085.1637799199390765523
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Nov 2021 16:13:19 -0800
Received: by mail-ot1-f49.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so6852207otl.3
        for <u-boot-amlogic@groups.io>; Wed, 24 Nov 2021 16:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO+rQhqv/0oaAaPmy5TTBTOkX/00Wc6JU02CC8nYVgA=;
        b=iDMXE/HqHoOOH+8VjOrkEO7W2TeWlnkBhpXnAXbnlCVXNaFSfjgiEKLLypZwlBzL+Q
         BgjIrBPfZB40w+8FxrPapC+wmAjafRLKJUs42A6GWquq7U2IGlIW1MARaSUk9FYZNmDT
         E00zgI2UahTekuX/5Q50bQus/B5j4Y3Pqhww0=
MIME-Version: 1.0
References: <20211119043647.1251416-1-art@khadas.com> <20211119043647.1251416-3-art@khadas.com>
In-Reply-To: <20211119043647.1251416-3-art@khadas.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Nov 2021 17:13:04 -0700
Message-ID: <CAPnjgZ3FPDi+n+KDOruT=mx4JFuXQ6hrNEc+61tFMSKLBQMXtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: env: deep resolve value testing
Content-Type: text/plain; charset="UTF-8"
To: Artem Lapkin <email2tema@gmail.com>
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, TWarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On Thu, 18 Nov 2021 at 21:37, Artem Lapkin <email2tema@gmail.com> wrote:
>
> Add new tests for `setenv -r` options (setup env variable with additional
> resolving vars inside value).
>
> test.py -k test_env
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  test/py/tests/test_env.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
