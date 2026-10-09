Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D64CA9ED2
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:17 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1024.1791566387163200673
 for <u-boot-amlogic@groups.io>;
 Fri, 09 Oct 2026 10:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=eE09xTjE;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=eE09xTjE;
 spf=pass (domain: arm.com, ip: 40.107.159.26, mailfrom: jerome.forissier@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lDk45PeI/I1BA718NSO7eA/WEr0q3PUMy6gabhKh7xhFZAmr7fx/8s+L7uRMFzBRTN057ZN6QMttk5uN8y8ly8UNrdCuOTFeYtZUw0+3TxyerRPVVh+KF8LNWZbuwrd8nV0n+0gdy2xcBWGJiackABF/rwlYr6a9P6OZk7F5lpEOR4zfH5GMqJuhUJMIc2K6I+Hl4IqSu5wSAJhFbCc7tJ8b7W5xsVLyObLeo/d/DScjnDvelAvrilImCfKXDLfGrrMAy1nEZWWL0k71ubG5ITxE2uLwmJCDXsucQ1XddNExGOKI2az9jYNiYqDT1l0gc9pPsGJIOlRnWcODMjkD0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=I0d3275aCUeo0zFdnNZK6b2gk3TtJ1UfRN1m3RBoE5B1JzFQYSskVdNbVzIVUeXbN2/XM81Cc+UioFF6CIljBb3aAfXdgoC5xUNN2L1wk30TjADFZ728lJPohmKRXscJOar1hJjVeUtX12HT3PfxUibmf8k70DFnsZIpoHrbR+6pJm23eTSHoIxDmakPwEkP74eWxA5uFRyaxjm4IFBm4s6NZz++Zphc8EV/owLr3do3QMWAEXLOPV4pp7ElwNqPVOzad8aNJoDrHsZ85u+JscafSpqPF06Tap5X5qcpI+S5Z6bHp2JVohnWBxw44jbqZiYEy0JYOoA+8xgnT4FO4A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=eE09xTjEwJQibAIPJCZ6hnX/HQZnRQdWxcNcruEvLMnN1a/B4b0MNXpVyAyG6EkCyfsGOA++zefMg9JPRtm1qFMGSm+nqeV4KQvAFlTSlUH/5iZ4KhQhX+olhS1ShM3np6ySy3ZwF0OdRHml5nSznBD3PrgO+CNqdj6nxGbb7Uw=
Received: from DU2PR04CA0169.eurprd04.prod.outlook.com (2603:10a6:10:2b0::24)
 by PA4PR08MB6319.eurprd08.prod.outlook.com (2603:10a6:102:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:05:25 +0000
Received: from MAD0EPF000008AD.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0:cafe::89) by DU2PR04CA0169.outlook.office365.com
 (2603:10a6:10:2b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:05:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008AD.mail.protection.outlook.com (10.167.241.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgiTTot7U+yoIQJq6AaQ3sVfDOzLNAb44MZh9ZQbyagpZbGHq9MudCSTtz/+2HN5JnhHSYi4pfR77vhFzHTmvPXGIm2IjgeEEq44oyAtF1GduZhPb2D4nlyxyKQj3QBI9MFfSZA04VMA6gw8SkKG2bbB2IpcJ/5dMa5EBDLdsnTnQ67keDd0Vltg1EaoRI64nd1MpmirYP598qqyTXYRUAeqV+MnY18SkM7K7NG/FXv0wT3tr7r0ZAMr0GO07XtRzwotxS99KXn7uG6BL6xc8Di0eLyWHN0ZMU2qhPU3whBg6U6TVIq+yYLyxcnlNISQEhFULIhxexEFEVfm55upfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=VnPFQ08dBHQ6LicwkAtNX85ZY8261aln7XEzGvraqVwfHTw7t/8gpEjwOKVA0zPbqNHYaZuewQfPFHM8pjqI1ls0og8WGcAgjlI4/ZV/E3o3HEuU98ZFOPEArU7gmJGhABL8eI21W/O0ESuBrRbzywmfCCVu0eASRZbKwYfxC3Gqoc5n6sNCXS+46Wgu5M6kkqa4ED61+dIpL6IGeAIRB5XlYaEwl73ggQf4kjI0AaVNDj6Cp0uJz5KDjKwsEq4CBYPTZmhVgdg4scVB0VvOrJNbywtClh5R0EaWpDwZj4UxdTfJMYDQg4SkGq7OGjdJpFTlJpnwJ8O3gFhcOZUGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdsI7+40lrXLm8wOp5F1G+rkK04U1a5qE8MPJBPhFtk=;
 b=eE09xTjEwJQibAIPJCZ6hnX/HQZnRQdWxcNcruEvLMnN1a/B4b0MNXpVyAyG6EkCyfsGOA++zefMg9JPRtm1qFMGSm+nqeV4KQvAFlTSlUH/5iZ4KhQhX+olhS1ShM3np6ySy3ZwF0OdRHml5nSznBD3PrgO+CNqdj6nxGbb7Uw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10251.eurprd08.prod.outlook.com
 (2603:10a6:20b:647::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:04:50 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:04:50 +0000
Message-ID: <d909d503-80f8-4d67-beb8-b698611b0495@arm.com>
Date: Fri, 9 Oct 2026 19:04:49 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/2] net: designware: Fix MDIO bus getting bound multiple times
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 Joe Hershberger <joe.hershberger@ni.com>, nd <nd@arm.com>
References: <20261005135406.509901-1-sanderson@brivo.com>
In-Reply-To: <20261005135406.509901-1-sanderson@brivo.com>
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: 
 AM0PR08MB11733:EE_|AS2PR08MB10251:EE_|MAD0EPF000008AD:EE_|PA4PR08MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9527d946-6dd2-4931-badb-08df262781e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 
 e6TzJzeQJdyhphTR+7QyfcduN+jFh/iic/7y/kVNJdlxBo+vlAkwRvJfY2ePyugjdZxmslami62kzMwdVn7fwWc1t+cb35nLF2xXWHao4Nq2DZydA9bid/0dYfMDFheIiKb24TBd7rLeSw/15L5222GBiWpJ7v3A/NznelM80Z8fvOooTMfYOkMJZNtWhfu06hhb/1IYy3Xg3uBaatxlYPthfcM9IGcm77itPtGZJW3hD+QPWioWO2nLD4FTDiyQdD6Jqkk6He/SyFuSuUlXve3HDXIubGpa3WF6UkOokknf74g9KKwlW+aW+xAz3eFYEbiDxfm7jsE3wcvUkUaapnW5EB7CnO82JaZ8k2ll6jr2ljmsw19Y3sZ76VFvEZIpquaNt+r5dbRJq4NVILd7iukqX+UvFUqaNQayN8MwH47QrZPunFFmCGf09Yx0Y/zzMqrUdOxXquOCAhrgZHLAXrQOLUXr60eQWn0k3zbRWCJ9E2H+IRuDR+IHQzwNp9GB1h3RcSBUZ6Yjmihb2xw3sE+XalwRqzRYMtLvZVp4psmbLu7An5tfhyBsEd2KS8GX2W+1aZ5CdGIUcc9/JEyqfeDZed/VsnpW1GNT0Oek7eK3leZFPuM99HS9IoiQETcWd2y7rjPz4vZpsvEpciLFPwa7hCIfa2bs/adg7cWYLpI=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11733.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked: 
 uRYpSbpZaRrTqi+pyB8a8M/ha++o3woWWUiZjebYuialmA3bTTRJ9y1yTpmCqEsQ+rW94HhqhlfmrCqAjMu81aN8wWHKQzfiOZm8bcc4iePHbh5czIlj4zw71G3HB/xazO/66X4LYhbZhL0wsfQsL2dlsskWMXp8mQYzUJpI/BXoRXBCSqG6P2fGsAI6u0YWNyCZarcqORblKz4vu/qKVd4EIhc99IOxLzLJOFO83JWioYBHHUiF5C/LQ62cAWXov72erLPwEN8ywjlkIne6H+bZXAYuGvyo2KcKwOuAhGSMp2PWf3NKqpnnU4+2MoAefV8EF3tuWkZN+e144hVuug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10251
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
 689741aa-e57b-4348-1a07-08df26276df6
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|35042699022|36860700016|23010399003|14060799003|82310400026|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
 sAmEHd3VKVKprDsn96Zo8yJtj4/4xzGv/eu4+gEHNEOyTxcOWAtKMi0aJEjNzwBP2gj0qyNAQuTeFLwp13Sbhcwy8cMw1/K8WaCMaME7Yn5ZC0HflLPyF17712AyHC6irbVPTIkOjJvWgi+o8G2DNVNVq85jQEmuf1nqO8V4pCynop9S0MR/8YyohygmtgNVHZ7WOAiYv28oB3lti/v3iMIEckThGIPRuphsif1PodR3w4EFwWEyUy5nPU6ssxZirS3vrVxhQGQcpoeDO92wISmhbhAnaID2SQTwSV1zeHdM/EcITtZDQwwvv+26IGBivl+Fwkt4wqJ/ZZ/3mNWN/0VsBBsM/H1FjSTd6CnTWk4nM/xi1Fd8FXpGjish+/XMdrFf6MQKQvHpfmlWkXIcR6tco7WezQwKw9s/NnXIAp7BQxut/r+s467V16HIcGHVWY0S2e0BqeuXXLhLyP7ou8MGqrBr5ZVj8nnUlC+rgCEuX4HPkvmdrO9hwWThDGStHXq0BKzKc6GpaURfZsClq9xd5hTSLM9RClk0901smh9rmrHrcm1Jt/5TRIWRxY5GtbCWmzhB4+UP2++P2+LZ4XUe9C6YFx/0OufuCgqSoQ5NHxKLIoqnYyRlfp6jx2H3E/3Xmox7bpHl+ODtFMCHu77so0Sky3/+SOSNcfpWjw8HsR1/Rjp84MO3jowye7fO+9lEHzcS8FoNFr2Gb93SRQ==
X-Forefront-Antispam-Report: 
 CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(23010399003)(14060799003)(82310400026)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 Ooi6ijoe4eXkUjqLaIfe1OPPdYH/zMEg7b5DoRqMhp2oVQ3CxfLtRaPHeXFMdr5G2wwpp83tLw06iWC4cNs86Z8coDSuGFhXmyO6oS5E3FTvZuFNGRBExDxoYrvatydlqimo9fwLKDMkkCqN9vzUDRcnw2anwp20aN2hNlpprvJEJyIHKJTyVQtrtISGoe/FIgfXviBRqnSb2+uQlkAhHyDZuGDK9ge7DpuVCgyWCN5cG4v5IuVh/20KcF6SmkMfQlUnG+GDvSGcokESY8BLMYniVLONH/H3as706yv+9mF7sqPeFFQ3xszYy7FtMV1EFYCV4wgDdfexrwaklM1ZgDFl0/X7wD/Z3NOEAmNFazsYKcMe1w0ZQOaFQyjafe87cdmfEoQkYMjCZpovCedDudGa7vQ+/MukGePjJKoP77NZVbvIEV0vgwM+UUq3Qw3A
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:23.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9527d946-6dd2-4931-badb-08df262781e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6319
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Oct 2026 09:35:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3126

On Mon, 05 Oct 2026 09:54:01 -0400, Sean Anderson wrote:
> This series fixes a bug caused by the MDIO bus getting created in
> probe() instead of bind().
> 
> Changes in v2:
> - Use if instead of #if for DM_MDIO
> - Fix warnings about mdio_err and dw_mdio_init not being used
> - Fix missing else clause when bitbang MDIO is enabled
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: designware: Use if instead of #if for DM_MDIO
      commit: beddf076d19427565e53588b5685a831c5a512ee
[2/2] net: designware: Fix MDIO bus getting bound multiple times
      commit: bcb0b1b44fd784e35dd2223d56a56f568735a72d

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


