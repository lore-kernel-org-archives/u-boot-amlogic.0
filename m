Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D6CCD1A4
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.18618.1760539193370899738
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=roJ8h0pN;
 spf=pass (domain: linaro.org, ip: 209.85.218.52, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3d50882cc2so1240497466b.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539192; x=1761143992; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIQysIx4KJugzMwhq25Do8V3rR1hN0bWenENxg6QWqg=;
        b=roJ8h0pNZ4i3r0u5GvhbsgMcgsdOsHZBf6iKpZNJtrMQ9ETT2oY4oZCapO9qZB6IGp
         o0NYJTGQ2u5vVWeB8OHBJBFbZLMO11Ipogh+e0VclYrrfNwpEb3NsnJryoOmo3f4bcBB
         QZS/B+nTw6O7XXRX9P2d7SY7VB61KcmtpitaNMAro086WknIZRrwsh+/srCpB9x+W/aK
         tFCfAnezZ0s5qlMeKmoFm7n3xtx0Z7BoHNSZUabI406rkrKj/GNPvZi2x+kfifJdD3m/
         qE9m5O+gkdsq33VEr+C3PBWsQwYPabLWL//fg4YzQHaNIStg1SsXO3vum/qdiSA146S2
         Xiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539192; x=1761143992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIQysIx4KJugzMwhq25Do8V3rR1hN0bWenENxg6QWqg=;
        b=pCaxa3PdzZamhCpm8KyQF1BazOoKV1z/tC1mCNWqlQx3AyzNHHHTIC3Tfc2D48LTAb
         rXYOvxBeVFCvCcBgu6oBbVvUVLi371O4vW9b+bo4unOREGTFfM3KKpeojgnuU9gN9+yN
         Z4oBoUJek+rJrlhTb+b/J5SQeg8Mb/C3Rj/SvabbM9TKi28oggFrXMyQ/9VPbFm5E5JO
         /ToZyOzl2BgA6mHfFzyyVbsjFBwoTjGHF8hqjdR9bgJHhhww8oaXfb6A9ju6cQVa4Y4Z
         eFgJbwm8nrH0XinCDrwp7uWWT0wjphpCYGAakX6WldgfULG1tynlSVceY6ym5pRg5LGr
         Bokg==
X-Gm-Message-State: AOJu0Yyzu1tJj7lU6adRLekNxf2K1R0XgmiBb0o/fKTnrexFE2Xwg68t
	wLKBbSR/FI8xV53/Iu+P3wqNtqPxLDUmqNSnSy6cy88QJhfWjDpOQ9R0oEjUQOo6Pu8=
X-Gm-Gg: ASbGncv+E9Q8ozT8AabG5BsF7Nr+ohPDETCYncCJjF4cnxL6FOvIfMz6EOfkDOhOG/p
	QTmxFRsBf6axkfI0qN+94Fp1hRDXQtoqz/0MYX4pWI1oWHnDFfLhgzkwIsCFnJzYQMsods19CeG
	Znhn4Zz2VjepOUtDlErDjh/mnATawQZBFNYZ2wcHjcu2KgBExrBA5B1AFhVhRZdHHpePdMLrzOw
	XuZrBXzm1eNkc3vD35wn+XUlIKbaf0nazbx4N/+bFwDEy0wK98GSgZ/73mUycnSvfk8eDc0Knzs
	agaLTR6oXPUhwsCPu0iD3kLefKh1Sgbr9em1jamyYInt7JbpuHuh695JNBuTBl+DiUIVajD9KZ3
	scpwCcSJ62kKfUiq4dPwH22DRwQG3xJW/hpvfKSe0UiciRmG+m43D1/rDPzTmbV8Kis3z/o6KYw
	==
X-Google-Smtp-Source: AGHT+IGf5GpcS+S5beWQTbh6N/+mYXSMKn3Cif7lbjfUlCZ5iEsIZ3P/e9T/0Yu9aiD1g4OPovrjJA==
X-Received: by 2002:a05:600d:8110:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-46fa9b09233mr207794075e9.28.1760538750432;
        Wed, 15 Oct 2025 07:32:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:29 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:09 +0100
Subject: [PATCH 04/24] clk: thead: th1520-ap: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-4-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2841

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 6899e1b595a7148a118d3a615d5dfea4b4fb5b96..e913621967eb131b534e8f5b928687967a02a30e 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -985,7 +985,7 @@ static ulong th1520_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(c);
 }

-- 
2.47.3


