Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE8CCD1BF
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.18596.1760539150901952962
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sj5cQWJ+;
 spf=pass (domain: linaro.org, ip: 209.85.218.51, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4aed12cea3so1067203366b.1
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539149; x=1761143949; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrFYn5HqWfkmgQZXH9W4GMctaMQzBSO78U9wF2VBV8A=;
        b=sj5cQWJ+du97/fLd6nerUryZeXYLuSms3dYrvQIcFtGAhqGeg89tbR/UBiNNDSOmUl
         2n5P2ImaxVQHxDH4/0Q28Uiw+rpO1clETz+hGoLTCuO5QNY+DIMmovh8FPwoDbxEDAzJ
         ZHw+h3PpcWCz7qGGA1gEMyauT9TwJo7dhmWA17FXEP5qLWsO3osf0byz+d31JUaqChol
         O1jjPfYPqsUwI0ApfWl73HKwcaodMZ8ueaRxlx0Sj5bh0HVWg3N/2QsFB4JcW2fJTbx0
         Sz4158JPQhuymwMGFIzNp6jhS+wTTxcLWgmtjb0VjwWqq9tnSIdpmLX06nfiu+oCSimt
         Ba1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539149; x=1761143949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrFYn5HqWfkmgQZXH9W4GMctaMQzBSO78U9wF2VBV8A=;
        b=hVYsrWU68Sl0X1q6/3hq2kjYiBW04izG/wihdLV82vBMhfcPhDtrk0wzNU6a78H/Ec
         fg/w0L/AQJUyGTbSbKjJbpuANdbnEJVFZQhXVhW3ZGbn+ETM0ltV8HL+vBnu0cA7EocO
         aPca/DqyJT5usM/8Z3KfYz6PSfuVAULlZpcIdNCxlPXGKYEVGVIoVSBIgRQulQ4lXrgR
         7NWLz24x6NZLOVelVCzwdMWkkxnzEEKT3mezxgzu0+DgOLmwq9Af2ku53cO7SIJz9sSL
         ctu1x/kCvYpEbL9C68YnyBXc3MCM4m9d3ouC5w9JU0ZPU7/hYd4KxxlKfvTUR4Nl2vNE
         ui0w==
X-Gm-Message-State: AOJu0YxET1XEpBp9jTgHQ1Pti2w7QZ7/l3bWN8nbbAlvSn1i2ypZeNSa
	c9jKlwdNOVwYNjn7d7vNHkEN0ezez/fsMTHFdFyNrgm1Cl1KoQZ+rmA7rh9oEs4npvitkLUXIy2
	di+jRzKg=
X-Gm-Gg: ASbGncvERzXEgPuw/OZ5xRqcoPOQIX+zDwcOJ41dSbQ3R+f2JltPSAOOKWo8Kl9DU30
	pos6Y0DxZQrBOeSV8f5voQqf1kigRP+m+cs7NjiziVjvRwgfqKlwolsVc0iFF4PMYog7FDRQb/N
	dlZHB7oV+npmnvm5euXJXHKGmW8AmtlSfluSWqu1PV6WUZ0Rhq0EvwLuysS4BW6wRZkBtp79mlZ
	+2Y6jw2HDjcWPdosyDICyB2RRgB3PA4XWNC2dMYNTitChZJrT5UK+VHwkaQ5GibO6aKzlYmBjPt
	heDHdZ9Mm3AbQ2lYiVLgd6yNSWBEn0gIzYZLQu8a+dzkHIharFtHG9TNDgLCOm85gmTRQ7LoLld
	prXhcSDXiY4ZQixQTIjAn1p8WE0ejfj4gvehWHH/49UzItzLho11VlkjhkTztcoDzqNqNSPSJgt
	Qw0+tR84Pb
X-Google-Smtp-Source: AGHT+IFlNowh+vGp70FH97qTtLRQH3h2fsYL1QnfN9LOkLczISksLceR9H/9QlvbKNOAnaY9OEN82w==
X-Received: by 2002:a05:6000:420d:b0:3f8:e016:41c0 with SMTP id ffacd0b85a97d-42666abb540mr18223531f8f.10.1760538761916;
        Wed, 15 Oct 2025 07:32:41 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:15 +0100
Subject: [PATCH 10/24] clk: starfive: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-10-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2823

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/starfive/clk-jh7110-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index f8af17227c502a39cc8f4b77f52a3d88fed210a9..12dd14c02c683bb860743bcb994b549e7a8f74bb 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -292,7 +292,7 @@ static ulong jh7110_pllx_recalc_rate(struct clk *clk)
 	else if (dacpd == 0 && dsmpd == 0)
 		do_div(frac, 1 << 24);
 	else
-		return -EINVAL;
+		return 0;
 
 	refclk *= (fbdiv + frac);
 	do_div(refclk, prediv * postdiv1);

-- 
2.47.3


