Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF4CF64A3
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.15628.1727269467806275514
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Sep 2024 06:04:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dq4oKjUD;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: clamor95@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb806623eso58465585e9.2;
        Wed, 25 Sep 2024 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727269466; x=1727874266; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDD++45rr4z9OpHh7T9S7/W/evwkqFgsBhhHyLXhORs=;
        b=dq4oKjUDCJ4S7h/5tVvBhZ23nTdJ12I//2AK7v+WqpzAygRthE5gaSeUzBnQXOEaGA
         LPFCzMkfC81L80NBualBIF4oNRzCxZCepMkUQOxIgPHp9dBBehzOu9qcvfo4H5NdukFD
         tlZZPwpc3ZbK3K0mxuaR3jep/WvKxEFULgAQxT4WY2oAEg6VPU1havjMnGWvjH4/+Nhz
         7Mxjgl3gbFDPYxV3VQO53U/NK995G0OcYqKtZ+rMJkCQelpo4VDtIaeUl7gQOUFJJ9/B
         SUYlSuSbTtpRXqCMw+foOCBXoooD/fMxD4aGWp6CKCWKTlxBz9un+Qn1M44oDGbHi+6l
         YXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269466; x=1727874266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDD++45rr4z9OpHh7T9S7/W/evwkqFgsBhhHyLXhORs=;
        b=Oh5lDLQdc5DkB3a0b/yrq2S5n9BNPMoKHYY7TkM0u1cIuzdMDm/u61JdBVrYWj8Dug
         xBqlY5+9T2Pc5ZRayrgOWcyShzS3GeEIIviM3JqIHhU/Iy5PdyNMxdMUhSCgcD4TjONB
         /o5moJP02WvXMd2oVl3kErOm+/bqxvKho9s6Kwfnm+Zxfut4/kvviliqWmNp0NxlUy7h
         979s2uOk4nnwOl9D3nyxqi/23W4fm7232pJzI+0IPUJ4sQXixTSffl3BDkCA8iKcZsOo
         Yx3Me5rCR5JyAoJr1kAy921biENeAa3nX/bAJaD9FeNklhvMGsYMJfmddbTifYnUFdPs
         Gvlw==
X-Forwarded-Encrypted: i=1; AJvYcCVQbNYxsrHu8JDmNLSkGG2tBeh+vHz2sE2tNTmDyBUVHPBdNL1It84Oq6huxtv4D6i2f7FiOCehiHPVOeJ6Tg==@groups.io, AJvYcCW90O145Z1OW3kM1lZ/bRpEp4Ub/f7fGGuQmbBh8HLMhF2yb1XCL4mr40CB7bWNBA9vrgmGODKKIQgnAtc=@groups.io
X-Gm-Message-State: AOJu0YyOu/ppSfScbodgf3l11pKNyar7ogpeDn/2m2a+nihfx6NlhAgx
	mOvH2S6CkOE+2r9a79so8jw7sTvTnYKcqyleTVEoctqeJoPXoGqTaeyzyOQU68NfZCzPS0yjOGa
	31PK9iIc5UXUUPFSVkIt5NUGQ4RA=
X-Google-Smtp-Source: AGHT+IHn1pvV5x/oNt3LZgMPQSzEbkojqXRVdw9uB0ltNpEjyGBgh5zfEfz/KM16xNDY0NH3ndAcrgb3u04y0EKWcek=
X-Received: by 2002:adf:f14e:0:b0:375:c4c7:c7ac with SMTP id
 ffacd0b85a97d-37cc24ca3f6mr1734527f8f.49.1727269465909; Wed, 25 Sep 2024
 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de> <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de> <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat> <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat> <20240924234406.GX4252@bill-the-cat>
 <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com> <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
In-Reply-To: <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Sep 2024 16:04:12 +0300
Message-ID: <CAPVz0n3cH5_1iK+0PSW1mBFKQz13Z0DKJyi6GdsGpPQpvBQ7mg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
	Ben Wolsieffer <benwolsieffer@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Max Krummenacher <max.krummenacher@toradex.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
	u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2416

=D1=81=D1=80, 25 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 15:48 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 9/25/24 12:18 PM, Svyatoslav Ryhel wrote:
>
> [...]
>
> > Hello there!
> > I was digging this when I had some free time and found that with
> > patches from Marek the only difference is that function
> > i2c_get_chip_for_busnum is not called for PMIC's main i2c address
>
> Is it possible this is called earlier, before UART output is
> initialized, so it does not show up in the log below ?
>
It is highly unlikely, this function is called when uart is already
working and pinmux is set.

> Could it be that it is called before your pinmux is properly
> initialized, hence no UART, and that is why the I2C communication fails?
>
But if we assume that pinmux is not set, then how we resolve situation
when pinmux and regulator enable are both set by probe after bind and
regulators are probed before pinmux. Regulators will fail, they will
not deffer till pinmux probes. Or you propose return to pre-DM version
of pinmux? Inconsistency.

> So far, I only found Toradex Tegra T20 board here, no T30.
What do you mean? Specify please

