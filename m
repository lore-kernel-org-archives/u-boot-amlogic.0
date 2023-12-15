Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A7C46CD7
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:44 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.77189.1702673330399009385
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Dec 2023 12:48:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GKz007g7;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: seanga2@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-425b9acaf80so8396661cf.1
        for <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702673329; x=1703278129; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jXkQvGvseRr9OSLhDEpKNiBne6PE2K/af+l97pnxyM=;
        b=GKz007g7nyiRCN2VV9WSEg+N2+0sb5MQRR2sqy4Kkts+G5Uj0RdQDKjm91NFT3iGsd
         yfYM+ppAKF/HRgwG62qTSZzsgyNJc1E0nz+a0CCcsFYwj4J3qWvntLS2GZ7rLzRZ2m10
         6KpG0BGxMecJdEgRbODDZt/qpbVvST7LP3nLLFsRc4gpvrWsRuHX5EXHIeFEg6dlGmeD
         kRmKMDS0ej6vvHDljsQol/FLPtSRTb8eVaB9DcGOM816aoWZA2j0m6LsoHZPCINIoMVH
         bj6H+1rrQB2L8fAUgw5ikeSxcxLb9zP21RINcHbFbz6dMYpyY2xlHYn0W0h/0Ux+0qK2
         F1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673329; x=1703278129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jXkQvGvseRr9OSLhDEpKNiBne6PE2K/af+l97pnxyM=;
        b=dy0uRZRvRVTX7l0dVnGyW0WFknn5rZzpRNIAKivKBwzGgMtyQhLCwoU3zeORjZXM4c
         XrtdiZ77hdYnn0xStPptwwXLSlterXia7n6NYKCjyd6FanAwHQJHtz7IgiqHqGx5Ra5I
         J8VGAfnwJTTzfpXOQdHutCWJq9HZ0GA59SbYUvba9jntjk8j1by0CNshNv8B4JqAzfq0
         wPMBYDhiUwn8XuLFbe+SOzeM1ckIPRMxBp74dNHXj0TMHGs15NYl/P6yuV7X/LODu3Fz
         PBZ7wmmEuX5l8stKW8yjR056RK5C0nRmGar35KVpW9sSvMOxtkSjdpTv/ZaHCwxEF4YI
         ItNg==
X-Gm-Message-State: AOJu0YzyctO9NUL2MDzSeDhA1O9LE51ZvdDpeXJeYM/VIEB7RWdXZcT2
	mGAa6SjJ3xOHhZ9JGr9gc/0=
X-Google-Smtp-Source: AGHT+IFh0KB6Ddcmip2ygFoybmhbuqRp+r9fRO8MZjby6AGfEX+H07Qa3nzASYtL43r0h9ISZE904w==
X-Received: by 2002:a05:622a:11cb:b0:425:4043:18a0 with SMTP id n11-20020a05622a11cb00b00425404318a0mr21132014qtk.83.1702673329488;
        Fri, 15 Dec 2023 12:48:49 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with UTF8SMTPSA id z4-20020ac875c4000000b004180fb5c6adsm6908123qtq.25.2023.12.15.12.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:48:49 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	daniel.schwierzeck@gmail.com,
	michal.simek@amd.com,
	sr@denx.de,
	neil.armstrong@linaro.org,
	patrice.chotard@foss.st.com,
	ivprusov@sberdevices.ru,
	Lukasz Majewski <lukma@denx.de>,
	patrick.delaunay@foss.st.com,
	ryan_chen@aspeedtech.com,
	chiawei_wang@aspeedtech.com
Cc: Sean Anderson <seanga2@gmail.com>,
	joel@jms.id.au,
	u-boot-amlogic@groups.io,
	kernel@sberdevices.ru,
	BMC-SW@aspeedtech.com,
	prusovigor@gmail.com,
	uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 0/8] clk: Switch from soc_clk_dump to clk_ops function
Date: Fri, 15 Dec 2023 15:48:32 -0500
Message-Id: <170267330672.2421617.16500568591017689149.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231109105516.24892-1-ivprusov@sberdevices.ru>
References: <20231109105516.24892-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1941

On Thu, 9 Nov 2023 13:55:08 +0300, Igor Prusov wrote:
> Currently clock providers may override default implementation of
> soc_clk_dump function to replace clk dump command output. This causes
> confusing behaviour when u-boot is built with one of such drivers
> enabled but still has clocks defined using CCF. For example, enabling
> CMD_CLK and using clk dump on sandbox target will not show CCF clocks
> because k210 driver overrides common soc_clk_dump.
> 
> [...]

Applied, thanks!

[1/8] clk: zynq: Move soc_clk_dump to Zynq clock driver
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/bdac75511411
[2/8] clk: ast2600: Move soc_clk_dump function
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/3f192541df79
[3/8] clk: k210: Move soc_clk_dump function
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/77beaad3d1d2
[4/8] clk: amlogic: Move driver and ops structs
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/4f48202ba82e
[5/8] clk: Add dump operation to clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/505ef5f627d8
[6/8] cmd: clk: Use dump function from clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/258c1002383e
[7/8] clk: treewide: switch to clock dump from clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/bc3e313ff6af
[8/8] cmd: clk: Make soc_clk_dump static
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/5666558a6cb0

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>

