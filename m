Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE1C31D97
	for <webhook@archiver.kernel.org>; Wed,  3 Jul 2024 09:22:45 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.web10.3997.1719857333750207618
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Jul 2024 11:08:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WInD04Cf;
 spf=pass (domain: konsulko.com, ip: 209.85.161.43, mailfrom: trini@konsulko.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c25ebf6380so1350696eaf.0
        for <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1719857333; x=1720462133; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+XPuVau1N5UPISM5bxeCFeBICz8WAjWnfvGxnYSrDY=;
        b=WInD04CfHg+c0rnBX+W/oC9Ny1AAYmL2Gynz+ImVTRMOS1WHVfykzJ4bIxmZtc52aE
         jvte5wN9PBiqM7yvf9J89+WU1Vpg9/DaSl1FDFULnXhjv2dgPlG6KggTggXmQ08p0vtQ
         GCzdmQRT/doet18kcniSxIp3E1ITmiURt5kM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857333; x=1720462133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+XPuVau1N5UPISM5bxeCFeBICz8WAjWnfvGxnYSrDY=;
        b=KijbhyOVi5JIGiQsKAxPW5lO75nfecU0SdmEiX3kOy161x6m6D0wr15k4g1ImzOk1F
         5/bxD/115MUZmoQXe8EF5YY4FuuqEJ/QY5ApD1UhXEqY5NRgAkYsQFeIn/+Q5jBB1DOz
         wQg9Pt8kdlcCKKXSIyyHId2CjEbiP6JMcBUrlUzjLIbem2rSJypT7L3Ge8If3/TkBCCp
         cXDQBw85ywVgzy9SA9lu0QOakMcLQ0hzwNcgTjyupnw48lk9UH5z5j00yxs7EzUBpVhY
         RT162vv7scQy3QJJdf5AXUxKLZqXeKsFzVtApLo0HNXWxlV6w2UBfbbaZiPHk0eXmeYP
         +YsQ==
X-Gm-Message-State: AOJu0YzZJDfWYnDbuBw1H9WrrZ0/k1Tc+aEpJBvQ8hW83bgoc/xD5s1U
	w76Hf0+rp+GqOweCJo2+tu7s0kHCn/WAsC9I/8SIdZNJKArtkLeolk2ZPOXr1OY=
X-Google-Smtp-Source: AGHT+IHJ8TXRdpWPBny8jj79+wT/UdbfHcgJLAqr1onI4BnLwByOl4xHUIl9ApxRNLCYyFso+/5cGw==
X-Received: by 2002:a4a:4b05:0:b0:5c2:1a93:f52a with SMTP id 006d021491bc7-5c437926999mr3096192eaf.4.1719857332923;
        Mon, 01 Jul 2024 11:08:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net. [187.190.197.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149b37e5sm1056096eaf.37.2024.07.01.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:08:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:08:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240404
Message-ID: <20240701180850.GM38804@bill-the-cat>
References: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=PRtRSiAU1Ee87YChkdcN"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 03 Jul 2024 09:22:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2350

--Groupsio=PRtRSiAU1Ee87YChkdcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 10:48:47AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A set of changes to switch meson dwc3/usb PHY to set_mode callback for sw=
itching USB mode,
> and a driver declaration fixup for meson_axg_gpio.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a7eada24327a40f7ef6c55c220e119839c9d42=
27:
>=20
>   Merge tag 'v2024.07-rc5' into next (2024-06-24 13:34:52 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20240701
>=20
> for you to fetch changes up to 96e1a156e90a0674b21c56e7121b17a9211176ec:
>=20
>   meson: Correct driver declaration for meson_axg_gpio (2024-06-26 11:19:=
57 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=PRtRSiAU1Ee87YChkdcN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaC8LIACgkQFHw5/5Y0
tywUggv/eBz1YhJa7uf0U5MNtt3xQL+kX5NsnfEey0cNz0eZHcqCoj9WNbFZr0AS
5+iQzfDjCHmXqf6g/v2vEOGbCdD4GHXGsdFTbT5g3AmcgHWcJeOIFuYQhcR+qTqe
QE7s0bCE+x473CsKp4uJKzbOCi0pbI52n36ePvkC1NhpB0n9kGLQ/unwKif174Gf
bEhJu0kaJjsXae7O59UQ5JwY/VT0tQnO8ddPwX8beVy3WKGsHk66iHEOqyyDzDBB
S65l64AS7mz+dZkYRpQ7mYfvBcT4L1IDFSUESLQDDvvyxvtYjqweaJ0EY/PODse9
1srpymYFz93t4Y/pYEKc1iKS6d/5AoiClFKAJxqCvoU5BC6U/7rBwwozFrUaEpx/
miS2l3vaLofcH/qABDjXRhAU4gvLFE6GjY7PWcbROneMSpVOSHfBEC1p4D9D+b8+
PRe5/P+h4D6XrYWXSDAeyqkIwmlj2550wfcPbMC1Bb5+9wUerXrJ9CYQklf/tcwe
OucXzaFF
=0iw/
-----END PGP SIGNATURE-----

--Groupsio=PRtRSiAU1Ee87YChkdcN--

