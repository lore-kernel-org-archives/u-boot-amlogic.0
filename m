Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1AAC27C6E
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 15:23:04 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.4270.1718223900807408243
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jun 2024 13:25:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=Rv02Np+q;
 spf=pass (domain: chromium.org, ip: 209.85.216.52, mailfrom: sjg@chromium.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so194500a91.1
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718223900; x=1718828700; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBZ4D6qCJEjUNX5DOt0PIHAhCJ21ci5M07TJzj7sxDQ=;
        b=Rv02Np+qf7RXMqGR3brbayG+jLZzq0dXxrqmppp490OqW8zJ5esKFTLwWrcBNLY294
         Qqi1BrR5jzJwcAYgU0WMXcFMzf6rI3k+XUCClBOxNgTH4NDNvCojookg5gNHtiem0m4j
         cUH/jnUOGZnVlJBS0gf9gogAH7mEys+V+epkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223900; x=1718828700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBZ4D6qCJEjUNX5DOt0PIHAhCJ21ci5M07TJzj7sxDQ=;
        b=HFlTgRgqM88pWfiIcEaz229KhgMrpLTejn26Z4CqcbnFX4MKf73ZYEzQ52VAv/meWT
         oqE1WYld4MbFEWD1LgOsV+IYYoj/0ClsFe9NQsGOlbrlj3r/+c1u4EA74StvrprZDXsE
         8hyXbNh6pDg7l8Q0jT02W8U0KoA5GNXwwSejQ96Un4ZwXRGkjEYetzOr4/tzkdWh6age
         RrjAalKmaiyLvdOmFi6EuH2Go/26cKWyTFzV+ZD4Qnzol9l0dpVlPoHOJsriOwSjXvKm
         UsCjK0OnwH6wsjEiMP6hv+nBHSL8pvp5Vje7C+gBF7HEkFSqZizYEKwux2HO8ELzwi7l
         Q7jg==
X-Forwarded-Encrypted: i=1; AJvYcCVn89kr5Bl+EwRh66DjOTuj+NoXVduvOjiiZlBaqOoz4Qj8RHz13diobieSN+HjTvdHZ+DLUBonKz8UJDW06L8+xmzkCMOb0Kc=
X-Gm-Message-State: AOJu0Yz2abAzLjTdffTUV6XlIC7d77Az+v0c5iobPJz/LFK+MGupBYUD
	BngEAsf08JBZMuJFF5Ej51SvObwfo/X7KWgbRZkKt9n5G8/LTR0wTzQxftOJalo83TUB4/XyKEY
	OFZ0tv4dwnN5x8upEV+4aznbnkSf0FdqOTk01RQxBcb7FkMMO/w==
X-Google-Smtp-Source: AGHT+IHLFqn2cS9MmAyX6KzR5TSEzr3sllkU3jlUyQMD+UgVR5ra592rS2s2afWvwDeMaqU4+iPThHCClfW5HnOTGq8=
X-Received: by 2002:a17:90b:1084:b0:2c3:1f2b:45d4 with SMTP id
 98e67ed59e1d1-2c4a763a442mr2936439a91.28.1718223900273; Wed, 12 Jun 2024
 13:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org> <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
 <20240612160301.GB68077@bill-the-cat>
In-Reply-To: <20240612160301.GB68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:28 -0600
Message-ID: <CAFLszThSrUvVjvWvzqezENhiGCVmMokUXR-ZjQqCA+tErN+5CA@mail.gmail.com>
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>, 
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Allen Martin <amartin@nvidia.com>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, Andrew Davis <afd@ti.com>, 
	Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Christian Taedcke <christian.taedcke@weidmueller.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Francis Laniel <francis.laniel@amarulasolutions.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Leo Yu-Chi Liang <ycliang@andestech.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
	Manorit Chawdhry <m-chawdhry@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
	Martyn Welch <martyn.welch@collabora.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Neha Malcom Francis <n-francis@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
	Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Trevor Woerner <twoerner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 13 Jun 2024 15:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2297

Hi Tom,

On Wed, 12 Jun 2024 at 10:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 12, 2024 at 09:08:32AM +0300, Ilias Apalodimas wrote:
> > Hi Simon
> >
> > On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Labgrid provides access to a hardware lab in an automated way. It is
> > > possible to boot U-Boot on boards in the lab without physically touching
> > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > >
> > > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > > which allowed my lab of about 30 devices to be operated remotely, using
> > > tbot for the console and build integration. While it worked OK and I
> > > used it for many bisects, I didn't take it any further.
> > >
> > > It turns out that there was already an existing program, called Labgrid,
> > > which I did not know about at time (thank you Tom for telling me). It is
> > > more rounded than Labman and has a number of advantages:
> > >
> > > - does not need udev rules, mostly
> > > - has several existing users who rely on it
> > > - supports multiple machines exporting their devices
> > >
> > > It lacks a 'lab check' feature and a few other things, but these can be
> > > remedied.
> > >
> > > On and off over the past several weeks I have been experimenting with
> > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > hooks.
> > >
> > > I hope that this might inspire others to set up boards and run tests
> > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > it may even be possible to have a number of labs available.
> > >
> > > Included in the integration are a number of simple scripts which make it
> > > easy to connect to boards and run tests:
> > >
> > > ub-int <target>
> > >     Build and boot on a target, starting an interactive session
> > >
> > > ub-cli <target>
> > >     Build and boot on a target, ensure U-Boot starts and provide an interactive
> > >     session from there
> > >
> > > ub-smoke <target>
> > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > >
> > > ub-bisect
> > >     Bisect a git tree to locate a failure on a particular target
> > >
> > > ub-pyt <target> <testspec>
> > >     Run U-Boot pytests on a target
> > >
> > > Some of these help to provide the same tbot[4] workflow which I have
> > > relied on for several years, albeit much simpler versions.
> > >
> > > The goal here is to create some sort of script which can collect
> > > patches from the mailing list, apply them and test them on a selection
> > > of boards. I suspect that script already exists, so please let me know
> > > what you suggest.
> > >
> > > I hope you find this interesting and take a look!
> >
> > Thanks this is interesting!
> > I only got cc'ed on the cover letter and I'll slowly have a look on
> > the rest. A naive question -- I saw you did integrate this on gitlab
> > with your internal lab. How secure is this? Could we schedule weekly
> > builds that run on various remote labs and get results on actual
> > hardware? Or do we have to rely on users for that ?
>
> That's where this certainly gets a little tricky. Ideally, and part of
> why I've been hoping to get Labgrid going with our pytest suite, since
> it's good enough for kernelci (and people to be reasonably confident
> about allowing not-exactly-random-user-access), it should be good enough
> for us too. So my long term hope is that we can:
> - Have Labgrid based labs + something know to monitor trees+branches at
>   X location (like I know today some people poll and test my WIP
>   branches).
> - Have it be reasonably clear that if you maintain a lab for kernelci,
>   you can add testing U-Boot in too.
>
> In the medium term, I am hopeful we can at least expose this to all
> custodian trees on source.denx.de. And I'm saying "we" here as I have
> two much smaller labs also going, one with Labgrid, and both a much
> smaller set of targets currently.

That sounds good to me.

Regards,
Simon

