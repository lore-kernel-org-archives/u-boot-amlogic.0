Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
 by mx.groups.io with SMTP id smtpd.web11.82084.1657014446489331956
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Jul 2022 02:47:26 -0700
Received: by mail-vs1-f41.google.com with SMTP id o13so11311527vsn.4
        for <u-boot-amlogic@groups.io>; Tue, 05 Jul 2022 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTzL4/IhM6pQpd3bH4eZVG9ZBWrkR80EI+cdgyfOX8Q=;
        b=Up/lXDcsSgr7U/aOxFl2KqsfIxkxcQp90O87RIA7P9pLNqQenM0QXMXQF6UlngTX73
         26sKJOnOwVYxHeXJSaTpUd7KMGx6WoQKduIkM9amPoNLxE1qAburoarwt8h1gdq8l0B3
         MbHghvMQ64u80oa5J3Jt4fo5PAxlS9vmZ06T0=
MIME-Version: 1.0
References: <20220704141016.3060901-1-narmstrong@baylibre.com>
In-Reply-To: <20220704141016.3060901-1-narmstrong@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Jul 2022 03:47:14 -0600
Message-ID: <CAPnjgZ1Ab_7+Ckpd3Oenp0wZLoRKaLoXfK2_73=YkAm9mFTnAw@mail.gmail.com>
Subject: Re: [PATCH] doc: board: amlogic: add documentation on boot flow
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Mon, 4 Jul 2022 at 08:10, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This is a preliminary documentation introducing different
> boot sequences, and notably the recovery mode.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  doc/board/amlogic/boot-flow.rst | 147 ++++++++++++++++++++++++++++++++
>  doc/board/amlogic/index.rst     |   1 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 doc/board/amlogic/boot-flow.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
