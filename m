Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE6CCD1BE
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.18644.1760539165986503280
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Zp7PQWBo;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so8134253e87.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539164; x=1761143964; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma2chDb3vOw+DvVL+Elh8yWCMC9/MPlr8PtTT73X6dU=;
        b=Zp7PQWBoNiV2ok0sDlsU6N8CDAt15gjt5a4VMx+/oIUOcF5xDhrKFUAtUU1esEJW5j
         nYUvyd5Im8juYRfpPP2nGRZ/3WEpPvDmXbC6NuQrx476GVP26ql3ot5qPxeSN65lEhAP
         hs2WCIynHV5FiSanWAmnld8Tfe3ad/SiZFau0gtYMD0GncyJO+AIkR06rS6Nfd5cRDRU
         GplVySKcr3gTMQQwYje4sCkp+xBtzgLZw2lXX+L96uJZEf7/Yz8I/1LG0crsB+e+NyC9
         U/aiEFVqBIwirAwcnSyqWl1VzjhNsv9esMq05ytuN1UtN7pEPaX1Svk+medBgp+IV/38
         rAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539164; x=1761143964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma2chDb3vOw+DvVL+Elh8yWCMC9/MPlr8PtTT73X6dU=;
        b=jdbHlPILraoPBsVRP60181UtmBBwFS8gjonlJ7bW/AakUro89hbnbGa4dfOZmR1KCU
         eUqjSKuHSZfRVWrhAexuXhSAl/1SfLY6yme1KsVGfJ7r2moFTBzYEXTIxdFFkVJi6RvF
         EEsxQ7DDWHIOaYZAMNLh83akJ1vV6nS6368seclcTUHW3SqfG17E0GH95wGZjS5ch09U
         EIO80KfpScZSkHRKHx8R3n/9NvtOifNM1eoH/WpWqGyWulW+eMaTPFlzH5JGYWV1ZA5L
         sdJJYYsEmL3qndin+sLjQSUbiHg90j5BuOLDLNlvLlFe2pl/fB641XyDlFj5w86QrVxN
         S3jQ==
X-Gm-Message-State: AOJu0YzfV6guFgRD7b3idxrL8TlTpJFalUi1XAfpZnpl7W6wx5PpKSA5
	fQz/uqakcBebzAz4yrJLw7kQP1yP0p4wC6swxnnNbV6JVZryfLt5rZqQo8uq5ZKF7L1D7HidggT
	UB3YM31I=
X-Gm-Gg: ASbGncsJSx1WGMQ9FYfzVWWADMND3x856qLzZO+gRUNZIFPfUcisRG/YejZDVQHMAc/
	HDuIUBTMv8smV+yy+hg/7qEU7LhA4UOD4ib7Hdxnd5JDLlfeNss/qDWVSHZaS9pZraQtvQ+p+iR
	hL0SjSafj5HkxViChnZ57PqNJq6u4zG4xm69MRWpHUsPm8pjBoPHfktQkvOFii56sB5p38KSI2O
	PVHjS5PXAvaW2BnalxfUOkyXWrm7BjH+2XxIDpqaAYJzlgJb027uTqBlrWkSi6xZant+Nzvx7E0
	bPz8sE51xt3ltqPS2m4YVQIRYFiJoFfQ7B3Ttl7kLKauq8HoV9wIZtGDVQVt/spV30cgs3a0bLl
	JsIld46BwEiy+j726SwBSicMXQK6V56QkyKFltOJDlsMKECpSauggLFLcZa2UbO8kmQEr2aC0HJ
	q6MbtYksfZ
X-Google-Smtp-Source: AGHT+IFxJ3tdTc9aXKyMZ7CBIzLF8xRR3KpTVUPPFRVIzybF4VytlYoKR7kxxnTeR6BEG36njzF8Fw==
X-Received: by 2002:a05:6000:601:b0:426:d80c:2759 with SMTP id ffacd0b85a97d-426d80c2f3amr10817335f8f.25.1760538743325;
        Wed, 15 Oct 2025 07:32:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:06 +0100
Subject: [PATCH 01/24] clk: meson: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2840

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/meson/a1.c   | 10 +++++-----
 drivers/clk/meson/axg.c  | 10 +++++-----
 drivers/clk/meson/g12a.c | 36 ++++++++++++++++++------------------
 drivers/clk/meson/gxbb.c | 20 ++++++++++----------
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index a1b8d79149102183402f470a60511d5300d0232c..78cad13239ca174a30f88cb2b18191cea74d6248 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -359,7 +359,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 
 	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
 	if (IS_ERR(info))
-		return PTR_ERR(info);
+		return 0;
 
 	/* Actual divider value is (field value + 1), hence the increment */
 	n = GET_PARM_VALUE(priv, info->parm) + 1;
@@ -402,7 +402,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 
 	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
 	if (IS_ERR(info))
-		return PTR_ERR(info);
+		return 0;
 
 	pm = &info->parm[0];
 	pn = &info->parm[1];
