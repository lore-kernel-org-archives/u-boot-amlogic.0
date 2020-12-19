Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.3741.1608345016749202739
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 18:30:16 -0800
Received: by mail-ot1-f49.google.com with SMTP id d8so3828796otq.6
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 18:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEMikhcHhKmTvycbkbe9tdG7KBAkC0wxRYyBJDKQ6s8=;
        b=j/pwewX59dicH8f+4CcgrV5SViYV6nY3BVF7a9Exc972AXHNdXG7t1guiLFiaIc8b/
         F0cXyR/RKMato8B/aMlDdofUaLBMCa7mAWUTzkU/i+3qbzQ+IKCb5+xoCc3W2//VeZGU
         Q+8zYg6mzBnWmoSuAkc4OXqAjHfcHwE7nrK08=
MIME-Version: 1.0
References: <CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
 <20201215144230.9235-7-m.szyprowski@samsung.com> <20201215165439.13165-1-m.szyprowski@samsung.com>
In-Reply-To: <20201215165439.13165-1-m.szyprowski@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Dec 2020 19:29:08 -0700
Message-ID: <CAPnjgZ1R3j6BNBJLnir+hcJXSEiOo=jX4JyeqVuL9mj--SJjVA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
Content-Type: text/plain; charset="UTF-8"
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On Tue, 15 Dec 2020 at 09:55, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Save examined button state in 'button' environment variable to enable
> checking button state in the scripts.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Resend reason: get rid of the Change-Id tag, that was still in v2.

If you use patman it does that for you.

Regards,
Simon
