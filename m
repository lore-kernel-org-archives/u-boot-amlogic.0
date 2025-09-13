Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C66CAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 07:17:32 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.899.1757779156838155413
 for <u-boot-amlogic@groups.io>;
 Sat, 13 Sep 2025 08:59:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gmlCYRlE;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-777fb17fdf0so2657146d6.0
        for <u-boot-amlogic@groups.io>; Sat, 13 Sep 2025 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757779156; x=1758383956; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CI4rGP583IiO2r9ZtJzDJj+2IzyEHheklXjgvyxtgV0=;
        b=gmlCYRlEiSTtK3Qgn+2XeOlLfp/lGNrOnqiH8LPC/nHY02delTWp0YhDYa64RCw2Ch
         bDavvqfoy1PSm/nck4YAB/h84d23u4Ng/R3EGFjSx/2DZfzjeIR6CATyQlVqWRF79j+8
         VqR9PYlbcf48RSfLl5qydXfCNZDrZFHKYLPok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757779156; x=1758383956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI4rGP583IiO2r9ZtJzDJj+2IzyEHheklXjgvyxtgV0=;
        b=iW0rzmKSjplZPUkXMwCJ+p7WTR/TwByQ3/4YnwQnhCl4i2yh0RC9y+Kj8251JdbaGX
         sC14+4OPe2je5c+Q1i74sk/PKKGNtlR6z0kfwHsgN5PGDKHmyDT+sjrGktvqT0OKK9DX
         EO5VJTICTZmLBcr/rYV+b2PLTQm2aMGphMyX9xvYlDodnQQa5Q4qSsdHWO9GnVSzTf36
         SAM3u/9QbXAL+NyQ2YT2FOFoS4LDJ3GCALwBeqRk4UvCe3n3GInMD0PVeEvWtBl9Jtbg
         oTAF4WVyU0w694NhZmKLntLZljfpO3tFJggwBX7l0aTo+VdJCR8KrsuQMj+4KB8drSJh
         fKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX45iRsHBUFLkOHUmbJ5RpjVKfgscx1/xreT5R0/s8mTBG4UuHTwxphU9yADE2fxw3n1O2i1se6XQ+OP+Jimw==@groups.io
X-Gm-Message-State: AOJu0YwPWl1KAzd1hHm3B8auRFG4f6+Y+W90uBdQnbLTq6dMftd1hOYU
	v91Aij7eOIHAwd2473NSc36XiqmkzT6XpLU5BYQXNM1x1d2PMoTwCwe2H8BFnFX+/9YHspb2KOL
	715P0fPI=
X-Gm-Gg: ASbGnctIoyyJluqZyf6UnoRyhjO4zYs78ZQDsqEPvE0NigkI2AE6c67W0kjUP0iOXsI
	uMdOAqfhgz/bMm2An4IYX6+RLupHCWzWZkjQjv0DAvwhF99viq2LlmCCvZcG6qDr2jq1/8oujRt
	3qBpUEiKdyMKMXTn4NX+jIbnGvY5r2oHzwbNpMzIZ/PanBfjXyKkWT8iW37EnDbGxeE4rxRX62S
	C1cge/Pfwwh9XPi8TIPpKAWJOUgA4WZFCVMjNGZsIMgIxqSm9z3mErSyPG+pTE9C8rnUgWwt3OH
	3vU6u3KcKjfV+W3KkqcOfVhyOuUlL/zfTW823Yz1klLNRf1XyACLdcqPoLfzc7Fll1kgYDO4oE2
	ALqn5umY7/VNG2Tr7NBzkHOnBNjVkK6u62U19fNafxmTx7pu0cjBU8NpB
X-Google-Smtp-Source: AGHT+IF5XAI7vVNFJhqCF995C+BzWEJw9qawQbrSYrcAlpl/O7CBN9940QP5Fl/LqnbQckQehEUzuA==
X-Received: by 2002:a05:6e02:1988:b0:3f3:86f:520c with SMTP id e9e14a558f8ab-4209d7e0f28mr83218675ab.7.1757778663380;
        Sat, 13 Sep 2025 08:51:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41df8eb44besm34094855ab.22.2025.09.13.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 08:51:02 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:51:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	~postmarketos/upstreaming@lists.sr.ht,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
	Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
Message-ID: <20250913155100.GA67696@bill-the-cat>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
MIME-Version: 1.0
In-Reply-To: <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=b1TlVg2k6Mf9Jr4LSK0G"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Sep 2025 07:17:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2785

--Groupsio=b1TlVg2k6Mf9Jr4LSK0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 03:37:07PM +0000, Ferass El Hafidi wrote:
> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
> > On 9/10/25 22:14, Ferass El Hafidi wrote:
> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
> >>> <...>
> >>>> +static int meson_serial_getc(void)
> >>>> +{
> >>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(=
DEBUG_UART_BASE);
> >>>> +	uint32_t status =3D readl(&uart->status);
> >>>> +
> >>>> +	if (status & AML_UART_RX_EMPTY)
> >>>> +		return -EAGAIN;
> >>>> +
> >>>> +	if (status & AML_UART_ERR) {
> >>>> +		u32 val =3D readl(&uart->control);
> >>>> +
> >>>> +		/* Clear error */
> >>>> +		val |=3D AML_UART_CLR_ERR;
> >>>> +		writel(val, &uart->control);
> >>>> +		val &=3D ~AML_UART_CLR_ERR;
> >>>> +		writel(val, &uart->control);
> >>>> +
> >>>> +		/* Remove spurious byte from fifo */
> >>>> +		readl(&uart->rfifo);
> >>>> +		return -EIO;
> >>>> +	}
> >>>> +
> >>>> +	return readl(&uart->rfifo) & 0xff;
> >>>> +}
> >>>> +
> >>>> +static int meson_serial_tstc(void)
> >>>> +{
> >>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(=
DEBUG_UART_BASE);
> >>>
> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and
> >>> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=
=3Dy?
> >>>
> >>> Creating this dependency does not look right to me.
> >>>
> >>=20
> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remov=
e
> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> >> right.
> >
> > We should avoid the possibility of build failures for changed configura=
tion.
> >
> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>=20
> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
> next revision.  Thanks!

The way we normally solve these kind of things, since they aren't
actually configurable (it's part of the chip itself) is just #define
them either in the driver header or some <asm/arch/..> header file.

--=20
Tom

--Groupsio=b1TlVg2k6Mf9Jr4LSK0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMWS3wAKCRAr4qD1Cr/k
CgNrAQDj42u/PHcPNZLcy06QtK9FlPCAUMvnmqOfHKnSuO3PbgEAx/yEqpzyEsS6
JnN8n6jWOLulzrySYh3UW7yS3dtoBww=
=fpui
-----END PGP SIGNATURE-----

--Groupsio=b1TlVg2k6Mf9Jr4LSK0G--

