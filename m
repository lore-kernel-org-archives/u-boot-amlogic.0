Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 by mx.groups.io with SMTP id smtpd.web11.5303.1641555194366701420
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Jan 2022 03:33:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1641555186; bh=5SrKZsnd69acqs5peOLZHgy3XL/gAb7otjIG9lEes0M=;
	h=Date:From:To;
	b=ZLWVcy+cxo0czD1wOYtIDTZYgOj0LUfNGRi3Wv90iLPaUAcXT2p2SrOkOW/j/QVX/
	 tC79XdPIijYlSkq26Zw2murZiIFpnrqDm9iN/I/0D9eh1BtTPVdpFvQSVREitEEJn7
	 czjZe17C4WxO+RYg0eHAVSxd7nK46qW4ZcZkGsWY=
Date: Fri, 7 Jan 2022 12:33:05 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: [PATCH u-boot-dm] fdt_support: Add fdt_for_each_node_by_compatible() helper macro
Message-ID: <20220107123305.59429722@thinkpad>
In-Reply-To: <20220107101329.25836-1-kabel@kernel.org>
References: <20220107101329.25836-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, Tom Warren <twarren@nvidia.com>, Aaron Williams <awilliams@marvell.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, York Sun <yorksun@freescale.com>, Priyanka Jain <priyanka.jain@nxp.com>, Wolfgang Denk <wd@denx.de>, Oliver Graute <oliver.graute@kococonnector.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Biwen Li <biwen.li@nxp.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Anji J <anji.jagarlmudi@nxp.com>, Michael Walle <michael@walle.cc>, Vladimir Oltean <vladimir.oltean@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, Igal Liberman <igall@marvell.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hello Simon, Stefan,

this patch is for u-boot-dm, but will apply only after marvell/next is
merged.

Could we perhaps review it and let Stefan apply it on marvell/next?

BTW it passed CI on github.

Marek
