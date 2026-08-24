Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D724C61DC4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11479.1787556836071219243
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 00:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=V9BurB2A;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.201.35, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4BrYapR7mc6oZcVPHVHMaj7h2erG8zU9ydZrBOAf3ZhhGwRx3ALFg8geKwYBxq8U2aRzEMym+AJx2K7P/EZVdmxN/SSfSbnWhRdICIE+ti17AIq/1Borj3Q8PE0WXLsAxNnP+QCxYq+jx5Rxom8YWrj1zRJXvsbJphZ5JSIdo0J0ZHHWfVwH2K6zVtW+l+tjDfe9uyPia83bw0mHeSENvhUpBfmOA7Tn3y3zlCQcs7yEG8XH/c6WK5vyqiZPZ4t7Dfl21wIiTnn7X0Wplxby4M8ymTZqbMoNAWSN//cz/jj6vuXtn27+ZJ1J8UDODm/af3IayVFGuLWx7Vputlavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA954YrXKR/ExNsgxVI27AcpfZ1l80aaoiMArfEG30U=;
 b=QXpLdfoPjqVkxjj1QmbTo5sreB1lTnftyYzEvEX0SOn/U3yEov/3LWNQw4Fu4j5OmeML4cA2Nw7k9/1+mIqOGVEyQe73mnhvAVHRkLuouH02glTj0Mql4XzrxaoIJL40cLULqwM21pdMg5hhdY+3o1W/wWL+3/2QesFPRNAEcm5fVMLsZVXCRv5a5adhwWovZebTQPkS2r1aZ/ifv/xq4FC/e5bcq/H/l0P6/+wDSi50t4ZItsdhwZKRG+IhQvCCBy0iejYKHqnPV1W8410pa7vSDhWk3091DaPVkZGEQ5/gPXPVHArlOeB+ItuUpDVDwCbAnCScAzZBsKdUG70O8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA954YrXKR/ExNsgxVI27AcpfZ1l80aaoiMArfEG30U=;
 b=V9BurB2A1jFjpo48tNjhw7mFASyWy5G/f49KBqXVtIJG39Vsc00tjlYaQuJXyCTwunN4bBXdy4umjcTE19KjYSdFUAwyGYdtwjeEif3LyMszPILqqEWG2ZzRmjCO/QaEWjTqGJ7Ew/ShDzYkK9IoAfEtqQIXWqiEOf0+w3aNkHk=
