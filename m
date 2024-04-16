Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF72C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.42])
 by mx.groups.io with SMTP id smtpd.web10.14379.1713250531610866336
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Apr 2024 23:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=p/vEv+O+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.42, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiGmZObRhaCBpi3ZuzC/C97JUPFalfbkDdIp/8JrUKiKozeCseVGQY5Om6+OKYcd0lt3PjUjZesFbKfHUc+hC7JbzYvAhOmNfTgFEKaIwebF/x6lLZNnYvRGBhLWE+jl2po/KFtsduxpZsgcRrW4q92D2gxmiDnFEwM+DAYHgLVrrH6Dt1WuHx7zZ7Cn0JkHEQft8nVV3/DtjQZ4TgQoFDqatlZLVS/RVlYh8IZ9lzcb85h+fLJYILyMpHCzZq9UA16bfpnmOaZKfcxkgvzbjc8zVRnkmujQ0XQ9bxS5pmvC1fJV2ik/jZia9qI9dw9LzZWsnUzjfIDddVlsd6Q1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5DZ5PSGz/K3YWOTOIwU/amqFCuRTH+XjOHackMxr48=;
 b=KtWUAE0yA7qt4Ec9Xtpab2TmDA7fS+5cgE1EVdXq09IPrfWgOvDuweuldbmgSrbfuOhJQxT2cWn5j1omhqOxrLAsNw7FYDy88UgcTfb6KHp9CLdBmYhsayu/+WpzZhyBVGQIes2hPN3Z0WI/mLbc71Aa3ZR6/lCWWAwGnK/g9ddifPHrpmRcxpq7wIgaYphBmY/JnR7VvcPTHaPr0xfikquss2DMrHDpITGCyqjiSeGmCoUpY6jdmoCP3VMaFIIH4Nv7J0qR4w1WNRiDM2MAjtAsXQ6VRYIIucEAXE+9NLHuY30jmiQXoA/q9CVHtIX7uGQ9kHs4msx35rv+GKngSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5DZ5PSGz/K3YWOTOIwU/amqFCuRTH+XjOHackMxr48=;
 b=p/vEv+O+/pi7QLtKAUPUlbV+kTKmB4cI+I6it+mQwexZfxbOxJGeb+O+O7Qb1OMyOoHw3a6XV82pYSxUNkS9a8ikDMmTRciMLfCnhwUxPDp2pIiBoqqOnRD8j6K7G2hCMMT+vpTc489KNDn+PSjcDHnyvYlXA2jTOfpb4NDT7BU=
