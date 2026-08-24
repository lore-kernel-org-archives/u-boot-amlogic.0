Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFEC61DBD
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (SJ2PR03CU001.outbound.protection.outlook.com [52.101.43.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13405.1787566091142939667
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 03:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=S9CBNqUq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.43.43, mailfrom: michal.simek@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1YabO8z94Cngrd4HrGEdhlxW0OulyrvdlPpYZ1KzXdFmd1LJP/+fI1FKY/N5LQHgKuhHLRPMdsxAndmN7UZMhog7UabeVBoSKq/1GV9Kmj7AvhrgJ54WLALMosntJ6pE8008uqHoylHCrkBnsvt0cWTa33PTgwXCiAo3Nn6eUNeMuKKVaeD0Qg9urtwdc1Mq4OQzZGKCmgxwmgNrkSBCQ/g4PNsqucwW4vOXEdnl5yW+c3fCwI3K2au6gyk7XDMJJ3DgwcYmqjdp1ume56vPQ7ZNvZd2lsjz1YKEpTIGU4OJ/f/29YVmT5Wlu/pM6VCDkHOb40F9SBEZWLF6r0ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4cnIG8yyx013J3uVrpbTyUYBy4HUHcWyDNmTdHMYo=;
 b=NtJ8UBHQh8cmAbeThTGQdKXyrFydDkB0DDlGtaros9ShN2mMiUmK6PrXGnlO/JuRXXH4U0K6yyRYVwisy/cnep3hluUIMCEWxqmKndYJ4yaOX9nR1cbB2v9hy/wjKuxAIMguPi5ofJiK0wDe0XWS7pupQTtWJVPK0ifIJPfDPfl72ZDeN6hULhe7iRwoCmJedX4XkwdA9xMu2TzavESrJ5QF6u/libvsMt17WkztN7CWtlyb7huCcZIDPJ8TMpLLbqev9GnR0RnlMrfMEhIbDy4C+TO2ZG0snU3iUE93fj7pkZuuSA8Vr/eL2Dl5fX8ejnFT/ADhz5HJoyq1aXFSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA4cnIG8yyx013J3uVrpbTyUYBy4HUHcWyDNmTdHMYo=;
 b=S9CBNqUq1LyLs2SXtZdTIzLbdGwGY8m2FzDJNZz7d81Qpl/JhRYrXNV5EMuoaEhiT+eK+w/6SnM4er1vAxEioHzZpU3DWTo9YZ61C/GJvUOXoDcDZbyrpbNH+dE4B+eegr90KJV1YQE4piauMLo+P1RYpMEr67w0lFo+cWSnddY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:07:59 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:07:59 +0000
Message-ID: <e14e6b85-97d7-4546-88d5-7d5e3a875ae7@amd.com>
Date: Mon, 24 Aug 2026 12:07:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, git@amd.com, Tom Rini <trini@konsulko.com>
CC: Aaron Williams <awilliams@marvell.com>, Adam Ford <aford173@gmail.com>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Allen Martin <amartin@nvidia.com>, Andre Przywara <andre.przywara@arm.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinh.nguyen@intel.com>,
 Dominik Haller <d.haller@phytec.de>, Dzmitry Sankouski
 <dsankouski@gmail.com>, =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>,
 Eugen Hristev <ehristev@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Gilles Talis <gilles.talis@gmail.com>, Green Wan <green.wan@sifive.com>,
 Hans de Goede <hdegoede@redhat.com>, Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Mathew McBride <matt@traverse.com.au>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Geis <pgwipeout@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 "maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>,
 Philip Oberfichtner <pro@denx.de>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Randolph <randolph@andestech.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>,
 Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>,
 Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Stelian Pop <stelian@popies.net>,
 Stephan Gerhold <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Warren <twarren@nvidia.com>,
 Tony Dinh <mibodhi@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 "open list:P212" <u-boot-amlogic@groups.io>,
 "open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>,
 "open list:phyCORE-AM62ax" <upstream@lists.phytec.de>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fa38d1ba-ea87-4e29-905d-f71c04dcd458@cherry.de>
X-ClientProxiedBy: VIVP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 599096be-4418-4215-627d-08df01c7937c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	kUGE+q8uD7AA/jEQh98yuJhYqvgHrEqvUNFpbGNvDf9Ot7f3mAk50GKgmR8Xfk0qE2fxkkkaZVWLFEldXMb139d8yeKDDT9PQ2Mt1iFBMl7LjFpTzPhGDoEPTo8Gj+bpKgrBxGFmtc1Rssdrr8QuN5e76RIfocZHhIeu8EDTmtMNTCaNpW7TZWUV6tgYdPJdJCD24AdZnpEtdOrGkfXYoNgqVDCUR3OmI7zL2Wu4X0dHxSaHq6b7Pv3fCoIZykANcEUxJYyFhCF7WdvDTrhQ+kLYG64FvmdPCGMhKMmwAXFgnMUwoJYCXspfbD2xFYFrBq0P3ALGuooEB4FgrlmEWQkDFKX9zG4ZsqNtCvoeIvtwUCpni6UMC8ecR/aoNcj2ksbeHi6BMNQoAT3UebqCRK4ii/8zDQcAgXJSUCXuKisPOrKIFEKT66rkCZuqVcKqSL6a3r/QLs7CiaNs7fk/a6J/AcwN1zklqq0DFxQI5YhMrCLxMCb194lEIKwCCguKJx42rmXaMvvBELLxdnw57FiB6udGsoQLBWD7/Wd/3ZgckIJ1x65b7ZnPcPswQT0+k9fP4zHNF2TAaej8Wmndv51rk/jyOQUJsaRfKpzWQDCU8zX8pg8fZPG5v1Wq2oLyM+94S/OdD9IBYmMa/Nrj/V2wGddrWNLeSrcFKHaRJjk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQaWNFsO+m+BauOU0qwUgyD4HXDgFKfMCqh5bExHVor4yMsY5fO8COwWGHq/?=
 =?us-ascii?Q?98yf/FI4CfLcow2fTwBMgPnCD0vn1M6CRb+r7YJRt9m0Uflac+UyVSDHi1kX?=
 =?us-ascii?Q?n+/g1/SoJqZRTpVesREcFbT7p0gth+MPoz5/YUZeU+vYMYYqHccupCGlIg61?=
 =?us-ascii?Q?QjO0ZtNW0BsLMRveHNGskTYHDPQ4G4E6eLdWBXxNjxkaJ55ywv2jsv8INRTT?=
 =?us-ascii?Q?mRk2EyLRFqaaixYJo4o/LRli3N53ALHx8KL5FMnjOJIpu2kRmtZ4OkEuuAmG?=
 =?us-ascii?Q?q8i0f00gEp8t8SEoPLRSDVb9nwG4U951gRWxcmMbnm2si6xcVR8fE7Ps0X8U?=
 =?us-ascii?Q?ifTnAIlZi09baw/gWnRh1QWvieWA1yBg9/ZJLxGiVJaGaGc4fXyFZWNkFehw?=
 =?us-ascii?Q?apgaCy9q2YsL4UX6MEBJ9VFFi8ElJs0yQIPdfpFiaIwUjuawN4TxG37EJAPR?=
 =?us-ascii?Q?HHvRrijZ7Ybr9rwyKfHRiJ9Uqek/xOBAvmH5sEL+qGByR31zoxUisJU7pNC5?=
 =?us-ascii?Q?ckIaVuxxyw8ROGuJg+0YD3s+OxD480N3EjCeJu4TZ+2/K5i2jZlOECvePNfT?=
 =?us-ascii?Q?DJ18rwV+9c9niWjIg6JTtH8lxvwTGEpyN1hLEwC8bfpLD/djE+DT9ZirXWP9?=
 =?us-ascii?Q?51RLTduZgEazAs8OVkM6GS/SxtuGs1ZO6carkhLEnF+qRu7JY3AUHY3bDRbt?=
 =?us-ascii?Q?Or1mm0H5Hw8Xx7GuQ78B6hOgucKIr9Uzz6O5F5spFJPWMK56f9gUmedbdP0n?=
 =?us-ascii?Q?KJI/po1l5S3z1Hlgr8xg+PTb2dutiYHX5h7SZNXJ1mruJskwoCs8gP4vaexZ?=
 =?us-ascii?Q?vFZfEiLEae6pJU66DZYnG+19k3e0SZP9v6j17wKsEKmzeXp78OmTMEZJ0ADh?=
 =?us-ascii?Q?QsD+2UJAEXpXaOGKEsuMaIcIzSWhGMRdYJmgHrWEvPLCeWpRP6XXSrfOor8Z?=
 =?us-ascii?Q?feC+LlM0sog0R2ZNOywQl+0ks4l+HoCnmuYrbXJzsbaiBqE3P0mlY3q85W44?=
 =?us-ascii?Q?cypgfqG0nrDE6D1V6A9g/muD5Levny5TfJiGyst8jn4dWvAokjMYlD3DkcIq?=
 =?us-ascii?Q?mxoPn8aBI8Bkws7UTeqJjUBEOG89AzKbKdyVVicDleUdEgRRgfxXgvNUThMY?=
 =?us-ascii?Q?CGPKRtLNCjp95IQUU55MDGWgLQRJwrfsCabiDtJagOcu7h/M1kGd0Uw+Itr5?=
 =?us-ascii?Q?J20JW3SF12lYKI4NN1GnnRxnAEqOo7h07tchvh9KXhAru9gu0uw4oR+up/d5?=
 =?us-ascii?Q?DwTZtWBwOXgowtMOS4u1A6pMauHWgkDcGG9g4BcxswAFH4Ix3nwa9pfT8X2E?=
 =?us-ascii?Q?ChcXXqDjMkgk53wItNaMry54cvU5Oi05984NuYHs8jlhJo1KHZijcokUiyEU?=
 =?us-ascii?Q?XhOkh+ZzdoU4kXdpjhtZFX2Rh0iqxaWhyENoKoPr/L+ZaZ4++Dw1Ahia4hZS?=
 =?us-ascii?Q?7B8tqNVzvKRFim24/V3Y0ANsVH71TGE0SiVCrp2lbuIqGZbTGyjJnePYIdoa?=
 =?us-ascii?Q?ywSCdIk8HUB/LD10l8iJNfcutvryrZurwIQa4S1GFV9FU55uLk0J3yuDp1v5?=
 =?us-ascii?Q?kJ3fIExunWkugFkPj+koIy+luAd8mAzAZQT3I5COG0AvbL+ETxYTffN/hdrT?=
 =?us-ascii?Q?l6xXOjyKhCeX9Br5VzjZ/Seiqlc4ilqTLhLvRngiZASxc1mx065KgsnpzdKV?=
 =?us-ascii?Q?AEytPlYRpFw7GJnuNxcfDr9N9g725fCoLSwlc/82FzqXNA1e1XXxiDO2/Ywv?=
 =?us-ascii?Q?ZayVWvMN6Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599096be-4418-4215-627d-08df01c7937c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:07:59.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zc/OVGKWYcuI5/CMSC8zF/72c0SCnRY+SGfkS/QaLtN3ErEzLJR02pEkqY7vzfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3047



On 8/24/26 11:54, Quentin Schulz wrote:
> Hi Michal,
>=20
> On 8/24/26 9:18 AM, Michal Simek wrote:
>> A number of file (F:) entries across the MAINTAINERS files pointed to
>> files or directories which had been renamed or removed over time. Drop
>> these stale references so that every F: entry resolves to an existing
>> path.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> [...]
>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-=
=20
>> rockchip/rk3576/MAINTAINERS
>> index 79cf9e97f70b..62c3ce765e0d 100644
>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> @@ -13,7 +13,6 @@ F:=C2=A0=C2=A0=C2=A0 configs/nanopi-m5-rk3576_defconfi=
g
>> =C2=A0 NANOPI-R76S-RK3576
>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Jonas Karlman <jonas@kwiboo.se>
>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>> -F:=C2=A0=C2=A0=C2=A0 arch/arm/dts/rk3576-nanopi-r76s*
>=20
> This is a leftover from v1 which had a file there, but we merged the v2. =
See=20
> https://lore.kernel.org/u-boot/20260108143551.4017839-3-jonas@kwiboo.se/ =
and=20
> https://lore.kernel.org/u-boot/20260310000610.592998-3-jonas@kwiboo.se/
>=20
> For now we don't have U-Boot-specific additions to the upstream DTS for t=
he=20
> NanoPi R76S but we could in the future, so having a wildcard like that wo=
uld=20
> allow Jonas to be notified if one ever gets added. So it's not completely=
=20
> useless. No strong opinion on still deleting it or not.

File is there or not. If you add it in future you should extend that fragme=
nt=20
and that's it.

Thanks,
Michal


