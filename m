Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7447C47DB1
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.122081.1703768285978191600
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 04:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PQDbdMZM;
 spf=pass (domain: konsulko.com, ip: 209.85.128.174, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e734d6cbe4so48565037b3.3
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703768285; x=1704373085; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amGZzSpLKwTB1scP384G40wOwvm2zayj6NHN4DcVBeM=;
        b=PQDbdMZM89iZB1yzZ3MiK+5FL7YYKtrfzemZYDhAzZUkpgkR5mpdLQtpIWS3em3qJu
         sYJlXBPIJMZ9/RPmldVV6vaXta7g9G7ovlbVp36ltHNKF3tN9KyOK4K/Z5R+c5iFampr
         gkA+ARwtX5n9jh/+nnrO6ZFoRSHhbjwrCAJDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768285; x=1704373085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amGZzSpLKwTB1scP384G40wOwvm2zayj6NHN4DcVBeM=;
        b=f98JG8AIxl5fNBMbw1XWDEduovrYtJZGrsW567L51po8BK4a8AAnJhSpZROr6kiMIQ
         GWQqOxQ1aAByBIrxaHAyLtZB579ssnHs5cc3gqUgWBfTppCQvLsc0LtwiwGNFdeFi0uc
         7K2rAcgv6mlTmRjeWIzfpLgN3APmIfmAMlpbgiFrENwTRSDADjNHeFgCWNOp7Ubsq5Os
         M4R1XZA/TfNCnCsrXWdfMPdoAC1UyfydkVEBMQD5yTGMxdAefHpE9KSvAAkv984gi95G
         FhiGRY95a9Ji+K9ZUSuHF5nek9OnPqDOEiCUz/GIQ33uWLrQ/b91l77VAdsDoP3d/GQ+
         fuWw==
X-Gm-Message-State: AOJu0YyUpGa9XqqS5IljWjSdFYHE51bZZ1vBIiVowP5J5ttYolr50p2b
	CJ+cB2pCilBERN/pEWJJxvKxmbJAOA6tIA==
X-Google-Smtp-Source: AGHT+IGivtlp0J6uDiVS/Gf3hInJCMufR2yO20/iIEwDO3PD3U7VhdvZIpbe2s9+gAPkZZCgLiccTA==
X-Received: by 2002:a81:b503:0:b0:5ee:6ad3:b0b1 with SMTP id t3-20020a81b503000000b005ee6ad3b0b1mr1837524ywh.4.1703768285190;
        Thu, 28 Dec 2023 04:58:05 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id u124-20020a0deb82000000b005de8c10f283sm7348864ywe.102.2023.12.28.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:04 -0800 (PST)
Date: Thu, 28 Dec 2023 07:58:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
Message-ID: <20231228125800.GY2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20231228115804.3626579-6-sumit.garg@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=lzrPxknvScYutYDF7fbW"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1990

--Groupsio=lzrPxknvScYutYDF7fbW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 05:28:01PM +0530, Sumit Garg wrote:

> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>=20
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for the related cleanups in there.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Groupsio=lzrPxknvScYutYDF7fbW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNcNUACgkQFHw5/5Y0
tyxeEQv+JFUxK6fePvqRO08hexX80jvOaBwfjxYnsT4M5kTQy1zmldJeqm5ybhuS
SaKtxdU2UPK7cOmry77gHOaEHN5tEZ4GU1vl8G0FumPrpe95xY/vtNkgEStpudHS
eLUV4mTfhS8MAe9QvEOIiDygaZLm8pMEdHtM/liW2t0N9QbD+WZeyNrxyguy++N5
1+XIg/7kW/m2XB9i40u+YdOeA9Le+8y1qPoWj647t/Mk0SPDd03lp2vF8zNnb9sb
jv7fD1GsD20n6qVp6pBulFGPzbmAtbMWqB2qVIsiN6RiKn+8yFSGdaLSNO2JdtPV
kqS3XCD6N35/kszkmMF6GZO674spcoj/bYPhnDSUGM2pt5FidBNC4fPGOfDo4fnY
8aQxK4XMioVZ6WV8dI+GJiuzGbNo+xH87CApDqpNuXvY9p9RrxRWxEmmfoliFMFv
Wz3WXm5b1swfYE18MoFRJOJeJ4v55YKgnL3tcf+rAPyJDnh8COtn08aIgQh92Vnx
ouf2mUGj
=+12a
-----END PGP SIGNATURE-----

--Groupsio=lzrPxknvScYutYDF7fbW--

