Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C56DC41513
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 15:23:04 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.213.1718208186793187391
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jun 2024 09:03:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=h6mso7UC;
 spf=pass (domain: konsulko.com, ip: 209.85.161.41, mailfrom: trini@konsulko.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ba1f60eb96so20389eaf.3
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1718208186; x=1718812986; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVL0K+4RVRG/L5MOsD20eMVxBw1m0p8/HrcUyfTcVIs=;
        b=h6mso7UCtjEB09p/F8J4hzIkJxP27zN7pdr9B32N8DuYanAJKwfbupr2dm5lO1pWhh
         gXcpBWAtK3sF8tW1HnAIdynaYGvbEZGzfY693GYdeVTufC49NRGKRAGacnX2RofzP2js
         PkCkyHZI9hX/P5fn3xH0rWifsdaEISfHU4IeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208186; x=1718812986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVL0K+4RVRG/L5MOsD20eMVxBw1m0p8/HrcUyfTcVIs=;
        b=NZWDtfzrT5iHFFqzJz/mtcLPszrkoUnSAKQba3MtHHchTNzwfZwxckwwgE1ijK1egm
         IlFs6qvY94OMWkY0xnDTu+NEz5/gplSv8xi28/DGoHW8mQDvWpRlA1XVHBHxU91WjX6A
         5cd6jd9hVZmu4A0+zmgqmwZISboPCiMO1p+j1TiXUj69K/ux9Fw91X1vp6Sbls+vy3S+
         Pp+t0hZJPDKad409Z835TQyCWmA49JNTobatf59xbrvFil2aRJ4LttOAz1xX4uaDMgaA
         tFzmuqKu0kQjfeA7MOLAGp1EiIek+nLeoeS/fpUn51s7kz3Y1Ku/2DcXxDJMoBjZJ/x8
         fcxA==
X-Forwarded-Encrypted: i=1; AJvYcCV6MQt1ht09UszJqbNG39n75MMwulo9a0baTQ7m/KUB1xqLctQ1W3v0X5Lfq/V01UEw2dBCQoUrPSmwPrdIQO0lqJYi6HSZjLk=
X-Gm-Message-State: AOJu0Yxm+av+T+3MtQKJYgVb3fdoUjfbDotrwfpalfPbK4TqHa5VbRGj
	coLqtxefjXMOddnZUgFOH8dEPoNKqbSnLKSuDiaXb2mjZ5qb616X0SGdFjlMr6Q=
X-Google-Smtp-Source: AGHT+IEgASZEah86I/fbSifEySJiQWlrzH5jCPpBPAO/K2UieK91RF4s+KwwhDg0yNl1RhHqZN43/w==
X-Received: by 2002:a05:6820:1c88:b0:5ba:e995:3efb with SMTP id 006d021491bc7-5bb3ba4d347mr2666898eaf.4.1718208185778;
        Wed, 12 Jun 2024 09:03:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net. [189.203.100.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976bf79fsm2262424eaf.20.2024.06.12.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:03:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:03:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	AKASHI Takahiro <akashi.tkhro@gmail.com>,
	Alexander Gendin <agendin@matrox.com>,
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
	Allen Martin <amartin@nvidia.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Christian Taedcke <christian.taedcke@weidmueller.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Francis Laniel <francis.laniel@amarulasolutions.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Lukas Funke <lukas.funke@weidmueller.com>,
	Manorit Chawdhry <m-chawdhry@ti.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marex@denx.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Neha Malcom Francis <n-francis@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Pavel Herrmann <morpheus.ibis@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
	Philippe Reynes <philippe.reynes@softathome.com>,
	Samuel Holland <samuel@sholland.org>,
	Sean Anderson <seanga2@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Trevor Woerner <twoerner@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
Message-ID: <20240612160301.GB68077@bill-the-cat>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=4Qxi8TBBIte6zofRvoSi"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 13 Jun 2024 15:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2295

--Groupsio=4Qxi8TBBIte6zofRvoSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 09:08:32AM +0300, Ilias Apalodimas wrote:
> Hi Simon
>=20
> On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Labgrid provides access to a hardware lab in an automated way. It is
> > possible to boot U-Boot on boards in the lab without physically touchin=
g
> > them. It relies on relays, USB UARTs and SD muxes, among other things.
> >
> > By way of background, about 4 years ago I wrong a thing called Labman[1=
]
> > which allowed my lab of about 30 devices to be operated remotely, using
> > tbot for the console and build integration. While it worked OK and I
> > used it for many bisects, I didn't take it any further.
> >
> > It turns out that there was already an existing program, called Labgrid=
,
> > which I did not know about at time (thank you Tom for telling me). It i=
s
> > more rounded than Labman and has a number of advantages:
> >
> > - does not need udev rules, mostly
> > - has several existing users who rely on it
> > - supports multiple machines exporting their devices
> >
> > It lacks a 'lab check' feature and a few other things, but these can be
> > remedied.
> >
> > On and off over the past several weeks I have been experimenting with
> > Labgrid. I have managed to create an initial U-Boot integration (this
> > series) by adding various features to Labgrid[2] and the U-Boot test
> > hooks.
> >
> > I hope that this might inspire others to set up boards and run tests
> > automatically, rather than relying on infrequent, manual test. Perhaps
> > it may even be possible to have a number of labs available.
> >
> > Included in the integration are a number of simple scripts which make i=
t
> > easy to connect to boards and run tests:
> >
> > ub-int <target>
> >     Build and boot on a target, starting an interactive session
> >
> > ub-cli <target>
> >     Build and boot on a target, ensure U-Boot starts and provide an int=
eractive
> >     session from there
> >
> > ub-smoke <target>
> >     Smoke test U-Boot to check that it boots to a prompt on a target
> >
> > ub-bisect
> >     Bisect a git tree to locate a failure on a particular target
> >
> > ub-pyt <target> <testspec>
> >     Run U-Boot pytests on a target
> >
> > Some of these help to provide the same tbot[4] workflow which I have
> > relied on for several years, albeit much simpler versions.
> >
> > The goal here is to create some sort of script which can collect
> > patches from the mailing list, apply them and test them on a selection
> > of boards. I suspect that script already exists, so please let me know
> > what you suggest.
> >
> > I hope you find this interesting and take a look!
>=20
> Thanks this is interesting!
> I only got cc'ed on the cover letter and I'll slowly have a look on
> the rest. A naive question -- I saw you did integrate this on gitlab
> with your internal lab. How secure is this? Could we schedule weekly
> builds that run on various remote labs and get results on actual
> hardware? Or do we have to rely on users for that ?

That's where this certainly gets a little tricky. Ideally, and part of
why I've been hoping to get Labgrid going with our pytest suite, since
it's good enough for kernelci (and people to be reasonably confident
about allowing not-exactly-random-user-access), it should be good enough
for us too. So my long term hope is that we can:
- Have Labgrid based labs + something know to monitor trees+branches at
  X location (like I know today some people poll and test my WIP
  branches).
- Have it be reasonably clear that if you maintain a lab for kernelci,
  you can add testing U-Boot in too.

In the medium term, I am hopeful we can at least expose this to all
custodian trees on source.denx.de. And I'm saying "we" here as I have
two much smaller labs also going, one with Labgrid, and both a much
smaller set of targets currently.

--=20
Tom

--Groupsio=4Qxi8TBBIte6zofRvoSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxrUACgkQFHw5/5Y0
tyz0JQv7BuRanyt/in37dCMi8s0RE69nlJaj9j+Y8mABNRlBVBO9Jae4RjkYBWK8
gOaxu6bN3AQ0TkEb/MGI9froWlSNnNWMzoodGwXUm3HUEIl3ykIRaQmtRQkNA9r5
0UXDQloITORfJh+7kCPHgmcRaCJE+IaOt08upsAWZnUS/kdxxgnmTGBacJWhicp7
Uek30F73/dl/K4ajtdvm8lwocR83pbGSWyBiYUYvwPks5/LpQMhxMqi11vdpXF5j
rWLwRiRx7qg5eZ8JsBowvb5No5d/aG+MVYi3U9bnubBVnu4aByKbGD6SK/HNMJFX
/OKmHX2aEqKW11Ik1JUU/+aUxRmhlAp3o0ErVaS4hbYbhjAHL7lUwsKsxlwjm36w
cvEfJpwL8D8+wLUjUbuIzDDidc1GhE6GWSSkI91H48wPSWfh2pdfAcV5d1OonQcz
FHLHpUpDW+1QJhQ+f+HJZ55a63m4+W0bMpBgFHC24PsiPcje07GkZWTrWjkoBw4s
oaN/Lt40
=R7Yr
-----END PGP SIGNATURE-----

--Groupsio=4Qxi8TBBIte6zofRvoSi--

