Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6BC04FFF
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:15 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web11.25162.1713284478463460409
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Apr 2024 09:21:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=xypron.glpk@gmx.de header.s=s31663417 header.b=a7vKatEk;
 spf=pass (domain: gmx.de, ip: 212.227.15.18, mailfrom: xypron.glpk@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713284412; x=1713889212; i=xypron.glpk@gmx.de;
	bh=6MivIWAskDkTnfCkpEL05lkh0YuHw6lkxje4i2lUcCU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a7vKatEk5MMTR6dKOlYU5I8Jt4b1hUlrZ4oth6JMhwQJTyVkzatAl268Oh4mIaLo
	 7v1sM8X/f8Ife72RU9UHpxMgQVBw6RA42b2mdPJejL/f2/RhznGQPp6RlkFDOHaum
	 tfwzQQ/DOYZKZP7akDkzMs78z8kvocP2J3Yg/8E5Z3FSy4CTBrcGtfXh/sIcZily7
	 G6R5e4vFuArYuG8BXwZ83Kv5so02A8MqxswpecA2BkqATTi7+VViZyDmlRXMuLhbh
	 sUjQxWezT7fjoVl/LTsO0TPDtcUVvO593DXY8L4YnFDxdOPJPvsOnFMk0QpXyXens
	 TocwlCOEqZzv2JR2OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1sJ5dV2aOX-00VAHD; Tue, 16
 Apr 2024 18:20:12 +0200
Message-ID: <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
Date: Tue, 16 Apr 2024 18:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Aaron Williams <awilliams@marvell.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Doug Zobel <douglas.zobel@climate.com>, Enrico Leto
 <enrico.leto@siemens.com>, Fabio Estevam <festevam@gmail.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Grzegorz Szymaszek <gszymaszek@short.pl>, Heiko Schocher <hs@denx.de>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?UTF-8?Q?Pawe=C5=82_Jarosz?= <paweljarosz3691@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Viacheslav Bocharov <adeep@lexina.in>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "open list:VIM3" <u-boot-amlogic@groups.io>,
 "moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
 <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
 <20240416160631.GO1054907@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240416160631.GO1054907@bill-the-cat>
X-Provags-ID: V03:K1:E/tn4fCtbNK59ah0buIGEzkjRN+LrPJ/aIWAg6tNiqAL2lcb9/8
 8Hcmdr8m4DoGiGAmVvD7gapx0yfhHZBdtCLDOVcPhq6Vd1ZqSqcEN3dPkOYnEX1WfgWGI54
 J9nrQfrNJ9SZHeYIK5zgMnLYCxkGzGkFUtxcR03nkyagGQewezMtKAYL9yGBYIPc1biOP4f
 NHMaTd09bbxCPDhV1X4cQ==
UI-OutboundReport: notjunk:1;M01:P0:AonO1huSYZY=;nnPH+QyQAberWkauphdDX1oGC6P
 NjtHRkD8/TRlwJcoNIH2CbKZXaeB8TC62UYwYE4B4Lru7GCevSYQJlnpsVEVDsOE8tkQwz+JI
 m/4/SelW1EMl95XoXrUG6vO/CzH7Tr2XN6mqSC1eYM/fs8DPCAFcBBi6/pCjuQevTAhS9ajGT
 TDdOsFpRNNvDSSO/lSKPC4AgUhB4spzixdIiuAtw9Nb8Hs4zHoQx5MUMw8XWOlDwBJYYJY9z3
 fizvhvIlvxnI2X5aOTZ+S6APSXBrwDhDGgkr7NX+qI9R+Hsfz6u9/n4kHg6l9JBAcfQQWE9Lr
 KNLi7hIpKHgITNDvOOF9fYWpuTBJoo4vGOztKCzfrZ20CL9fl1UV2DAIo42n4ixLvw/A2+85a
 gWzW070VrHkSVQZbZNoq07U4bNzY+Mtt4u5VobtRm4SQgIbO4Go96JPZ2Um7g2t5fMedfzzAR
 vr4AkW33x1LVrS3HPJ5248sPz4AmLcMpr6sN/FQBsusiqW5A48MFj86D9UH/n59mKi8FE32A9
 OUfITyWrs0rLTZi4LtJhUR8mK3GGtHDH1P3FhLee43c4fNjBQGRxDAZOXF7cbhFNeDTr5j4ag
 brtB17cs9Cu4vta0NhxDMbnFEuxUXldM7F/U0Q5J4YMMJ/UnpbVoe9gWywssBAmIXfCeWhcum
 bQeGnW60+YXffBMLW/wmqu60FQ3uuE/OxBE7ouBb5W8F+cZLCtkL54BLyabdToVeDwmen76yq
 zfCvI1CFhSMIj5+Z5CmfcEXVBPqON3jMQ3G+G94BmNJhGifQr3zHnmknmE6+d3q1mPYhUr7Cn
 m/lu35TwA/bLoEsoMbtzpUaIsTb9crfDD26HPRAN/6tQU=
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 17:00:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2274

On 16.04.24 18:06, Tom Rini wrote:
> On Tue, Apr 16, 2024 at 08:55:19AM +0200, Michal Simek wrote:
>
>> Convert UTF-8 chars to ASCII in cases where make sense. No Copyright or
>> names are converted.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> Now, how did you test / find these? Given names a CI test is unlikely
> to be doable but if it's otherwise scriptable I can put it in my loops
> and just fixup as needed (like I do today for adding <common.h> for
> example).
>

There seem no to be too many non-ASCI strings outside of comments.
Should we care about non-ASCII comments?

$ find . -name '*.h' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
':\s*[\/\*']
./include/configs/tec-ng.h:13:#define CFG_TEGRA_BOARD_STRING    "Avionic
Design Tamonten=E2=84=A2 NG Evaluation Carrier"
./arch/mips/mach-octeon/include/mach/cvmx-pko3.h:369:   MEMALG_SUB =3D 9,
      /* mem =3D mem =E2=80=93 PKO_SEND_MEM_S[OFFSET] */

$ find . -name '*.c' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
':\s*[\/\*']
./drivers/mtd/nand/raw/nand_ids.c:65:   {"H27QCG8T2E5R=E2=80=90BCF 64G 3.3V=
 8-bit",
./drivers/video/dw_mipi_dsi.c:861:MODULE_AUTHOR("Yannick Fertr=C3=A9
<yannick.fertre@st.com>");
./board/bosch/acc/acc.c:440:    .SRT =3D 0, // Set to 1 for temperatures
above 85=C2=B0C
./cmd/2048.c:65:                                printf("   =C2=B7   ");
./cmd/2048.c:79:        printf("        =E2=86=90, =E2=86=91, =E2=86=92, =
=E2=86=93 or q        \n");

Best regards

Heinrich

