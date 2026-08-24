Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49244C61DB7
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11524.1787556833808567757
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 00:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=WjR911rE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.4, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc7afIvOn0wy46LkTq3PWNPDy+A53Fsf1yECoX+hF0K8vgLnlWrcZmUeC3yXBskh0IpvYR8aYBqzQQW8DomMbGmiQwdYuw7yuJBgFjbJqUAQWVyQFSBHR4x9Ju0mr35qgTg+ObkPTweC1Q++xjbJzdqEqHmsZ3fMn9ganvRw+tMtMPfr7PExegIIrXtEqDmASuY8qgSlv8IVpDkZ6L4ZzlsYhsyF40NzdEs+yMlU36HmirqmtUMFq4cCe3C8yTA/Zs28A6/9duaOi1IWEmxQKtrib9EUsVKOoRgwC+fIDlUJNuXqD7DZ7XNKq7jNaXRLetP48CEAE3k34KDgK0pfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq20E+XRwwhHZtZCfW90z0Hzst6NLxjuzCmeBFMAsyk=;
 b=TMfZqSoWh+qfV5+9sE3c+INueH6ehRIbhCMIgzCB5vAui0g8aU6FyGX0JNTgj08liMHv7/Xby/xYmZUs4AQyYjqJE/hwHsSuaXYWbHshFzeTx9wCUQxa8jH3nmxhIMHzaJUS9NhUFe/dMC8XGtxWZQlWGaBqjyJnjN1XEoHkQQWNtb8oJgzU/Vg6c/i9KDwknYODmuIuVXLc6knW0t99p0mKmrwxJ6nR5svGEznkw2oLAocAASVpq49zgsEher7RUurVebJIbBb3+sgXYQVJqrK/XMUvVZdjy/af0xbOuvwC5Y4pAhKE7J2PFLrpJs3MgpaDF0K6rGuRLKiuN6qmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq20E+XRwwhHZtZCfW90z0Hzst6NLxjuzCmeBFMAsyk=;
 b=WjR911rEaDfhOQhrjqtI/Tyrs+GJkFYg5limT8eg1eXSSnqMQ1TcPH7uJ+AueI9GzZqalY2y9+dkZDDw4UDrmPpQjK2tgzDoc0LIomwg2XTcouvR5LYpG/bwbMfedPqcnWvr4kx+4ziD0jqWDTUh8dcRJqfWb53zBMf9odud9ug=
