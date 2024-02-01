Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B6C48291
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.18423.1706802030707290208
 for <u-boot-amlogic@groups.io>;
 Thu, 01 Feb 2024 07:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UwSD7zMg;
 spf=pass (domain: konsulko.com, ip: 209.85.219.176, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d94b9961so797052276.3
        for <u-boot-amlogic@groups.io>; Thu, 01 Feb 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1706802030; x=1707406830; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNw890gxb9kXi4rPSmoGmWihix1Joig+wcclFPInVE8=;
        b=UwSD7zMgFaLGkst/SDagI549uuhLXJkr21V/u8HhXhwj8RXA+vyPuT61fBCCdqcK2+
         5II0Dm6Esp7NjnSZwtKYhel/digktgHesihiL402XtWVIh75rA2NTg+ewvdrRL8xNDOi
         0bW/RQJrUe2NaE9Yd1b7wZhjSirRAtYgmbuVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802030; x=1707406830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNw890gxb9kXi4rPSmoGmWihix1Joig+wcclFPInVE8=;
        b=kfRB7h93t8CCjfGE3ehWlrEQpLgxGFCPxa26a5wOlaePTY/5ZJ/updW51rLT5hVdQ2
         jeETSaMxV/S6gFzPMuoPBaTWNWvuYQ+IAdLs5/6ZUzfHujDOtgfscuJoXhOkCxmmMQfI
         s71xQwcq+Kvu3kNkwMps+3skykbYbSPnduwQnkgGEF+0iY7YFAq2KDlS+9tv9QWsyZo4
         LoR4sehDOgwRII1zHih4dbRZBqizl2eshIHsuYK6szhZbkvBhipo9lVbaEjm9uZ7JCFn
         /dkIRhiBVsOJPAcxpJVSz6+sKe4o8z4a0WUIQv97kWgyxxSPvdVUeN563jHsJhfHs8oc
         No6g==
X-Gm-Message-State: AOJu0YxAAUonBCtqkxBlBl02z2HPoTOJtO4v0BngtDZqcrsuyVOTnFo7
	srCvufvGRhLw3+96YLaCOqaDMTtQazq6VhWmLCwDF5RkN7qUy8CGOnHhBgsb8t9NWbTzH5HPNlu
	P
X-Google-Smtp-Source: AGHT+IF0omimRnhYaGp1TsHMYvg28skx4iWPzqZnU8U+wYPB32Bb2ccB2xbTPu/616YVW7tust0IRg==
X-Received: by 2002:a05:690c:f85:b0:602:da5e:816b with SMTP id df5-20020a05690c0f8500b00602da5e816bmr5670561ywb.32.1706802029926;
        Thu, 01 Feb 2024 07:40:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqDwM6QPaMQl5hB8aOuRB24FsKK/VQh4Pe4nvcYlXbXUOoZoRDpp3/48VVLgjVeLCXmB7Rd/EuOUACrjcQgnwbhM5Wmg==
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id r65-20020a0de844000000b005ff928d6effsm1220780ywe.33.2024.02.01.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:40:29 -0800 (PST)
Date: Thu, 1 Feb 2024 10:40:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-fixes-20240201
Message-ID: <20240201154027.GZ1152441@bill-the-cat>
References: <bb777d08-1723-44b3-ac69-e55af1218cf2@linaro.org>
MIME-Version: 1.0
In-Reply-To: <bb777d08-1723-44b3-ac69-e55af1218cf2@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=NvcvVGZdZd2pBfBtPWhM"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2098

--Groupsio=NvcvVGZdZd2pBfBtPWhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 03:26:25PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this simple fix avoiding printing the board model twice.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 6faba41927bdc8973b59678649ef83c564cc42=
1e:
>=20
>   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240201
>=20
> for you to fetch changes up to 076529725f16f07a5cb2d5feba25d62b5f5a5872:
>=20
>   ARM: meson: stop printing board model after sysinfo update (2024-01-30 =
09:35:51 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=NvcvVGZdZd2pBfBtPWhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW7u2sACgkQFHw5/5Y0
tyx7wgv/QMYRnG6TRzhT2PEW5Koi5/X/ONwrQSLr6Of330f0ctEhexK80X1igpn9
xADy3WzWNCO5LMAdw6cb6UUHo12Nd9w1Lx0GUhOYd+hWSvtgldF+qan+BMGnJ2GM
e2IegeE6a08oBLB8tFehlnAXM4XNSxobmIHsdj+p6mzSyQ9wtn466yfbZSRlBwbC
U2HE/ZSnykyNI9ab1nT4vcDzwX/An2IdYoAyfhPPvdGY93Th/TwdmhWSkb01JybY
xrnBCBQlxWFGNoT0wWDtL64tUIiFSekGStrqypQfx83M3JmFheicpCfTEaVJr2+A
z22z/eDQGwKUZ8vuyu7OHLx0iU2PhMzEBQelZ6gMC3G7pdOmw1srBumTTeEoWfhz
CdvipZhNRV+eQnZqIkl5V6SL6t939Cb8SRixmYEQ6kPLQwuPLmup5lu+6vqIwZaV
+rZBtX0BfpwN2NR1D6LrBH8d5vDLPAdmmokPvVcyaU4ksyLwIU3Qf2iWKtNjdaVn
+xz0c91h
=9urQ
-----END PGP SIGNATURE-----

--Groupsio=NvcvVGZdZd2pBfBtPWhM--

