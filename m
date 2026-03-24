Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30610F2858
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:38 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3404.1774374426738556778
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Mar 2026 10:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=mE82+j8+;
 spf=pass (domain: chromium.org, ip: 209.85.208.51, mailfrom: sjg@chromium.org)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66970715adbso5513940a12.3
        for <u-boot-amlogic@groups.io>; Tue, 24 Mar 2026 10:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774374425; cv=none;
        d=google.com; s=arc-20240605;
        b=kWG77oOrkY6O/8KzyElnKQw9EYSggOOmL+S9HbAGEeLhMxsAWmWgpF4iXz+M/Nvlj/
         56qSnmARDrLthplFG9RsDqeiHicVccZ1KmP1JGv0w6ZV8BOVqIwXIk5Vdhfyc/u3Lucb
         Pii02UkoOHgVgS2LZecRSAAq9KIE459EnrkWR+a5wnzntvKhg52WCXtcVDMBsGY4PGQ7
         PqEdiDF2iYKktA2H74PA5oAp0hg1jJd5uvyzTq1grjf3M4bR2dV7UBv/P3ny54mKxmh8
         OvpS4qDEB9ihi0s4QjNdFOIOjXlH7SJFsIUSyULZsqC6sHaZMujemrW74wBymE5RDGM6
         159Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
        fh=+GktbOm2xXTxFg9xs4qoGri+T49GRymllviqfAhD54g=;
        b=f5/PAodPkxFfTgw+0Ob5gwClOz2TpAItBn629WxIuIgjEgDma7pLWfeYKrG0LYUmSF
         5+PW7EUYp+iRMYido/X/MBKqHW7cp0VymT+U5GM55A3tntWFpvOfzsLPvpUPLdTzYQzk
         rVQC9QBdVvCEp/znoY8CItCgSdT3lShjJMrPesBgHuC9qEXFxBQmigvb8uHquk+wVT+o
         U28lXFo4RREbyet6LHAtFe9LNt0ryH6J7OCoC5kz8n0dcQDm1/9Gploh+hJkqv4vrmc7
         ymU06w2Dfc6hem3zFeoyPqxt66Eitn7LGHbl2nkhBBr6xWB6lh4U/xOlkw3xOHHru6aK
         1L6g==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774374425; x=1774979225; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
        b=mE82+j8+y/GZXOyO3wXLxLEwWBgHZiLbvWLBdTRFoY9t3a9/V/AFezSzslDDnBWQDf
         BnP5KAnwuik2+aIH6Axd1z2A+9m/Z7gGdGGcWjaQmBTXyANKa8t8jszMVXaFeFRfgkgb
         imQyb0cUaeJIc6XOlvbjmyPNvingYqHYaIA2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774374425; x=1774979225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
        b=YiIyy1VgxxtnMjpxMZw4LTmetZbzfmFdQX/yzqynGfHY2Yw/aIkAvWNHM2Mqxv0kKD
         j6oYzSkmmU2hu8fCL8sKBW0lgm0wXTx9UqKBP8WnyNreV4nXPGj766N/AaMMRT/ehUB1
         9mAbNT5y01ZtphuPrXlCiK56mQ7jweDinhZp4uAzmX8Bkpf/0nvwJQST1HyUUettGOJP
         svvU1wJygypnrGWxda/W4DFVkLOO+YiW0edajueJRT1mS7qYD0SfCxOFHjS2CqCHa5CX
         rNH7SS6wFxJpY3oh8/t9uCxeB/yawknxEu3QqKASUTCrRDTPYcYoxBwOcUlxZiNLBOGN
         IGcw==
X-Forwarded-Encrypted: i=1; AJvYcCW7kvH49GVBbFtb3mw9VzZoN6wZMadYX2YdaGPkUri3Jneyut1GLTEzJgq83OWJv/ea/9Uob7szzQn1BLfDpg==@groups.io
X-Gm-Message-State: AOJu0YxCGIfpYjv9Gv6eI7YyGOJ1Ni+xCvyio4jk4JjQY0ytI35FIWlN
	iROaNDxTTuBYz8YRbMJr7AXNuiY0Rm6zICKxy7Fdh1n+IuHDTZJBPiHCBMDxeh2ZxMwIlYPjoLZ
	+gUDdbwJxEMFI/kUjBW4gbudOWPA7H4bUBXMcwRBgfyQTA7V7Zs5Ftw==
X-Gm-Gg: ATEYQzxYh6M/ZFPkWaLxro+R/AnbgoJvxBIuRjYKq6t1gmB/UhtrpcpRe9gvOuU7655
	9sCiOLS+Sj8QEKLCY+/ASpkCCUSDI8TTCWwYkec0FFz4tPS3ajN1c21LHPQr0JYPgQ2vd7U6GjQ
	GGQ4QrP8JLlxaEDYF2OdZQ0YCaua6Oa29Cytg5ZskQZauR2PJVSMpBRMvK48xgNiuysTqhRZJi5
	A0pBxwhMqYc4n9aSeN/lQEcnc3gP1hHwoDZkl4CAGdsROtePIdn9/R1wytNwUko3G0z0mua6YQl
	Jfh/kQs=
X-Received: by 2002:a17:907:e11c:b0:b99:7697:76dc with SMTP id
 a640c23a62f3a-b9a3f1663d8mr18984566b.4.1774374100786; Tue, 24 Mar 2026
 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260323225537.896180-1-trini@konsulko.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Mar 2026 11:41:30 -0600
X-Gm-Features: AQROBzDoBbiLnL-H8z3_ppKXN1rO1G4g0-_SU87GunPz7GS7SCrV8NIEQMmqpLQ
Message-ID: <CAFLszTjN7ZSkc0vfT_KmN9um+v=--RRyV5OzJSWVirOT2fZWMA@mail.gmail.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
	Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
	Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jerome Forissier <jerome.forissier@arm.com>, Kever Yang <kever.yang@rock-chips.com>, 
	=?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, Matthias Brugger <mbrugger@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
	U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, u-boot-qcom@groups.io, 
	linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 27 Mar 2026 16:57:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2938

On Mon, 23 Mar 2026 at 16:55, Tom Rini <trini@konsulko.com> wrote:
>
> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: =C5=81ukasz Majewski <lukma@nabladev.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: u-boot-amlogic@groups.io
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot-qcom@groups.io
> Cc: linux@analog.com
> ---
>  arch/x86/cpu/broadwell/sdram.c             | 2 +-
>  arch/x86/cpu/ivybridge/early_me.c          | 2 +-
[..]

For x86:

Reviewed-by: Simon Glass <sjg@chromium.org>