Received: from MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 07:19:28 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::d) by MW4PR03CA0200.outlook.office365.com
 (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:19:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:25 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:19:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Tom Rini
	<trini@konsulko.com>
CC: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
	Alban Bedel <alban.bedel@avionic-design.de>, Alif Zakuan Yuslaimi
	<alif.zakuan.yuslaimi@altera.com>, Allen Martin <amartin@nvidia.com>, Andre
 Przywara <andre.przywara@arm.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, Bryan
 Brattlof <bb@ti.com>, Casey Connolly <casey.connolly@linaro.org>, Chee Hong
 Ang <chee.hong.ang@intel.com>, Chee Tien Fong <tien.fong.chee@intel.com>,
	Chin-Liang See <chin.liang.see@intel.com>, Chris Packham
	<chris.packham@alliedtelesis.co.nz>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, "Cogent Embedded, Inc."
	<source@cogentembedded.com>, David Lechner <dlechner@baylibre.com>, Dinh
 Nguyen <dinh.nguyen@intel.com>, Dominik Haller <d.haller@phytec.de>, Dzmitry
 Sankouski <dsankouski@gmail.com>, =?UTF-8?q?Eric=20B=C3=A9nard?=
	<eric@eukrea.com>, Eugen Hristev <ehristev@kernel.org>, Fabio Estevam
	<festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, GSS_MTK_Uboot_upstream
	<GSS_MTK_Uboot_upstream@mediatek.com>, Garrett Giordano
	<ggiordano@phytec.com>, Gilles Talis <gilles.talis@gmail.com>, Green Wan
	<green.wan@sifive.com>, Hans de Goede <hdegoede@redhat.com>, Heiko Schocher
	<hs@nabladev.com>, Holger Brunck <holger.brunck@hitachienergy.com>, Ian Ray
	<ian.ray@gehealthcare.com>, Igor Belwon
	<igor.belwon@mentallysanemainliners.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Jan
 Kiszka <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, =?UTF-8?q?Jonas=20Schw=C3=B6bel?=
	<jonasschwoebel@yahoo.de>, Jorge Ramirez-Ortiz
	<jorge.ramirez.ortiz@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
	Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>, Ley Foon
 Tan <ley.foon.tan@intel.com>, Lim Siew Chin <elly.siew.chin.lim@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Marek Vasut
	<marek.vasut+socfpga@mailbox.org>, Martyn Welch <martyn.welch@collabora.com>,
	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>, Mathew McBride
	<matt@traverse.com.au>, Matthias Winker <matthias.winker@de.bosch.com>,
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Meenakshi Aggarwal
	<meenakshi.aggarwal@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, NXP i.MX
 U-Boot Team <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Oliver Graute
	<oliver.graute@kococonnector.com>, Parthiban Nallathambi
	<parthiban@linumiz.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan
	<peng.fan@nxp.com>, Peter Geis <pgwipeout@gmail.com>, Peter Robinson
	<pbrobinson@gmail.com>, "maintainer:TK1-SOM BOARD"
	<Peter.Chubb@data61.csiro.au>, Philip Oberfichtner <pro@denx.de>, Pramod
 Kumar <pramod.kumar_1@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
	Quentin Schulz <u-boot@0leil.net>, Randolph <randolph@andestech.com>, Ryder
 Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>, Sam Shih
	<sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, Simon Glass
	<sjg@chromium.org>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
	Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>,
	Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Stefano Babic
	<sbabic@nabladev.com>, Stelian Pop <stelian@popies.net>, Stephan Gerhold
	<stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel
	<clamor95@gmail.com>, Teresa Remmet <t.remmet@phytec.de>, Tien Fong Chee
	<tien.fong.chee@altera.com>, Tim Harvey <tharvey@gateworks.com>, Tom Warren
	<twarren@nvidia.com>, Tony Dinh <mibodhi@gmail.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Wasim Khan
	<wasim.khan@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>, Zubair Lutfullah Kakakhel
	<Zubair.Kakakhel@imgtec.com>, "open list:P212" <u-boot-amlogic@groups.io>,
	"open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>, "open
 list:phyCORE-AM62ax" <upstream@lists.phytec.de>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Date: Mon, 24 Aug 2026 09:18:48 +0200
Message-ID: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787555916.git.michal.simek@amd.com>
References: <cover.1787555916.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=75883; i=michal.simek@amd.com; h=from:subject:message-id; bh=zEQuNauLBP3gCk8CmbKhYEDsXEfsS0y7SlyR5FKeg3s=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f0gribS8ydpq+b1i64xVXgsnTTV6k+yx78cJzQm++ cvK7p+X6ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJzLdk+GehWWHI9ib2a6Ku 0emzzmKr/8m73WB2WSRceHpR87GZj7Yx/NOVT9tdp7HYUDC4zP7mwkg5l9a85p58cd9O/wUCp4/ M5wcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3821c0dd-08ff-4dcf-44dc-08df01b00871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|30052699003|376014|36860700016|1800799024|13003099007|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	SsHv95pFGXRi+1t6h9m10pqFYpO++7//7M5kwmX8ZjrE5IgsxGw0yTlyUFTTLJwBOFjX0ysBi2cYwV5/5uHaUj/rSF2WEAReSd0zNlGRCuOXdMN9gY5uT19B6TaXnwYfAd+3sRkmqEwxrmSQOMjqwZBrrQB6aEB5ivE9DFrzErqextBm0fc8xl72FhMg/oebyWt+r+EWJ1XgSbfkkh0YAArU91/qVvUrmFrftGocshgg3DTbNNejDonUFWsvXFh2r5BEk8xH30pJXHVnOIw6OLYCmc+9x36AVWza6PyClEx/AULjLU2nkmbiIGzVH/1ozl/XSzT36w7BBW5yqPhRnnVJiwKIQUgytK9yhmJXp18cutCJ3MoD+uqi9Z+1Neo6OAIE8Mr1GlsPOo3arEy6NXhb4T2LBr8EO3XV8GG6/Hj55Hr3qn+v08yzRmMedZOD0LQRTqt2feLZ9IW7jrL9WDlz7leFWbDqpN2M2aaSt0n7jhwhJvUUaHdq7VzYZLpaeeEP3pkGG5kO3Pb7yiH6el9RyoEPMsi0pFh6AEaS+9mJ7tKI/onGyhWxPvEpwFfzfhJ5D1viH2EK24lICS1bAYQP1tjRoXUQC6t/3iTl3bheWBEZ4TkKzqbmOMbCyteiDK8ehoaTGdoqEF0KbAd99k9WRwcG5C98ZyvzqofVM/4=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(30052699003)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oGyq2xb0Y+f5fj7oZn4ltoD2gstNZn28cFfL4tH69qzHwZugbP0ImM4TJ8k8G/255ikN0dGtoI5ppcQk77SNZA5/kN0VUMRe9lVOw84WFPD1AknEzqmL6y0qezfU8TcxzI3CiUBTb9rLVhcrxq2H1i80yC1W2Pd2+z7WGnOTiW0wSTu2vMQHjZdZIBKSabIzrFY11Dz0goGqAITLxmdZtdUBgOlVud/SoRnlJU0w4fpN7nVPrjIg0zpOmzNlVMQBPDh0VTYmruQJLqUYimwSGjAMSrcqUh8VN3n5MC/Y/BRpMYcny4DWaUEnLwihVx8uPoE2/x8jlbcgKElZQWPpS7MMeSnZKdMrQOHB3pYaXriyMlTyARYTfTiKt0X38LL+DMehYERmDmRl1t4a8g4PbcBINF97v69FRFAhI5YA4tht5z1zov2V4Uy/G6gTPYjv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:19:27.6168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3821c0dd-08ff-4dcf-44dc-08df01b00871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3046

A number of file (F:) entries across the MAINTAINERS files pointed to
files or directories which had been renamed or removed over time. Drop
these stale references so that every F: entry resolves to an existing
path.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
 board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
 board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
 board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
 board/Marvell/octeontx/MAINTAINERS                |  2 --
 board/Marvell/octeontx2/MAINTAINERS               |  2 --
 board/Synology/ds116/MAINTAINERS                  |  1 -
 board/acer/picasso/MAINTAINERS                    |  1 -
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
 board/altera/stratix10-socdk/MAINTAINERS          |  1 -
 board/amlogic/p212/MAINTAINERS                    |  1 -
 board/amlogic/q200/MAINTAINERS                    |  1 -
 board/amlogic/s400/MAINTAINERS                    |  1 -
 board/andestech/voyager/MAINTAINERS               |  1 -
 board/asus/grouper/MAINTAINERS                    |  1 -
 board/asus/transformer-t114/MAINTAINERS           |  1 -
 board/asus/transformer-t20/MAINTAINERS            |  1 -
 board/asus/transformer-t30/MAINTAINERS            |  1 -
 board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
 board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
 board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
 board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
 board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
 board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
 board/avionic-design/plutux/MAINTAINERS           |  1 -
 board/avionic-design/tec-ng/MAINTAINERS           |  1 -
 board/avionic-design/tec/MAINTAINERS              |  1 -
 board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
 board/bosch/acc/MAINTAINERS                       |  1 -
 board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
 board/compal/paz00/MAINTAINERS                    |  1 -
 board/compulab/trimslice/MAINTAINERS              |  1 -
 board/comtrend/vr3032u/MAINTAINERS                |  1 -
 board/comtrend/wap5813n/MAINTAINERS               |  1 -
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
 board/davinci/da8xxevm/MAINTAINERS                |  1 -
 board/embest/mx6boards/MAINTAINERS                |  1 -
 board/engicam/imx6ul/MAINTAINERS                  |  3 ---
 board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
 board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
 board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
 board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
 board/ge/bx50v3/MAINTAINERS                       |  3 ---
 board/htc/endeavoru/MAINTAINERS                   |  1 -
 board/imgtec/xilfpga/MAINTAINERS                  |  1 -
 board/intel/agilex-socdk/MAINTAINERS              |  1 -
 board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
 board/intel/n5x-socdk/MAINTAINERS                 |  1 -
 board/keymile/km83xx/MAINTAINERS                  |  2 --
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
 board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
 board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
 board/lg/x3-t30/MAINTAINERS                       |  1 -
 board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
 board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
 board/mediatek/mt7981/MAINTAINERS                 |  2 --
 board/mediatek/mt7986/MAINTAINERS                 |  4 ----
 board/microsoft/surface-rt/MAINTAINERS            |  1 -
 board/myir/mys_6ulx/MAINTAINERS                   |  1 -
 board/nvidia/beaver/MAINTAINERS                   |  1 -
 board/nvidia/cardhu/MAINTAINERS                   |  1 -
 board/nvidia/dalmore/MAINTAINERS                  |  1 -
 board/nvidia/harmony/MAINTAINERS                  |  1 -
 board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
 board/nvidia/nyan-big/MAINTAINERS                 |  1 -
 board/nvidia/p2371-0000/MAINTAINERS               |  1 -
 board/nvidia/p2371-2180/MAINTAINERS               |  1 -
 board/nvidia/p2571/MAINTAINERS                    |  1 -
 board/nvidia/p2771-0000/MAINTAINERS               |  1 -
 board/nvidia/p3450-0000/MAINTAINERS               |  1 -
 board/nvidia/seaboard/MAINTAINERS                 |  1 -
 board/nvidia/tegratab/MAINTAINERS                 |  1 -
 board/nvidia/venice2/MAINTAINERS                  |  1 -
 board/nvidia/ventana/MAINTAINERS                  |  1 -
 board/nxp/imx93_evk/MAINTAINERS                   |  1 -
 board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
 board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
 board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
 board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
 board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
 board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
 board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
 board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
 board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
 board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
 board/nxp/lx2160a/MAINTAINERS                     |  2 --
 board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
 board/nxp/mx6slevk/MAINTAINERS                    |  2 --
 board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
 board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
 board/nxp/t208xqds/MAINTAINERS                    |  5 -----
 board/nxp/t208xrdb/MAINTAINERS                    |  1 -
 board/ouya/ouya/MAINTAINERS                       |  1 -
 board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
 board/phytec/phycore_am68x/MAINTAINERS            |  1 -
 board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
 board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
 board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
 board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
 board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
 board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
 board/renesas/blanche/MAINTAINERS                 |  1 -
 board/renesas/eagle/MAINTAINERS                   |  1 -
 board/renesas/grpeach/MAINTAINERS                 |  1 -
 board/renesas/v3msk/MAINTAINERS                   |  1 -
 board/samsung/starqltechn/MAINTAINERS             |  2 --
 board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
 board/siemens/iot2050/MAINTAINERS                 |  1 -
 board/sifive/unmatched/MAINTAINERS                |  1 -
 board/sunxi/MAINTAINERS                           |  2 --
 board/ti/am62ax/MAINTAINERS                       |  1 -
 board/ti/am62dx/MAINTAINERS                       |  1 -
 board/ti/am62px/MAINTAINERS                       |  1 -
 board/ti/j7200/MAINTAINERS                        |  1 -
 board/toradex/apalis-tk1/MAINTAINERS              |  1 -
 board/toradex/apalis_t30/MAINTAINERS              |  2 --
 board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
 board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
 board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
 board/toradex/colibri_t20/MAINTAINERS             |  2 --
 board/toradex/colibri_t30/MAINTAINERS             |  2 --
 board/toradex/colibri_vf/MAINTAINERS              |  1 -
 board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
 board/traverse/ten64/MAINTAINERS                  |  1 -
 board/wandboard/MAINTAINERS                       |  1 -
 board/wexler/qc750/MAINTAINERS                    |  1 -
 board/xiaomi/mocha/MAINTAINERS                    |  1 -
 board/xilinx/zynqmp/MAINTAINERS                   |  1 -
 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
 board/zyxel/nsa325/MAINTAINERS                    |  3 ---
 134 files changed, 241 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rock=
chip/rk3576/MAINTAINERS
index 79cf9e97f70b..62c3ce765e0d 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -13,7 +13,6 @@ F:	configs/nanopi-m5-rk3576_defconfig
 NANOPI-R76S-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
-F:	arch/arm/dts/rk3576-nanopi-r76s*
 F:	configs/nanopi-r76s-rk3576_defconfig
=20
 OMNI3576-RK3576
diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_om=
nia/MAINTAINERS
index effce8a753b4..530ca5b420fc 100644
--- a/board/CZ.NIC/turris_omnia/MAINTAINERS
+++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
@@ -5,5 +5,4 @@ F:	arch/arm/dts/armada-385-turris-omnia*.dts*
 F:	board/CZ.NIC/turris_atsha_otp.*
 F:	board/CZ.NIC/turris_omnia/
 F:	configs/turris_omnia_defconfig
-F:	drivers/gpio/turris_omnia_mcu.c
 F:	include/configs/turris_omnia.h
diff --git a/board/LaCie/net2big_v2/MAINTAINERS b/board/LaCie/net2big_v2/MA=
INTAINERS
index 66e82196794e..41a7f07e4a3d 100644
--- a/board/LaCie/net2big_v2/MAINTAINERS
+++ b/board/LaCie/net2big_v2/MAINTAINERS
@@ -1,12 +1,8 @@
 NET2BIG_V2 BOARD
 M:	Simon Guinot <simon.guinot@sequanux.org>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-d2net.dts
 F:	arch/arm/dts/kirkwood-d2net-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-d2net.dtsi
-F:	arch/arm/dts/kirkwood-net2big.dts
 F:	arch/arm/dts/kirkwood-net2big-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-netxbig.dtsi
 F:	board/LaCie/common/
 F:	board/LaCie/net2big_v2/
 F:	include/configs/lacie_kw.h
diff --git a/board/LaCie/netspace_v2/MAINTAINERS b/board/LaCie/netspace_v2/=
MAINTAINERS
index 03bc7874c164..1e0a50240781 100644
--- a/board/LaCie/netspace_v2/MAINTAINERS
+++ b/board/LaCie/netspace_v2/MAINTAINERS
@@ -1,15 +1,9 @@
 NETSPACE_V2 BOARDS
 M:	Simon Guinot <simon.guinot@sequanux.org>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-is2.dts
 F:	arch/arm/dts/kirkwood-is2-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2-common.dtsi
-F:	arch/arm/dts/kirkwood-ns2.dts
-F:	arch/arm/dts/kirkwood-ns2lite.dts
 F:	arch/arm/dts/kirkwood-ns2lite-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2max.dts
 F:	arch/arm/dts/kirkwood-ns2max-u-boot.dtsi
-F:	arch/arm/dts/kirkwood-ns2mini.dts
 F:	arch/arm/dts/kirkwood-ns2mini-u-boot.dtsi
 F:	arch/arm/dts/kirkwood-ns2-u-boot.dtsi
 F:	board/LaCie/common/
diff --git a/board/Marvell/octeontx/MAINTAINERS b/board/Marvell/octeontx/MA=
INTAINERS
index 1f3b12b1abf2..c66607c01d5a 100644
--- a/board/Marvell/octeontx/MAINTAINERS
+++ b/board/Marvell/octeontx/MAINTAINERS
@@ -2,7 +2,5 @@ OCTEONTX BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx/
-F:	include/configs/octeontx_81xx.h
-F:	include/configs/octeontx_83xx.h
 F:	configs/octeontx_81xx_defconfig
 F:	configs/octeontx_83xx_defconfig
diff --git a/board/Marvell/octeontx2/MAINTAINERS b/board/Marvell/octeontx2/=
MAINTAINERS
index eec1d77dd108..8502c119c352 100644
--- a/board/Marvell/octeontx2/MAINTAINERS
+++ b/board/Marvell/octeontx2/MAINTAINERS
@@ -2,7 +2,5 @@ OCTEONTX2 BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx2/
-F:	include/configs/octeontx2_96xx.h
-F:	include/configs/octeontx2_95xx.h
 F:	configs/octeontx2_96xx_defconfig
 F:	configs/octeontx2_95xx_defconfig
diff --git a/board/Synology/ds116/MAINTAINERS b/board/Synology/ds116/MAINTA=
INERS
index 8d3cc24fbef4..048ec9f10a1d 100644
--- a/board/Synology/ds116/MAINTAINERS
+++ b/board/Synology/ds116/MAINTAINERS
@@ -1,7 +1,6 @@
 DS116 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/armada-385-synology-ds116.dts
 F:	board/Synology/ds116/
 F:	board/Synology/common
 F:	include/configs/ds116.h
diff --git a/board/acer/picasso/MAINTAINERS b/board/acer/picasso/MAINTAINER=
S
index 99f8c0b6d7fa..ab2fe5ebdf5e 100644
--- a/board/acer/picasso/MAINTAINERS
+++ b/board/acer/picasso/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/acer/picasso/
 F:	configs/picasso_defconfig
 F:	doc/board/acer/picasso.rst
-F:	include/configs/picasso.h
diff --git a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS b/board/advantech=
/imx8mp_rsb3720a1/MAINTAINERS
index bc967af4f509..5141b6f6b776 100644
--- a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
+++ b/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
@@ -2,6 +2,5 @@ i.MX8MP RSB3720 BOARD
 M:	Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
 S:	Maintained
 F:	board/advantech/imx8mp_rsb3720a1/
-F:	include/configs/imx8mp_rsb3720a1.h
 F:	configs/imx8mp_rsb3720a1_4G_defconfig
 F:	configs/imx8mp_rsb3720a1_6G_defconfig
diff --git a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS b/board/advantec=
h/imx8qm_dmsse20_a1/MAINTAINERS
index 8292c6ba7122..b1513f98ce97 100644
--- a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
+++ b/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
@@ -2,6 +2,5 @@ i.MX8QM ROM DMSSE20 a1 BOARD
 M:	Oliver Graute <oliver.graute@kococonnector.com>
 S:	Maintained
 F:	board/advantech/imx8qm_dmsse20_a1/
-F:	arch/arm/dts/imx8qm-dmsse20-a1.dtb
 F:	include/configs/imx8qm_dmsse20.h
 F:	configs/imx8qm_dmsse20a1_defconfig
diff --git a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS b/board/alliedteles=
is/SBx81LIFKW/MAINTAINERS
index 31ccec0e9b7e..da184c9d29a5 100644
--- a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
@@ -2,6 +2,5 @@ SBx81LIFKW BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFKW/
-F:	include/configs/SBx81LIFKW
 F:	configs/SBx81LIFKW_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifkw.dts
diff --git a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS b/board/alliedtel=
esis/SBx81LIFXCAT/MAINTAINERS
index 6b722ded250e..8245c56ac80a 100644
--- a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
@@ -2,6 +2,5 @@ SBx81LIFXCAT BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFXCAT/
-F:	include/configs/SBx81LIFXCAT
 F:	configs/SBx81LIFXCAT_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifxcat.dts
diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/strati=
x10-socdk/MAINTAINERS
index 6efd0cfc0560..6192bc917465 100644
--- a/board/altera/stratix10-socdk/MAINTAINERS
+++ b/board/altera/stratix10-socdk/MAINTAINERS
@@ -4,5 +4,4 @@ M:	Dinh Nguyen <dinh.nguyen@intel.com>
 S:	Maintained
 F:	board/altera/stratix10-socdk/
 F:	include/configs/socfpga_stratix10_socdk.h
-F:	configs/socfpga_stratix10_atf_defconfig
 F:	configs/socfpga_stratix10_defconfig
diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINER=
S
index e73a4e52c1fd..004f3885327c 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
-F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/libretech-cc_v2_defconfig
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINER=
S
index aece8d5e05c7..39cff03e66ae 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
-F:	include/configs/q200.h
 F:	configs/beelink-gt1-ultimate_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINER=
S
index ca51bb6b3ba1..60ea339097ca 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
-F:	include/configs/s400.h
 F:	configs/s400_defconfig
 F:	doc/board/amlogic/s400.rst
diff --git a/board/andestech/voyager/MAINTAINERS b/board/andestech/voyager/=
MAINTAINERS
index b87026ee383b..c64d2d135f9d 100644
--- a/board/andestech/voyager/MAINTAINERS
+++ b/board/andestech/voyager/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/andestech/voyager/
 F:	configs/voyager_spl_defconfig
 F:	doc/board/andestech/voyager.rst
-F:	include/configs/qilai.h
=20
diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAINER=
S
index 3c59632451ff..6a54389c74ec 100644
--- a/board/asus/grouper/MAINTAINERS
+++ b/board/asus/grouper/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/asus/grouper/
 F:	configs/grouper_defconfig
 F:	doc/board/asus/grouper.rst
-F:	include/configs/grouper.h
diff --git a/board/asus/transformer-t114/MAINTAINERS b/board/asus/transform=
er-t114/MAINTAINERS
index 2e8f01b98df2..01692fd29af7 100644
--- a/board/asus/transformer-t114/MAINTAINERS
+++ b/board/asus/transformer-t114/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra114-asus-tf701t.dts
 F:	board/asus/transformer-t114/
 F:	configs/tf701t_defconfig
 F:	doc/board/asus/transformer_t114.rst
-F:	include/configs/transformer-t114.h
diff --git a/board/asus/transformer-t20/MAINTAINERS b/board/asus/transforme=
r-t20/MAINTAINERS
index 7bf93570985f..28b8f954e7c6 100644
--- a/board/asus/transformer-t20/MAINTAINERS
+++ b/board/asus/transformer-t20/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra20-asus-*
 F:	board/asus/transformer-t20/
 F:	configs/transformer_t20_defconfig
 F:	doc/board/asus/transformer_t20.rst
-F:	include/configs/transformer-t20.h
diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transforme=
r-t30/MAINTAINERS
index 869cc5aeb910..3fdcdd7c027a 100644
--- a/board/asus/transformer-t30/MAINTAINERS
+++ b/board/asus/transformer-t30/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/asus/transformer-t30/
 F:	configs/transformer_t30_defconfig
 F:	doc/board/asus/transformer_t30.rst
-F:	include/configs/transformer-t30.h
diff --git a/board/atmel/at91sam9260ek/MAINTAINERS b/board/atmel/at91sam926=
0ek/MAINTAINERS
index aa7898ef7469..28b11243feb5 100644
--- a/board/atmel/at91sam9260ek/MAINTAINERS
+++ b/board/atmel/at91sam9260ek/MAINTAINERS
@@ -9,7 +9,6 @@ F:	configs/at91sam9260ek_nandflash_defconfig
 F:	configs/at91sam9g20ek_2mmc_nandflash_defconfig
 F:	configs/at91sam9g20ek_dataflash_cs0_defconfig
 F:	configs/at91sam9g20ek_dataflash_cs1_defconfig
-F:	configs/at91sam9g20ek_mmc_defconfig
 F:	configs/at91sam9g20ek_2mmc_defconfig
 F:	configs/at91sam9g20ek_nandflash_defconfig
 F:	configs/at91sam9xeek_dataflash_cs0_defconfig
diff --git a/board/atmel/sama5d29_curiosity/MAINTAINERS b/board/atmel/sama5=
d29_curiosity/MAINTAINERS
index 54894d6cbb68..4b467fa96f99 100644
--- a/board/atmel/sama5d29_curiosity/MAINTAINERS
+++ b/board/atmel/sama5d29_curiosity/MAINTAINERS
@@ -1,7 +1,6 @@
 SAMA5D29 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama5d29_curiosity.c
 F:     include/configs/sama5d29_curiosity.h
 F:     configs/sama5d29_curiosity_mmc_defconfig
 F:     configs/sama5d29_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7d65_curiosity/MAINTAINERS b/board/atmel/sama7=
d65_curiosity/MAINTAINERS
index 054af3c65416..2a25d03e899f 100644
--- a/board/atmel/sama7d65_curiosity/MAINTAINERS
+++ b/board/atmel/sama7d65_curiosity/MAINTAINERS
@@ -1,6 +1,5 @@
 SAMA7D65 CURIOSITY BOARD
 M:     Ryan Wanner <ryan.wanner@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7d65_curiosity.c
 F:     include/configs/sama7d65_curiosity.h
 F:     configs/sama7d65_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7g54_curiosity/MAINTAINERS b/board/atmel/sama7=
g54_curiosity/MAINTAINERS
index b9f1a271c09c..a31ec3ca4350 100644
--- a/board/atmel/sama7g54_curiosity/MAINTAINERS
+++ b/board/atmel/sama7g54_curiosity/MAINTAINERS
@@ -1,7 +1,6 @@
 SAMA7G54 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7g54_curiosity.c
 F:     include/configs/sama7g54_curiosity.h
 F:     configs/sama7g54_curiosity_mmc_defconfig
 F:     configs/sama7g54_curiosity_nandflash_defconfig
diff --git a/board/atmel/sama7g5ek/MAINTAINERS b/board/atmel/sama7g5ek/MAIN=
TAINERS
index 4d1c6f666c0b..f72c4204025a 100644
--- a/board/atmel/sama7g5ek/MAINTAINERS
+++ b/board/atmel/sama7g5ek/MAINTAINERS
@@ -1,7 +1,6 @@
 SAMA7G5 EK BOARD
 M:     Eugen Hristev <ehristev@kernel.org>
 S:     Maintained
-F:     board/atmel/sama7g5ek.c
 F:     include/configs/sama7g5ek.h
 F:     configs/sama7g5ek_mmc1_defconfig
 F:     configs/sama7g5ek_mmc_defconfig
diff --git a/board/avionic-design/medcom-wide/MAINTAINERS b/board/avionic-d=
esign/medcom-wide/MAINTAINERS
index 3d2cdeca7259..c0f75035be9f 100644
--- a/board/avionic-design/medcom-wide/MAINTAINERS
+++ b/board/avionic-design/medcom-wide/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/medcom-wide/
 F:	board/avionic-design/common/
-F:	include/configs/medcom-wide.h
 F:	configs/medcom-wide_defconfig
diff --git a/board/avionic-design/plutux/MAINTAINERS b/board/avionic-design=
/plutux/MAINTAINERS
index 0275680d21f2..0b76fd5348cf 100644
--- a/board/avionic-design/plutux/MAINTAINERS
+++ b/board/avionic-design/plutux/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/plutux/
 F:	board/avionic-design/common/
-F:	include/configs/plutux.h
 F:	configs/plutux_defconfig
diff --git a/board/avionic-design/tec-ng/MAINTAINERS b/board/avionic-design=
/tec-ng/MAINTAINERS
index 645be8186aa6..36bd28b7cd90 100644
--- a/board/avionic-design/tec-ng/MAINTAINERS
+++ b/board/avionic-design/tec-ng/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec-ng/
 F:	board/avionic-design/common/
-F:	include/configs/tec-ng.h
 F:	configs/tec-ng_defconfig
diff --git a/board/avionic-design/tec/MAINTAINERS b/board/avionic-design/te=
c/MAINTAINERS
index 36088e7daccf..b1fa0eff7755 100644
--- a/board/avionic-design/tec/MAINTAINERS
+++ b/board/avionic-design/tec/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec/
 F:	board/avionic-design/common/
-F:	include/configs/tec.h
 F:	configs/tec_defconfig
diff --git a/board/beacon/beacon-rzg2m/MAINTAINERS b/board/beacon/beacon-rz=
g2m/MAINTAINERS
index a4a920a017b0..b28272c58ee0 100644
--- a/board/beacon/beacon-rzg2m/MAINTAINERS
+++ b/board/beacon/beacon-rzg2m/MAINTAINERS
@@ -7,9 +7,6 @@ F:	include/configs/beacon-rzg2m.h
 F:	configs/rzg2_beacon_defconfig
 F:	arch/arm/dts/beacon-renesom-baseboard.dtsi
 F:	arch/arm/dts/beacon-renesom-som.dtsi
-F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
-F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts
-F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
 F:	arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
 F:	arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
 F:	arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
diff --git a/board/bosch/acc/MAINTAINERS b/board/bosch/acc/MAINTAINERS
index 1b880037121f..d6001d824951 100644
--- a/board/bosch/acc/MAINTAINERS
+++ b/board/bosch/acc/MAINTAINERS
@@ -6,4 +6,3 @@ F:	board/bosch/acc
 F:	include/configs/imx6q-bosch-acc.h
 F:	configs/imx6q_bosch_acc_defconfig
 F:	arch/arm/dts/imx6q-bosch-acc.dts
-F:	arch/arm/dts/imx6q-bosch-acc-u-boot.dts
diff --git a/board/cei/cei-tk1-som/MAINTAINERS b/board/cei/cei-tk1-som/MAIN=
TAINERS
index f1817401a5df..20affd32d424 100644
--- a/board/cei/cei-tk1-som/MAINTAINERS
+++ b/board/cei/cei-tk1-som/MAINTAINERS
@@ -2,5 +2,4 @@ TK1-SOM BOARD
 M:	Peter.Chubb@data61.csiro.au
 S:	Maintained
 F:	board/cei/cei-tk1-som/
-F:	include/configs/cei-tk1-som.h
 F:	configs/cei-tk1-som_defconfig
diff --git a/board/compal/paz00/MAINTAINERS b/board/compal/paz00/MAINTAINER=
S
index ba174cd190db..477ef604a82e 100644
--- a/board/compal/paz00/MAINTAINERS
+++ b/board/compal/paz00/MAINTAINERS
@@ -2,5 +2,4 @@ PAZ00 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compal/paz00/
-F:	include/configs/paz00.h
 F:	configs/paz00_defconfig
diff --git a/board/compulab/trimslice/MAINTAINERS b/board/compulab/trimslic=
e/MAINTAINERS
index 4eb868c0c838..da557f8e1083 100644
--- a/board/compulab/trimslice/MAINTAINERS
+++ b/board/compulab/trimslice/MAINTAINERS
@@ -2,5 +2,4 @@ TRIMSLICE BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compulab/trimslice/
-F:	include/configs/trimslice.h
 F:	configs/trimslice_defconfig
diff --git a/board/comtrend/vr3032u/MAINTAINERS b/board/comtrend/vr3032u/MA=
INTAINERS
index 132101f4cd0c..79a7cc3559ad 100644
--- a/board/comtrend/vr3032u/MAINTAINERS
+++ b/board/comtrend/vr3032u/MAINTAINERS
@@ -2,5 +2,4 @@ COMTREND VR-3032U BOARD
 M:	=C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/vr3032u/
-F:	include/configs/comtrend_vr-3032u.h
 F:	configs/comtrend_vr3032u_ram_defconfig
diff --git a/board/comtrend/wap5813n/MAINTAINERS b/board/comtrend/wap5813n/=
MAINTAINERS
index c6764831b2bc..493e5f47150a 100644
--- a/board/comtrend/wap5813n/MAINTAINERS
+++ b/board/comtrend/wap5813n/MAINTAINERS
@@ -2,5 +2,4 @@ COMTREND WAP-5813N BOARD
 M:	=C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/wap5813n/
-F:	include/configs/comtrend_wap-5813n.h
 F:	configs/comtrend_wap5813n_ram_defconfig
diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/gen=
book_cm5_rk3588/MAINTAINERS
index 0496cc93b599..8f677f3170b2 100644
--- a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
+++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
@@ -1,7 +1,6 @@
 GENBOOK-CM5-RK3588
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
-F:	board/coolpi/genbook-cm5-rk3588
 F:	include/configs/genbook-cm5-rk3588.h
 F:	configs/coolpi-cm5-genbook-rk3588_defconfig
 F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
diff --git a/board/davinci/da8xxevm/MAINTAINERS b/board/davinci/da8xxevm/MA=
INTAINERS
index 993b22f2f638..55b7e6f69ce9 100644
--- a/board/davinci/da8xxevm/MAINTAINERS
+++ b/board/davinci/da8xxevm/MAINTAINERS
@@ -10,5 +10,4 @@ F:	configs/da850evm_direct_nor_defconfig
 OMAPL138_LCDK BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	include/configs/omap1l38_lcdk.h
 F:	configs/omapl138_lcdk_defconfig
diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/MA=
INTAINERS
index 02756c58b3c8..0ffd4668b42d 100644
--- a/board/embest/mx6boards/MAINTAINERS
+++ b/board/embest/mx6boards/MAINTAINERS
@@ -5,4 +5,3 @@ F:	board/embest/mx6boards/
 F:	include/configs/embestmx6boards.h
 F:	configs/marsboard_defconfig
 F:	configs/riotboard_defconfig
-F:	configs/riotboard_spl_defconfig
diff --git a/board/engicam/imx6ul/MAINTAINERS b/board/engicam/imx6ul/MAINTA=
INERS
index b9c6af27245c..bf42f1f2f521 100644
--- a/board/engicam/imx6ul/MAINTAINERS
+++ b/board/engicam/imx6ul/MAINTAINERS
@@ -7,12 +7,9 @@ F:	include/configs/imx6-engicam.h
 F:	configs/imx6ul_geam_mmc_defconfig
 F:	configs/imx6ul_geam_nand_defconfig
 F:	configs/imx6ul_isiot_emmc_defconfig
-F:	configs/imx6ul_isiot_mmc_defconfig
 F:	configs/imx6ul_isiot_nand_defconfig
 F:	arch/arm/dts/imx6ul.dtsi
 F:	arch/arm/dts/imx6ul-u-boot.dtsi
-F:	arch/arm/dts/imx6ul-geam-kit.dts
-F:	arch/arm/dts/imx6ul-geam-kit-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-emmc.dts
diff --git a/board/friendlyarm/nanopi2/MAINTAINERS b/board/friendlyarm/nano=
pi2/MAINTAINERS
index c8e2ce7b7c0e..5b4dd51a177d 100644
--- a/board/friendlyarm/nanopi2/MAINTAINERS
+++ b/board/friendlyarm/nanopi2/MAINTAINERS
@@ -2,6 +2,5 @@ NANOPI2 BOARD
 NANOPC-T2 BOARD
 M:  Stefan Bosch <stefan_b@posteo.net>
 S:  Maintained
-F:  board/s5p4418/nanopi2/
 F:  include/configs/s5p4418_nanopi2.h
 F:  configs/s5p4418_nanopi2_defconfig
diff --git a/board/gardena/smart-gateway-at91sam/MAINTAINERS b/board/garden=
a/smart-gateway-at91sam/MAINTAINERS
index a5e4c71b824d..7e29a4cba9f9 100644
--- a/board/gardena/smart-gateway-at91sam/MAINTAINERS
+++ b/board/gardena/smart-gateway-at91sam/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/gardena/smart-gateway-at91sam/
 F:	include/configs/gardena-smart-gateway-at91sam.h
 F:	configs/gardena-smart-gateway-at91sam_defconfig
-F:	arch/arm/dts/gardena-smart-gateway-at91sam.dts
diff --git a/board/gardena/smart-gateway-mt7688/MAINTAINERS b/board/gardena=
/smart-gateway-mt7688/MAINTAINERS
index bbb491c1ce6d..f241d5c3a5e5 100644
--- a/board/gardena/smart-gateway-mt7688/MAINTAINERS
+++ b/board/gardena/smart-gateway-mt7688/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/gardena/smart-gateway-mt7688
 F:	include/configs/gardena-smart-gateway-mt7688.h
 F:	configs/gardena-smart-gateway-mt7688_defconfig
-F:	configs/gardena-smart-gateway-mt7688-ram_defconfig
 F:	arch/mips/dts/gardena-smart-gateway-mt7688.dts
diff --git a/board/gateworks/gw_ventana/MAINTAINERS b/board/gateworks/gw_ve=
ntana/MAINTAINERS
index f9872806c0c5..3d604b725b2c 100644
--- a/board/gateworks/gw_ventana/MAINTAINERS
+++ b/board/gateworks/gw_ventana/MAINTAINERS
@@ -15,7 +15,6 @@ F:	arch/arm/dts/imx6dl-gw553x.dts
 F:	arch/arm/dts/imx6dl-gw560x.dts
 F:	arch/arm/dts/imx6dl-gw5903.dts
 F:	arch/arm/dts/imx6dl-gw5904.dts
-F:	arch/arm/dts/imx6dl-gw5905.dts
 F:	arch/arm/dts/imx6dl-gw5907.dts
 F:	arch/arm/dts/imx6dl-gw5910.dts
 F:	arch/arm/dts/imx6dl-gw5912.dts
@@ -30,7 +29,6 @@ F:	arch/arm/dts/imx6qdl-gw553x.dtsi
 F:	arch/arm/dts/imx6qdl-gw560x.dtsi
 F:	arch/arm/dts/imx6qdl-gw5903.dtsi
 F:	arch/arm/dts/imx6qdl-gw5904.dtsi
-F:	arch/arm/dts/imx6qdl-gw5905.dtsi
 F:	arch/arm/dts/imx6qdl-gw5907.dtsi
 F:	arch/arm/dts/imx6qdl-gw5910.dtsi
 F:	arch/arm/dts/imx6qdl-gw5912.dtsi
@@ -38,17 +36,13 @@ F:	arch/arm/dts/imx6qdl-gw5913.dtsi
 F:	arch/arm/dts/imx6q-gw51xx.dts
 F:	arch/arm/dts/imx6q-gw52xx.dts
 F:	arch/arm/dts/imx6q-gw53xx.dts
-F:	arch/arm/dts/imx6q-gw5400-a.dts
 F:	arch/arm/dts/imx6q-gw54xx.dts
 F:	arch/arm/dts/imx6q-gw551x.dts
 F:	arch/arm/dts/imx6q-gw552x.dts
 F:	arch/arm/dts/imx6q-gw553x.dts
 F:	arch/arm/dts/imx6q-gw560x.dts
-F:	arch/arm/dts/imx6q-gw5901.dts
-F:	arch/arm/dts/imx6q-gw5902.dts
 F:	arch/arm/dts/imx6q-gw5903.dts
 F:	arch/arm/dts/imx6q-gw5904.dts
-F:	arch/arm/dts/imx6q-gw5905.dts
 F:	arch/arm/dts/imx6q-gw5907.dts
 F:	arch/arm/dts/imx6q-gw5910.dts
 F:	arch/arm/dts/imx6q-gw5912.dts
diff --git a/board/ge/bx50v3/MAINTAINERS b/board/ge/bx50v3/MAINTAINERS
index 53a8d88a9043..9dacfaf99974 100644
--- a/board/ge/bx50v3/MAINTAINERS
+++ b/board/ge/bx50v3/MAINTAINERS
@@ -7,8 +7,5 @@ F:	arch/arm/dts/imx6q-b650v3.dts
 F:	arch/arm/dts/imx6q-b850v3.dts
 F:	arch/arm/dts/imx6q-bx50v3*
 F:	board/ge/bx50v3/
-F:	configs/ge_b450v3_defconfig
-F:	configs/ge_b650v3_defconfig
-F:	configs/ge_b850v3_defconfig
 F:	configs/ge_bx50v3_defconfig
 F:	include/configs/ge_bx50v3.h
diff --git a/board/htc/endeavoru/MAINTAINERS b/board/htc/endeavoru/MAINTAIN=
ERS
index 85f439f4672e..7ad66e37914a 100644
--- a/board/htc/endeavoru/MAINTAINERS
+++ b/board/htc/endeavoru/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/htc/endeavoru/
 F:	configs/endeavoru_defconfig
 F:	doc/board/htc/endeavoru.rst
-F:	include/configs/endeavoru.h
diff --git a/board/imgtec/xilfpga/MAINTAINERS b/board/imgtec/xilfpga/MAINTA=
INERS
index aa045325eac6..384e327bae0d 100644
--- a/board/imgtec/xilfpga/MAINTAINERS
+++ b/board/imgtec/xilfpga/MAINTAINERS
@@ -2,5 +2,4 @@ XILFPGA BOARD
 M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
 S:	Maintained
 F:	board/imgtec/xilfpga
-F:	include/configs/xilfpga.h
 F:	configs/imgtec_xilfpga_defconfig
diff --git a/board/intel/agilex-socdk/MAINTAINERS b/board/intel/agilex-socd=
k/MAINTAINERS
index fd05e9a4afb3..a90e9e91bb5a 100644
--- a/board/intel/agilex-socdk/MAINTAINERS
+++ b/board/intel/agilex-socdk/MAINTAINERS
@@ -4,7 +4,6 @@ M:	Chee Hong Ang <chee.hong.ang@intel.com>
 S:	Maintained
 F:	board/intel/agilex-socdk/
 F:	include/configs/socfpga_agilex_socdk.h
-F:	configs/socfpga_agilex_atf_defconfig
 F:	configs/socfpga_agilex_defconfig
=20
 SOCFPGA BOARD WITH VAB
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-=
socdk/MAINTAINERS
index 9a5b80ae4dfe..0f62784e686c 100644
--- a/board/intel/agilex7m-socdk/MAINTAINERS
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -3,8 +3,6 @@ M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
 S:	Maintained
 F:	arch/arm/dts/socfpga_soc64_u-boot.dtsi
-F:	arch/arm/dts/socfpga_agilex7m*
 F:	arch/arm/mach-socfpga/spl_agilex7m.c
 F:	board/intel/agilex7m-socdk/
 F:	include/configs/socfpga_agilex7m_socdk.h
-F:	configs/socfpga_agilex7m_sdmmc_defconfig
diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAIN=
TAINERS
index ca063a9f3f1d..0ef39964412c 100644
--- a/board/intel/n5x-socdk/MAINTAINERS
+++ b/board/intel/n5x-socdk/MAINTAINERS
@@ -5,5 +5,4 @@ S:	Maintained
 F:	board/intel/n5x-socdk/
 F:	include/configs/socfpga_n5x_socdk.h
 F:	configs/socfpga_n5x_defconfig
-F:	configs/socfpga_n5x_atf_defconfig
 F:	configs/socfpga_n5x_vab_defconfig
diff --git a/board/keymile/km83xx/MAINTAINERS b/board/keymile/km83xx/MAINTA=
INERS
index af0d6afb2b44..83ee8ea40107 100644
--- a/board/keymile/km83xx/MAINTAINERS
+++ b/board/keymile/km83xx/MAINTAINERS
@@ -5,10 +5,8 @@ S:	Maintained
 F:	board/keymile/km83xx/
 F:	board/keymile/common/
 F:	board/keymile/scripts/
-F:	include/configs/km8360.h
 F:	configs/kmcoge5ne_defconfig
 F:	configs/kmeter1_defconfig
-F:	include/configs/tuxx1.h
 F:	configs/kmopti2_defconfig
 F:	configs/kmsupx5_defconfig
 F:	configs/kmtepr2_defconfig
diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/k=
hadas-edge2-rk3588s/MAINTAINERS
index c43f469589dd..2e7f43042ba3 100644
--- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
+++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
@@ -3,4 +3,3 @@ M:	Jacobe Zang <jacobe.zang@wesion.com>
 S:	Maintained
 F:	configs/khadas-edge2-rk3588s_defconfig
 F:	include/configs/khadas-edge2-rk3588s.h
-F:	arch/arm/dts/rk3588s-khadas-edge2*
diff --git a/board/kontron/sl-mx6ul/MAINTAINERS b/board/kontron/sl-mx6ul/MA=
INTAINERS
index 9e9dff0361ce..5d150531b0e7 100644
--- a/board/kontron/sl-mx6ul/MAINTAINERS
+++ b/board/kontron/sl-mx6ul/MAINTAINERS
@@ -1,9 +1,7 @@
 Kontron SL/BL i.MX6UL/ULL Boards (N63xx/N64xx)
 M:	Frieder Schrempf <frieder.schrempf@kontron.de>
 S:	Maintained
-F:	arch/arm/dts/imx6ul-kontron-sl*
 F:	arch/arm/dts/imx6ul-kontron-bl*
-F:	arch/arm/dts/imx6ull-kontron-sl*
 F:	arch/arm/dts/imx6ull-kontron-bl*
 F:	board/kontron/sl-mx6ul
 F:	configs/kontron-sl-mx6ul_defconfig
diff --git a/board/lenovo/ideapad-yoga-11/MAINTAINERS b/board/lenovo/ideapa=
d-yoga-11/MAINTAINERS
index 77e82534a95c..c65bf943c2a6 100644
--- a/board/lenovo/ideapad-yoga-11/MAINTAINERS
+++ b/board/lenovo/ideapad-yoga-11/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/lenovo/ideapad-yoga-11/
 F:	configs/ideapad-yoga-11_defconfig
 F:	doc/board/lenovo/ideapad-yoga-11.rst
-F:	include/configs/ideapad-yoga-11.h
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
index 13c8588d0b92..55cac0ba2833 100644
--- a/board/lg/x3-t30/MAINTAINERS
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/lg/x3-t30/
 F:	configs/x3_t30_defconfig
 F:	doc/board/lg/x3_t30.rst
-F:	include/configs/x3-t30.h
diff --git a/board/libre-computer/aml-a311d-cc/MAINTAINERS b/board/libre-co=
mputer/aml-a311d-cc/MAINTAINERS
index b4b77acd23b2..a259b944add5 100644
--- a/board/libre-computer/aml-a311d-cc/MAINTAINERS
+++ b/board/libre-computer/aml-a311d-cc/MAINTAINERS
@@ -2,6 +2,5 @@ LIBRE-COMPUTER AML-A311D-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-a311d-cc/
 F:	configs/aml-a311d-cc_defconfig
 F:	doc/board/amlogic/aml-a311d-cc.rst
diff --git a/board/libre-computer/aml-s805x-ac/MAINTAINERS b/board/libre-co=
mputer/aml-s805x-ac/MAINTAINERS
index 7cbc08aeb6c8..ed82d64fc0ac 100644
--- a/board/libre-computer/aml-s805x-ac/MAINTAINERS
+++ b/board/libre-computer/aml-s805x-ac/MAINTAINERS
@@ -2,7 +2,6 @@ LIBRE-COMPUTER AML-S805X-AC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s805x-ac/
 F:	include/configs/libretech-ac.h
 F:	configs/libretech-ac_defconfig
 F:	doc/board/amlogic/libretech-ac.rst
diff --git a/board/libre-computer/aml-s905d3-cc/MAINTAINERS b/board/libre-c=
omputer/aml-s905d3-cc/MAINTAINERS
index 4b75c815c07c..cd521bc4d800 100644
--- a/board/libre-computer/aml-s905d3-cc/MAINTAINERS
+++ b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
@@ -2,6 +2,5 @@ LIBRE-COMPUTER AML-S905D3-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s905d3-cc/
 F:	configs/aml-s905d3-cc_defconfig
 F:	doc/board/amlogic/aml-s905d3-cc.rst
diff --git a/board/mediatek/mt7981/MAINTAINERS b/board/mediatek/mt7981/MAIN=
TAINERS
index e7592a7a548a..b75a5b0bfcfd 100644
--- a/board/mediatek/mt7981/MAINTAINERS
+++ b/board/mediatek/mt7981/MAINTAINERS
@@ -6,5 +6,3 @@ F:	include/configs/mt7981.h
 F:	configs/mt7981_emmc_rfb_defconfig
 F:	configs/mt7981_rfb_defconfig
 F:	configs/mt7981_sd_rfb_defconfig
-F:	configs/mt7981_spim_nand_rfb_defconfig
-F:	configs/mt7981_spim_nor_rfb_defconfig
diff --git a/board/mediatek/mt7986/MAINTAINERS b/board/mediatek/mt7986/MAIN=
TAINERS
index ddc078a567a8..ab09615f0bcf 100644
--- a/board/mediatek/mt7986/MAINTAINERS
+++ b/board/mediatek/mt7986/MAINTAINERS
@@ -6,7 +6,3 @@ F:	include/configs/mt7986.h
 F:	configs/mt7986_rfb_defconfig
 F:	configs/mt7986a_bpir3_emmc_defconfig
 F:	configs/mt7986a_bpir3_sd_defconfig
-F:	configs/mt7986a_emmc_rfb_defconfig
-F:	configs/mt7986a_sd_rfb_defconfig
-F:	configs/mt7986b_emmc_rfb_defconfig
-F:	configs/mt7986b_sd_rfb_defconfig
diff --git a/board/microsoft/surface-rt/MAINTAINERS b/board/microsoft/surfa=
ce-rt/MAINTAINERS
index 1bbd896de928..8c55978f6965 100644
--- a/board/microsoft/surface-rt/MAINTAINERS
+++ b/board/microsoft/surface-rt/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/microsoft/surface-rt/
 F:	configs/surface-rt_defconfig
 F:	doc/board/microsoft/surface-rt.rst
-F:	include/configs/surface-rt.h
diff --git a/board/myir/mys_6ulx/MAINTAINERS b/board/myir/mys_6ulx/MAINTAIN=
ERS
index d4ee66118269..fe6d71ee922f 100644
--- a/board/myir/mys_6ulx/MAINTAINERS
+++ b/board/myir/mys_6ulx/MAINTAINERS
@@ -1,7 +1,6 @@
 MYS_6ULX BOARD
 M:	Parthiban Nallathambi <parthiban@linumiz.com>
 S:	Maintained
-F:	arch/arm/dts/imx6ull-myir-mys-6ulx-nand.dts
 F:	arch/arm/dts/imx6ull-myir-mys-6ulx.dtsi
 F:	arch/arm/dts/imx6ull-mys-6ulx-u-boot.dtsi
 F:	board/myir/mys_6ulx/
diff --git a/board/nvidia/beaver/MAINTAINERS b/board/nvidia/beaver/MAINTAIN=
ERS
index 20d5836b9ec8..1dd1fad7fbfa 100644
--- a/board/nvidia/beaver/MAINTAINERS
+++ b/board/nvidia/beaver/MAINTAINERS
@@ -2,5 +2,4 @@ BEAVER BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/beaver/
-F:	include/configs/beaver.h
 F:	configs/beaver_defconfig
diff --git a/board/nvidia/cardhu/MAINTAINERS b/board/nvidia/cardhu/MAINTAIN=
ERS
index d3c3e368c17b..3984aa8d57b7 100644
--- a/board/nvidia/cardhu/MAINTAINERS
+++ b/board/nvidia/cardhu/MAINTAINERS
@@ -2,5 +2,4 @@ CARDHU BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/cardhu/
-F:	include/configs/cardhu.h
 F:	configs/cardhu_defconfig
diff --git a/board/nvidia/dalmore/MAINTAINERS b/board/nvidia/dalmore/MAINTA=
INERS
index fe86375ca9b4..5c8c08a2bdaa 100644
--- a/board/nvidia/dalmore/MAINTAINERS
+++ b/board/nvidia/dalmore/MAINTAINERS
@@ -2,5 +2,4 @@ DALMORE BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/dalmore/
-F:	include/configs/dalmore.h
 F:	configs/dalmore_defconfig
diff --git a/board/nvidia/harmony/MAINTAINERS b/board/nvidia/harmony/MAINTA=
INERS
index f3508edc3f56..2c25611dc358 100644
--- a/board/nvidia/harmony/MAINTAINERS
+++ b/board/nvidia/harmony/MAINTAINERS
@@ -2,5 +2,4 @@ HARMONY BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/harmony/
-F:	include/configs/harmony.h
 F:	configs/harmony_defconfig
diff --git a/board/nvidia/jetson-tk1/MAINTAINERS b/board/nvidia/jetson-tk1/=
MAINTAINERS
index f0d8f5eb8e52..15a7a04de392 100644
--- a/board/nvidia/jetson-tk1/MAINTAINERS
+++ b/board/nvidia/jetson-tk1/MAINTAINERS
@@ -2,5 +2,4 @@ JETSON-TK1 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/jetson-tk1/
-F:	include/configs/jetson-tk1.h
 F:	configs/jetson-tk1_defconfig
diff --git a/board/nvidia/nyan-big/MAINTAINERS b/board/nvidia/nyan-big/MAIN=
TAINERS
index 779077729c92..91a48bda0a8f 100644
--- a/board/nvidia/nyan-big/MAINTAINERS
+++ b/board/nvidia/nyan-big/MAINTAINERS
@@ -2,5 +2,4 @@ NYAN-BIG BOARD
 M:	Allen Martin <amartin@nvidia.com>
 S:	Maintained
 F:	board/nvidia/nyan-big/
-F:	include/configs/nyan-big.h
 F:	configs/nyan-big_defconfig
diff --git a/board/nvidia/p2371-0000/MAINTAINERS b/board/nvidia/p2371-0000/=
MAINTAINERS
index e6d04bf7c5e1..d3f6d64731d4 100644
--- a/board/nvidia/p2371-0000/MAINTAINERS
+++ b/board/nvidia/p2371-0000/MAINTAINERS
@@ -2,5 +2,4 @@ P2371-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2371-0000/
-F:	include/configs/p2371-0000.h
 F:	configs/p2371-0000_defconfig
diff --git a/board/nvidia/p2371-2180/MAINTAINERS b/board/nvidia/p2371-2180/=
MAINTAINERS
index 815377490c7f..49d6062ab6b7 100644
--- a/board/nvidia/p2371-2180/MAINTAINERS
+++ b/board/nvidia/p2371-2180/MAINTAINERS
@@ -2,5 +2,4 @@ P2371-2180 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2371-2180/
-F:	include/configs/p2371-2180.h
 F:	configs/p2371-2180_defconfig
diff --git a/board/nvidia/p2571/MAINTAINERS b/board/nvidia/p2571/MAINTAINER=
S
index c165135a9432..23b9c6e83e3b 100644
--- a/board/nvidia/p2571/MAINTAINERS
+++ b/board/nvidia/p2571/MAINTAINERS
@@ -2,5 +2,4 @@ P2571 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2571/
-F:	include/configs/p2571.h
 F:	configs/p2571_defconfig
diff --git a/board/nvidia/p2771-0000/MAINTAINERS b/board/nvidia/p2771-0000/=
MAINTAINERS
index 1a49e63231de..7dbdbe0bcea2 100644
--- a/board/nvidia/p2771-0000/MAINTAINERS
+++ b/board/nvidia/p2771-0000/MAINTAINERS
@@ -2,6 +2,5 @@ P2771-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2771-0000/
-F:	include/configs/p2771-0000.h
 F:	configs/p2771-0000-000_defconfig
 F:	configs/p2771-0000-500_defconfig
diff --git a/board/nvidia/p3450-0000/MAINTAINERS b/board/nvidia/p3450-0000/=
MAINTAINERS
index 40700066bf39..6b93e40c842d 100644
--- a/board/nvidia/p3450-0000/MAINTAINERS
+++ b/board/nvidia/p3450-0000/MAINTAINERS
@@ -2,5 +2,4 @@ P3450-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p3450-0000/
-F:	include/configs/p3450-0000.h
 F:	configs/p3450-0000_defconfig
diff --git a/board/nvidia/seaboard/MAINTAINERS b/board/nvidia/seaboard/MAIN=
TAINERS
index 7926ca19a896..b4759028a778 100644
--- a/board/nvidia/seaboard/MAINTAINERS
+++ b/board/nvidia/seaboard/MAINTAINERS
@@ -2,5 +2,4 @@ SEABOARD BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/seaboard/
-F:	include/configs/seaboard.h
 F:	configs/seaboard_defconfig
diff --git a/board/nvidia/tegratab/MAINTAINERS b/board/nvidia/tegratab/MAIN=
TAINERS
index bfd9eae86581..903279523a3d 100644
--- a/board/nvidia/tegratab/MAINTAINERS
+++ b/board/nvidia/tegratab/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra114-nvidia-tegratab.dts
 F:	board/nvidia/tegratab/
 F:	configs/tegratab_defconfig
 F:	doc/board/nvidia/tegratab.rst
-F:	include/configs/tegratab.h
diff --git a/board/nvidia/venice2/MAINTAINERS b/board/nvidia/venice2/MAINTA=
INERS
index 221df654d741..3ce3c6e1d26e 100644
--- a/board/nvidia/venice2/MAINTAINERS
+++ b/board/nvidia/venice2/MAINTAINERS
@@ -2,5 +2,4 @@ VENICE2 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/venice2/
-F:	include/configs/venice2.h
 F:	configs/venice2_defconfig
diff --git a/board/nvidia/ventana/MAINTAINERS b/board/nvidia/ventana/MAINTA=
INERS
index ba65a2bfc2fb..a83fec521335 100644
--- a/board/nvidia/ventana/MAINTAINERS
+++ b/board/nvidia/ventana/MAINTAINERS
@@ -2,5 +2,4 @@ VENTANA BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/ventana/
-F:	include/configs/ventana.h
 F:	configs/ventana_defconfig
diff --git a/board/nxp/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTAIN=
ERS
index da0540307c6a..d962cb1b7eb7 100644
--- a/board/nxp/imx93_evk/MAINTAINERS
+++ b/board/nxp/imx93_evk/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/nxp/imx93_evk/
 F:	include/configs/imx93_evk.h
 F:	configs/imx93_11x11_evk_defconfig
-F:	configs/imx93_11x11_evk_ld_defconfig
diff --git a/board/nxp/ls1012afrdm/MAINTAINERS b/board/nxp/ls1012afrdm/MAIN=
TAINERS
index a69c268e53b7..bc64cfba6e53 100644
--- a/board/nxp/ls1012afrdm/MAINTAINERS
+++ b/board/nxp/ls1012afrdm/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012afrdm/
 F:	include/configs/ls1012afrdm.h
-F:	configs/ls1012afrdm_qspi_defconfig
 F:	configs/ls1012afrdm_tfa_defconfig
 F:	configs/ls1012afrwy_tfa_defconfig
 F:	configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -11,7 +10,4 @@ F:	configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
 LS1012AFRWY BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:      Maintained
-F:      board/nxp/ls1012afrwy/
 F:      include/configs/ls1012afrwy.h
-F:      configs/ls1012afrwy_qspi_defconfig
-F:	configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1012aqds/MAINTAINERS b/board/nxp/ls1012aqds/MAINTA=
INERS
index 2178df909929..52bf79ebd6fb 100644
--- a/board/nxp/ls1012aqds/MAINTAINERS
+++ b/board/nxp/ls1012aqds/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012aqds/
 F:	include/configs/ls1012aqds.h
-F:	configs/ls1012aqds_qspi_defconfig
 F:	configs/ls1012aqds_tfa_defconfig
 F:	configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1012ardb/MAINTAINERS b/board/nxp/ls1012ardb/MAINTA=
INERS
index 5dd2858a86c7..dfb852f5f537 100644
--- a/board/nxp/ls1012ardb/MAINTAINERS
+++ b/board/nxp/ls1012ardb/MAINTAINERS
@@ -3,15 +3,12 @@ M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1012ardb/
 F:	include/configs/ls1012ardb.h
-F:	configs/ls1012ardb_qspi_defconfig
 F:	configs/ls1012ardb_tfa_defconfig
 F:	configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
 F:	configs/ls1012a2g5rdb_tfa_defconfig
-F:	configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
=20
 LS1012A2G5RDB BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:      Maintained
 F:      board/nxp/ls1012ardb/
 F:      include/configs/ls1012a2g5rdb.h
-F:      configs/ls1012a2g5rdb_qspi_defconfig
diff --git a/board/nxp/ls1043aqds/MAINTAINERS b/board/nxp/ls1043aqds/MAINTA=
INERS
index daea64483d2a..9e82c2c9f20c 100644
--- a/board/nxp/ls1043aqds/MAINTAINERS
+++ b/board/nxp/ls1043aqds/MAINTAINERS
@@ -3,12 +3,5 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1043aqds/
 F:	include/configs/ls1043aqds.h
-F:	configs/ls1043aqds_defconfig
-F:	configs/ls1043aqds_nor_ddr3_defconfig
-F:	configs/ls1043aqds_nand_defconfig
-F:	configs/ls1043aqds_sdcard_ifc_defconfig
-F:	configs/ls1043aqds_sdcard_qspi_defconfig
-F:	configs/ls1043aqds_qspi_defconfig
-F:	configs/ls1043aqds_lpuart_defconfig
 F:	configs/ls1043aqds_tfa_defconfig
 F:	configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1043ardb/MAINTAINERS b/board/nxp/ls1043ardb/MAINTA=
INERS
index 4df5940ab713..14ea4d2492f1 100644
--- a/board/nxp/ls1043ardb/MAINTAINERS
+++ b/board/nxp/ls1043ardb/MAINTAINERS
@@ -3,11 +3,5 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1043ardb/
 F:	include/configs/ls1043ardb.h
-F:	configs/ls1043ardb_defconfig
-F:	configs/ls1043ardb_nand_defconfig
-F:	configs/ls1043ardb_sdcard_defconfig
 F:	configs/ls1043ardb_tfa_defconfig
 F:	configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
-F:	configs/ls1043ardb_nand_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1046aqds/MAINTAINERS b/board/nxp/ls1046aqds/MAINTA=
INERS
index 792531f7f3ae..86c1c7e2c81f 100644
--- a/board/nxp/ls1046aqds/MAINTAINERS
+++ b/board/nxp/ls1046aqds/MAINTAINERS
@@ -3,12 +3,5 @@ M:	Mingkai Hu <Mingkai.Hu@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1046aqds/
 F:	include/configs/ls1046aqds.h
-F:	configs/ls1046aqds_defconfig
-F:	configs/ls1046aqds_nand_defconfig
-F:	configs/ls1046aqds_sdcard_ifc_defconfig
-F:	configs/ls1046aqds_sdcard_qspi_defconfig
-F:	configs/ls1046aqds_qspi_defconfig
-F:	configs/ls1046aqds_lpuart_defconfig
 F:	configs/ls1046aqds_tfa_defconfig
 F:	configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1046aqds_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls1046ardb/MAINTAINERS b/board/nxp/ls1046ardb/MAINTA=
INERS
index bb5f6a64d7b4..ef5f7002002e 100644
--- a/board/nxp/ls1046ardb/MAINTAINERS
+++ b/board/nxp/ls1046ardb/MAINTAINERS
@@ -4,13 +4,6 @@ S:	Maintained
 F:	board/nxp/ls1046ardb/
 F:	board/nxp/ls1046ardb/ls1046ardb.c
 F:	include/configs/ls1046ardb.h
-F:	configs/ls1046ardb_qspi_defconfig
-F:	configs/ls1046ardb_qspi_spl_defconfig
-F:	configs/ls1046ardb_sdcard_defconfig
-F:	configs/ls1046ardb_emmc_defconfig
 F:	configs/ls1046ardb_tfa_defconfig
 F:	configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
-F:	configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
 F:	doc/board/nxp/ls1046ardb.rst
diff --git a/board/nxp/ls1088a/MAINTAINERS b/board/nxp/ls1088a/MAINTAINERS
index 85f38fcf0c72..412ddc54599b 100644
--- a/board/nxp/ls1088a/MAINTAINERS
+++ b/board/nxp/ls1088a/MAINTAINERS
@@ -3,8 +3,6 @@ M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1088a/
 F:	include/configs/ls1088ardb.h
-F:	configs/ls1088ardb_qspi_defconfig
-F:	configs/ls1088ardb_sdcard_qspi_defconfig
 F:	configs/ls1088ardb_tfa_defconfig
 F:	configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
=20
@@ -13,23 +11,16 @@ M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
 F:	board/nxp/ls1088a/
 F:	include/configs/ls1088aqds.h
-F:	configs/ls1088aqds_qspi_defconfig
-F:	configs/ls1088aqds_sdcard_qspi_defconfig
-F:	configs/ls1088aqds_defconfig
-F:	configs/ls1088aqds_sdcard_ifc_defconfig
 F:	configs/ls1088aqds_tfa_defconfig
=20
 LS1088AQDS_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
=20
 LS1088ARDB_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
=20
 LS1088ARDB_SD_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls2080aqds/MAINTAINERS b/board/nxp/ls2080aqds/MAINTA=
INERS
index 3659cec4cd86..9328a084e41e 100644
--- a/board/nxp/ls2080aqds/MAINTAINERS
+++ b/board/nxp/ls2080aqds/MAINTAINERS
@@ -3,11 +3,7 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
 F:	board/nxp/ls2080aqds/
-F:	board/nxp/ls2080a/ls2080aqds.c
 F:	include/configs/ls2080aqds.h
-F:	configs/ls2080aqds_defconfig
 F:	configs/ls2080aqds_nand_defconfig
 F:	configs/ls2080aqds_qspi_defconfig
-F:	configs/ls2080aqds_sdcard_defconfig
 F:	configs/ls2088aqds_tfa_defconfig
-F:	configs/ls2080aqds_SECURE_BOOT_defconfig
diff --git a/board/nxp/ls2080ardb/MAINTAINERS b/board/nxp/ls2080ardb/MAINTA=
INERS
index 867ebe99cace..8341609b6e99 100644
--- a/board/nxp/ls2080ardb/MAINTAINERS
+++ b/board/nxp/ls2080ardb/MAINTAINERS
@@ -3,30 +3,24 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
 F:	board/nxp/ls2080ardb/
-F:	board/nxp/ls2080a/ls2080ardb.c
 F:	include/configs/ls2080ardb.h
-F:	configs/ls2080ardb_defconfig
 F:	configs/ls2080ardb_nand_defconfig
=20
 LS2088A_QSPI-boot BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	configs/ls2088ardb_qspi_defconfig
 F:	configs/ls2088ardb_tfa_defconfig
 F:	configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
=20
 LS2081ARDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	configs/ls2081ardb_defconfig
=20
 LS2080A_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls2080ardb_SECURE_BOOT_defconfig
=20
 LS2088A_QSPI_SECURE_BOOT BOARD
 M:	Udit Agarwal <udit.agarwal@nxp.com>
 S:	Maintained
-F:	configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
index abdac1372d28..945366a99861 100644
--- a/board/nxp/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -19,7 +19,6 @@ LX2160AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/nxp/lx2160a/eth_lx2160aqds.h
 F:	include/configs/lx2160aqds.h
 F:	configs/lx2160aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2160a-qds.dts
@@ -33,7 +32,6 @@ LX2162AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/nxp/lx2160a/eth_lx2162aqds.h
 F:	include/configs/lx2162aqds.h
 F:	configs/lx2162aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2162a-qds.dts
diff --git a/board/nxp/mpc837xerdb/MAINTAINERS b/board/nxp/mpc837xerdb/MAIN=
TAINERS
index 9b05a6ad4217..cc0a6acd8c38 100644
--- a/board/nxp/mpc837xerdb/MAINTAINERS
+++ b/board/nxp/mpc837xerdb/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/nxp/mpc837xerdb/
 F:	include/configs/MPC837XERDB.h
 F:	configs/MPC837XERDB_defconfig
-F:	configs/MPC837XERDB_SLAVE_defconfig
diff --git a/board/nxp/mx6slevk/MAINTAINERS b/board/nxp/mx6slevk/MAINTAINER=
S
index 4410358ea08c..6b8d5f2ca2c8 100644
--- a/board/nxp/mx6slevk/MAINTAINERS
+++ b/board/nxp/mx6slevk/MAINTAINERS
@@ -5,5 +5,3 @@ S:	Maintained
 F:	board/nxp/mx6slevk/
 F:	include/configs/mx6slevk.h
 F:	configs/mx6slevk_defconfig
-F:	configs/mx6slevk_spl_defconfig
-F:	configs/mx6slevk_spinor_defconfig
diff --git a/board/nxp/p2041rdb/MAINTAINERS b/board/nxp/p2041rdb/MAINTAINER=
S
index f0d5c1192ac6..d139dd518747 100644
--- a/board/nxp/p2041rdb/MAINTAINERS
+++ b/board/nxp/p2041rdb/MAINTAINERS
@@ -4,8 +4,5 @@ S:	Maintained
 F:	board/nxp/p2041rdb/
 F:	include/configs/P2041RDB.h
 F:	configs/P2041RDB_defconfig
-F:	configs/P2041RDB_NAND_defconfig
 F:	configs/P2041RDB_SDCARD_defconfig
-F:	configs/P2041RDB_SECURE_BOOT_defconfig
 F:	configs/P2041RDB_SPIFLASH_defconfig
-F:	configs/P2041RDB_SRIO_PCIE_BOOT_defconfig
diff --git a/board/nxp/t104xrdb/MAINTAINERS b/board/nxp/t104xrdb/MAINTAINER=
S
index 5542530698d9..d0b5709df81f 100644
--- a/board/nxp/t104xrdb/MAINTAINERS
+++ b/board/nxp/t104xrdb/MAINTAINERS
@@ -3,24 +3,11 @@ M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
 F:	board/nxp/t104xrdb/
 F:	include/configs/T104xRDB.h
-F:	configs/T1040RDB_defconfig
-F:	configs/T1040RDB_NAND_defconfig
-F:	configs/T1040RDB_SPIFLASH_defconfig
-F:	configs/T1040D4RDB_defconfig
-F:	configs/T1040D4RDB_NAND_defconfig
-F:	configs/T1040D4RDB_SPIFLASH_defconfig
-F:	configs/T1042RDB_defconfig
 F:	configs/T1042D4RDB_defconfig
 F:	configs/T1042D4RDB_NAND_defconfig
 F:	configs/T1042D4RDB_SPIFLASH_defconfig
-F:	configs/T1042RDB_PI_defconfig
-F:	configs/T1042RDB_PI_NAND_defconfig
-F:	configs/T1042RDB_PI_SPIFLASH_defconfig
=20
 T1040RDB_SDCARD BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	configs/T1040RDB_SDCARD_defconfig
-F:	configs/T1040D4RDB_SDCARD_defconfig
 F:	configs/T1042D4RDB_SDCARD_defconfig
-F:	configs/T1042RDB_PI_SDCARD_defconfig
diff --git a/board/nxp/t208xqds/MAINTAINERS b/board/nxp/t208xqds/MAINTAINER=
S
index 56911e8fd154..3c94352ec997 100644
--- a/board/nxp/t208xqds/MAINTAINERS
+++ b/board/nxp/t208xqds/MAINTAINERS
@@ -8,11 +8,6 @@ F:	configs/T2080QDS_NAND_defconfig
 F:	configs/T2080QDS_SDCARD_defconfig
 F:	configs/T2080QDS_SPIFLASH_defconfig
 F:	configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
-F:	configs/T2081QDS_defconfig
-F:	configs/T2081QDS_NAND_defconfig
-F:	configs/T2081QDS_SDCARD_defconfig
-F:	configs/T2081QDS_SPIFLASH_defconfig
-F:	configs/T2081QDS_SRIO_PCIE_BOOT_defconfig
=20
 T2080QDS_SECURE_BOOT BOARD
 M:	Ruchika Gupta <ruchika.gupta@nxp.com>
diff --git a/board/nxp/t208xrdb/MAINTAINERS b/board/nxp/t208xrdb/MAINTAINER=
S
index db58c79c2544..aa70c2424b5a 100644
--- a/board/nxp/t208xrdb/MAINTAINERS
+++ b/board/nxp/t208xrdb/MAINTAINERS
@@ -7,7 +7,6 @@ F:	configs/T2080RDB_defconfig
 F:	configs/T2080RDB_NAND_defconfig
 F:	configs/T2080RDB_SDCARD_defconfig
 F:	configs/T2080RDB_SPIFLASH_defconfig
-F:	configs/T2080RDB_SRIO_PCIE_BOOT_defconfig
 F:	configs/T2080RDB_revD_defconfig
 F:	configs/T2080RDB_revD_NAND_defconfig
 F:	configs/T2080RDB_revD_SDCARD_defconfig
diff --git a/board/ouya/ouya/MAINTAINERS b/board/ouya/ouya/MAINTAINERS
index 7f664b2e65ff..6cac853823dc 100644
--- a/board/ouya/ouya/MAINTAINERS
+++ b/board/ouya/ouya/MAINTAINERS
@@ -5,4 +5,3 @@ S:	Maintained
 F:	board/ouya/ouya/
 F:	configs/ouya_defconfig
 F:	doc/board/ouya/ouya.rst
-F:	include/configs/ouya.h
diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore=
_am62ax/MAINTAINERS
index ded4a88d1997..1a2ac6a59a70 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -5,7 +5,6 @@ L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am62a
 S:	Maintained
 F:	arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
-F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsit.dtsi
 F:	arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
 F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62ax/
diff --git a/board/phytec/phycore_am68x/MAINTAINERS b/board/phytec/phycore_=
am68x/MAINTAINERS
index 5e175fdb9efe..ca61746f244b 100644
--- a/board/phytec/phycore_am68x/MAINTAINERS
+++ b/board/phytec/phycore_am68x/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Dominik Haller <d.haller@phytec.de>
 L:	upstream@lists.phytec.de
 W:	https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x-tda4x=
/
 S:	Maintained
-F:	arch/arm/dts/k3-am68-phycore-som-ddr4-4gb.dtsi
 F:	arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
 F:	arch/arm/dts/k3-am68-phycore-som-binman.dtsi
 F:	arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore=
_imx8mm/MAINTAINERS
index 5cada15ac4b3..f96ebc31b36d 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -10,5 +10,4 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS b/board/polyhex=
/imx8mp_debix_model_a/MAINTAINERS
index d3afa91c1188..0e07186413ae 100644
--- a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
+++ b/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
@@ -1,7 +1,6 @@
 DEBIX MODEL A BOARD (i.MX8M Plus)
 M:	Gilles Talis <gilles.talis@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/imx8mp-debix-model-a.dts
 F:	arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
 F:	board/polyhex/imx8mp_debix_model_a/
 F:	include/configs/imx8mp_debix_model_a.h
diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dr=
agonboard410c/MAINTAINERS
index 9c10fa3053b0..2a98a6d5e850 100644
--- a/board/qualcomm/dragonboard410c/MAINTAINERS
+++ b/board/qualcomm/dragonboard410c/MAINTAINERS
@@ -4,5 +4,4 @@ R:	Sam Day <me@samcday.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard410c/
 F:	include/configs/dragonboard410c.h
-F:	configs/dragonboard410c_defconfig
 F:	doc/board/qualcomm/dragonboard410c.rst
diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dr=
agonboard820c/MAINTAINERS
index 7ef905bdf69c..a06fc4fdba2b 100644
--- a/board/qualcomm/dragonboard820c/MAINTAINERS
+++ b/board/qualcomm/dragonboard820c/MAINTAINERS
@@ -3,4 +3,3 @@ M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard820c/
 F:	include/configs/dragonboard820c.h
-F:	configs/dragonboard820c_defconfig
diff --git a/board/qualcomm/dragonboard845c/MAINTAINERS b/board/qualcomm/dr=
agonboard845c/MAINTAINERS
index e555953df697..3b5c63459fe0 100644
--- a/board/qualcomm/dragonboard845c/MAINTAINERS
+++ b/board/qualcomm/dragonboard845c/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Robotics RB3 Development Platform (dragonboard845c=
)
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/dragonboard845c/
-F:	include/configs/dragonboard845c.h
-F:	configs/dragonboard845c_defconfig
diff --git a/board/qualcomm/qcs404-evb/MAINTAINERS b/board/qualcomm/qcs404-=
evb/MAINTAINERS
index 0a2e194ff608..c6c672d6c3c4 100644
--- a/board/qualcomm/qcs404-evb/MAINTAINERS
+++ b/board/qualcomm/qcs404-evb/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Technologies, Inc. QCS404 evaluation board
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/qcs404-evb/
-F:	include/configs/qcs404-evb.h
-F:	configs/qcs404evb_defconfig
diff --git a/board/renesas/blanche/MAINTAINERS b/board/renesas/blanche/MAIN=
TAINERS
index 39fb93ed0836..c6d70a78ce69 100644
--- a/board/renesas/blanche/MAINTAINERS
+++ b/board/renesas/blanche/MAINTAINERS
@@ -2,7 +2,6 @@ BLANCHE BOARD
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 M:	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
 S:	Maintained
-F:	arch/arm/dts/r8a7792*
 F:	board/renesas/blanche/
 F:	configs/blanche_defconfig
 F:	include/configs/blanche.h
diff --git a/board/renesas/eagle/MAINTAINERS b/board/renesas/eagle/MAINTAIN=
ERS
index c28b6502478c..322f2500088f 100644
--- a/board/renesas/eagle/MAINTAINERS
+++ b/board/renesas/eagle/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-eagle*
 F:	board/renesas/eagle/
 F:	configs/r8a77970_eagle_defconfig
-F:	include/configs/eagle.h
diff --git a/board/renesas/grpeach/MAINTAINERS b/board/renesas/grpeach/MAIN=
TAINERS
index c0f4fbcbae16..506323e31a7f 100644
--- a/board/renesas/grpeach/MAINTAINERS
+++ b/board/renesas/grpeach/MAINTAINERS
@@ -7,7 +7,6 @@ F:	configs/grpeach_defconfig
 F:	drivers/gpio/gpio-rza1.c
 F:	drivers/mtd/renesas_rpc_hf.c
 F:	drivers/net/sh_eth*
-F:	drivers/pinctrl/renesas/pfc-r7s72100.c
 F:	drivers/serial/serial_sh*
 F:	drivers/spi/renesas_rpc_spi.c
 F:	drivers/timer/ostm_timer.c
diff --git a/board/renesas/v3msk/MAINTAINERS b/board/renesas/v3msk/MAINTAIN=
ERS
index c198cf8c9b89..056d83285e48 100644
--- a/board/renesas/v3msk/MAINTAINERS
+++ b/board/renesas/v3msk/MAINTAINERS
@@ -5,4 +5,3 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-v3msk*
 F:	board/renesas/v3msk/
 F:	configs/r8a77970_v3msk_defconfig
-F:	include/configs/v3msk.h
diff --git a/board/samsung/starqltechn/MAINTAINERS b/board/samsung/starqlte=
chn/MAINTAINERS
index 135cafdd69ca..0abfa658e9b4 100644
--- a/board/samsung/starqltechn/MAINTAINERS
+++ b/board/samsung/starqltechn/MAINTAINERS
@@ -2,5 +2,3 @@ Samsung S9 (SM-G9600)(starqltechn)  Board
 M:	Dzmitry Sankouski <dsankouski@gmail.com>
 S:	Maintained
 F:	board/samsung/starqltechn/
-F:	include/configs/starqltechn.h
-F:	configs/starqltechn_defconfig
diff --git a/board/seeed/linkit-smart-7688/MAINTAINERS b/board/seeed/linkit=
-smart-7688/MAINTAINERS
index f2186c1b9d72..5f24c9cecb57 100644
--- a/board/seeed/linkit-smart-7688/MAINTAINERS
+++ b/board/seeed/linkit-smart-7688/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/seeed/linkit-smart-7688
 F:	include/configs/linkit-smart-7688.h
 F:	configs/linkit-smart-7688_defconfig
-F:	configs/linkit-smart-7688-ram_defconfig
 F:	arch/mips/dts/linkit-smart-7688.dts
diff --git a/board/siemens/iot2050/MAINTAINERS b/board/siemens/iot2050/MAIN=
TAINERS
index 1b525356c2d6..7745f18d0e51 100644
--- a/board/siemens/iot2050/MAINTAINERS
+++ b/board/siemens/iot2050/MAINTAINERS
@@ -5,5 +5,4 @@ S:	Maintained
 F:	board/siemens/iot2050/
 F:	include/configs/iot2050.h
 F:	configs/iot2050_defconfig
-F:	arch/arm/dts/iot2050-*
 F:	doc/board/siemens/iot2050.rst
diff --git a/board/sifive/unmatched/MAINTAINERS b/board/sifive/unmatched/MA=
INTAINERS
index e601a0f3288f..d4b2a051a4f7 100644
--- a/board/sifive/unmatched/MAINTAINERS
+++ b/board/sifive/unmatched/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Green Wan <green.wan@sifive.com>
 S:	Maintained
 F:	board/sifive/unmatched/
-F:	doc/board/sifive/hifive-unmatched-fu740.rst
 F:	include/configs/sifive-unmatched.h
 F:	configs/sifive_unmatched_defconfig
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 775d0f7ae83c..df745f146494 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -50,10 +50,8 @@ F:	configs/Bananapi_defconfig
 F:	configs/Bananapro_defconfig
 F:	configs/i12-tvbox_defconfig
 F:	configs/Linksprite_pcDuino3_defconfig
-F:	configs/Linksprite_pcDuino3_fdt_defconfig
 F:	configs/Orangepi_defconfig
 F:	configs/Orangepi_mini_defconfig
-F:	configs/qt840a_defconfig
 F:	configs/Wits_Pro_A20_DKT_defconfig
 F:	include/configs/sun8i.h
 F:	configs/sun8i_a23_evb_defconfig
diff --git a/board/ti/am62ax/MAINTAINERS b/board/ti/am62ax/MAINTAINERS
index bb0de6a04966..c1a71b5b333e 100644
--- a/board/ti/am62ax/MAINTAINERS
+++ b/board/ti/am62ax/MAINTAINERS
@@ -4,7 +4,6 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62ax/
-F:	include/configs/am62a7_evm.h
 F:	configs/am62ax_evm_r5_defconfig
 F:	configs/am62ax_evm_a53_defconfig
 F:	configs/am62ax_evm_r5_ethboot_defconfig
diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
index e7af7be35bca..0c6217811e81 100644
--- a/board/ti/am62dx/MAINTAINERS
+++ b/board/ti/am62dx/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 S:	Maintained
 F:	board/ti/am62dx/
-F:	include/configs/am62a7_evm.h
 F:	configs/am62dx_evm_r5_defconfig
 F:	configs/am62dx_evm_a53_defconfig
diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
index c6c6deca61eb..5d3bad7b75d5 100644
--- a/board/ti/am62px/MAINTAINERS
+++ b/board/ti/am62px/MAINTAINERS
@@ -4,7 +4,6 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62px/
-F:	include/configs/am62p5_evm.h
 F:	configs/am62px_evm_r5_defconfig
 F:	configs/am62px_evm_a53_defconfig
 F:	configs/am62px_evm_r5_ethboot_defconfig
diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
index 626141367a57..38574d7d271d 100644
--- a/board/ti/j7200/MAINTAINERS
+++ b/board/ti/j7200/MAINTAINERS
@@ -2,6 +2,5 @@ J7200 BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j7200
-F:	include/configs/j7200_evm.h
 F:	configs/j7200_evm_r5_defconfig
 F:	configs/j7200_evm_a72_defconfig
diff --git a/board/toradex/apalis-tk1/MAINTAINERS b/board/toradex/apalis-tk=
1/MAINTAINERS
index 393c8dcf8016..28ef83efeb1f 100644
--- a/board/toradex/apalis-tk1/MAINTAINERS
+++ b/board/toradex/apalis-tk1/MAINTAINERS
@@ -5,4 +5,3 @@ F:	board/toradex/apalis-tk1/
 F:	board/toradex/common/
 F:	include/configs/apalis-tk1.h
 F:	configs/apalis-tk1_defconfig
-F:	arch/arm/dts/tegra124-apalis.dtb
diff --git a/board/toradex/apalis_t30/MAINTAINERS b/board/toradex/apalis_t3=
0/MAINTAINERS
index 368decf66744..6479869c3d8d 100644
--- a/board/toradex/apalis_t30/MAINTAINERS
+++ b/board/toradex/apalis_t30/MAINTAINERS
@@ -3,6 +3,4 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/apalis_t30/
 F:	board/toradex/common/
-F:	include/configs/apalis_t30.h
 F:	configs/apalis_t30_defconfig
-F:	arch/arm/dts/tegra30-apalis.dtb
diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/coli=
bri-imx6ull/MAINTAINERS
index 6c93e35cc65f..1ceb1c8eb1b3 100644
--- a/board/toradex/colibri-imx6ull/MAINTAINERS
+++ b/board/toradex/colibri-imx6ull/MAINTAINERS
@@ -9,7 +9,6 @@ F:	arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
 F:	arch/arm/dts/imx6ull-colibri-eval-v3.dts
 F:	arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
 F:	arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
-F:	arch/arm/dts/imx6ull-colibri-u-boot.dtsi
 F:	board/toradex/colibri-imx6ull/
 F:	board/toradex/common/
 F:	configs/colibri-imx6ull_defconfig
diff --git a/board/toradex/colibri-imx8x/MAINTAINERS b/board/toradex/colibr=
i-imx8x/MAINTAINERS
index 938c2ca0ca01..e0a0d564e464 100644
--- a/board/toradex/colibri-imx8x/MAINTAINERS
+++ b/board/toradex/colibri-imx8x/MAINTAINERS
@@ -2,8 +2,6 @@ Colibri iMX8X
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 S:	Maintained
-F:	arch/arm/dts/fsl-imx8x-colibri.dts
-F:	arch/arm/dts/fsl-imx8x-colibri-u-boot.dtsi
 F:	board/toradex/colibri-imx8x/
 F:	board/toradex/common/
 F:	configs/colibri-imx8x_defconfig
diff --git a/board/toradex/colibri_imx7/MAINTAINERS b/board/toradex/colibri=
_imx7/MAINTAINERS
index 80770cc71a96..e440e5d61172 100644
--- a/board/toradex/colibri_imx7/MAINTAINERS
+++ b/board/toradex/colibri_imx7/MAINTAINERS
@@ -3,12 +3,6 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
-F:	arch/arm/boot/dts/imx7-colibri.dtsi
-F:	arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
-F:	arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 F:	board/toradex/colibri_imx7/
 F:	board/toradex/common/
 F:	configs/colibri_imx7_defconfig
diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibri_=
t20/MAINTAINERS
index 58842434024f..cc639e40599d 100644
--- a/board/toradex/colibri_t20/MAINTAINERS
+++ b/board/toradex/colibri_t20/MAINTAINERS
@@ -3,6 +3,4 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t20/
 F:	board/toradex/common/
-F:	include/configs/colibri_t20.h
 F:	configs/colibri_t20_defconfig
-F:	arch/arm/dts/tegra20-colibri.dtb
diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibri_=
t30/MAINTAINERS
index 73859fd25c2e..627ef51a0301 100644
--- a/board/toradex/colibri_t30/MAINTAINERS
+++ b/board/toradex/colibri_t30/MAINTAINERS
@@ -3,6 +3,4 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t30/
 F:	board/toradex/common/
-F:	include/configs/colibri_t30.h
 F:	configs/colibri_t30_defconfig
-F:	arch/arm/dts/tegra30-colibri.dtb
diff --git a/board/toradex/colibri_vf/MAINTAINERS b/board/toradex/colibri_v=
f/MAINTAINERS
index a41bd165a7ca..861a46e6e132 100644
--- a/board/toradex/colibri_vf/MAINTAINERS
+++ b/board/toradex/colibri_vf/MAINTAINERS
@@ -6,7 +6,6 @@ S:	Maintained
 F:	arch/arm/dts/vf-colibri.dtsi
 F:	arch/arm/dts/vf-colibri-eval-v3.dtsi
 F:	arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
-F:	arch/arm/dts/vf610-colibri.dts
 F:	board/toradex/colibri_vf/
 F:	board/toradex/common/
 F:	configs/colibri_vf_defconfig
diff --git a/board/toradex/smarc-imx8mp/MAINTAINERS b/board/toradex/smarc-i=
mx8mp/MAINTAINERS
index f7fcef1c0921..056750c50fb4 100644
--- a/board/toradex/smarc-imx8mp/MAINTAINERS
+++ b/board/toradex/smarc-imx8mp/MAINTAINERS
@@ -3,7 +3,6 @@ F:	arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
 F:	board/toradex/smarc-imx8mp/
 F:	board/toradex/common/
 F:	configs/toradex-smarc-imx8mp_defconfig
-F:	doc/board/toradex/toradex-smarc-imx8mp.rst
 F:	include/configs/toradex-smarc-imx8mp.h
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
diff --git a/board/traverse/ten64/MAINTAINERS b/board/traverse/ten64/MAINTA=
INERS
index 7b53e8793858..590327b8d829 100644
--- a/board/traverse/ten64/MAINTAINERS
+++ b/board/traverse/ten64/MAINTAINERS
@@ -1,7 +1,6 @@
 TEN64 BOARD
 M:	Mathew McBride <matt@traverse.com.au>
 S:	Maintained
-F:	arch/arm/dts/fsl-ls1088a-ten64.dts
 F:	board/traverse/ten64/
 F:	board/traverse/common/
 F:	include/configs/ten64.h
diff --git a/board/wandboard/MAINTAINERS b/board/wandboard/MAINTAINERS
index 3c2a06cf09bc..0c156a52bdc6 100644
--- a/board/wandboard/MAINTAINERS
+++ b/board/wandboard/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/imx6qdl-wandboard.dtsi
 F:	arch/arm/dts/imx6qdl-wandboard-revb1.dtsi
-F:	arch/arm/dts/imx6dl-wandboard-revb1.dts
 F:	board/wandboard/
 F:	include/configs/wandboard.h
 F:	configs/wandboard_defconfig
diff --git a/board/wexler/qc750/MAINTAINERS b/board/wexler/qc750/MAINTAINER=
S
index 017f6f2b707e..7922514c5d75 100644
--- a/board/wexler/qc750/MAINTAINERS
+++ b/board/wexler/qc750/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/wexler/qc750/
 F:	configs/qc750_defconfig
 F:	doc/board/wexler/qc750.rst
-F:	include/configs/qc750.h
diff --git a/board/xiaomi/mocha/MAINTAINERS b/board/xiaomi/mocha/MAINTAINER=
S
index c3871a15a35b..90215d1325a4 100644
--- a/board/xiaomi/mocha/MAINTAINERS
+++ b/board/xiaomi/mocha/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra124-xiaomi-mocha.dts
 F:	board/xiaomi/mocha/
 F:	configs/mocha_defconfig
 F:	doc/board/xiaomi/mocha.rst
-F:	include/configs/mocha.h
diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTAIN=
ERS
index 3db240782f4d..de753c8fe4e5 100644
--- a/board/xilinx/zynqmp/MAINTAINERS
+++ b/board/xilinx/zynqmp/MAINTAINERS
@@ -8,4 +8,3 @@ F:	board/xilinx/common/
 F:	board/xilinx/zynqmp/
 F:	include/configs/xilinx_zynqmp*
 F:	configs/xilinx_zynqmp*
-F:	configs/avnet_ultra96_rev1_defconfig
diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunl=
ong/orangepi-5-ultra-rk3588/MAINTAINERS
index 79981aa43f13..0c7906acc992 100644
--- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
+++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
@@ -1,6 +1,5 @@
 ORANGEPI-5-RK3588-ULTRA
 M:	Niu Zhihong <zhihong@nzhnb.com>
 S:	Maintained
-F:	board/xunlong/orangepi-5-rk3588-ultra
 F:	configs/orangepi-5-ultra-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-ultra*
diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAINER=
S
index 013cb84b99d2..4a84d2437c3c 100644
--- a/board/zyxel/nsa325/MAINTAINERS
+++ b/board/zyxel/nsa325/MAINTAINERS
@@ -1,9 +1,6 @@
 NSA325 BOARD
 M:	Tony Dinh <mibodhi@gmail.com>
 S:	Maintained
-F:	arch/arm/dts/kirkwood-6282.dtsi
-F:	arch/arm/dts/kirkwood-nsa325.dts
-F:	arch/arm/dts/kirkwood-nsa3x0-common.dtsi
 F:	board/zyxel/nsa325/
 F:	include/configs/nsa325.h
 F:	configs/nsa325_defconfig
--=20
2.43.0