Received: from SA9PR13CA0089.namprd13.prod.outlook.com (2603:10b6:806:23::34)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:55:28 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::d) by SA9PR13CA0089.outlook.office365.com
 (2603:10b6:806:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Aaron Williams
	<awilliams@marvell.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Anastasiia Lukianenko
	<vicooodin@gmail.com>, Anatolij Gustschin <agust@denx.de>, Andre Przywara
	<andre.przywara@arm.com>, Biju Das <biju.das.jz@bp.renesas.com>, Bin Meng
	<bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>, "Daniel
 Schwierzeck" <daniel.schwierzeck@gmail.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Doug Zobel
	<douglas.zobel@climate.com>, Dragan Simic <dsimic@manjaro.org>, Eddie James
	<eajames@linux.ibm.com>, Elon Zhang <zhangzj@rock-chips.com>, Enrico Leto
	<enrico.leto@siemens.com>, Eugen Hristev <eugen.hristev@collabora.com>,
	"Fabio Estevam" <festevam@gmail.com>, Francis Laniel
	<francis.laniel@amarulasolutions.com>, Gatien Chevallier
	<gatien.chevallier@foss.st.com>, Gregory CLEMENT
	<gregory.clement@bootlin.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
	Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>,
	"Jagan Teki" <jagan@edgeble.ai>, Johan Jonker <jbx6244@gmail.com>, John Clark
	<inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Joshua Riek
	<jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
	Lukasz Majewski <lukma@denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Marek Vasut
	<marek.vasut+renesas@mailbox.org>, Masahisa Kojima
	<kojima.masahisa@socionext.com>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Matthias Winker
	<matthias.winker@de.bosch.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Minda Chen <minda.chen@starfivetech.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
	<iwamatsu@nigauri.org>, Oleksandr Andrushchenko
	<oleksandr_andrushchenko@epam.com>, Oleksandr Suvorov
	<oleksandr.suvorov@foundries.io>, Oliver Graute
	<oliver.graute@kococonnector.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Pawe=C5=82=20Jarosz?= <paweljarosz3691@gmail.com>, Peng Fan
	<peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, "Philip
 Oberfichtner" <pro@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>, Rasmus Villemoes
	<rasmus.villemoes@prevas.dk>, Sean Anderson <sean.anderson@seco.com>, "Sean
 Anderson" <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>, Shiji Yang <yangshiji66@outlook.com>,
	Simon Glass <sjg@chromium.org>, Stefan Herbrechtsmeier
	<stefan.herbrechtsmeier@weidmueller.com>, Stefan Roese <sr@denx.de>, "Stefano
 Babic" <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tim Lunn <tim@feathertop.org>, Tom Fitzhenry
	<tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>, Viacheslav Bocharov
	<adeep@lexina.in>, Vignesh R <vigneshr@ti.com>, Yanhong Wang
	<yanhong.wang@starfivetech.com>, "open list:VIM3" <u-boot-amlogic@groups.io>,
	"moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/5] Kconfig: some cleanups
Date: Tue, 16 Apr 2024 08:55:14 +0200
Message-ID: <cover.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9553; i=michal.simek@amd.com; h=from:subject:message-id; bh=m7spHwnmbiPgeOtYbeW9ZYmv9HSXpTS+QISw8lgczBI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hSshcv/Wfl8yPe91ttHXFSzRe4X6/pVeac1Nvsez2 8/mlqZFRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIZEuG+XUSesvStB3v5hqY Py7rTXoe8mfNE4aZjBNyknyYiizSphm9rnc/HXUz6tp8AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd4435a-03e1-44b7-5d66-08dc5de232c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yo7t2K/U8wK8UiqYmBpByulr2/CifiBsDiZZ5DihYHvN9es1VLwGcaT2CCByWbA+kWzCUAawmFu9Fuz8U8gfistt5Crh6qxUkXkczkeH2C/SFPAeLYcJQa3KHE5jSiicjkEDGtrBQFEOihjOhWE0SED3MkMLD9X/vXRS0L4uABPHtSrFsRktCPkV2KjnDVbsiW2rk6K4gv5bJn4abCW7BBrfhxLEQAdfbWN+6ktHxgeNR55ps83u9J+Rz6+BS4/Edq4PLfZSYBG2b3Vvbgl2gfIGQhEy97LKAirz2ILvDW+NTn1kjtR8n8gjap2badhf0g2XIznPe7g+THZQe8tueaYLgJAljKXCY9IOYQZc17mii0uKq6B1Huw7/v74ZY/3EgSVLSwcOLUrVisxJ0B0pHLauOIqEdQuptW/S6b8C698yzgeEbttuLnJSqiefZ1i/58LOp/AeH70SOcH8xPeYyFLJJ1eKlSRmxOq13dllUOdHzbDdthtT7K7WpnR+8foAdK1ftkkcAOiqbvlca3WhMhOuI2wWskAMOvpFKd5iqxrFcq1MDfMu0Qhx19vxTl9mHNma0EBfF0sXKRESmnuyVo0/pI0Ir69PCZD7MsKil6g1capXrzB0AuUYjEb5ymiKfmw2KZWDWT438IxQehfBde7fpvFbAA8nGoPRbZlGfYfbP6eaY+ku2e89gYMeE0Kiyg3CRuNcZtSYwvbJlgPQ8l+HY2XYoMNqPRk4ERMJlFq3tFsGA+3zV+uQgFY9/cqbZEeVUVXYqTfNC7WxY6G2Fbe3nbPkDKIaLlYsxeaDs8=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004)(32650700005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:27.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd4435a-03e1-44b7-5d66-08dc5de232c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 17:00:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2270

I looked as cleaning up some dependencies and I found that qconfig is
reporting some issues. This series is fixing some of them. But there are
still some other pending. That's why please go and fix them if they are
related to your board.

UTF-8: I am using uni2ascii -B < file to do conversion. When you run it in
a loop you will find some other issue with copyright chars or some issues
in files taken from the Linux kernel like DTs. They should be likely fixed
in the kernel first.
Based on discussion I am ignoring names too.

Thanks,
Michal

drivers/pinctrl/intel/Kconfig:12: warning: style: quotes recommended around=
 'n' in 'bool n'
warning: the choice symbol CPU_ARCEM6 (defined at arch/arc/Kconfig:46) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - TARGET_EMSDP (defined at arch/arc/Kconfig:173)
 - TARGET_IOT_DEVKIT (defined at arch/arc/Kconfig:180)
warning: the choice symbol ARC_MMU_ABSENT (defined at arch/arc/Kconfig:77) =
is selected by the following symbols, but select/imply has no effect on cho=
ice symbols
 - CPU_ARCEM6 (defined at arch/arc/Kconfig:46)
 - CPU_ARCHS36 (defined at arch/arc/Kconfig:53)
warning: the choice symbol ARC_MMU_V2 (defined at arch/arc/Kconfig:82) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARC750D (defined at arch/arc/Kconfig:32)
warning: the choice symbol ARC_MMU_V3 (defined at arch/arc/Kconfig:89) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARC770D (defined at arch/arc/Kconfig:39)
warning: the choice symbol ARC_MMU_V4 (defined at arch/arc/Kconfig:97) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARCHS38 (defined at arch/arc/Kconfig:60)
warning: the choice symbol FSP_VERSION2 (defined at arch/x86/Kconfig:396) i=
s selected by the following symbols, but select/imply has no effect on choi=
ce symbols
 - INTEL_APOLLOLAKE (defined at arch/x86/cpu/apollolake/Kconfig:6)
warning: the choice symbol SPL_RISCV_MMODE (defined at arch/riscv/Kconfig:1=
84) is implied by the following symbols, but select/imply has no effect on =
choice symbols
 - BOARD_SPECIFIC_OPTIONS (defined at board/bsh/imx8mn_smm_s2/Kconfig:21, b=
oard/bsh/imx8mn_smm_s2/Kconfig:41, board/engicam/px30_core/Kconfig:12, boar=
d/theobroma-systems/ringneck_px30/Kconfig:12, board/radxa/rockpi4-rk3399/Kc=
onfig:12, board/theobroma-systems/puma_rk3399/Kconfig:12, board/theobroma-s=
ystems/jaguar_rk3588/Kconfig:12, board/edgeble/neural-compute-module-2/Kcon=
fig:12, board/itead/sonoff-ihost/Kconfig:12, board/emulation/qemu-arm/Kconf=
ig:6, board/emulation/qemu-arm/Kconfig:22, board/freescale/ls1012aqds/Kconf=
ig:27, board/freescale/ls1012ardb/Kconfig:27, board/freescale/ls1012ardb/Kc=
onfig:76, board/freescale/ls1012afrdm/Kconfig:27, board/advantech/som-db580=
0-som-6867/Kconfig:18, board/congatec/conga-qeval20-qa3-e3845/Kconfig:17, b=
oard/coreboot/coreboot/Kconfig:15, board/dfi/dfi-bt700/Kconfig:17, board/ef=
i/efi-x86_app/Kconfig:12, board/efi/efi-x86_payload/Kconfig:15, board/emula=
tion/qemu-x86/Kconfig:16, board/google/chromebook_coral/Kconfig:18, board/g=
oogle/chromebook_link/Kconfig:19, board/google/chromebox_panther/Kconfig:19=
, board/google/chromebook_samus/Kconfig:19, board/intel/bayleybay/Kconfig:1=
5, board/intel/cherryhill/Kconfig:15, board/intel/cougarcanyon2/Kconfig:15,=
 board/intel/crownbay/Kconfig:15, board/intel/edison/Kconfig:24, board/inte=
l/galileo/Kconfig:15, board/intel/minnowmax/Kconfig:15, board/intel/slimboo=
tloader/Kconfig:19, board/AndesTech/ae350/Kconfig:34, board/emulation/qemu-=
riscv/Kconfig:32, board/microchip/mpfs_icicle/Kconfig:19, board/openpiton/r=
iscv64/Kconfig:26, board/sifive/unleashed/Kconfig:26, board/sifive/unmatche=
d/Kconfig:26, board/sipeed/maix/Kconfig:30, board/sophgo/milkv_duo/Kconfig:=
24, board/starfive/visionfive2/Kconfig:26, board/thead/th1520_lpi4a/Kconfig=
:30, board/xilinx/mbv/Kconfig:22, board/keymile/km83xx/Kconfig:34, board/ke=
ymile/km83xx/Kconfig:54, board/keymile/km83xx/Kconfig:74, board/keymile/km8=
3xx/Kconfig:93, board/keymile/km83xx/Kconfig:112, board/keymile/km83xx/Kcon=
fig:131, board/keymile/km83xx/Kconfig:150, board/keymile/kmcent2/Kconfig:12=
, board/keymile/pg-wcom-ls102xa/Kconfig:15, board/keymile/pg-wcom-ls102xa/K=
config:35)
warning: the choice symbol SYS_BIG_ENDIAN (defined at arch/Kconfig:528) is =
selected by the following symbols, but select/imply has no effect on choice=
 symbols
 - ARC (defined at arch/Kconfig:53)
warning: the choice symbol SYS_LITTLE_ENDIAN (defined at arch/Kconfig:532) =
is selected by the following symbols, but select/imply has no effect on cho=
ice symbols
 - ARC (defined at arch/Kconfig:53)
warning: the choice symbol OF_SEPARATE (defined at dts/Kconfig:108) is sele=
cted by the following symbols, but select/imply has no effect on choice sym=
bols
 - ARCH_MVEBU (defined at arch/arm/Kconfig:620)
 - ARCH_SNAPDRAGON (defined at arch/arm/Kconfig:1074)
 - ARCH_SUNXI (defined at arch/arm/Kconfig:1143)
 - ARCH_S5P4418 (defined at arch/arm/mach-nexell/Kconfig:3)
warning: the choice symbol MULTI_DTB_FIT_USER_DEFINED_AREA (defined at dts/=
Kconfig:242) is implied by the following symbols, but select/imply has no e=
ffect on choice symbols
 - RZG2L (defined at arch/arm/mach-renesas/Kconfig:70)
 - TARGET_BEACON_RZG2M (defined at arch/arm/mach-renesas/Kconfig.rcar3:82)
 - TARGET_HIHOPE_RZG2 (defined at arch/arm/mach-renesas/Kconfig.rcar3:130)
 - TARGET_SALVATOR_X (defined at arch/arm/mach-renesas/Kconfig.rcar3:149)
 - TARGET_ULCB (defined at arch/arm/mach-renesas/Kconfig.rcar3:160)
warning: the choice symbol SYS_NAND_SOFT_ECC (defined at drivers/mtd/nand/r=
aw/Kconfig:184) is selected by the following symbols, but select/imply has =
no effect on choice symbols
 - NAND_SANDBOX (defined at drivers/mtd/nand/raw/Kconfig:450)
warning: the choice symbol USB_ULPI_VIEWPORT (defined at drivers/usb/ulpi/K=
config:11) is selected by the following symbols, but select/imply has no ef=
fect on choice symbols
 - USB_EHCI_MSM (defined at drivers/usb/host/Kconfig:263)
warning: the choice symbol LIB_RAND (defined at lib/Kconfig:275) is selecte=
d by the following symbols, but select/imply has no effect on choice symbol=
s
 - CMD_LINK_LOCAL (defined at cmd/Kconfig:1994)
warning: the choice symbol EFI_APP (defined at lib/efi/Kconfig:15) is selec=
ted by the following symbols, but select/imply has no effect on choice symb=
ols
 - TARGET_EFI_APP32 (defined at board/efi/Kconfig:7)
 - TARGET_EFI_APP64 (defined at board/efi/Kconfig:16)


Changes in v2:
- Describe temperature as deg C instead of just C
- Update commit message to explain the reason
- New patch in series

Michal Simek (5):
  Kconfig: Remove trailing whitespace in its prompt
  Kconfig: Add missing quotes around source file
  Kconfig: Add missing quotes around default string value
  Kconfig: Make all Kconfig encoding ascii
  common: Convert *.c/h from UTF-8 to ASCII enconfing

 .../armv8/fsl-layerscape/fsl_lsch2_serdes.c   |  2 +-
 .../armv8/fsl-layerscape/fsl_lsch3_serdes.c   |  2 +-
 arch/arm/mach-imx/ddrmc-vf610-calibration.c   | 12 +++++-----
 arch/arm/mach-imx/mx6/clock.c                 |  8 +++----
 arch/arm/mach-imx/mx7/psci-mx7.c              |  4 ++--
 arch/arm/mach-rockchip/px30/Kconfig           |  4 ++--
 arch/arm/mach-rockchip/rk3588/Kconfig         | 24 +++++++++----------
 arch/arm/mach-rockchip/rv1108/Kconfig         |  4 ++--
 arch/arm/mach-rockchip/rv1126/Kconfig         |  8 +++----
 arch/mips/mach-mscc/include/mach/ddr.h        |  2 +-
 .../include/mach/cvmx-helper-pki.h            |  2 +-
 arch/mips/mach-octeon/include/mach/cvmx-pki.h |  6 ++---
 .../mips/mach-octeon/include/mach/cvmx-pko3.h |  2 +-
 board/CZ.NIC/turris_mox/turris_mox.c          |  2 +-
 board/amlogic/vim3/vim3.c                     |  2 +-
 board/bosch/acc/acc.c                         |  2 +-
 board/bosch/shc/board.c                       |  2 +-
 board/bosch/shc/board.h                       |  2 +-
 board/congatec/cgtqmx8/cgtqmx8.c              |  4 ++--
 board/freescale/common/i2c_mux.c              |  2 +-
 board/siemens/capricorn/board.c               |  8 +++----
 board/st/common/cmd_stboard.c                 |  2 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |  4 ++--
 cmd/Kconfig                                   |  2 +-
 drivers/clk/Kconfig                           | 10 ++++----
 drivers/clk/renesas/rzg2l-cpg.c               |  6 ++---
 drivers/clk/stm32/clk-stm32-core.h            | 22 ++++++++---------
 drivers/crypto/Kconfig                        |  8 +++----
 drivers/ddr/imx/imx8ulp/Kconfig               |  2 +-
 drivers/led/led_lp5562.c                      |  4 ++--
 drivers/mtd/nand/raw/nand_ids.c               |  2 +-
 drivers/mtd/spi/Kconfig                       |  2 +-
 drivers/rng/stm32_rng.c                       |  6 ++---
 drivers/soc/ti/k3-navss-ringacc.c             |  2 +-
 drivers/thermal/thermal_sandbox.c             |  2 +-
 drivers/video/renesas-r61307.c                |  2 +-
 drivers/video/renesas-r69328.c                |  2 +-
 drivers/xen/pvblock.c                         |  2 +-
 include/acpi/acpigen.h                        |  6 ++---
 include/linux/mtd/mtd.h                       |  2 +-
 lib/Kconfig                                   | 18 +++++++-------
 lib/crypto/x509_cert_parser.c                 |  2 +-
 lib/efi_loader/Kconfig                        |  2 +-
 43 files changed, 107 insertions(+), 107 deletions(-)

--=20
2.44.0


