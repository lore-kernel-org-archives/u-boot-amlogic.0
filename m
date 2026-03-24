Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB410F285B
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:38 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21830.1774364354836932290
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Mar 2026 07:59:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Wwa4eLNY;
 spf=pass (domain: konsulko.com, ip: 209.85.210.47, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d91f82d819so1150234a34.1
        for <u-boot-amlogic@groups.io>; Tue, 24 Mar 2026 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1774364354; x=1774969154; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kltq/UHaD/wPopTvCXbE3VL6aLVmgprbNTi1kf4pPUw=;
        b=Wwa4eLNYgMLC94woRJZ7QCVYVL3beI2Mlf+TFTA5MaQ84C+FFp72HbBpd4nGTX2mYl
         /Y37YMWajv3OI6D5uZ0tYJA37FL/qD3sE56SKXBC33tYyVOzaWx1kKlqZVnBg0kB6DfI
         WnYOqsL8B5vpalcd/40kioGw9ONCA5Ti0rVUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364354; x=1774969154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kltq/UHaD/wPopTvCXbE3VL6aLVmgprbNTi1kf4pPUw=;
        b=qISI4xCmotlguRl0IIszTKdvijN5fjavkz9qYWMwxALFg72hbTGrSDEDtYD3XZjEv/
         VicsxUjSDkosz1MvQRrGU+/JqemB1JooJ2+NEn2bA0y5hCaSQhGCDyW/E6585uk+2wwO
         Dx7esdsH4TI33on/9rsuQ8exLXvWniwJ0z7hO/lhSADNcVev2J1pOD17zdG0GuDttlTn
         ARGv+jHBhpvcLlY7Ml0kWudAyc6EZWMlhLCIzOT2aCHylTPrBv6Yp7yvCw/g8S3AyizW
         HbMxczrm8CeWAuMTeLz+hmSFQA5LvtlvvOCEQLT6udQKPRuev9jO1RF1h8SXnoYLwCC3
         wxLA==
X-Forwarded-Encrypted: i=1; AJvYcCVZvuofJGqHTfjBOXcYXHrazhRQco8qnHsbm7M6rOuOLMjGwq0I7Yf5S3XiiseJKRt/YqLD0UVxuh18pJM1dA==@groups.io
X-Gm-Message-State: AOJu0YzWMBIiHV9g5ONExHZo/svxSGbfxfaoRa5FIRbS1SBkzyRuPHbL
	EJyjIIK4lhgd4aOp6XRgOv1kSpXc4GIXCF0/WPOIWguVShACArK9JpWmcbeveWiWMFM=
X-Gm-Gg: ATEYQzyew8y/lcwUoEakOJVbWINB1IBHItpSeF2JnxVWB/O75G0IUDatLDRTTs1SXO+
	kYc9N6WTj8WHjdjYaL0Nh/Reo9TzycFJ/KdU5SVxCkMKFLZfpMVujtUw6L1EkQJ6LpJNBdQzAyO
	4/bH5DkZD7fJDWIOtXtzYIlY4fj5NfilCUqeBzTvOyW1sfKys0DLLsXaoABs94vVdsyNRkJpyIt
	J2NAD8Y46rrCI6L8e3FDV7F/9DtIaIsg0pC2DLfhYnipYYxu4Ym+qxd+aMqrdUiLkHwL/9D9VuR
	drh0QPzSfQfhbWf1ySEotE7I/7E0a7W48YeOP0alkcpuy1goadhCkq2he1vgS1LRJL0cIE1CLlz
	YuZ0v2k3wa23Nhwq1Mb2Me6BzO08xz6xQtF48FSPh1ObfwkbkP1tobkGsM7Cf+8NVXFFyungvC4
	spPgYiV3G+OI2fhSH/7JE/oqFT9FPLTTJVr+OP8mEN4egTz3AzG4aR6YKcJTjSx7Wclr8E/ZGzl
	7NypVz1+/z5k5mjW91V3se2UtcdEI0StYi+Z+AWpTU/Rhz2
X-Received: by 2002:a05:6830:f97:b0:7d9:c783:5cc0 with SMTP id 46e09a7af769-7d9c7835cfemr1947958a34.33.1774364354030;
        Tue, 24 Mar 2026 07:59:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net. [189.203.97.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadd17d9sm13368818a34.14.2026.03.24.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:59:13 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:59:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
	Bin Meng <bmeng.cn@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Heiko Schocher <hs@nabladev.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jerome Forissier <jerome.forissier@arm.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	=?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Simon Glass <sjg@chromium.org>,
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Tien Fong Chee <tien.fong.chee@altera.com>,
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com,
	u-boot-qcom@groups.io, linux@analog.com
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Message-ID: <20260324145910.GP502704@bill-the-cat>
References: <20260323225537.896180-1-trini@konsulko.com>
 <ef7c8db3-0df8-4d32-983f-4b2dd81b298e@mailbox.org>
MIME-Version: 1.0
In-Reply-To: <ef7c8db3-0df8-4d32-983f-4b2dd81b298e@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=e3yQP50mWARQvZG1XNcz"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 27 Mar 2026 16:57:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2941

--Groupsio=e3yQP50mWARQvZG1XNcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:28:13AM +0100, Marek Vasut wrote:
>=20
> [...]
>=20
> > diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3=
-meson-g12a.c
> > index 41d15996e5b2..49e9c3fa0e99 100644
> > --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> > +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> > @@ -533,7 +533,7 @@ static const struct udevice_id dwc3_meson_g12a_ids[=
] =3D {
> >   	{ }
> >   };
> > -U_BOOT_DRIVER(dwc3_generic_wrapper) =3D {
> > +U_BOOT_DRIVER(dwc3_meson_g12a) =3D {
>=20
> Could you please add usb_ as a prefix in front those usb drivers ?

As we talked about on IRC a bit, globally we're not consistent with
prefix or suffix or nothing. Your suggestion of a new macro that takes
the uclass name and rest of the driver name and constructs U_BOOT_DRIVER
from that sounds great and would be a good general improvement. If you
can file an issue about it please I'll try and find some time to look in
to doing that.

--=20
Tom

--Groupsio=e3yQP50mWARQvZG1XNcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacKmugAKCRAr4qD1Cr/k
CmpyAQCuN4p26T/REii2QoFiw0+VYKRzKAkpxhJdroMVZggDdAEA6sQoSKo9eVVD
YEQJqehffXAcWEV/EoPeILkWOYavEgU=
=m20y
-----END PGP SIGNATURE-----

--Groupsio=e3yQP50mWARQvZG1XNcz--

