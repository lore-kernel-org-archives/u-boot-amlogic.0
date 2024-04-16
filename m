Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACDC4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:15 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.16783.1713262473220423532
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Apr 2024 03:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=ZenL25HE;
 spf=pass (domain: kernel.org, ip: 139.178.84.217, mailfrom: kabel@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7AC3661122;
	Tue, 16 Apr 2024 10:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDAEC32781;
	Tue, 16 Apr 2024 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262472;
	bh=ujW8DqFcTlwhrOGCXDWncEn2W+NVuTOeHJlK6znXb6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZenL25HEVT9iaJsI4qTvmz9U/fIaylBtb090zrxTR/ifEW9/B+UtXYmXEN7MQOdai
	 NxuqHbufqWPAUI/ZD10nVQTbQpbplBxCpFpXQwBv7oEnPwE28BUoN9Z+y5EyfbN0wi
	 KS5WCFlSpqpBKolfpVcWV8FcuxycFK9QlHicb0zQOEBC10Gm1Jq9V9LIEPN1OWSKPz
	 aNFcUY0z3HJklGcz2nCxfDcdVJ0XwYzlfV8vQHpirf8BuMYY648BhNygsT/Kg2Z6am
	 0Ax2qbFjN+TlQkvc0P2h63RmQOzLtyLNUw6otPeu+2PrI6esaU9o6mnQE1+4A0kjED
	 FRNpR8Rm5I+yQ==
Date: Tue, 16 Apr 2024 12:14:19 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: <u-boot@lists.denx.de>, <git@xilinx.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Aaron Williams <awilliams@marvell.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Anastasiia Lukianenko
 <vicooodin@gmail.com>, Anatolij Gustschin <agust@denx.de>, Biju Das
 <biju.das.jz@bp.renesas.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Doug Zobel
 <douglas.zobel@climate.com>, Enrico Leto <enrico.leto@siemens.com>, Fabio
 Estevam <festevam@gmail.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Matthias Winker
 <matthias.winker@de.bosch.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Minda Chen <minda.chen@starfivetech.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Oliver Graute
 <oliver.graute@kococonnector.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, =?UTF-8?B?UGF3ZcWC?= Jarosz
 <paweljarosz3691@gmail.com>, Peng Fan <peng.fan@nxp.com>, Philip
 Oberfichtner <pro@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Stefan
 Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini
 <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, "open list:VIM3"
 <u-boot-amlogic@groups.io>, "moderated list:ST BOARDS"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
Message-ID: <20240416121419.58ec6def@dellmb>
In-Reply-To: <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
	<abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 17:00:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2272

Acked-by: Marek Beh=C3=BAn <kabel@kernel.org>

