Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF06C636D0
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.41380.1700575773365185420
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Nov 2023 06:09:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RKTxHB/C;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so24937546d6.0
        for <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700575772; x=1701180572; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzHgzlpLVoZ5UkHF4NnwFsRGXxpsmY5b9XKQU6YTQkY=;
        b=RKTxHB/CtLAZAlwrAfc2SJST19z3cKC1h8Z5tmW2vOKqsQdYZDSCK8ynlchUS34Fmp
         x5hbYdjHR3LnVf6ksjfjWTbYSPfJq5iLH7XVhhAW6vDdEHKA1EMKJ6BUm4GBaZEdmld8
         DP+cnS3En0TiKgHug+C5HKSTU8o0nSpbGzb/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575772; x=1701180572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzHgzlpLVoZ5UkHF4NnwFsRGXxpsmY5b9XKQU6YTQkY=;
        b=us2vtJOHIS3T6iupQhIBDv+JinwGZixdiB0QtucuJhSIb0LhT3A0Y1pjgx2nnJkeNG
         OwMROlR1Y5YpZlA/srYA1BHNYc/UtGCPegkuodzydKnr2mhotWS+RJ8Z+PZJrzjOYQaW
         nVwki8SSGse3lb+y4Oqj/Tg9A6W8gfWSrj7QyY0h6PrWBluQpX6+5KQ6P25H0CfIqVb4
         FuSQn4OPRLxwOtu/HTGnYtnsx88QnOOexml8i8XZt97tM4WJqx9Z9ZdGDoNu7KtJWZnU
         4KMZx/5Zk78PKHXswrn8Gz26pUdYLGA0bPNsjrGg3ECWDuISPUgiwRQnhSWwjYGdk3cK
         2+3g==
X-Gm-Message-State: AOJu0YyuZmoJchb1C+7PdDHFVx7Lmzub1IdxFFXKB60VU4rmY48tYTff
	h/OLv+rrrBAVBiI3ElJj/a2wAA==
X-Google-Smtp-Source: AGHT+IGWYtE8ZOo5MoTZ4gi4xRh/qOTVIKHDAUyyWHoH8xASsIfyS/CMSnz4VfvlcsoKexbh5wN6yw==
X-Received: by 2002:ad4:5763:0:b0:679:d38e:3387 with SMTP id r3-20020ad45763000000b00679d38e3387mr3931624qvx.11.1700575772377;
        Tue, 21 Nov 2023 06:09:32 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com. [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
        by smtp.gmail.com with ESMTPSA id m5-20020a0562141bc500b00679d90922c8sm2000163qvc.131.2023.11.21.06.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:09:31 -0800 (PST)
Date: Tue, 21 Nov 2023 09:09:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Message-ID: <20231121140929.GV2513409@bill-the-cat>
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
 <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
MIME-Version: 1.0
In-Reply-To: <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=gW2jbpAkHaYNeAF2xFUh"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1886

--Groupsio=gW2jbpAkHaYNeAF2xFUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> On 21/11/2023 14:15, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> > > Hi Tom,
> > >=20
> > > On 20/11/2023 21:16, Tom Rini wrote:
> > > > Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux c=
an
> > > > eventually display this information
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Posting this as this was the easiest platform for me to test some S=
MBIOS
> > > > related patches on and I needed to populate the nodes so I could ch=
eck
> > > > things in dmidecode once Linux was up.
> > >=20
> > > Sorry to be late a the party, but can't this be dynamically found fro=
m DT's compatible & model ?
> > > Since I'll probably need to add this to all boards, it seems like a d=
uplicate of what's already in the DT.
> >=20
> > Part of the "fun" as to why we have the binding here is that while we
> > could use the top-level model property, there's not a corresponding one
> > for manufacturer. I'm fine ignoring the patch I posted here and having =
a
> > longer discussion about populating SMBIOS more usefully, globally, as I
> > think has been suggested a time or two.
> >=20
>=20
> I'm ok landing it with the same data as from the vendor.
> but couldn't we use the first top-level compatible as default smbios data=
 ?
>=20
> compatible =3D "vendor1,board-name", "vendor1,soc-name";
>=20
> and translate to:
>=20
>=20
> smbios {
> 	system {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
>=20
> 	baseboard {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
>=20
> 	chassis {
> 		manufacturer =3D "vendor1";
> 		product =3D "board-name";
> 	};
> };
>=20
> since the vendor name should be already documented in the linux
> bindings, same for the board name.
> And we would be free to add some custom data in the DT if needed.
>=20
> Anyway, not sure it's the right place to discuss about that !

That's essentially
https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2-ili=
as.apalodimas@linaro.org/
which had a bunch of comments on 1/2:
https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1-ili=
as.apalodimas@linaro.org/

But I think that since then some thoughts on the subject have changed
and that approach might be more welcome now than it was then.

--=20
Tom

--Groupsio=gW2jbpAkHaYNeAF2xFUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcuhkACgkQFHw5/5Y0
tyw1HwwAiGhL5ytMB41hDUR0c1kOOvYWALEfr/vwFuTDmxz68yBe4E35by4Zj3gX
5Gl6hRVBALrM/E7z3N0pD4Gr5sWZXiulPSno132ktGLYov7kPKuQiShJe19oRuKs
SGA1DWJJxxXsY1EW4t16EIx/H7+sl4q88SOHUieu1d5OkZcVwYc/9Y2brGYABiYv
BAENcJb1YE0VIEwRRz665r3dmpnXGTX4yUvODBB88hA8ILaUEgcq93gha9yGoOvt
A0OmO1J0MXuc6s/Ui+V0bJBq/pjDTzJcOtlOfFQ59plaiFY5l0i+8NKnwjm1k8xd
Ch+MZEeMDGxyJ7F0zeO0VPQ7LW7qpPIEaiGtvKA08v6xiwKlbKvXaxzDWi3Uz4TU
i5bLY0sWH04pXTYShPhK5KmliGfessaM+y33jWW3XigBH/Hr1wRaQ1tRy40iWd0u
HT47kTAhy4vRx/qjJQ160BAERk2r/vaN3/sO8KD/hNO7WIlsx6gCnZMCZXLEpEVb
Q+efy3Ej
=kboi
-----END PGP SIGNATURE-----

--Groupsio=gW2jbpAkHaYNeAF2xFUh--

