Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.59])
 by mx.groups.io with SMTP id smtpd.web11.14960.1679409581350054310
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Mar 2023 07:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlZrF45Pb/TT0fVYrbuddGuvlqS6yUgowgFz7F6W/NI=;
 b=X9rNETb+O/YjjTShFYOfFglIa1LUKDxLcFLJ/Bp7fafYOf9zQVoyStVvukJ5XEkYPMkrcPk/cyUoX0wUU3g5e8o+aTvfRgN4UBD1fVCPKNB7XhSbSGanSOFn/+AZDASUy/Ocx2u7ph9xfj4P7YiBTgkFwtyQwh3DLHkz9OcHpT0=
Message-ID: <7336cd2b-0060-17b7-45be-602fc65e6ea1@amd.com>
Date: Tue, 21 Mar 2023 15:39:16 +0100
Subject: Re: [PATCH 01/41] net: phy: aquantia: Staticize PHY driver entries
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
Return-Path: michal.simek@amd.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 3/19/23 18:02, Marek Vasut wrote:
> These struct phy_driver ... instances are local to this source code
> file, staticize them. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> Cc: "Marek Beh=C3=BAn" <kabel@kernel.org>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Haolin Li <li.haolin@qq.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Josua Mayer <josua@solid-run.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nate Drude <nate.d@variscite.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: T Karthik Reddy <t.karthik.reddy@xilinx.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: u-boot-amlogic@groups.io
> ---
>   drivers/net/phy/aquantia.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Would be good if you also create cover letter which I can reply.
I have tested this series on Microblaze which is also using MANUAL relocati=
on=20
(but we are removing it from 2023.07 release) and it is working fine.

I also went over all these patches and changes look good to me.
That's why for all patches feel free to add

Acked-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com> #microblaze (MANUAL_RELOC)

Thanks,
Michal
