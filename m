Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448DE7719B
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
 by mx.groups.io with SMTP id smtpd.web11.17098.1735992389878742256
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Jan 2025 04:06:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=jyYVudNN;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.174, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1735992387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=WICRutFrzNfYukhOJag2K9op4TGnqlYZc1cVanitdIs=;
	b=jyYVudNNbg3WFqO7bXve3CMHMad72at4tZgVGWL3Uw/AIi39KsIn5z/6t9t+aj/loltCmi
	eDk3heKEDWcKXMYccBmjtYVzPqzdPfzM4J/SPYMZYge+WqiXJju7y0VPsMIMXh+mNutUQe
	Td4CmUXdYwc4Kfam0GV6txeBgzHhstCm528zyGTfIGLP8CKXyFDJhFq6jCL6URPyafU9Q7
	b72Zp92wo212b3fe+eXPE0UQ4lkZw7W2XgN7bCur6XwU/KA+dIiLAJixLN1UnqCUUg3lsv
	r2tEWs63AlM7aI8ijm5IytDoNZKBNxbsQkB1yfC2nr4sPGHA+hWx/V2Fdx7jQw==
Date: Sat, 04 Jan 2025 12:06:07 +0000
Message-Id: <D6T9XNZMHBVE.2FGE2RIBUOBP6@postmarketos.org>
To: <jonas@kwiboo.se>
In-Reply-To: <20250103215904.2590769-2-jonas@kwiboo.se>
Subject: Re: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <neil.armstrong@linaro.org>, <trini@konsulko.com>,
 <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <vitali64pmemail@protonmail.com>
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2602

Hi,

> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> Amlogic AArch64 SoCs.
>=20
> Images can optionally be signed for secure boot scenario, however
> creation of signed images has not been implemented.
>=20
> Example of how to use it:
>   # Create an amlogic boot image
>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin u-boot-amlogic.bin
>=20
>   # List boot image header information
>   tools/mkimage -l u-boot-amlogic.bin
>=20
>   # Extract amlogic boot image payload
>   tools/dumpimage -T amlimage -o bl2-payload.bin u-boot-amlogic.bin
>=20
> Or with binman using something like:
>   binman {
> 	u-boot-amlogic {
> 		filename =3D "u-boot-amlogic.bin";
> 		pad-byte =3D <0xff>;
>=20
> 		mkimage {
> 			filename =3D "bl2.bin";
> 			args =3D "-n", "gxbb", "-T", "amlimage";
>=20
> 			u-boot-spl {
> 			};
> 		};
> 	};
>   };
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---

Acked-by: Ferass El Hafidi <funderscore@postmarketos.org>

Thanks for sending those patches upstream :) I've been using them for a
while now, and they work nicely.

Cheers!

