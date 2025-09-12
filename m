Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BECAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 07:17:32 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.1979.1757720827061701829
 for <u-boot-amlogic@groups.io>;
 Fri, 12 Sep 2025 16:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=howVF15O;
 spf=pass (domain: chromium.org, ip: 209.85.218.41, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b043a33b060so370770166b.1
        for <u-boot-amlogic@groups.io>; Fri, 12 Sep 2025 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757720825; x=1758325625; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=79zWTKys9C37Th56GSgm3O4Sw5T87FkU4DpxQQvwWsI=;
        b=howVF15OG3u+ru4MyEED+z5HOUDF2WGBW9HIH7+mCO11/m06h5yFCqcxM0O+g5PATN
         37k7ZMmisjGzTOaN94xlu48k0aF1wqypIFE9sBVf/0hn0PFXMC1MZ5ZdjKMghxKlr8++
         rrtILrlhLH7UBYHKzaFgPEHEjR7g2Jqh7+lOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757720825; x=1758325625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79zWTKys9C37Th56GSgm3O4Sw5T87FkU4DpxQQvwWsI=;
        b=YerJSj8YHCPIoHmiuRW2J/1JYyx+iaXAmpIlIH6ZaXhtAHxmhSKsMVJ3/Cdt6ZXKaT
         VAzlD9jFC2vX3Wpb/GMMioToKYlKEKJQCV4khEMETJPw6zifVhI+hxFvJ2e2Jv6rgIgV
         sSuaUa1DjgqPO37JHEKN1rFqEDzMZ525DilvKEeB5j0c/zf286NH7gJ9+ZqtnIIysYxG
         yiEQESa+3ySMH/8HtT53v8JbtXOZ/RnysOfyrFpKZKe40Xw1jBkQ9p2WtmHTMmPR6o4E
         Cm8/Un1n7gItwNLD95paMoPmtoxzX92aq8WqU+JLJR6KhtYUr0UpUJkKvHIC0qpFqfut
         SFOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkJcTE/WtSfEMYxi4EDIBDP89O7ZfhJjpsxMtvxePHs0Am+yjqYQlDPNcwNPHdfByVUCop/fG9317w/ypCeg==@groups.io
X-Gm-Message-State: AOJu0Yx4FILjlFB89yUkVecCVEg0sPG2g51PJEV95PMw4VvNw3YXrEeY
	7X1xli0+IMIcA+41eEo8/Ov/nbmbFxt3r0Ufph/WRroKp1kXcEYnBJJ8G0LkI2NrbI12gY4jlUq
	+hSYtm8sQDOrftBhtxUZkMiGzBlfW/3LDGul0NXP7WR/zGWYSp48=
X-Gm-Gg: ASbGncv/cxS4zB3/VxgYSnMgUgx5zTOB8IO+U/SjuxecPTQ4xb6X3I8du163ZZfMqPT
	/H/9ZsClQfM8F3uwRoB6t0caqcEakZhkrAPnC/s6CkPpy1vRgG45P8LeWU6NmnLoUhJGz5y3tiQ
	TrWHiThhTus0zR3a76F0xl67YLHH43U7jEUTB9PO836iGvdTkHyHfLml2fY2RqjaYa3VZLp7YMo
	xpl590Ht1MH0lDy
X-Google-Smtp-Source: AGHT+IHXO48+SKSHFsZpdO6xy0evtTY/Vr6qE+/XklBq73RrA1L6ndXzGZUAntriTBvuBugXajD8T5ON8xYJjvpoXEo=
X-Received: by 2002:a17:907:3f94:b0:b04:854b:bced with SMTP id
 a640c23a62f3a-b07c3574f95mr437716166b.20.1757720482439; Fri, 12 Sep 2025
 16:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org> <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org> <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
In-Reply-To: <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Sep 2025 17:41:10 -0600
X-Gm-Features: AS18NWBBJnqHfeUlWOJUyD3_RrGLN53jEh2Tweeeqg5LsClAv1lON7yp3AOgqlY
Message-ID: <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
	u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Beniamino Galvani <b.galvani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Sep 2025 07:17:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2784

Hi Ferass,

On Thu, 11 Sept 2025 at 09:37, Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
> > On 9/10/25 22:14, Ferass El Hafidi wrote:
> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
> >>> <...>
> >>>> +static int meson_serial_getc(void)
> >>>> +{
> >>>> +  struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> >>>> +  uint32_t status = readl(&uart->status);
> >>>> +
> >>>> +  if (status & AML_UART_RX_EMPTY)
> >>>> +          return -EAGAIN;
> >>>> +
> >>>> +  if (status & AML_UART_ERR) {
> >>>> +          u32 val = readl(&uart->control);
> >>>> +
> >>>> +          /* Clear error */
> >>>> +          val |= AML_UART_CLR_ERR;
> >>>> +          writel(val, &uart->control);
> >>>> +          val &= ~AML_UART_CLR_ERR;
> >>>> +          writel(val, &uart->control);
> >>>> +
> >>>> +          /* Remove spurious byte from fifo */
> >>>> +          readl(&uart->rfifo);
> >>>> +          return -EIO;
> >>>> +  }
> >>>> +
> >>>> +  return readl(&uart->rfifo) & 0xff;
> >>>> +}
> >>>> +
> >>>> +static int meson_serial_tstc(void)
> >>>> +{
> >>>> +  struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> >>>
> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=y and
> >>> CONFIG_SPL=y. Shall all configurations depend on CONFIG_DEBUG_UART=y?
> >>>
> >>> Creating this dependency does not look right to me.
> >>>
> >>
> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> >> right.
> >
> > We should avoid the possibility of build failures for changed configuration.
> >
> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>
> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
> next revision.  Thanks!

I've been thinking about doing something about a minimal UART (and
i2c) for a while.

Before driver model we just called serial_putc() and *the* serial
driver would handle it. Can we do something similar here?

My suggestion for an API:

CONFIG_SERIAL_ONE to indicate that driver model is not used for serial

Then in serial-uclass.c update serial_putc() to use that config and
call serial_one_putc(int ch), with that function being defined in the
only serial driver that is compiled in. Update serial_init() to call
serial_one_init().

That way we keep things compatible with driver model and avoid
building on the old serial.c

This is similar to how the debug UART, but the debug UART is special.

Regards,
Simon

