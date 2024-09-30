Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A0CCF64A0
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.50528.1727689402535577909
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Sep 2024 02:43:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DEuEavFy;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: miquel.raynal@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FA3140003;
	Mon, 30 Sep 2024 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727689400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk9PfTdSng/f6BOxizJgMx8zThAm4aj29ORFqJM00Zs=;
	b=DEuEavFyR/Ep70P32Mw8jPoMdCua7aY3wUymp8zFSCYfok8phg0+BWsOJjnJXBxHDRQbb+
	RhiKvivrslfMGexW/IrBQCqQIpvfJ/Ht1rA/wDZD+HapjwYLyQ3G+YBzZpNorsOTC1jcPP
	81S+bU+sfqwhcUl4ajhK25+tTn5GVsoAdkrpkt3HwZOndpGEX6VY63EuKwUlGHJ5inHb0o
	WqW8g2nlHGMAuE4Uw9aBJ6e79mxV6PFIb3ozUELBKQaf1TAXaQ+G2JvZPuBh6qEdXSH3ro
	DWjfDn6GphQ7800gghaOayRoDqEFD3VpYBLZkyQIgszXYqVV4hXHYX2D+cpjng==
Date: Mon, 30 Sep 2024 11:43:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Anatolij Gustschin <agust@denx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Anton Bambura <jenneron@protonmail.com>, Ashok
 Reddy Soma <ashok.reddy.soma@amd.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Fabio Estevam
 <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou
 Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Jonas =?UTF-8?B?U2Nod8O2YmVs?=
 <jonasschwoebel@yahoo.de>, Julien Masson <jmasson@baylibre.com>, Liu Ying
 <victor.liu@nxp.com>, Lukasz Majewski <lukma@denx.de>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, Martyn
 Welch <martyn.welch@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nicolas Heemeryck
 <nicolas.heemeryck@devialet.com>, Nikhil M Jain <n-jain1@ti.com>, Patrick
 Barsanti <patrick.barsanti@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefan
 Bosch <stefan_b@posteo.net>, Stefano Babic <sbabic@denx.de>, Svyatoslav
 Ryhel <clamor95@gmail.com>, =?UTF-8?B?U8OpYmFzdGllbg==?= Szymanski
 <sebastien.szymanski@armadeus.com>, Tim Harvey <tharvey@gateworks.com>, Tom
 Rini <trini@konsulko.com>, Vinod Koul <vkoul@kernel.org>, Yang Xiwen
 <forbidden405@outlook.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
Subject: Re: [PATCH 00/26] Support display (and even more) on the BSH SMM S2/PRO boards
Message-ID: <20240930114314.30b9e1f5@xps-13>
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-GND-Sasl: miquel.raynal@bootlin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2425

Hi Dario,

dario.binacchi@amarulasolutions.com wrote on Fri, 13 Sep 2024 11:55:42
+0200:

> This series was created out of the need to supportsimple-framebuffer for
> BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was necessary
> to develop additional code and/or drivers for all the required components
> (i. e. clock, power domain, video, etc.). This series has a Linux
> counterpart that will also be submitted upstream as soon as possible.
> Furthermore, given the overlap in topics with the recent series [1], we
> are open to collaborate on the common parts to ensure proper development.
>=20
> [1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@boo=
tlin.com/T/#mb7cd440abc6fcc0de205f577eb3225e1c1c76823

I received a bit of feedback on this U-Boot series, I can take the
feedback into account and send a v2. Then, if you are still okay, you
can stack your patches on top of mine and do the required adaptations
(on both sides).

Thanks,
Miqu=C3=A8l

