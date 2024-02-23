Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0AC54E4A
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:57 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web10.5506.1708720693101406146
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Feb 2024 12:38:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=K2KIRQqq;
 spf=pass (domain: konsulko.com, ip: 209.85.219.171, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1186499276.1
        for <u-boot-amlogic@groups.io>; Fri, 23 Feb 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1708720692; x=1709325492; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Oy9OkCzC2kSqoNXbREZmiRkGSqqztausV0h3OnZnI=;
        b=K2KIRQqqZnNBMM4uTmqrNQxRJJbpxE2g889NqaPJWHEoUzRytaGS2k+mOG0JQhTmBD
         g73hrg12sOW3ovbZb4jpw7xU2mjL8EeqHEjC/2FmRIJlRspg/ZalzwGQf1LVD5vsL6ZI
         rIpbSyh0izyMsQsaJARWCjM9BE8lB3fdnZQ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720692; x=1709325492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Oy9OkCzC2kSqoNXbREZmiRkGSqqztausV0h3OnZnI=;
        b=BVea08hWyLfscTbN0kbAF0rjGqFM+qsHAFEQs19rKeyMRKaavNeScrAJSvREqIM3RB
         +HdUFxw7rMNYN3mCQgdVtYf7lUhKc6VFpQa9UI5U4jOPrnV9vpqG35wail7iFUFnmvbt
         jhwG0XtEJAcyepamkqh49i/jXVe8UtceJ6/PYqfVA9cV7fBFRv5ndVt/qluNt8rIBpyT
         SjjkvtGju1o9bNjgdHvf8ecRMIUOEahxslJAdA8An7isapD/iPESxRn/Cjl90za7QchP
         QC5yGmKv0jkeKydMcI2Sb3tHUbTYCYA+seqhlZYySjcsiOEjl7oR8pWten2CCWoZPpHo
         1fRA==
X-Gm-Message-State: AOJu0YzaqJX9ynai6GsSC/1W80GROk/GMEYdSdr7C1XcurlZiY4Ch+tl
	vThKZ//MO91mugRsyMzsWytcuo9ApiaeAf5nhmRfwCkXbFnqwuO5w4+zyrDcvF4=
X-Google-Smtp-Source: AGHT+IFYgRg6QzPTdLVs5yjJbg05/YEoJFfvbcAp/mzljUe4XVw4dKlzCE/lqV08X+vEWnTEH4Ig3A==
X-Received: by 2002:a25:9d8f:0:b0:dc7:48f8:ce2e with SMTP id v15-20020a259d8f000000b00dc748f8ce2emr959620ybp.37.1708720692230;
        Fri, 23 Feb 2024 12:38:12 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com. [65.184.194.195])
        by smtp.gmail.com with ESMTPSA id r15-20020a25844f000000b00dc6f1cdd45csm3294976ybm.22.2024.02.23.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 12:38:11 -0800 (PST)
Date: Fri, 23 Feb 2024 15:38:09 -0500
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull u-boot-amlogic-fixes-20240223
Message-ID: <20240223203809.GA3040305@bill-the-cat>
References: <20240223174124.866683-1-neil.armstrong@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240223174124.866683-1-neil.armstrong@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=Ep2K4GSepJOwlRmIcn80"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2143

--Groupsio=Ep2K4GSepJOwlRmIcn80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 06:41:24PM +0100, neil.armstrong@linaro.org wrote:

> From: Neil Armstrong <neil.armstrong@linaro.org>
>=20
> Please pull this simple config fixes for the Khadas VIM3 Android
> setup to fix an Out Of Memory error for AVB.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 5e4a0c7f4a2c9d4670b75a6a2056243b1a5651=
2b:
>=20
>   Merge branch 'qcom-fixes-2024.04' of https://gitlab.denx.de/u-boot/cust=
odians/u-boot-snapdragon (2024-02-22 11:34:59 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240223
>=20
> for you to fetch changes up to fc0a7431e1729f456690468f2e9570fcc2c18175:
>=20
>   configs: khadas-vim3*_android: fix AVB oom error (2024-02-23 18:22:50 +=
0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=Ep2K4GSepJOwlRmIcn80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXZAjEACgkQFHw5/5Y0
tyxh3wv/dGSeKWlK7PEPp8tE6P4o4C1MIPKatVFxpXMbKNOGMv6y3l6CtmGm0m7u
tbdprDPjspv/XI4lxAUbio+v2VsCj0K+7LBwpgZAYUPOfJ3135WxXPBoZra0RtNh
Z8gqoDmkON2efwwxlfo55ZzRRhR7q8FhfGBHHT+l1oJqBO89ddCNab5Fw6aX862t
/yZn+LePCY/+qCniBNtdPgXLvo2Kf2scbcyDmmR9hE/LTd7O0TIHylaijOD2tTOZ
eeWsq1+evt3PM3fD3rDmx+8INpONqRtXWzRPhE1vKszMJytTbb5RwpSqwdAzc8GV
t8YnxgNTvTe3FBRkv3pbXNljXFWbLvAs4v/U57So2X+UYssao++/mRnhKZMdCTFk
/trOZoGt7c2McYZxBauO1yvKTIE1aGECU5RonGOPuQlc4i441KOhMmE0fqhfRZre
8ZZlSgadqlJGffjufQgh/UXhX8Kf0jnuI1xY3OUE8Iycg13iabgCWDhMZTjobIg/
+t3ZyWYp
=zKeU
-----END PGP SIGNATURE-----

--Groupsio=Ep2K4GSepJOwlRmIcn80--

