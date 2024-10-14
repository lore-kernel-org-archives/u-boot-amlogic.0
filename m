Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A6D206B6
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:55 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web10.2062.1728930208509660460
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 11:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=a+9TZep1;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b10f298052so218647085a.1
        for <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1728930207; x=1729535007; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75ba4MXXLozBeHoVvbuu5ubTf49//IpXOAWqU2hdg7Y=;
        b=a+9TZep1Q6jnXTC5Y/iLeYWYLqSP6i40TbzElu//7wTwA7srltHFMMlbJoDQ+7lE7A
         8OTAcoI1nr/5XTn9CXLt45cbbQN1De0qZpkIzvjk7Y5+R/KOun7jqos+rSukigKuyuEK
         5J+a3tGSSyX05iN+LK5yv3+whnWJn9g+pBM9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930207; x=1729535007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75ba4MXXLozBeHoVvbuu5ubTf49//IpXOAWqU2hdg7Y=;
        b=irKb/uoCGj9J3waKgNwjBrM1piC38VS4eCZJPZXsEp+FSjtNCQWeIfX9j26gTwV04V
         XupZWdtV3ksgjhIMFfE3rQwEAJ4K8smyqEGs1aV0GDWw+paA7rd0vDpA40q4DkDDR3IY
         yZ+q06tjNpNT6Tfo4GJWOjjYDp6z/FEMxl59MC72tLruMaNghStlGwoe3Q5T2ngIaB7N
         XrFCPVZALhYAxZEKyuZ5F2PVwvzTszrwdp3H0aEF1reiUzZCs2nkj4UKfnEbLnCpY5FS
         QcsxxM02xkZ8OR9MOMJMwS+P+bBUK93kJUmmfLK4kb5vbAVJUtF26e81wYZJc8GJJiGA
         nLLQ==
X-Gm-Message-State: AOJu0Yyt58VlLyGILXThxV/t654xHIQuKSJ6VusiyeUoYgF7r/C4W0JI
	7s8GXVxE0vyRdEB7/Kddhoibs/WAKgOI23rsqvk29NGuSJxbCWIL+fi5akaTsBUzNtfeTInkaM2
	exN8=
X-Google-Smtp-Source: AGHT+IElcDSfcuLAyEINTmscyK7TFVcjej258Cjs8vvbefUbgg8hVNAJ3nNGecmOQJmofrguHCSqMQ==
X-Received: by 2002:a05:620a:2411:b0:7a9:b10f:d54 with SMTP id af79cd13be357-7b11a34d980mr1816984585a.3.1728930207455;
        Mon, 14 Oct 2024 11:23:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d4f62sm47588081cf.26.2024.10.14.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:23:27 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20241014
Message-ID: <20241014182324.GQ53053@bill-the-cat>
References: <d2b5a5e5-c50b-459e-a81e-90c952efdd16@linaro.org>
MIME-Version: 1.0
In-Reply-To: <d2b5a5e5-c50b-459e-a81e-90c952efdd16@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=NceNJ3y4mcJOALJqPWhd"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 16 Oct 2024 07:57:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2489

--Groupsio=NceNJ3y4mcJOALJqPWhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:44:01AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> New Libre Computer boards are added with UEFI Capsule Update support,
> plus various fixes for HDMI support, boot targets and android-mainline
> kernel support for khadas-vim3 android config.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 580fb5773634c4a01f907a164b2a05961840b4=
c0:
>=20
>   Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-10-13 16:25:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20241014
>=20
> for you to fetch changes up to 315cad97a5ae09b1b975fff2413ce785b3b8592a:
>=20
>   configs: meson64: Ensure commands for boot targets are available (2024-=
10-14 09:06:16 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=NceNJ3y4mcJOALJqPWhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYZsACgkQFHw5/5Y0
tyxMWAwAq77H4XS06wdFB13lRqSfE0Qk63sn400Tj2rIgt8utohBS3ygnNfV9pPf
RBFF4rFwHkulGLu4oSUDb4Raa0MiTNXbFhg0u0ez1NVf0y9NNUl9xnrREaw0mZNH
ZeTHpRyE6xT08cHifEyq2uzmsSGvxZ3wW3FQDBtUEf0st42z2Im+kGZsFNd9nW7t
gFvC+z6RdxIyETU67VqHsnNcUlzDgwzTcZNZaTGkwtMlU8f/4nOh2Ax3wytbZyXy
vv9VT4bhMiw38xaX0cwgLXH7HKmPL49OJkSoqAV6Qw8mALbBJAthL8BLXhaaY9Rc
Q/Zv1ppdfYCPpH3OCiYrERufnL1fsiHpjam47zx25cTf3UpYPMiYn8bTuDJ50qLS
gxYTCzCZqCmwiqWfaD5nqqRcB2sSdl9nzE0ukF/wIodnpNiBXjxJ+hguOUupufh7
juUUWeKEVMiEHXHt2u89mvYxBm+31QMD4vRpWWyHj8i5CXOTDVfKcuHnoHTjYp8z
E5UT6HAt
=X9zY
-----END PGP SIGNATURE-----

--Groupsio=NceNJ3y4mcJOALJqPWhd--

