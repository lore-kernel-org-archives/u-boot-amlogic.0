Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD67C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:38:22 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.11922.1702136932308186926
 for <u-boot-amlogic@groups.io>;
 Sat, 09 Dec 2023 07:48:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=q+oj0C5f;
 spf=pass (domain: konsulko.com, ip: 209.85.128.177, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5cfc3a48ab2so25601947b3.0
        for <u-boot-amlogic@groups.io>; Sat, 09 Dec 2023 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702136931; x=1702741731; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v63WRHG7Rh7997+vhjCcKhv2PlckHAlOD8we4b3fKY0=;
        b=q+oj0C5f3wGJ/Pp7ZziZIG5XLqM4vKYbPog3zbzeD+DbhSDwf7Gl+7lMz/GUjrgwPK
         Th00P/QHNPONcbcNljLj/g+zckxTLElSDtGpE36SA8+3SReqrCNPkkNRweMTB2UQxGYP
         VEuHX2ZJbdwrKAqLRAg1X3ZWBgTm9kHEF5YEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702136931; x=1702741731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v63WRHG7Rh7997+vhjCcKhv2PlckHAlOD8we4b3fKY0=;
        b=oD4IMMAC4DZmEa9XdD/ngJ3F9OALGbdiueztSdtyGJtmrWfNjDzu8Xgc3Oqi7ZJST1
         sdd1apL+/ZF2bdUqNW/Jfj3DJFdfEtii8MmJcA4wXxfRVeV0ay60acblBhMUCppdj4qm
         TxROkR69juYGhIWhuouP4btn8wpG8vr+efyWsYVJEp1EiwWaCPPHl0RzSaWTYTmNqFA9
         Mij6tL3eo5ZT5IBC4VZBpXESnaGVZymz9ouLJtIJK6z4IwgfpDz4DBd+xYK7liMq1DDl
         aNG6C2jr02bYY09hoG89w5MqsBGV8aHpA0Up9ftdBA8EuRv9ShT94LSKVTiIUSrxi2e5
         slbA==
X-Gm-Message-State: AOJu0YxIfuEKTO8/507w4lCG27KgSUg0y+17wyULZ8fxGXi8TN22MPlg
	KmDFmmTAAePSfYjPxlKnUxuG9UnNr+YvC8z+Qlqpcw==
X-Google-Smtp-Source: AGHT+IEYvaAn1tXPcuI6HHSCCi6jPT1YhW3h8EXSNjua7Y8GXhGTQuDJMlJ+hOv3L0NP+zmp7hAyxA==
X-Received: by 2002:a81:6e0b:0:b0:5d7:1941:acd with SMTP id j11-20020a816e0b000000b005d719410acdmr941205ywc.104.1702136931437;
        Sat, 09 Dec 2023 07:48:51 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com. [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
        by smtp.gmail.com with ESMTPSA id m14-20020a81d24e000000b005d8bb479c51sm1538563ywl.11.2023.12.09.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 07:48:50 -0800 (PST)
Date: Sat, 9 Dec 2023 10:48:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231207
Message-ID: <20231209154849.GH2513409@bill-the-cat>
References: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
MIME-Version: 1.0
In-Reply-To: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=83GRkcyxThhh2Hd1E0yc"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Dec 2023 09:38:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1903

--Groupsio=83GRkcyxThhh2Hd1E0yc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 04:02:26PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> A little fix to add the missing DM_USB_GADGET config for the amlogic boar=
ds
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18828
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231207
>=20
> for you to fetch changes up to 4005729c0de234ffcf36465f6471755617b42375:
>=20
>   configs: meson: enable missing DM_USB_GADGET (2023-12-07 09:36:19 +0100=
)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=83GRkcyxThhh2Hd1E0yc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jGEACgkQFHw5/5Y0
tyzK1gwAmusgUMY+HyPhtjF9Y8HwCtOWYhHPXfMfuqEdCZAomnAi/wt3mZjAIrdX
Ey9LH/tTv8Ga1pVUj0E6SlZhDVlUOG/Uv1vCl8WpwTZcRAnKtg56GC/82T/1/kqt
pZyZRb2ygwW8OroKyIcUt30q71PZvV9KwrMPGTJqER9HH0n0O4NZVsnwAiQZVvGc
tG50lrnY4+T901c7v3KAQ05V0l8hMdeyrPXZfFYw/CFn9LY/A7ikpWp4BCdXv/CQ
0oVVd/6R8Y49hY51saKLmz7DBI7rUYJCws4BD1u6bt9Da6HNzT6oh56JlaMREOgZ
pLENltfbM1bBeh3g0X7sy4SHr94dlc5isuAG0GXrYrt0vI9c9A+W1from2ljToal
bIH4Z2NGVOUSaG3wbCYStnex2cfaqhCHPMMJfdODKNKLhVOvARYppDz2W4l6Vf6x
p74hMTEN90QE3A83AuYSvY9bMW44aEqzskK0jCrweHIv2/KgCzmLjc5QRVDyOlM1
nbUgEQhf
=puWR
-----END PGP SIGNATURE-----

--Groupsio=83GRkcyxThhh2Hd1E0yc--