Received: from SJ0PR03CA0125.namprd03.prod.outlook.com (2603:10b6:a03:33c::10)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:19:16 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::73) by SJ0PR03CA0125.outlook.office365.com
 (2603:10b6:a03:33c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Mon,
 24 Aug 2026 07:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:19:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:19:10 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:19:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Tom Rini
	<trini@konsulko.com>
CC: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
	Alban Bedel <alban.bedel@avionic-design.de>, Alif Zakuan Yuslaimi
	<alif.zakuan.yuslaimi@altera.com>, Allen Martin <amartin@nvidia.com>, "Andre
 Przywara" <andre.przywara@arm.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
	"Bryan Brattlof" <bb@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
	"Chee Hong Ang" <chee.hong.ang@intel.com>, Chee Tien Fong
	<tien.fong.chee@intel.com>, Chin-Liang See <chin.liang.see@intel.com>, Chris
 Packham <chris.packham@alliedtelesis.co.nz>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, "Cogent Embedded, Inc."
	<source@cogentembedded.com>, David Lechner <dlechner@baylibre.com>, "Dinh
 Nguyen" <dinh.nguyen@intel.com>, Dominik Haller <d.haller@phytec.de>,
	"Dzmitry Sankouski" <dsankouski@gmail.com>, =?UTF-8?q?Eric=20B=C3=A9nard?=
	<eric@eukrea.com>, Eugen Hristev <ehristev@kernel.org>, Fabio Estevam
	<festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, GSS_MTK_Uboot_upstream
	<GSS_MTK_Uboot_upstream@mediatek.com>, Garrett Giordano
	<ggiordano@phytec.com>, Gilles Talis <gilles.talis@gmail.com>, Green Wan
	<green.wan@sifive.com>, Hans de Goede <hdegoede@redhat.com>, Heiko Schocher
	<hs@nabladev.com>, Holger Brunck <holger.brunck@hitachienergy.com>, Ian Ray
	<ian.ray@gehealthcare.com>, Igor Belwon
	<igor.belwon@mentallysanemainliners.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, =?UTF-8?q?Jonas=20Schw=C3=B6bel?=
	<jonasschwoebel@yahoo.de>, Jorge Ramirez-Ortiz
	<jorge.ramirez.ortiz@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
	Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>, "Ley
 Foon Tan" <ley.foon.tan@intel.com>, Lim Siew Chin
	<elly.siew.chin.lim@intel.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
	<kabel@kernel.org>, Marek Vasut <marek.vasut+socfpga@mailbox.org>, Martyn
 Welch <martyn.welch@collabora.com>, Masakazu Mochizuki
	<masakazu.mochizuki.wd@hitachi.com>, Mathew McBride <matt@traverse.com.au>,
	Matthias Winker <matthias.winker@de.bosch.com>, "Matwey V. Kornilov"
	<matwey.kornilov@gmail.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, Nobuhiro Iwamatsu
	<iwamatsu@nigauri.org>, Oliver Graute <oliver.graute@kococonnector.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>, Peter Geis
	<pgwipeout@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
	"maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>, Philip Oberfichtner
	<pro@denx.de>, "Pramod Kumar" <pramod.kumar_1@nxp.com>, Priyanka Jain
	<priyanka.jain@nxp.com>, Quentin Schulz <u-boot@0leil.net>, Randolph
	<randolph@andestech.com>, "Ryder Lee" <ryder.lee@mediatek.com>, Sam Day
	<me@samcday.com>, Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu
	<Shengzhou.Liu@nxp.com>, Simon Glass <sjg@chromium.org>, Simon Goldschmidt
	<simon.k.r.goldschmidt@gmail.com>, Simon Guinot <simon.guinot@sequanux.org>,
	Sinan Akman <sinan@writeme.com>, Stefan Bosch <stefan_b@posteo.net>, Stefan
 Roese <sr@denx.de>, Stefano Babic <sbabic@nabladev.com>, Stelian Pop
	<stelian@popies.net>, Stephan Gerhold <stephan@gerhold.net>, Sumit Garg
	<sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>, Tien Fong Chee <tien.fong.chee@altera.com>, Tim Harvey
	<tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>, Tony Dinh
	<mibodhi@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov
	<w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>, Weijie Gao
	<weijie.gao@mediatek.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, "open list:P212"
	<u-boot-amlogic@groups.io>, "open list:ARM SNAPDRAGON"
	<u-boot-qcom@groups.io>, "open list:phyCORE-AM62ax"
	<upstream@lists.phytec.de>, =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?=
	<noltari@gmail.com>
Subject: [PATCH 0/3] MAINTAINERS: Cleanup non existing files arch/board
Date: Mon, 24 Aug 2026 09:18:45 +0200
Message-ID: <cover.1787555916.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8252; i=michal.simek@amd.com; h=from:subject:message-id; bh=ZgT8W+YsPzCpCyW3yE+2h6wzaev4dD7cnNGUStKLE1c=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR1f0hgq399pCmqnX8rY8Zuo1/6MSxPJkmfjJfvPPBja 6bxrwfxHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRl7cYGe5bnBL/+b952x9h 6XUeO+ad4WCNU09oWxUemd+tH/ecx5rhr9zWGyvXpqgbfTY0P2CTu3qqSOrVf99VRL+wb9mTu/+ HHTMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: df68ac5a-56c3-4679-0ac3-08df01afff50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	/Nntx1lHCvP/DZbmxjYSTC3tjkQVMiBG+UhKEl9iCaZrPqdoCZG/b14u6fbKudyXIaahNLZ7KUj+VeEmKg+REP/HQeedZUuGBsc9H430NVMgWYZMrYdNaGvIb8f2hvJQgWFylRR7RNz5Z5GM8a2i4hQhXXxHk7P1G9aiFWDPBlYSuFlqd/5gW3BwCOGruiCEm1CwMX/oDFd/ELdKgBmCw64NPPjwtEU7GVv1hfZ5f9OI8l35rC/9GouE/v6uFcS3lvS7RHbc1S0vRi+1YxXlV/v46D58+rZpSgPHJZLfG0RAmCewVpH/le6qWZHpmekUijuVN+QPQhtXVKSJN6t8tV87/te1C85odefXvnUbu3SSnK0/iFQIapcmIq3qt1Gr4+F9JSeo8pcOvwcMEPxP86zYN1AlgsZNSeRy7EDM0ddLkje53gRElix4uEE4XowqCmi+JnkUCTUyIjOuefyjaC+N9oZiZWQVRiddHMaCnKXwb8ih56L0T9pbXzPVe56XvnYpgeRcjwrlMQEG1D8O2WW9ZBNGHIsUkqBEoDCKc+enJrhuRDvB7RdaSgDbpefWrjGfy9lJsGf6QAGMlTVa4mUMzAJ6E4mKT/gBNtFjtYz+k155kssFENsIoe4CdxIlkTAxmO1DtB2x2wXEHo1iOlTYmAtRjjMehJ4gioQ0RxGA43SP6bSYj/f7IsIvgg3qjGBwODg8cAzkJUkeWaY3jQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	eEe+txFmVnpF1O9hoJRrZR4hMvKKlh+smQgYjnsaqt1JtGlchxW1VnRtRqiBcrLKGPKqR7w6oXhCXiRtUvepF0gV6DHtpUFzmZHtrccvktuJdfvxwyJMzRzj5e5msa4iuex5zutaSyduEwMfZET2a1g6JCX1icAgEnMqGUJRNhN/HaDMZQt2zWvo+0E2dShqk+ctTE5I+/zIXFJJlzfyQspKlnp1WxifEzF6/YMV4DQFdwBe30HWFbVqBvt+eK/pzXabq6P6d3UW6z/ZbW5jfYFlecNc6xePeYtMUQzywaF7vPqUirKaYLJdUFVDdQTjl1yM2hetwKSuSBTcCTx24uFDKk7Im2aJGiqpEp5DiupzpZDBJURhnDIARen9wWnz0a7tblKGZDAWOHes6XV9dyvbvnnMI+qFYD67So1I7cQDsnGoaK1uPmcL7qq+/FnX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:19:12.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df68ac5a-56c3-4679-0ac3-08df01afff50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3044

Hi,

based on ask from Tom here is script extension to cover all MAINTAINERS
files in the repository. Small fix for one of my fragment and one patch to
remove references in other files. A lot these changes are related to
configs files and device trees (likely because of using kernel one).

A lot of these files are also in utf-8 which likely should be converted to
plain text. But Tom up2you.

Thanks,
Michal


Michal Simek (3):
  xilinx: Correct zynqmp_r5 MAINTAINERS fragment
  scripts: Check F: entries in all MAINTAINERS files
  MAINTAINERS: Remove references to not existing files

 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  1 -
 board/CZ.NIC/turris_omnia/MAINTAINERS         |  1 -
 board/LaCie/net2big_v2/MAINTAINERS            |  4 -
 board/LaCie/netspace_v2/MAINTAINERS           |  6 --
 board/Marvell/octeontx/MAINTAINERS            |  2 -
 board/Marvell/octeontx2/MAINTAINERS           |  2 -
 board/Synology/ds116/MAINTAINERS              |  1 -
 board/acer/picasso/MAINTAINERS                |  1 -
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS  |  1 -
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS |  1 -
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS    |  1 -
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS  |  1 -
 board/altera/stratix10-socdk/MAINTAINERS      |  1 -
 board/amlogic/p212/MAINTAINERS                |  1 -
 board/amlogic/q200/MAINTAINERS                |  1 -
 board/amlogic/s400/MAINTAINERS                |  1 -
 board/andestech/voyager/MAINTAINERS           |  1 -
 board/asus/grouper/MAINTAINERS                |  1 -
 board/asus/transformer-t114/MAINTAINERS       |  1 -
 board/asus/transformer-t20/MAINTAINERS        |  1 -
 board/asus/transformer-t30/MAINTAINERS        |  1 -
 board/atmel/at91sam9260ek/MAINTAINERS         |  1 -
 board/atmel/sama5d29_curiosity/MAINTAINERS    |  1 -
 board/atmel/sama7d65_curiosity/MAINTAINERS    |  1 -
 board/atmel/sama7g54_curiosity/MAINTAINERS    |  1 -
 board/atmel/sama7g5ek/MAINTAINERS             |  1 -
 board/avionic-design/medcom-wide/MAINTAINERS  |  1 -
 board/avionic-design/plutux/MAINTAINERS       |  1 -
 board/avionic-design/tec-ng/MAINTAINERS       |  1 -
 board/avionic-design/tec/MAINTAINERS          |  1 -
 board/beacon/beacon-rzg2m/MAINTAINERS         |  3 -
 board/bosch/acc/MAINTAINERS                   |  1 -
 board/cei/cei-tk1-som/MAINTAINERS             |  1 -
 board/compal/paz00/MAINTAINERS                |  1 -
 board/compulab/trimslice/MAINTAINERS          |  1 -
 board/comtrend/vr3032u/MAINTAINERS            |  1 -
 board/comtrend/wap5813n/MAINTAINERS           |  1 -
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |  1 -
 board/davinci/da8xxevm/MAINTAINERS            |  1 -
 board/embest/mx6boards/MAINTAINERS            |  1 -
 board/engicam/imx6ul/MAINTAINERS              |  3 -
 board/friendlyarm/nanopi2/MAINTAINERS         |  1 -
 .../gardena/smart-gateway-at91sam/MAINTAINERS |  1 -
 .../gardena/smart-gateway-mt7688/MAINTAINERS  |  1 -
 board/gateworks/gw_ventana/MAINTAINERS        |  6 --
 board/ge/bx50v3/MAINTAINERS                   |  3 -
 board/htc/endeavoru/MAINTAINERS               |  1 -
 board/imgtec/xilfpga/MAINTAINERS              |  1 -
 board/intel/agilex-socdk/MAINTAINERS          |  1 -
 board/intel/agilex7m-socdk/MAINTAINERS        |  2 -
 board/intel/n5x-socdk/MAINTAINERS             |  1 -
 board/keymile/km83xx/MAINTAINERS              |  2 -
 board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  1 -
 board/kontron/sl-mx6ul/MAINTAINERS            |  2 -
 board/lenovo/ideapad-yoga-11/MAINTAINERS      |  1 -
 board/lg/x3-t30/MAINTAINERS                   |  1 -
 board/libre-computer/aml-a311d-cc/MAINTAINERS |  1 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS |  1 -
 .../libre-computer/aml-s905d3-cc/MAINTAINERS  |  1 -
 board/mediatek/mt7981/MAINTAINERS             |  2 -
 board/mediatek/mt7986/MAINTAINERS             |  4 -
 board/microsoft/surface-rt/MAINTAINERS        |  1 -
 board/myir/mys_6ulx/MAINTAINERS               |  1 -
 board/nvidia/beaver/MAINTAINERS               |  1 -
 board/nvidia/cardhu/MAINTAINERS               |  1 -
 board/nvidia/dalmore/MAINTAINERS              |  1 -
 board/nvidia/harmony/MAINTAINERS              |  1 -
 board/nvidia/jetson-tk1/MAINTAINERS           |  1 -
 board/nvidia/nyan-big/MAINTAINERS             |  1 -
 board/nvidia/p2371-0000/MAINTAINERS           |  1 -
 board/nvidia/p2371-2180/MAINTAINERS           |  1 -
 board/nvidia/p2571/MAINTAINERS                |  1 -
 board/nvidia/p2771-0000/MAINTAINERS           |  1 -
 board/nvidia/p3450-0000/MAINTAINERS           |  1 -
 board/nvidia/seaboard/MAINTAINERS             |  1 -
 board/nvidia/tegratab/MAINTAINERS             |  1 -
 board/nvidia/venice2/MAINTAINERS              |  1 -
 board/nvidia/ventana/MAINTAINERS              |  1 -
 board/nxp/imx93_evk/MAINTAINERS               |  1 -
 board/nxp/ls1012afrdm/MAINTAINERS             |  4 -
 board/nxp/ls1012aqds/MAINTAINERS              |  1 -
 board/nxp/ls1012ardb/MAINTAINERS              |  3 -
 board/nxp/ls1043aqds/MAINTAINERS              |  7 --
 board/nxp/ls1043ardb/MAINTAINERS              |  6 --
 board/nxp/ls1046aqds/MAINTAINERS              |  7 --
 board/nxp/ls1046ardb/MAINTAINERS              |  7 --
 board/nxp/ls1088a/MAINTAINERS                 |  9 ---
 board/nxp/ls2080aqds/MAINTAINERS              |  4 -
 board/nxp/ls2080ardb/MAINTAINERS              |  6 --
 board/nxp/lx2160a/MAINTAINERS                 |  2 -
 board/nxp/mpc837xerdb/MAINTAINERS             |  1 -
 board/nxp/mx6slevk/MAINTAINERS                |  2 -
 board/nxp/p2041rdb/MAINTAINERS                |  3 -
 board/nxp/t104xrdb/MAINTAINERS                | 13 ---
 board/nxp/t208xqds/MAINTAINERS                |  5 --
 board/nxp/t208xrdb/MAINTAINERS                |  1 -
 board/ouya/ouya/MAINTAINERS                   |  1 -
 board/phytec/phycore_am62ax/MAINTAINERS       |  1 -
 board/phytec/phycore_am68x/MAINTAINERS        |  1 -
 board/phytec/phycore_imx8mm/MAINTAINERS       |  1 -
 .../polyhex/imx8mp_debix_model_a/MAINTAINERS  |  1 -
 board/qualcomm/dragonboard410c/MAINTAINERS    |  1 -
 board/qualcomm/dragonboard820c/MAINTAINERS    |  1 -
 board/qualcomm/dragonboard845c/MAINTAINERS    |  2 -
 board/qualcomm/qcs404-evb/MAINTAINERS         |  2 -
 board/renesas/blanche/MAINTAINERS             |  1 -
 board/renesas/eagle/MAINTAINERS               |  1 -
 board/renesas/grpeach/MAINTAINERS             |  1 -
 board/renesas/v3msk/MAINTAINERS               |  1 -
 board/samsung/starqltechn/MAINTAINERS         |  2 -
 board/seeed/linkit-smart-7688/MAINTAINERS     |  1 -
 board/siemens/iot2050/MAINTAINERS             |  1 -
 board/sifive/unmatched/MAINTAINERS            |  1 -
 board/sunxi/MAINTAINERS                       |  2 -
 board/ti/am62ax/MAINTAINERS                   |  1 -
 board/ti/am62dx/MAINTAINERS                   |  1 -
 board/ti/am62px/MAINTAINERS                   |  1 -
 board/ti/j7200/MAINTAINERS                    |  1 -
 board/toradex/apalis-tk1/MAINTAINERS          |  1 -
 board/toradex/apalis_t30/MAINTAINERS          |  2 -
 board/toradex/colibri-imx6ull/MAINTAINERS     |  1 -
 board/toradex/colibri-imx8x/MAINTAINERS       |  2 -
 board/toradex/colibri_imx7/MAINTAINERS        |  6 --
 board/toradex/colibri_t20/MAINTAINERS         |  2 -
 board/toradex/colibri_t30/MAINTAINERS         |  2 -
 board/toradex/colibri_vf/MAINTAINERS          |  1 -
 board/toradex/smarc-imx8mp/MAINTAINERS        |  1 -
 board/traverse/ten64/MAINTAINERS              |  1 -
 board/wandboard/MAINTAINERS                   |  1 -
 board/wexler/qc750/MAINTAINERS                |  1 -
 board/xiaomi/mocha/MAINTAINERS                |  1 -
 board/xilinx/zynqmp/MAINTAINERS               |  1 -
 board/xilinx/zynqmp_r5/MAINTAINERS            |  2 +-
 .../orangepi-5-ultra-rk3588/MAINTAINERS       |  1 -
 board/zyxel/nsa325/MAINTAINERS                |  3 -
 scripts/check_maintainers_files.sh            | 80 ++++++++++++-------
 136 files changed, 54 insertions(+), 269 deletions(-)

---
base-commit: 2d379a529c257606946831a6dac1c37de6a3f8c0

--=20
2.43.0


