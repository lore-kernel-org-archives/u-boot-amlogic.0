Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1586FC41535
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 12:48:15 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.59406.1699288431490968314
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Nov 2023 08:33:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=O+iTorhk;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-777745f1541so335132785a.0
        for <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 08:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1699288430; x=1699893230; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQZj1dxmK6v7Eh2x/mQqV9oJJC5iX4JIdYdBZiwt7yo=;
        b=O+iTorhkWpdEryMRoDpe0i6loEZBlZm7WaUm/uSlJnGTeb+jLgKjHtrzyn5L0OwUBa
         5JK4P4xXHIJLQvIm8e8c23HKbCuEwZO3uB5k/aswmStYpJWOCYdK1hTGcxEJ7/2hP6KC
         hc42B5MNTCSVfFTu/d6oHZ+gZVtF1xFh8bV2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288430; x=1699893230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQZj1dxmK6v7Eh2x/mQqV9oJJC5iX4JIdYdBZiwt7yo=;
        b=RbojoaMYg285e5CvQZqHpq54e+LxOjqwk+lT1f4XsazlW+Klhg9Cw7sdhErA7oX302
         gK9CQErFICpBHqQCEqX4lzfUkJGwtelRGnXQxROV4C+5ZzvtuGgnte4FgjAQFJhy9Uhn
         xhG9P7t15PL9NA9Lh/6A1ONeD44ZGUwuZnDYSlXkx5fRgFCXEtVKO0WB0SoB04tM4LfT
         Hj6R63tNxwokUI0z4qR7SmigkwxMVIxvEEcKYvQk2czKcTsLOV3Myne1xNp4t2h33FOs
         X9wybfO6oXyfuGyNASU0Vwi6H+nnFTAH/bBdXZ5mBR3UNNGHtJIbaQl/x8WtpJEs16C9
         lWuA==
X-Gm-Message-State: AOJu0Yw26ecva80sVWzdHz34fWrMc6RSNZsWllPQDFErU/WVszpa9qFI
	ukxcfxswNs/GcgruJQnHuoM9TDoGokI8s2YNqnq25A==
X-Google-Smtp-Source: AGHT+IFhWRj+0Sn0mBWASY/l/x9qjmF950l8J2dqorsF0fWn1j5r13aJIJ4QvatlkXY3Wmog+KveOA==
X-Received: by 2002:ac8:5fd1:0:b0:419:544d:1c0 with SMTP id k17-20020ac85fd1000000b00419544d01c0mr36936998qta.3.1699288430588;
        Mon, 06 Nov 2023 08:33:50 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com. [2603:6081:7b00:6400::13d])
        by smtp.gmail.com with ESMTPSA id kf8-20020a05622a2a8800b0041817637873sm3545452qtb.9.2023.11.06.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:33:50 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231106
Message-ID: <20231106163348.GZ496310@bill-the-cat>
References: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
MIME-Version: 1.0
In-Reply-To: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=htzbQH4ZMkmKDwkSHCdc"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Nov 2023 12:48:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1859

--Groupsio=htzbQH4ZMkmKDwkSHCdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 03:34:31PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> A little set of fix for:
> - also enable DFU RAM boot for libretech-ac, since it uses a different co=
nfig header
> - SM probe fix
> - A1 USB missing clocks
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18452
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a4c83bda17196bf5d1ce640844595aaeced646=
5e:
>=20
>   Merge branch '2023-11-03-assorted-tegra-improvements' (2023-11-04 09:55=
:39 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231106
>=20
> for you to fetch changes up to c550e81171940932664a85bda315a6a073aae23c:
>=20
>   ARM: configs: libretech-ac: enable USB_DFU like in meson64.h (2023-11-0=
6 09:46:05 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=htzbQH4ZMkmKDwkSHCdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFWwACgkQFHw5/5Y0
tyymaQv+LI4pg3zjONNo+cqUcOLlgQYuxDvX+b7JF/BgAr+Z2VgOZskAlm2cNe6O
sTviSIKa98ilStM0tzzJg19FATptYuqIRGPyk4XPvTqbUe8aWSe2a4h/inCHw1fx
mVfusT2tvNMY6B2dlShlj6SW+ndHvsFeMX0wienEhZYe3Udu53h24loX22tqcYne
9Csb+LrSnsuVugoxCwHkn7lijoBJD2Cu215d+B7eNR51p1QKHwZ8ARrkd9g9U9Ir
8k5yyqxmdmI8mTjm8p4IH8QaDnn9dX51DqtRQlYwajGQmgWbgeeHvUk+xXCKuDLj
6BqoaljXT0IwjeXYYp0eWfgl6YVo7qet+5XP84dSLqXCiBnqyyejHJZbDzOS6dlT
yYuohIcpxUo0HjAIEMValpfI43gHEJTGtkyRNEIXOVm682XWunQa6dng5yno2Jse
gEQA6bJsManZGOc+Xz39rkPMW+1X7IQeft3ITMjmrOpYmlvC1mAgD51QwMx8nvJ+
ueM7+twZ
=Va9t
-----END PGP SIGNATURE-----

--Groupsio=htzbQH4ZMkmKDwkSHCdc--