@@ -411,7 +411,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 	m = GET_PARM_VALUE(priv, pm);
 
 	if (n == 0)
-		return -EINVAL;
+		return 0;
 
 	parent = info->parents[0];
 	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
@@ -453,13 +453,13 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 
 		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
 		if (ret)
-			return ret;
+			return 0;
 
 		rate = clk_get_rate(&external_clk);
 		break;
 	}
 	default:
-		rate = -EINVAL;
+		rate = 0;
 		break;
 	}
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c421a622a587d2eddef70d28b65e560722cf7f62..e0b41811b0dfcc59f9a57366639ff2133209b697 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -104,7 +104,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 		parent_rate = XTAL_RATE;
 		break;
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -123,7 +123,7 @@ static long mpll_rate_from_params(unsigned long parent_rate,
 	unsigned long divisor = (SDM_DEN * n2) + sdm;
 
 	if (n2 < N2_MIN)
-		return -EINVAL;
+		return 0;
 
 	return DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, divisor);
 }
@@ -171,7 +171,7 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
@@ -219,7 +219,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 		pod = &meson_sys_pll_parm[2];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, pn->reg_off, &reg);
@@ -272,7 +272,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a7a42b2edb6a5b98612fb71fec6d17b1f3ab77c8..910b91e874bfdf6753ffc40bec7cd3a94e0b41ad 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -264,7 +264,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -273,8 +273,8 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 	debug("%s: div of %ld is %d\n", __func__, id, reg + 1);
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %d\n", __func__, id, parent_rate);
 
@@ -323,12 +323,12 @@ static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %ld\n", __func__, id, parent_rate);
 
@@ -348,15 +348,15 @@ static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 			return ret;
 
 		parent_rate = meson_clk_get_rate_by_id(clk, parent);
-		if (IS_ERR_VALUE(parent_rate))
-			return parent_rate;
+		if (!parent_rate)
+			return 0;
 
 		new_div = DIV_ROUND_CLOSEST(parent_rate, rate);
 
 		debug("%s: new new div of %ld is %d\n", __func__, id, new_div);
 
 		if (!new_div || new_div > (1 << parm->width))
-			return -EINVAL;
+			return 0;
 	}
 
 	debug("%s: setting div of %ld to %d\n", __func__, id, new_div);
@@ -471,7 +471,7 @@ static ulong meson_mux_get_parent(struct clk *clk, unsigned long id)
 		parents = meson_hdmi_mux_parents;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -560,8 +560,8 @@ static ulong meson_mux_get_rate(struct clk *clk, unsigned long id)
 {
 	int parent = meson_mux_get_parent(clk, id);
 
-	if (IS_ERR_VALUE(parent))
-		return parent;
+	if (!parent)
+		return 0;
 
 	return meson_clk_get_rate_by_id(clk, parent);
 }
@@ -588,7 +588,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 
 	switch (reg) {
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -655,12 +655,12 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	regmap_read(priv->map, psdm->reg_off, &reg);
 	sdm = PARM_GET(psdm->width, psdm->shift, reg);
@@ -711,7 +711,7 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 		pod = &meson_sys_pll_parm[2];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, pn->reg_off, &reg);
@@ -851,7 +851,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 51f124869c9c4043dfe047cf2f694bf59df7e87f..6dcfd084b8f93ade3fe1270db48f91f87cb61d26 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -306,7 +306,7 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 		parent = meson_hdmi_div_parent;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	regmap_read(priv->map, parm->reg_off, &reg);
@@ -315,8 +315,8 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 	debug("%s: div of %ld is %d\n", __func__, id, reg + 1);
 
 	parent_rate = meson_clk_get_rate_by_id(clk, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	debug("%s: parent rate of %ld is %d\n", __func__, id, parent_rate);
 
@@ -596,8 +596,8 @@ static ulong meson_mux_get_rate(struct clk *clk, unsigned long id)
 {
 	int parent = meson_mux_get_parent(clk, id);
 
-	if (IS_ERR_VALUE(parent))
-		return parent;
+	if (parent < 0)
+		return 0;
 
 	return meson_clk_get_rate_by_id(clk, parent);
 }
@@ -627,7 +627,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 		parent_rate = XTAL_RATE;
 		break;
 	case 1:
-		return -ENOENT;
+		return 0;
 	default:
 		parent_rate = meson_clk_get_rate_by_id(clk, parents[reg]);
 	}
@@ -695,12 +695,12 @@ static ulong meson_mpll_get_rate(struct clk *clk, unsigned long id)
 		pn2 = &meson_mpll2_parm[1];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	parent_rate = meson_clk_get_rate_by_id(clk, CLKID_FIXED_PLL);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	regmap_read(priv->map, psdm->reg_off, &reg);
 	sdm = PARM_GET(psdm->width, psdm->shift, reg);
@@ -833,7 +833,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 			rate = meson_clk81_get_rate(clk);
 			break;
 		}
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("clock %lu has rate %lu\n", id, rate);

-- 
2.47.3


