Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F93CCD1BB
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.18654.1760539196496745403
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=RPePMzwm;
 spf=pass (domain: linaro.org, ip: 209.85.218.54, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b40f11a1027so1200089966b.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539195; x=1761143995; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbJGyCPupNXvdaZuspymNgL6rmLyPY5BcTTejfTvzn4=;
        b=RPePMzwmu04/sOJH+wNYXKNJuj3zp+vhmEqXOqYIprojXJAz5YLyet0ADhJVdg8Adr
         km9qM7LQNbwOMcUcVFGa0Dfdkkb1S3JcLliM0KgUsSDRKtOXWqVe86lElfw4anGXMVPJ
         +aU9wOK8dh7XEYk2Nku1ImaM1nC5Dp7uom3pv8TEigjCUmBiQmxRa4vSRRTC9E+y09bW
         PekMHI7FkYcLo2W+HfW0u7gxK9kjnW0LUja0xhz/L/mbfy+li3FkTfb0peYp+Glz8/xa
         S8yjPDYPvB/44YK7G+tlUix0k1owVS/x//1t3sE+o/7c7SNGPchuMYtYH2pe4LwnhPiR
         RIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539195; x=1761143995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbJGyCPupNXvdaZuspymNgL6rmLyPY5BcTTejfTvzn4=;
        b=OoxK1aS1apIk5a3DEL0lnRR3JqBy7JFAl8A4SjUMU35UkxpGjjaTYvpuic+3qWpEz6
         gC3NL57M2vvDBYSB6WrJXyG93NJOKHqg7lfJ7WVD04D5xSU+KFi+EtQecjek9TWoom3b
         oSLwmjFybOUS9JFTl8KBakMqpwHorBSkM8D3zR6OI/q8mNrSKFJH6g0Ynv7JShmzn/0+
         RN6MmRFlDAAPOGFABLMb6M0EODEXiAHtsIuF/glOTAdVXOUo50ULN26FF8llWEQkcAB9
         a+7tNSWdtaVbkeXCzcYQEF3SzQyxBhEVmebw0Q1jsTiu38hvd9wN0z17XqqBFRwoftul
         i2dA==
X-Gm-Message-State: AOJu0YxpeB/oH82mXar36GkHSA+nlLcWQajq+RIFY6enGozpdEmYz7zg
	4mTyBfebvfwjrqNPu2pozgyFGsSzkhpeJbdandEtULNQDlvxkkN2e+r4B8Bdz5vG4C4Oc3ez8i/
	Is0/Xkwo=
X-Gm-Gg: ASbGncuWnwlo2V8qfafQA+ZgJDTBCvGFGfdO/lmCP4Tr3fKyqnJH0c5C6DfREabCoH9
	XReT/9WnKmoiYot0W3bjtEU3xEQAYC/EYhsj3FURe9ywv1ZLVU2AqJ2ImhtKOCyQAySZiAONseU
	OfqoJPbx6F7q8SYyUV9Ngb0o1F7iQDhbmMgNJIX3b0UFz7AS6cnoS2Rp/GQ16kVAI9bOD632fdm
	0erWfxz55U8MUSCwGtBHNyFQYq0Hyiu81dP6N3MyuWWaDmoX1uTApMIbTtuIZt+5n1siAT/+RQu
	d4aYEXtyc8IusaLWWpcZAqZwCQJpHV3RxdOt7P9seDZ+VFQTU5+SuPNoDpedkNHw+14lzXd6l70
	XkzRM430+9IoVi1i3avGYeaITqi7Fp/T5tyEUZB43fd554ERibYx/C4E0KVVCqZLRGli20h7rVu
	9Tu3vk8c/q
X-Google-Smtp-Source: AGHT+IGi5fNTGKvgaEXbnvfgUckaDznPDbpCkdyTHr9U1ivBHTEOZKwwP8TWWCIEcxcSc0ljuw95ww==
X-Received: by 2002:a05:600d:d:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47109da53bcmr1352065e9.15.1760538745360;
        Wed, 15 Oct 2025 07:32:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:07 +0100
Subject: [PATCH 02/24] clk: sifive: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-2-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2829

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/sifive/sifive-prci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index de55504b5c90785f8d5f1f66eb914847feb4a495..01fcc85ab23ff56886638cc0581b5389012de154 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -548,11 +548,11 @@ static ulong sifive_prci_parent_rate(struct __prci_clock *pc, struct prci_clk_de
 		}
 
 		if (i >= data->num_clks)
-			return -ENXIO;
+			return 0;
 
 		p = &data->clks[i];
 		if (!p->pd || !p->ops->recalc_rate)
-			return -ENXIO;
+			return 0;
 
 		return p->ops->recalc_rate(p, sifive_prci_parent_rate(p, data));
 	}
@@ -572,11 +572,11 @@ static ulong sifive_prci_get_rate(struct clk *clk)
 		(struct prci_clk_desc *)dev_get_driver_data(clk->dev);
 
 	if (data->num_clks <= clk->id)
-		return -ENXIO;
+		return 0;
 
 	pc = &data->clks[clk->id];
 	if (!pc->pd || !pc->ops->recalc_rate)
-		return -ENXIO;
+		return 0;
 
 	return pc->ops->recalc_rate(pc, sifive_prci_parent_rate(pc, data));
 }

-- 
2.47.3


