Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE12CD11DD
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:20:51 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.43146.1710938656026303944
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Mar 2024 05:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nRdskL6q;
 spf=pass (domain: konsulko.com, ip: 209.85.219.182, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed179f0faso589065276.1
        for <u-boot-amlogic@groups.io>; Wed, 20 Mar 2024 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1710938655; x=1711543455; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS1huUGzAwvLrSU766QT8OnqM5JzVnh4NhORzINH4IE=;
        b=nRdskL6qEXa36RxAXaRUDmQYVnaVSLvpK+sPZz94vcfnyQuHeuLHk9fdiFDnVG9nOQ
         f9Y84654bzyFg4EmkxNiQI50utAM8Or2zr8YSO996riE0fZel1vlTLkxG8Tw1epZIRl6
         TjS3/XjvzBXEfOY054VT3k7O45IeKdsYxIq2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938655; x=1711543455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS1huUGzAwvLrSU766QT8OnqM5JzVnh4NhORzINH4IE=;
        b=e9sCq7g5o3iEPR6zIqD37DZujR9YuLcoZisnM8zxf/NVqRqJwERfjmqlu1HGIqWdo0
         pnxVCaIzT3djSevkKCcBSmTp6b/ErE3zMXfg1Wi3L28S5HiHad3e9Rp7oGQY02Dua36z
         +O52pgvigJFboDgjj1xiusP9ykyZ0TFEgh21CaAg+2awnowyPVbwgWW1hjP9Vg8Xo0Jp
         htUwUuWmD97PgaK44fnJAJ7j3rqP4iw74byzmGOiwhVzO6rQopBRl/Mj7aQhPF2K3TlT
         LnOzNAcNI4aGygomB0irizcWd0kIfum2FUNweuC9tfyfLAHiIZ4yXemdMDTTwhab1e2e
         MchA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1kEmDsF5ewyKUmr10HijXcuXDMiTWoowMAyUBekc/TjM+bgJ7a1wzaB+B0qxeq2jaaFlIaLTrxTjVWMnkdpUxDxxTrzhrs4=
X-Gm-Message-State: AOJu0YwP8YuPBv7oEmjrHy+1ODUR6WRCpOHpcfIm6hO9Yc/DGcT4P3HH
	8Vde5T+ULlopBcPdSEHCqIF1z7Zdlm2jMfO9b8pUr+aVZlw44GU8Iy4Ifo5lY+o=
X-Google-Smtp-Source: AGHT+IFlagVIG6IiLcGvhoakhy1suk41tdoQver/cA0c0vrW21CxVwFdTeIQ7rivsLaLLmNSSrhpyQ==
X-Received: by 2002:a25:dbc2:0:b0:dcd:c909:334d with SMTP id g185-20020a25dbc2000000b00dcdc909334dmr1332971ybf.12.1710938655199;
        Wed, 20 Mar 2024 05:44:15 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
        by smtp.gmail.com with ESMTPSA id g21-20020a25b115000000b00dcf35be9f51sm1528890ybj.24.2024.03.20.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:44:14 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:44:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Vyacheslav Bocharov <adeep@lexina.in>,
	Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: Re: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
Message-ID: <20240320124412.GT3442575@bill-the-cat>
References: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
 <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
 <34826ce3-3d9e-4f1b-9f77-23df6ef7f17f@linaro.org>
MIME-Version: 1.0
In-Reply-To: <34826ce3-3d9e-4f1b-9f77-23df6ef7f17f@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=jBpCClhM6Ot9zVqOHS1o"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:20:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2211

--Groupsio=jBpCClhM6Ot9zVqOHS1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 09:26:29AM +0100, Neil Armstrong wrote:
> On 20/03/2024 06:28, Dan Carpenter wrote:
> > On Tue, Mar 19, 2024 at 03:53:24PM +0100, Neil Armstrong wrote:
> > > While meson_sm_read_efuse() doesn't overflow, the string is not
> > > zero terminated and env_set() will buffer overflow and add random
> > > characters to environment.
> > >=20
> >=20
> > In the Linux kernel we would give this a CVE because it's information
> > disclosure bug...
>=20
> Yes probably

Yes, but this isn't the Linux kernel and we aren't a CNA. I don't object
to someone getting a CVE if so inclined, but we don't have the resources
to follow in the kernel's footsteps here either.

--=20
Tom

--Groupsio=jBpCClhM6Ot9zVqOHS1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62hwACgkQFHw5/5Y0
tywk6Qv/bn6uXpmVLGwBxdILKZcZRjMR+b0W/BBGOyAdmb2S/Q4pzvjR1Q0MzVe/
Hw3Ej4Y0PV3T96iikx/S+J84nf93uKuHxV5+8Kc8v7dleJ+x5PnmuBE/pAeIEC63
SG8ePTo2klOWZHQieiKcHrFlZwaGp9ccjvjHRJusi8pZH4x/a4BPYojUcoYnpY+j
qeJEDZ0ydncUsBah6I+PgOf56YfrnpEuiGBWZXF/XtMfxblmOeGb1P48kcInZerq
QQmAuyTodVd8Qh9PasI8W+lPzR9hRSZjq96kS7iYh1U3R+tMdkcrtxF82vFBJzKr
96EV3lxaq0A/HPc6nT2mGWoQ6/jOpP9p+6cGgqebimSpxbKmGw5w1TmhVoPA0b4X
BkW8jyPm/M3tVaXcv+a6uj6XBEucle0lgdW0E/b0Dh5e+MGqMzD248YT6+mr6uLY
ig/eke0NWcSunibmICgXrT/C5HS5nN3/xol33dFk0SeSZHBM/IzE8/eXkVSrEgKI
MDIKmLO7
=R/NW
-----END PGP SIGNATURE-----

--Groupsio=jBpCClhM6Ot9zVqOHS1o--

