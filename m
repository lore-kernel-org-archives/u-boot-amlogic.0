Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DACCD1BA
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.18652.1760539191112557179
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=piO+rwrU;
 spf=pass (domain: linaro.org, ip: 209.85.218.48, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1201650366b.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539189; x=1761143989; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERwowSjUiSfjiyeRoDtHaJmN8qD2SmfA6iuhiy4Rcrk=;
        b=piO+rwrUzctJqBJUsdTLBt7+xZ6Z6w9y4Q7qwuLKMJO/Xnii9ggKU61R4r3IgrfSCX
         0ryHENG13o2pLFhWdd8GbKmoZCyuhPqIFHINNBYr9RMPKX4/IOTqt2MrsnCjMJIP61Wm
         qdV+K7XncBaGt8a4HDRiXnCs2GsJAR8pntvJ3UrN5+5eOJ8Ix7GWMWvWj6YDdbOH2v0c
         sNZIf7lb9BOOi43XOEfgvqM+Nqdg3ImVFq6LPScVqVeRtxO8cYaXMKDBQZWvXchqKEqy
         vvJXd22gQA8maLa1W2Bp0epwhFOE/TepYsKgB+JeetwH7QCUQjrjttl+iv3WOffJrysM
         pw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539189; x=1761143989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERwowSjUiSfjiyeRoDtHaJmN8qD2SmfA6iuhiy4Rcrk=;
        b=CTHdyhtT/25dIV60h8HeX9w4yKy9oaaSlHRhYGRI+r/Y/5cltcggnbM8qDR4HbGyRX
         vcHWQvJJRr2WtQ9nd4VUf6soPa2Txvkqjo6rRPBKSjZLb8FIa+RaM6Oz7zjfBrrc8+v+
         rUImPkjp0N4fKmcnOQ4nCLUOp+yXgFNPPQrMnJI+I+DUO22SlVZWRsrh5eBrTq2V4zyU
         lv3Ih9LYQdjsL16J0VwjHMMHafdVvva8N3X2v7CoCK/xnf+477oN1h/yyX0z+vL4aRXP
         7gZW2BQitmttqmLI9+P50KNdEc0sBwKqRVPX7oTBYVP0Og1p0JS1f4vhrcg9fFSkfbVq
         WKoA==
X-Gm-Message-State: AOJu0YwSkMTcO8ZJqmEyBxXLV/sWy9vtpxIgOVJRl4Igq541Y4qLdpny
	NAExiTRuLIRGWIkTMjeo+MGJWv0nytOLlMhgRvQphYgorNgV4zpzNLcPomtKfQ2NCsKs832PhVb
	JuUj1q/w=
X-Gm-Gg: ASbGncushlwv+3XEUMV1p1mOEXSRsyd23C0eQZh35fC1bWt7c/6qQiWrAuT5XpXytwy
	p2ZnONQKZSJxzpcYjnG+RR94d0UpjY5p+K1kDjvYDm8nFG3GjteqSEAhhxMMQVUec/7BK7iKyEN
	Bm9CpjVyv/Mr8oOh/DWgqr6ApTbjP+4Gp2W22d69T7RzrBht4xkLNwqa3/dYbfiuFtLHjyE/Hf5
	/oEBh03Da9zZNrpg9EXfMP2EHoPyQgaZIBzI4GYnfjkHX420NX4VnShqkuCnNSfUemlaCI17EVL
	vmiDpvEg57851NtbOKpe7XSXESlH6KLpeCd+FsLwuJFRY2a1ZgTmLb8o4R6nJ8WvkTyJ50zGF/C
	LDcHzVRLLrOuqCKSlja7YSVKz93EhmKl7H8U45XCQomcTcQluctPyQ+mJ3kYhHOBnBcx3HRKHFd
	3GFfbDeIJ/LfRIkZG7OLI=
X-Google-Smtp-Source: AGHT+IEYyrBIrogkMQ3xVs6oCJsz6+b5u5hitXq0HuUBGcvkXrEFn3Yf8t0jmhLEmQ4TxVA9MpI9eA==
X-Received: by 2002:a05:600c:c8d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-46fce362f77mr79718925e9.32.1760538752292;
        Wed, 15 Oct 2025 07:32:32 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:10 +0100
Subject: [PATCH 05/24] clk: ccf: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-5-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2826

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b8c2e8d531b91f986995d15669620feff936e617..eb3b58edd2669cdff0f72ee9daad083d063c4dd8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -84,7 +84,7 @@ ulong ccf_clk_get_rate(struct clk *clk)
 	int err = clk_get_by_id(clk->id, &c);
 
 	if (err)
-		return err;
+		return 0;
 	return clk_get_rate(c);
 }
 

-- 
2.47.3


