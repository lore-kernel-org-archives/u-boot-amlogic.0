Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15865.1795264872769095157
 for <u-boot-amlogic@groups.io>;
 Sat, 21 Nov 2026 04:41:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=BHRC08t7;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.167.51, mailfrom: dario.binacchi@amarulasolutions.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so2402878e87.1
        for <u-boot-amlogic@groups.io>; Sat, 21 Nov 2026 04:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795264871; x=1795869671; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
        b=BHRC08t7RiJaIdjjisOeyKOnfV6Ys21v/UUewUXj0B4P8hvN3UU8Ub/g7mcxgdK3t2
         28850Caf9xPxqZLV7P6pFdoGys5OERkIEAKEF217dYL0WAJ5/pDJEYcKX+XO4QW4S4R0
         I+ituL9Ld4XHj+GcTdgRqp+UwtFftup+P2NmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795264871; x=1795869671;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0n+YNFcmMyOeqNS629GEoFYUxyDiF7wnnMtBbUZqLM=;
        b=PsfpdwDfpgUpsvqa8KDR/BAbDNOzJ36ykjDGv+tlcQnodDfxyrKh2Z31b8wCTI+szH
         Qc5jMemLh4zw7HuPypHUYxYcgWcgQfRqMY09+vi2mJv1F6gobJmQkcAM+vaIYWgU8kwY
         +Yl3JXYLVcdmwyOGuG/ujNBCZJh5Ef4Ee1XhfjVXCHsWxADrrPbtOljHaboGvLl2I4g0
         ORMnnjeMULlM5WO9ewSGLfaZa6m9ojMd6i8dl7L8xneYefNT8oIpnMnlhHSsqwLe2j+j
         1kVaxlzw1/hS/GvT8YD7aD3E8FkvbViZvRkKpKriMEdzo3tNmeQWfb8KOj3RUD+5S2/3
         omiA==
X-Forwarded-Encrypted: i=1; AL+hErFYi4cak2/Hvjf8fAxycUtwU/+TbEbHAJBKlrBGMmpQl4kv9nTIKmzQ/e75EkmMuEoAMob2qYeySZQ8/Cj23A==@groups.io
X-Gm-Message-State: APuU4Z9tVXKqchdPjkYEjHY42PMYGybarjsfslSMalp9TaDSP82BQ/1o
	nkBx6lzxPkGvNslx6WXXtyqt469rLlpqYToB6WyoyD8YLSF68I+d3ij4C2ecjU5aeqlvRJAmDnG
	hjsHE
X-Gm-Gg: AZFdTZfjx17+zfhUQH7ipzIfzsmOBvphcdjUicJnTVVAP+T9qDgCaIMIZ79o99yDPKS
	LA45a1HKKl4w7hUaXidG5e7A9EoexXSvtz50LVTifFrnKrB0IgrHw1V3mSX5xbYr0wOKFeHCUvW
	m/SyQi7lmIEfn3DV1/jxiPk1LONm3vaweW3pXao6An5n1X6A70MSsTrV7czpsDkFPW4adrPfNTl
	0a0KfycOXRYwmVYRAIx0xQIR98ZuzpPydqRzo/s7F5tQWdNwKeFQIa681BkECScfsJd8sCkBA8V
	v0mP+77p0tfot+BRcFkqcJDsYyDVnIcFqkovnlHLOY5MI0P/Mza+kwuPiWy5WSfZTMpMTR4REhQ
	6qMRVrGuuP/u39rbRxrMvlGhcQo30EKRfnVnUG5ud9VihKOSuF47IPvgrmGqjRqB86vIHP5cvTn
	cL2BDnaAOV/hiiDtg6Uh3vS0lEpBG6PacByk5Y4Jsxs0mjpc456SQ0/svwWyNi6I5zTfPRiYDBt
	msqwRraYMPWPJIr7h0ZdgVeCw7h4g/7jfGmiklZj32qBcx2eBUjl4YXu3P/FFt5e2oiE+OBv/Nj
	tsnq1npAe1Jl5+x6eXnN6aTQdRs/+F6B0uOJJWVDgZ94/nZFHGGhbn6wmT6MuEGEHZKbTj8FPAb
	pl3kwCydH3Xd7xut3PAQtlkxGZIX4qHujLfnPCKCCmMG7LDbx9gxwynwePwpk//aJZ5TFkaWlro
	AHPsP3OJakHFBQkEVhkruCi1fEpg==
