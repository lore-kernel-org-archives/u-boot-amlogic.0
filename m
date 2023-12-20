Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192FC35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 08:48:18 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.22730.1703083363844864559
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 06:42:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TupsFz4M;
 spf=pass (domain: konsulko.com, ip: 209.85.128.176, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5d05ff42db0so48315217b3.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703083363; x=1703688163; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXh7j7HAGsiQRq6+tsB7AD52vte5LkfJb7K9j/HmfXQ=;
        b=TupsFz4MKawalW+UNjSKO+lexE6CZ231JdU+Mn6CUTNoy4N+p7Qu9/EZoAfl/ebwqu
         wfCTEhxQ6T2E+T7zs9sNMgigRCrDaZnI0lbRDIXXv52eQFKWlw1S0CdiBmHrtSuay17f
         wQpz04wplLpyjmGGH4fZQk9NRiGUCOtdCVdVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083363; x=1703688163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXh7j7HAGsiQRq6+tsB7AD52vte5LkfJb7K9j/HmfXQ=;
        b=FWHDCJEG00wtmSXaR9U+96edZY998/zcL/V5HHkwkuhXVeQRokN3MzJaWIh+aO56l3
         ycXSIwH4XmZOGExeacU1n4KTY/7uODWQaHh/M1kArIfI4r8JK8d5bgStcQP6LfCQT+EV
         RVT1X2CSMjtv3U7VuAqWaW4Dd5zzdUjhCRT2ZO5z8itMjpgC+Gw4jW3uQLp4yGQH4s3/
         +bJfdKRjCINFh7cns4dzSb7TWzSN0koVCyCIku0FhH5KGtt2QnOqYVzMk/4opyjiqz1e
         Ce7hQB5EGRNpWpdEvOH/WaJOcozBLxKoQj62Zw77K0iaCAo7hqRGkWWKNWttRC5QbULN
         m7qA==
X-Gm-Message-State: AOJu0YwyrhS+nbDIkJUETWw+/ayOQjQK5SJ300qGAF7jN9oRWvQ/rSCW
	pxDhvrjWQ9C5pC7nD7uNFPb3DfwSyy4SGh2uWmY=
X-Google-Smtp-Source: AGHT+IFDtLGVm+mloAt+DzlE1plA647vvZ2tObsfJ63ZZS9F1Fn+hHjK8ufoKWQV2MvHY+XdOff/bA==
X-Received: by 2002:a81:4f91:0:b0:5e6:c3d7:6c4a with SMTP id d139-20020a814f91000000b005e6c3d76c4amr3472521ywb.50.1703083363010;
        Wed, 20 Dec 2023 06:42:43 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com. [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
        by smtp.gmail.com with ESMTPSA id f63-20020a81a842000000b005e82879d18esm1036538ywh.53.2023.12.20.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:42:42 -0800 (PST)
Date: Wed, 20 Dec 2023 09:42:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20231220
Message-ID: <20231220144240.GM2513409@bill-the-cat>
References: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
MIME-Version: 1.0
In-Reply-To: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=pZD6Eu4s88mnwnr4TrVN"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 21 Dec 2023 08:48:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1963

--Groupsio=pZD6Eu4s88mnwnr4TrVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:43:51AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull into next branch support for the new GXL MDIO mux along
> with a Linux v6.4 DT sync, this will permit using upstream Linux DT
> as-is on GXL & GXM based boards.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a6f86132e30a407c7f96461df53c62fbe52e2b=
54:
>=20
>   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-=
riscv into next (2023-12-18 09:56:58 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20231220
>=20
> for you to fetch changes up to 4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb:
>=20
>   ARM: dts: sync Amlogic GX DT to Linux v6.4 (2023-12-19 11:24:38 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=pZD6Eu4s88mnwnr4TrVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC/V0ACgkQFHw5/5Y0
tyyE4gv+LQ0DiXu4uyOg1qPDqD0D4n3OrqFGJ2sSyDL415OaSaeGav81Fx+UCHA7
Ey1r8IxVHrqkXW4uv79SjC1xUsb+BfvSoDtyKyCO9I9uNd5HscWu5On+VVEX4vrl
NmqZui3Z2DdwP6uaBstDCVuQwbts7XOZfCGJ1ajXoATmS4zPKLBLc9XUJcGYDVi5
3EtNzMgzB2+wp9T/zbZICoaUfGnabY+OR7/25tf7uNDxjJqRB+tbJVOhbA1ga3cF
FllDXRqnEMppscFsm8+SMRJmFxHGxEXkok1ML0ZQw252wo+yA8ZfZKoDD018fDXW
kVMaZtDnaHkALTk0B1LAElDj/UpKR6jbRQRMjM6sDzhePk9t0qiLhDtd/oLexPS1
ltXfIy+2iMAOfqtTpR+w3DI7Grs5Pmi0xLeaByU+3s639wgk/Mr+zbY8hMAEIjp0
Q7f6GzdFcK0SFxydJ6C6XYwD57kHCFKJxri19+Kf5f5HJPHrGCAeCUjbVWDuGJk9
f0+bTExF
=2tgD
-----END PGP SIGNATURE-----

--Groupsio=pZD6Eu4s88mnwnr4TrVN--

