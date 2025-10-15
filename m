Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF95ACCD1BC
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.18626.1760539144931134317
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VXjSGRA0;
 spf=pass (domain: linaro.org, ip: 209.85.208.46, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so4681650a12.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539143; x=1761143943; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49jSWRHsss//EBfN7zOwUemnNlZQX5Z/2fmZ0qpW5eQ=;
        b=VXjSGRA0CQ6OER0UtUzhGP3S6myHFwvQDD/TlWFDUVzpxPhz3sswnj+6wPSI3lS9hB
         vgArLgGQjhRT2fHGimVUKPF1aKfK7xDaNNmdrVURFUFe9rCLTId5VhKTiJjsT+dwBW7S
         4Eph93pLJaKthYKsBC8aJW8rFeR8RuCh0kUQJPlAlPhnQe51b4aSRoUhsjAoKBePDAQU
         EXsOpBHt/NXMOiPIh47FAgNkKuXuhFhmeAXHqsfQjUZCnO9PiObS3m3fFSPIPHJeI8L+
         bJe+hQYYD+uCM+vHa+Q8+UYGDtDm+OBs+O/UxmMfsR0/nPS0w/b2RwdS+T/LCwPQwJp2
         HSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539143; x=1761143943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49jSWRHsss//EBfN7zOwUemnNlZQX5Z/2fmZ0qpW5eQ=;
        b=lDdSqsjIWlb6LWnzub48Y3kYflow6MnzgqITufP7iYKqWAUgZRksCJzGK6BkDMQ9d/
         gpxbbA/J4V9n0qcgPBCZlDqLOJSbHrRQbW1J0ilD8Bms0EzoNUJ7Uw668tmi9LAcFvzL
         o+bszAr/JkV/A98pG+zsW9Ej9CIMMOyz2WSdxaPMfIUjA5ZSs34UBv5UMJchicnfTTF/
         nA/1P5amzbCR9q/1flZJLxBJSsE+ROoLbpJOJS3LBqWvqlZYLeqfE83Ak2J3tGaH6VoQ
         y+gx4SUcIBPjGcU8sySO/SsfDiPwjPRtQcko8ws9Q1Q5uOsObZORovd7F5MPeeQC8Oij
         9knw==
X-Gm-Message-State: AOJu0YwZqhvPFl5aOBL7u257bkmryIScT7CGAfP9GrGrmKWeEIxXWGWA
	ugjfEYwDCEPWzRkgJr8b+HK8snY7YETWUrh1L5CjwG3sEHfSNNEfQWLB8wZhfEDn3tCSMhPUSkN
	ZLHHhuUU=
X-Gm-Gg: ASbGncsWCiW/bFNHtVhra8xLCpmFb0xE/z7CZFIId9X60LENkIxWB37NZzpP30exztA
	1s0LuUlLP7CNDnLj81xYUkGO2CpSTu+bxiRftRYDWOHNN2HH/cZWH+p5v7F5o4FUyz11b4ux5n/
	OGkl0fIlAK3VMAkUdQhuUkIULXBZs7/ntrZmvNy2/NaO252ohK8XnBT6jGfFc01CzWAhGvFlA1T
	IuDOyQDUrKVKMZxpYKOfJTzxDg4MovDYJCvhpRURMvCGt7SJlEV9zDdwZuqZm2mcPRD8hAsLo/o
	8pT0jM+thSXK4pd8ts4qC/dv5aTWyjcr2SiF7bx9qV8m5N0oVqDa/HXmUdM+wyJUEynuF9XPPtg
	VJScnkDqJaKzM/KjvfrlDH/hU0YZtAT1dkX1ngGMAen6Ogcpwx/E4M5FMGd8LNV8vcnyKEmqnjg
	==
X-Google-Smtp-Source: AGHT+IE61xZ44uz8zMhdoQ8tBs0hpzL01dSTtaZwdHp/BnAZL3FSDzrFGhj1LePLNzK4t2rGWJb6kg==
X-Received: by 2002:a05:600c:530e:b0:46e:4c90:81d0 with SMTP id 5b1f17b1804b1-46fa9a8f1c5mr206392935e9.2.1760538765676;
        Wed, 15 Oct 2025 07:32:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:17 +0100
Subject: [PATCH 12/24] clk: uniphier: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-12-5f80f827407e@linaro.org>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2836

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/uniphier/clk-uniphier-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 33369c93916b06a68f81db056988bd4954adae4c..32e1d7efb86e835a47e0c51bf913fbca4dcb6071 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -168,7 +168,7 @@ static unsigned long uniphier_clk_get_rate(struct clk *clk)
 
 	data = uniphier_clk_get_data(priv, clk->id);
 	if (!data)
-		return -ENODEV;
+		return 0;
 
 	return __uniphier_clk_get_rate(priv, data);
 }

-- 
2.47.3


