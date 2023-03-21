Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.51])
 by mx.groups.io with SMTP id smtpd.web10.20314.1679419707817762643
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Mar 2023 10:28:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdD4g1XYR9qU37rj279dOGhWTsB6+xsosEl2ocCUGSM=;
 b=Eof67SjImr3jezv3XhssrJFKv2YGhmivKT9PfwwDp/wLGChDAHZzuy/GiaQJSkV8ZNXKZb3K2JUUO57TDA8c2BmQRmP9OAFHbrzkrETPD6cIYuuRmjIlVAnfs+oakGupIM1CJURIZYqGO1M1eeQVWuwmObhoTSCne6JXiWrLUMs=
Date: Tue, 21 Mar 2023 19:28:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 01/41] net: phy: aquantia: Staticize PHY driver entries
Message-ID: <20230321172819.pfcdfyo6rpgeraip@skbuf>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
 <7336cd2b-0060-17b7-45be-602fc65e6ea1@amd.com>
In-Reply-To: <7336cd2b-0060-17b7-45be-602fc65e6ea1@amd.com>
Return-Path: vladimir.oltean@nxp.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, Mar 21, 2023 at 03:39:16PM +0100, Michal Simek wrote:
> Would be good if you also create cover letter which I can reply.
> I have tested this series on Microblaze which is also using MANUAL
> relocation (but we are removing it from 2023.07 release) and it is working
> fine.

Agree that a cover letter giving the big picture would have been nice,
not really sure what I'm looking at here :-/ and especially whether
there's anything to test on platforms which don't have CONFIG_NEEDS_MANUAL_RELOC.