X-Received: by 2002:a05:6000:2385:b0:497:9e2a:b1e with SMTP id ffacd0b85a97d-4abb36787a4mr13966065f8f.9.1795264526668;
        Sat, 21 Nov 2026 04:35:26 -0800 (PST)
Return-Path: <dario.binacchi@amarulasolutions.com>
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:35:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Heiko Schocher <hs@nabladev.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 16/25] phy: dphy: Correct clk_pre parameter
Date: Sat, 21 Nov 2026 13:34:06 +0100
Message-ID: <20261121123451.2471185-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3153
Content-Type: text/plain; charset="utf-8"

From: Michael Trimarchi <michael@amarulasolutions.com>

Upstream linux commit 9a8406ba1a9a29.

The D-PHY specification (v1.2) explicitly mentions that the T-CLK-PRE
parameter's unit is Unit Interval(UI) and the minimum value is 8.  Also,
kernel doc of the 'clk_pre' member of struct phy_configure_opts_mipi_dphy
mentions that it should be in UI.  However, the dphy core driver wrongly
sets 'clk_pre' to 8000, which seems to hint that it's in picoseconds.

So, let's fix the dphy core driver to correctly reflect the T-CLK-PRE
parameter's minimum value according to the D-PHY specification.

I'm assuming that all impacted custom drivers shall program values in
TxByteClkHS cycles into hardware for the T-CLK-PRE parameter.  The D-PHY
specification mentions that the frequency of TxByteClkHS is exactly 1/8
the High-Speed(HS) bit rate(each HS bit consumes one UI).  So, relevant
custom driver code is changed to program those values as
DIV_ROUND_UP(cfg->clk_pre, BITS_PER_BYTE), then.

Note that I've only tested the patch with RM67191 DSI panel on i.MX8mq EVK.
Help is needed to test with other i.MX8mq, Meson and Rockchip platforms,
as I don't have the hardwares.

Tested-by: Liu Ying <victor.liu@nxp.com> # RM67191 DSI panel on i.MX8mq EVK
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> # for phy-meson-axg-mipi-dphy.c
Tested-by: Neil Armstrong <narmstrong@baylibre.com> # for phy-meson-axg-mipi-dphy.c
Tested-by: Guido Günther <agx@sigxcpu.org> # Librem 5 (imx8mq) with it's rather picky panel
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Link: https://lore.kernel.org/r/20220124024007.1465018-1-victor.liu@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/phy/meson-axg-mipi-dphy.c | 2 +-
 drivers/phy/phy-core-mipi-dphy.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
index 3f89de19970b..fb10ccca6ac1 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -237,7 +237,7 @@ static int phy_meson_axg_mipi_dphy_power_on(struct phy *phy)
 		     (DIV_ROUND_UP(priv->config.clk_zero, temp) << 16) |
 		     (DIV_ROUND_UP(priv->config.clk_prepare, temp) << 24));
 	regmap_write(priv->regmap, MIPI_DSI_CLK_TIM1,
-		     DIV_ROUND_UP(priv->config.clk_pre, temp));
+		     DIV_ROUND_UP(priv->config.clk_pre, BITS_PER_BYTE));
 
 	regmap_write(priv->regmap, MIPI_DSI_HS_TIM,
 		     DIV_ROUND_UP(priv->config.hs_exit, temp) |
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 79cab9125002..27cff85709d9 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -36,7 +36,7 @@ static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 
 	cfg->clk_miss = 0;
 	cfg->clk_post = 60000 + 52 * ui;
-	cfg->clk_pre = 8000;
+	cfg->clk_pre = 8;
 	cfg->clk_prepare = 38000;
 	cfg->clk_settle = 95000;
 	cfg->clk_term_en = 0;
-- 
2.43.0

