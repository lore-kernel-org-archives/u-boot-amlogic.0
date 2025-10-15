Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE430CCD1B0
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.18617.1760539131324634807
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:38:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ojzie4w6;
 spf=pass (domain: linaro.org, ip: 209.85.218.53, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deaef9so1206937466b.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539130; x=1761143930; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mYf+ZLXtoLCHvLL+hmapejeAW0e0m0pVkOV1J4YAZE=;
        b=ojzie4w68C/Yy9V7xClWpHA9v39cMS1T91RO/PTKPlsZ3mJD/jVaROlm5EkGBa1ogA
         AAxDeUeJqs5K35iR0KOzGPXFljOX8p8G4tHJZFGHuM9ZzG80D6Stwe48RzHiuT+Q/bs8
         e9gaR5Ouch80YwhYRIiUSKt1RzLQIiXhdk/34rMXK6IOZHCFZnJ0maY6wBrK2xSNL+Nu
         OajN3X94ZjkWJMzMvsKzHioW62ti4EuGP874y9UatbEYZuf7+BtUF1FqN9njf7Yq/U8z
         MBh5Kh5A0EJPTtD/GsT+SA5Q0GU/xdFqAXaapMOxXZK+1mO9BhT/uZbguVT62l9eFY8I
         QcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539130; x=1761143930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mYf+ZLXtoLCHvLL+hmapejeAW0e0m0pVkOV1J4YAZE=;
        b=c7Mml8vnKUPewwpzS8E0YCQ+8WXLeXzHJ2bju592uIt9+ehpQJx0czvuIqMk+RO/t0
         mChgY0C4e08Q9VTuyLiQLnqir1n23a5e9lLBCt8FUF8wboSJFYtHhQWN11k5uyv60Lyb
         CBjqohXbo03m1H2ldRXeXTBmTjOOqK3sWVjCJG/7c31MEQUY2n0jUFSL8TIPFnjanWt+
         qwjsq1fHE2uq/tZosmt/YHCQmxIM+JAD1lFuinWHle5OVxVp2sH4ysQHxDK/F5H62yhA
         gNbMH4yXN875yd+luSMupLCA7rHDL0IUsLCSgz7glw/lkD6sTogrHNSXiO5VOf2Da1yk
         4s8g==
X-Gm-Message-State: AOJu0YwISS8XfBZXbRL4nYznLQFocTSy9LHX9icxOqOP9NW8asCFXVF2
	qv8HH8EkEsXVLMuRmZwzZh9Z/GiN7u+pqvKV+mJkDIWv4RfkKptNSZgf5jIiSLUF4ovSo6Z0gMG
	1E9LamRg=
X-Gm-Gg: ASbGncuuVNVl7PKHhexq8XcBcfvyDp9jgePC3oxLfvdWLY1us+UIjTY2MZ48y9lOhl9
	TYdr3X7BL8+gZbF/86dIXHzy8cOvTaxOwXpH0/kPKg8gzyVWPwCUKsRyl/79krcnphy+eoeS9WJ
	IifMVECFVH7MV633kaJVwCNNyEXvsU7MaNJnXCLCL6BV9y3VA4zwCQ2odVnmuaub2SReqA1Sl3q
	kb/l4nRmcgEjmMlf5ddnnf+wvP4pq1Vq5IN7t5mAEllRCPsftyv9MxyNab3YtmrQLWU58tdcynV
	GvAXWFHidnFmvbJfP3TWLgv3E0NKrm7JDUOpTvGVkiScywohJ0D2KtrRFNBJ+nLWn/7M78cDop7
	Mflqm/GDrcRc6t8DJDipex3PlSkiA1bQ4wHJU3wEdKZ6xJADAsujDKVC7Nq4T1riUYjU8rkd8Hg
	==
X-Google-Smtp-Source: AGHT+IHmA+3anug88rLKoZk2IDNl0jKo2zNei1cUyM+bbHaejNyPOJDNmgXZszImGkVvkeSnn974YQ==
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-46fa9b092ddmr240317015e9.32.1760538758191;
        Wed, 15 Oct 2025 07:32:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:13 +0100
Subject: [PATCH 08/24] clk: rockchip: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2831

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/rockchip/clk_px30.c   | 24 +++++++--------
 drivers/clk/rockchip/clk_rk3036.c |  2 +-
 drivers/clk/rockchip/clk_rk3066.c |  8 ++---
 drivers/clk/rockchip/clk_rk3128.c |  6 ++--
 drivers/clk/rockchip/clk_rk3188.c |  6 ++--
 drivers/clk/rockchip/clk_rk322x.c |  4 +--
 drivers/clk/rockchip/clk_rk3288.c |  6 ++--
 drivers/clk/rockchip/clk_rk3308.c | 26 ++++++++--------
 drivers/clk/rockchip/clk_rk3328.c |  6 ++--
 drivers/clk/rockchip/clk_rk3368.c |  8 ++---
 drivers/clk/rockchip/clk_rk3399.c | 12 ++++----
 drivers/clk/rockchip/clk_rk3528.c | 20 ++++++-------
 drivers/clk/rockchip/clk_rk3568.c | 62 +++++++++++++++++++--------------------
 drivers/clk/rockchip/clk_rk3576.c | 36 +++++++++++------------
 drivers/clk/rockchip/clk_rk3588.c | 32 ++++++++++----------
 drivers/clk/rockchip/clk_rv1108.c |  4 +--
 drivers/clk/rockchip/clk_rv1126.c | 52 ++++++++++++++++----------------
 17 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index ad7e1c0f2460e3deb5bf24ff6e80ef8c6e80139c..e289cd60775f6e771e9afaabf70feb81bc904f08 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -308,7 +308,7 @@ static ulong px30_i2c_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -436,7 +436,7 @@ static ulong px30_i2s_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2s bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return clk_src * n / m;
@@ -523,7 +523,7 @@ static ulong px30_mmc_get_clk(struct px30_clk_priv *priv, uint clk_id)
 		con_id = 20;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -621,7 +621,7 @@ static ulong px30_pwm_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		break;
 	default:
 		printf("do not support this pwm bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -726,7 +726,7 @@ static ulong px30_spi_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		break;
 	default:
 		printf("do not support this pwm bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -786,7 +786,7 @@ static ulong px30_vop_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		parent = rkclk_pll_get_rate(&cru->pll[NPLL], &cru->mode, NPLL);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -883,7 +883,7 @@ static ulong px30_bus_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		div = (con & BUS_PCLK_DIV_MASK) >> BUS_PCLK_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -949,7 +949,7 @@ static ulong px30_peri_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		parent = priv->gpll_hz;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -1007,7 +1007,7 @@ static ulong px30_crypto_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 		parent = priv->gpll_hz;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -1189,7 +1189,7 @@ static ulong px30_clk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz && clk->id > ARMCLK) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("%s %ld\n", __func__, clk->id);
@@ -1268,7 +1268,7 @@ static ulong px30_clk_get_rate(struct clk *clk)
 		break;
 #endif
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -1704,7 +1704,7 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
 		rate = px30_pmu_uart0_get_clk(priv);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3036.c b/drivers/clk/rockchip/clk_rk3036.c
index 274428f2b4bd5e0b52818b4dca898acb45b68055..f41f8dff789fcddd097924cdfa2e00541f8a764d 100644
--- a/drivers/clk/rockchip/clk_rk3036.c
+++ b/drivers/clk/rockchip/clk_rk3036.c
@@ -287,7 +287,7 @@ static ulong rk3036_clk_get_rate(struct clk *clk)
 	case 0 ... 63:
 		return rkclk_pll_get_rate(priv->cru, clk->id);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index f7dea7859f7444de8f4531044b4ea521d56c1826..b2d61532af30ab15c386f502902bd7049c19ba8b 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -272,7 +272,7 @@ static ulong rk3066_clk_mmc_get_clk(struct rk3066_cru *cru, uint gclk_rate,
 		div = bitfield_extract_by_mask(con, SDIO_DIV_MASK);
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(gclk_rate, div) / 2;
@@ -330,7 +330,7 @@ static ulong rk3066_clk_spi_get_clk(struct rk3066_cru *cru, uint gclk_rate,
 		div = bitfield_extract_by_mask(con, SPI1_DIV_MASK);
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(gclk_rate, div);
@@ -376,7 +376,7 @@ static ulong rk3066_clk_saradc_get_clk(struct rk3066_cru *cru, int periph)
 		div = bitfield_extract_by_mask(con, TSADC_DIV_MASK);
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 	return DIV_TO_RATE(PERI_PCLK_HZ, div);
 }
@@ -534,7 +534,7 @@ static ulong rk3066_clk_get_rate(struct clk *clk)
 	case SCLK_UART3:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return new_rate;
diff --git a/drivers/clk/rockchip/clk_rk3128.c b/drivers/clk/rockchip/clk_rk3128.c
index a07285593b554b8855048e25e4b9a52ad55a9dde..d149fe66eea878d80fcfe40356d57f4d39004229 100644
--- a/drivers/clk/rockchip/clk_rk3128.c
+++ b/drivers/clk/rockchip/clk_rk3128.c
@@ -360,7 +360,7 @@ static ulong rk3128_peri_get_pclk(struct rk3128_cru *cru, ulong clk_id)
 		break;
 	default:
 		printf("do not support this peripheral bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(PERI_ACLK_HZ, div);
@@ -475,7 +475,7 @@ static ulong rk3128_vop_get_rate(struct rk3128_cru *cru, ulong clk_id)
 		parent = rkclk_pll_get_rate(cru, CLK_CODEC);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	return DIV_TO_RATE(parent, div);
 }
@@ -500,7 +500,7 @@ static ulong rk3128_clk_get_rate(struct clk *clk)
 	case ACLK_VIO1:
 		return rk3128_vop_get_rate(priv->cru, clk->id);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index d8b03e1d7ab3d9636467fe235a5b432418b9c382..c54a0af788bf0c03693b1ff2edf6170cdfd5a282 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -281,7 +281,7 @@ static ulong rockchip_mmc_get_clk(struct rk3188_cru *cru, uint gclk_rate,
 		div = (con >> SDIO_DIV_SHIFT) & SDIO_DIV_MASK;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(gclk_rate, div) / 2;
@@ -339,7 +339,7 @@ static ulong rockchip_spi_get_clk(struct rk3188_cru *cru, uint gclk_rate,
 		div = (con >> SPI1_DIV_SHIFT) & SPI1_DIV_MASK;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(gclk_rate, div);
@@ -489,7 +489,7 @@ static ulong rk3188_clk_get_rate(struct clk *clk)
 	case PCLK_I2C4:
 		return gclk_rate;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return new_rate;
diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
index 9b71fd863bad48832d0f0915e30d627102710fc0..fdb7ab0ec9612a7b5a6cf2d5531e9076e97e7202 100644
--- a/drivers/clk/rockchip/clk_rk322x.c
+++ b/drivers/clk/rockchip/clk_rk322x.c
@@ -234,7 +234,7 @@ static ulong rockchip_mmc_get_clk(struct rk322x_cru *cru, uint clk_general_rate,
 		div = (con & MMC0_DIV_MASK) >> MMC0_DIV_SHIFT;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	src_rate = mux == EMMC_SEL_24M ? OSC_HZ : clk_general_rate;
@@ -367,7 +367,7 @@ static ulong rk322x_clk_get_rate(struct clk *clk)
 		rate = rockchip_mmc_get_clk(priv->cru, gclk_rate, clk->id);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index a4ff1c41abb8c1ff563dad4c042d240dd05b9186..bd1e778dc3603e5bd4444cb100cf36d78191ea14 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -599,7 +599,7 @@ static ulong rockchip_mmc_get_clk(struct rockchip_cru *cru, uint gclk_rate,
 		div = (con & SDIO0_DIV_MASK) >> SDIO0_DIV_SHIFT;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	src_rate = mux == EMMC_PLL_SELECT_24MHZ ? OSC_HZ : gclk_rate;
@@ -679,7 +679,7 @@ static ulong rockchip_spi_get_clk(struct rockchip_cru *cru, uint gclk_rate,
 		div = (con & SPI2_DIV_MASK) >> SPI2_DIV_SHIFT;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 	assert(mux == SPI0_PLL_SELECT_GENERAL);
 
@@ -782,7 +782,7 @@ static ulong rk3288_clk_get_rate(struct clk *clk)
 		new_rate = rockchip_saradc_get_clk(priv->cru);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return new_rate;
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index e73bb6790af262c81a2ae11d94d700ec307d8861..1d0293bbf32e00e155771a61bc30ffa8cc4636b5 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -195,7 +195,7 @@ static ulong rk3308_i2c_get_clk(struct clk *clk)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -301,7 +301,7 @@ static ulong rk3308_mmc_get_clk(struct clk *clk)
 		con_id = 41;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -430,7 +430,7 @@ static ulong rk3308_spi_get_clk(struct clk *clk)
 		break;
 	default:
 		printf("do not support this spi bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -524,7 +524,7 @@ static ulong rk3308_uart_get_clk(struct clk *clk)
 		break;
 	default:
 		printf("do not support this uart interface\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -546,7 +546,7 @@ static ulong rk3308_uart_get_clk(struct clk *clk)
 		break;
 	default:
 		printf("do not support this uart pll sel\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -578,11 +578,11 @@ static ulong rk3308_vop_get_clk(struct clk *clk)
 			break;
 		default:
 			printf("do not support this vop pll sel\n");
-			return -EINVAL;
+			return 0;
 		}
 	} else {
 		printf("do not support this vop sel\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -663,7 +663,7 @@ static ulong rk3308_bus_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
 		div = (con & BUS_PCLK_DIV_MASK) >> BUS_PCLK_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -726,7 +726,7 @@ static ulong rk3308_peri_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
 		div = (con & PERI_PCLK_DIV_MASK) >> PERI_PCLK_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -785,7 +785,7 @@ static ulong rk3308_audio_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
 		div = (con & AUDIO_PCLK_DIV_MASK) >> AUDIO_PCLK_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -842,7 +842,7 @@ static ulong rk3308_crypto_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
 		parent = priv->vpll0_hz;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -891,7 +891,7 @@ static ulong rk3308_rtc32k_get_clk(struct rk3308_clk_priv *priv, ulong clk_id)
 	con = readl(&cru->clksel_con[2]);
 	if ((con & CLK_RTC32K_SEL_MASK) >> CLK_RTC32K_SEL_SHIFT !=
 	    CLK_RTC32K_FRAC_DIV)
-		return -EINVAL;
+		return 0;
 
 	fracdiv = readl(&cru->clksel_con[3]);
 	m = fracdiv & CLK_RTC32K_FRAC_NUMERATOR_MASK;
@@ -1004,7 +1004,7 @@ static ulong rk3308_clk_get_rate(struct clk *clk)
 		rate = rk3308_rtc32k_get_clk(priv, clk->id);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 7701a9734ee07ec0e89a1f780b21f3305527f7fc..eed871ea65ce3f3fc92b2b312bd260d686f590a5 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -357,7 +357,7 @@ static ulong rk3328_i2c_get_clk(struct rk3328_cru *cru, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(GPLL_HZ, div);
@@ -459,7 +459,7 @@ static ulong rk3328_mmc_get_clk(struct rk3328_cru *cru, uint clk_id)
 		con_id = 32;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 	con = readl(&cru->clksel_con[con_id]);
 	div = (con & CLK_EMMC_DIV_CON_MASK) >> CLK_EMMC_DIV_CON_SHIFT;
@@ -708,7 +708,7 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
 		rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1df5f9e43e2b00b72fdf812eae8bbb7..87447ea2ff7d97aa64980d4a0457e91fb8ba70d8 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -174,7 +174,7 @@ static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
 		con_id = 48;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -190,7 +190,7 @@ static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
 		break;
 	case MMC_PLL_SEL_USBPHY_480M:
 	default:
-		return -EINVAL;
+		return 0;
 	}
 	div = (con & MMC_CLK_DIV_MASK) >> MMC_CLK_DIV_SHIFT;
 	rate = DIV_TO_RATE(pll_rate, div);
@@ -391,7 +391,7 @@ static ulong rk3368_spi_get_clk(struct rk3368_cru *cru, ulong clk_id)
 
 	default:
 		pr_err("%s: SPI clk-id %ld not supported\n", __func__, clk_id);
-		return -EINVAL;
+		return 0;
 	}
 
 	val = readl(&cru->clksel_con[spiclk->reg]);
@@ -479,7 +479,7 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 		rate = rk3368_saradc_get_clk(priv->cru);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 6e87db18be075d519d097d31a51a3398d389d45d..0f32c9c8f078aee29e094d127f13d2a60f811cb7 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -546,7 +546,7 @@ static ulong rk3399_i2c_get_clk(struct rockchip_cru *cru, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(GPLL_HZ, div);
@@ -641,7 +641,7 @@ static ulong rk3399_spi_get_clk(struct rockchip_cru *cru, ulong clk_id)
 
 	default:
 		pr_err("%s: SPI clk-id %ld not supported\n", __func__, clk_id);
-		return -EINVAL;
+		return 0;
 	}
 
 	val = readl(&cru->clksel_con[spiclk->reg]);
@@ -744,7 +744,7 @@ static ulong rk3399_mmc_get_clk(struct rockchip_cru *cru, uint clk_id)
 		div = 1;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	div *= (con & CLK_EMMC_DIV_CON_MASK) >> CLK_EMMC_DIV_CON_SHIFT;
@@ -1003,7 +1003,7 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 		break;
 	default:
 		log_debug("Unknown clock %lu\n", clk->id);
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -1557,7 +1557,7 @@ static ulong rk3399_i2c_get_pmuclk(struct rk3399_pmucru *pmucru, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(PPLL_HZ, div);
@@ -1621,7 +1621,7 @@ static ulong rk3399_pmuclk_get_rate(struct clk *clk)
 		rate = rk3399_i2c_get_pmuclk(priv->pmucru, clk->id);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index d58557ff56de1b5e69cf0f51aa6ac9ab99bafd5f..fe5cdb18f645acdf93826f76cdf74d4fdf375295 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -239,7 +239,7 @@ static ulong rk3528_ppll_matrix_get_rate(struct rk3528_clk_priv *priv,
 		reg = &cru->clksel_con[60];
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	div = (readl(reg) & mask) >> shift;
@@ -378,7 +378,7 @@ static ulong rk3528_cgpll_matrix_get_rate(struct rk3528_clk_priv *priv,
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (sel_mask) {
@@ -575,7 +575,7 @@ static ulong rk3528_i2c_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (is_pmucru)
@@ -692,7 +692,7 @@ static ulong rk3528_spi_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 		shift = CLK_SPI1_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[id]);
@@ -765,7 +765,7 @@ static ulong rk3528_pwm_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[id]);
@@ -838,7 +838,7 @@ static ulong rk3528_adc_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(OSC_HZ, div);
@@ -1045,7 +1045,7 @@ static ulong rk3528_dclk_vop_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[id]);
@@ -1177,7 +1177,7 @@ static ulong rk3528_uart_get_rate(struct rk3528_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[id - 2]);
@@ -1310,7 +1310,7 @@ static ulong rk3528_clk_get_rate(struct clk *clk)
 	if (!priv->gpll_hz || !priv->cpll_hz) {
 		printf("%s: gpll=%lu, cpll=%ld\n",
 		       __func__, priv->gpll_hz, priv->cpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (clk->id) {
@@ -1416,7 +1416,7 @@ static ulong rk3528_clk_get_rate(struct clk *clk)
 		rate = rk3528_ppll_matrix_get_rate(priv, clk->id);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 533031caead6818fe41774c9efee969fdd428dbc..93b9af79d0a47f4d87e801ea2105505389d9ec5d 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -233,7 +233,7 @@ static ulong rk3568_i2c_get_pmuclk(struct rk3568_pmuclk_priv *priv,
 		div = (con & CLK_I2C0_DIV_MASK) >> CLK_I2C0_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->ppll_hz, div);
@@ -277,7 +277,7 @@ static ulong rk3568_pwm_get_pmuclk(struct rk3568_pmuclk_priv *priv,
 			parent = priv->ppll_hz;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -353,7 +353,7 @@ static ulong rk3568_pmuclk_get_rate(struct clk *clk)
 
 	if (!priv->ppll_hz) {
 		printf("%s ppll=%lu\n", __func__, priv->ppll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("%s %ld\n", __func__, clk->id);
@@ -380,7 +380,7 @@ static ulong rk3568_pmuclk_get_rate(struct clk *clk)
 		rate = rk3568_pmu_get_pmuclk(priv);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -641,7 +641,7 @@ static ulong rk3568_cpll_div_get_rate(struct rk3568_clk_priv *priv,
 		shift = CPLL_25M_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	div = (readl(&cru->clksel_con[con]) & mask) >> shift;
@@ -741,7 +741,7 @@ static ulong rk3568_bus_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -821,7 +821,7 @@ static ulong rk3568_perimid_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -924,7 +924,7 @@ static ulong rk3568_top_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -1022,7 +1022,7 @@ static ulong rk3568_i2c_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -1078,7 +1078,7 @@ static ulong rk3568_spi_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_SPI3_SEL_MASK) >> CLK_SPI3_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -1089,7 +1089,7 @@ static ulong rk3568_spi_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 	case CLK_SPI_SEL_CPLL_100M:
 		return 100 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1152,7 +1152,7 @@ static ulong rk3568_pwm_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_PWM3_SEL_MASK) >> CLK_PWM3_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -1163,7 +1163,7 @@ static ulong rk3568_pwm_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 	case CLK_PWM_SEL_CPLL_100M:
 		return 100 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1226,7 +1226,7 @@ static ulong rk3568_adc_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		prate = rk3568_adc_get_clk(priv, CLK_TSADC_TSEN);
 		return DIV_TO_RATE(prate, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1331,7 +1331,7 @@ static ulong rk3568_crypto_get_rate(struct rk3568_clk_priv *priv, ulong clk_id)
 		else
 			return 100 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1418,7 +1418,7 @@ static ulong rk3568_sdmmc_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_SDMMC2_SEL_MASK) >> CLK_SDMMC2_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -1435,7 +1435,7 @@ static ulong rk3568_sdmmc_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 	case CLK_SDMMC_SEL_750K:
 		return 750 * KHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1517,7 +1517,7 @@ static ulong rk3568_sfc_get_clk(struct rk3568_clk_priv *priv)
 	case SCLK_SFC_SEL_150M:
 		return 150 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1565,7 +1565,7 @@ static ulong rk3568_nand_get_clk(struct rk3568_clk_priv *priv)
 	case NCLK_NANDC_SEL_24M:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1619,7 +1619,7 @@ static ulong rk3568_emmc_get_clk(struct rk3568_clk_priv *priv)
 	case CCLK_EMMC_SEL_24M:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1677,7 +1677,7 @@ static ulong rk3568_emmc_get_bclk(struct rk3568_clk_priv *priv)
 	case BCLK_EMMC_SEL_125M:
 		return 125 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1765,7 +1765,7 @@ static ulong rk3568_dclk_vop_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		conid = 41;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[conid]);
@@ -1781,7 +1781,7 @@ static ulong rk3568_dclk_vop_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 	else if (sel == DCLK_VOP_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1886,7 +1886,7 @@ static ulong rk3568_gmac_src_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_MAC0_2TOP_SEL_PPLL:
 		return rk3568_pmu_pll_get_rate(priv, HPLL);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1936,7 +1936,7 @@ static ulong rk3568_gmac_out_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_MAC0_OUT_SEL_24M:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1989,7 +1989,7 @@ static ulong rk3568_gmac_ptp_ref_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_GMAC0_PTP_REF_SEL_24M:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -2074,7 +2074,7 @@ static ulong rk3568_ebc_get_clk(struct rk3568_clk_priv *priv)
 	case DCLK_EBC_SEL_GPLL_200M:
 		return 200 * MHz;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -2127,7 +2127,7 @@ static ulong rk3568_rkvdec_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 			p_rate = priv->gpll_hz;
 		return DIV_TO_RATE(p_rate, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -2216,7 +2216,7 @@ static ulong rk3568_uart_get_rate(struct rk3568_clk_priv *priv, ulong clk_id)
 		reg = 68;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	con = readl(&cru->clksel_con[reg]);
 	src = (con & CLK_UART_SEL_MASK) >> CLK_UART_SEL_SHIFT;
@@ -2323,7 +2323,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (clk->id) {
@@ -2487,7 +2487,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 		rate = rk3568_cpll_div_get_rate(priv, clk->id);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 125b08ee8322e26ae91b3e8ef8c1fc398db2eab8..3f87b0e26b80085a9bf1bf597995b8a40451bf0d 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -164,7 +164,7 @@ static ulong rk3576_bus_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -281,7 +281,7 @@ static ulong rk3576_top_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -406,7 +406,7 @@ static ulong rk3576_i2c_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	if (sel == CLK_I2C_SEL_200M)
 		rate = 200 * MHz;
@@ -509,7 +509,7 @@ static ulong rk3576_spi_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_SPI4_SEL_MASK) >> CLK_SPI4_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -522,7 +522,7 @@ static ulong rk3576_spi_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 	case CLK_SPI_SEL_OSC:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -593,7 +593,7 @@ static ulong rk3576_pwm_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_PMU1PWM_SEL_MASK) >> CLK_PMU1PWM_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -604,7 +604,7 @@ static ulong rk3576_pwm_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 	case CLK_PWM_SEL_OSC:
 		return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -667,7 +667,7 @@ static ulong rk3576_adc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		prate = OSC_HZ;
 		return DIV_TO_RATE(prate, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -808,7 +808,7 @@ static ulong rk3576_mmc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		return DIV_TO_RATE(prate, div);
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -992,7 +992,7 @@ static ulong rk3576_aclk_vop_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 			return OSC_HZ;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1106,7 +1106,7 @@ static ulong rk3576_dclk_vop_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (sel == DCLK_VOP_SRC_SEL_VPLL)
@@ -1249,7 +1249,7 @@ static ulong rk3576_clk_csihost_get_clk(struct rk3576_clk_priv *priv, ulong clk_
 		sel = (con & CLK_DSIHOST0_SEL_MASK) >> CLK_DSIHOST0_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (sel == CLK_DSIHOST0_SEL_VPLL)
@@ -1384,7 +1384,7 @@ static ulong rk3576_dclk_ebc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		m >>= CLK_UART_FRAC_DENOMINATOR_SHIFT;
 		return parent * n / m;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1552,7 +1552,7 @@ static ulong rk3576_gmac_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		div = (con & CLK_GMAC1_125M_DIV_MASK) >> CLK_GMAC1_125M_DIV_SHIFT;
 		return DIV_TO_RATE(priv->cpll_hz, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1634,7 +1634,7 @@ static ulong rk3576_uart_frac_get_rate(struct rk3576_clk_priv *priv, ulong clk_i
 		reg = 25;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	con = readl(&cru->clksel_con[reg + 1]);
 	p_src = (con & CLK_UART_SRC_SEL_MASK) >> CLK_UART_SRC_SEL_SHIFT;
@@ -1760,7 +1760,7 @@ static ulong rk3576_uart_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
 		con = readl(&cru->clksel_con[70]);
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	if (clk_id == SCLK_UART1) {
 		src = (con & CLK_UART1_SRC_SEL_SHIFT) >> CLK_UART1_SRC_SEL_SHIFT;
@@ -1899,7 +1899,7 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	if (!priv->ppll_hz) {
@@ -2051,7 +2051,7 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 		break;
 
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 8c3a113526f902ef25bd0f661b28a021b18744f2..d04698f2aec3bd10fd9e820cb3eae15f39e3d6ca 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -188,7 +188,7 @@ static ulong rk3588_center_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -300,7 +300,7 @@ static ulong rk3588_top_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 			rate = OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -402,7 +402,7 @@ static ulong rk3588_i2c_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_I2C8_SEL_MASK) >> CLK_I2C8_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	if (sel == CLK_I2C_SEL_200M)
 		rate = 200 * MHz;
@@ -491,7 +491,7 @@ static ulong rk3588_spi_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_SPI4_SEL_MASK) >> CLK_SPI4_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -575,7 +575,7 @@ static ulong rk3588_pwm_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & CLK_PMU1PWM_SEL_MASK) >> CLK_PMU1PWM_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (sel) {
@@ -659,7 +659,7 @@ static ulong rk3588_adc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 			prate = 100 * MHz;
 		return DIV_TO_RATE(prate, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -785,7 +785,7 @@ static ulong rk3588_mmc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -892,7 +892,7 @@ static ulong rk3588_aux16m_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		div = (con & CLK_AUX16MHZ_1_DIV_MASK) >> CLK_AUX16MHZ_1_DIV_SHIFT;
 		return DIV_TO_RATE(parent, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -971,7 +971,7 @@ static ulong rk3588_aclk_vop_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		else
 			return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1069,7 +1069,7 @@ static ulong rk3588_dclk_vop_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & DCLK3_VOP_SRC_SEL_MASK) >> DCLK3_VOP_SRC_SEL_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (sel == DCLK_VOP_SRC_SEL_AUPLL)
@@ -1224,7 +1224,7 @@ static ulong rk3588_gmac_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		div = (con & CLK_GMAC_50M_DIV_MASK) >> CLK_GMAC_50M_DIV_SHIFT;
 		return DIV_TO_RATE(priv->cpll_hz, div);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
@@ -1304,7 +1304,7 @@ static ulong rk3588_uart_get_rate(struct rk3588_clk_priv *priv, ulong clk_id)
 		reg = 57;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 	con = readl(&cru->clksel_con[reg + 2]);
 	src = (con & CLK_UART_SEL_MASK) >> CLK_UART_SEL_SHIFT;
@@ -1430,7 +1430,7 @@ static ulong rk3588_pciephy_get_rate(struct rk3588_clk_priv *priv, ulong clk_id)
 		div = (con & CLK_PCIE_PHY2_PLL_DIV_MASK) >> CLK_PCIE_PHY2_PLL_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	if (src == CLK_PCIE_PHY_REF_SEL_PPLL)
@@ -1487,7 +1487,7 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	if (!priv->ppll_hz) {
@@ -1644,7 +1644,7 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 		break;
 #endif
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -2083,7 +2083,7 @@ static ulong rk3588_scru_clk_get_rate(struct clk *clk)
 		else
 			return OSC_HZ;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
index 75202a66aa68c1a4f820bab29b317ea484f95632..abec0444fbb0aa9d992b844d08cf5826e5fe2fc1 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -441,7 +441,7 @@ static ulong rv1108_i2c_get_clk(struct rv1108_cru *cru, ulong clk_id)
 		break;
 	default:
 		printf("do not support this i2c bus\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	return DIV_TO_RATE(GPLL_HZ, div);
@@ -568,7 +568,7 @@ static ulong rv1108_clk_get_rate(struct clk *clk)
 	case SCLK_EMMC_SAMPLE:
 		return rv1108_mmc_get_clk(priv->cru);
 	default:
-		return -ENOENT;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index aeeea95691479e8a6a450fb25b27f1b86d9494cb..073a8dd620843931816803f23ecafadf143c350d 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -201,7 +201,7 @@ static ulong rv1126_i2c_get_pmuclk(struct rv1126_pmuclk_priv *priv,
 		div = (con & CLK_I2C1_DIV_MASK) >> CLK_I2C1_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -254,7 +254,7 @@ static ulong rv1126_pwm_get_pmuclk(struct rv1126_pmuclk_priv *priv,
 			return OSC_HZ;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -372,7 +372,7 @@ static ulong rv1126_pmuclk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	debug("%s %ld\n", __func__, clk->id);
@@ -399,7 +399,7 @@ static ulong rv1126_pmuclk_get_rate(struct clk *clk)
 		break;
 	default:
 		debug("%s: Unsupported CLK#%ld\n", __func__, clk->id);
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;
@@ -602,7 +602,7 @@ static ulong rv1126_pdbus_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == ACLK_PDBUS_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	case HCLK_PDBUS:
 		con = readl(&cru->clksel_con[2]);
@@ -613,7 +613,7 @@ static ulong rv1126_pdbus_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == HCLK_PDBUS_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	case PCLK_PDBUS:
 	case PCLK_WDT:
@@ -625,10 +625,10 @@ static ulong rv1126_pdbus_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == PCLK_PDBUS_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -698,7 +698,7 @@ static ulong rv1126_pdphp_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		parent = priv->gpll_hz;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -781,7 +781,7 @@ static ulong rv1126_i2c_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		div = (con & CLK_I2C5_DIV_MASK) >> CLK_I2C5_DIV_SHIFT;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(priv->gpll_hz, div);
@@ -921,7 +921,7 @@ static ulong rv1126_crypto_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == CLK_CRYPTO_CORE_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	case CLK_CRYPTO_PKA:
 		con = readl(&cru->clksel_con[7]);
@@ -932,7 +932,7 @@ static ulong rv1126_crypto_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == CLK_CRYPTO_PKA_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	case ACLK_CRYPTO:
 		con = readl(&cru->clksel_con[4]);
@@ -943,10 +943,10 @@ static ulong rv1126_crypto_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		else if (sel == ACLK_CRYPTO_SEL_CPLL)
 			parent = priv->cpll_hz;
 		else
-			return -ENOENT;
+			return 0;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	return DIV_TO_RATE(parent, div);
@@ -1011,7 +1011,7 @@ static ulong rv1126_mmc_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 		con_id = 57;
 		break;
 	default:
-		return -ENOENT;
+		return 0;
 	}
 
 	con = readl(&cru->clksel_con[con_id]);
@@ -1024,7 +1024,7 @@ static ulong rv1126_mmc_get_clk(struct rv1126_clk_priv *priv, ulong clk_id)
 	else if (sel == EMMC_SEL_XIN24M)
 		return DIV_TO_RATE(OSC_HZ, div) / 2;
 
-	return -ENOENT;
+	return 0;
 }
 
 static ulong rv1126_mmc_set_clk(struct rv1126_clk_priv *priv, ulong clk_id,
@@ -1085,7 +1085,7 @@ static ulong rv1126_sfc_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == SCLK_SFC_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1117,7 +1117,7 @@ static ulong rv1126_nand_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == CLK_NANDC_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1149,7 +1149,7 @@ static ulong rv1126_aclk_vop_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == ACLK_PDVO_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1182,7 +1182,7 @@ static ulong rv1126_dclk_vop_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == DCLK_VOP_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1245,7 +1245,7 @@ static ulong rv1126_scr1_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == CLK_SCR1_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1278,7 +1278,7 @@ static ulong rv1126_gmac_src_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == CLK_GMAC_SRC_SEL_GPLL)
 		parent = priv->gpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1311,7 +1311,7 @@ static ulong rv1126_gmac_out_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == CLK_GMAC_OUT_SEL_GPLL)
 		parent = priv->gpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1386,7 +1386,7 @@ static ulong rv1126_dclk_decom_get_clk(struct rv1126_clk_priv *priv)
 	else if (sel == DCLK_DECOM_SEL_CPLL)
 		parent = priv->cpll_hz;
 	else
-		return -ENOENT;
+		return 0;
 
 	return DIV_TO_RATE(parent, div);
 }
@@ -1413,7 +1413,7 @@ static ulong rv1126_clk_get_rate(struct clk *clk)
 
 	if (!priv->gpll_hz) {
 		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
-		return -ENOENT;
+		return 0;
 	}
 
 	switch (clk->id) {
@@ -1509,7 +1509,7 @@ static ulong rv1126_clk_get_rate(struct clk *clk)
 		break;
 	default:
 		debug("%s: Unsupported CLK#%ld\n", __func__, clk->id);
-		return -ENOENT;
+		return 0;
 	}
 
 	return rate;

-- 
2.47.3


