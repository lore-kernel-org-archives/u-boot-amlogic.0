Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E4CF58FA
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 09:27:38 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.69983.1726221440640965910
 for <u-boot-amlogic@groups.io>;
 Fri, 13 Sep 2024 02:57:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=kNZXvDrG;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.51, mailfrom: dario.binacchi@amarulasolutions.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d64b27c45so96029366b.3
        for <u-boot-amlogic@groups.io>; Fri, 13 Sep 2024 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1726221439; x=1726826239; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ6Zjs8lUX/jMH8JhmryfFLNpN3PXuow+IQQ28EHkRM=;
        b=kNZXvDrGRNm8QazH4KOe//V05zd+hS27gNTPqIk0IyZX72zHQanwSgOUpEY0vrxh/Q
         yuseyoutyp5/zb+Hhhok38pQxoBZi8Dqc3umX1yVRICi7NRc675FZyu9nKlqA6F3eswx
         UvHn4Ho7iUS1xkSf0rkOHg1gk2HOyHm/ZQy2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221439; x=1726826239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ6Zjs8lUX/jMH8JhmryfFLNpN3PXuow+IQQ28EHkRM=;
        b=K8RUuTDrpNKeeqXXybDTlr1ifrMDXMglpFpTHJqj8R/LLd1Q2zI0xZAfyIhI5cgtKP
         NGl+xn8DchKnfOZuRpSLHpP78Jgm+SZkPnYbBJxMbRzWmAc1hx/Swsk1f9J+XBQXjlhU
         n9bLlhQRYbKwfn1Iz/DQp9soggnV8/EbO3krjftWQO6p7TXT7Yl7OcKRukmwOiArV7DQ
         FS+8WejejQW8MVOSnfJSzrERAi3sRn/GTPDfn17V6eFk8OSEfjReobiF0f9ULQpx1cxf
         QNgKTJqB2jv1n6F0l14howbcKLmmiCD7ZdfJ+HRlF7Mc2CCXWUuftRylqHrpo75B/JY3
         tH1g==
X-Forwarded-Encrypted: i=1; AJvYcCUhuBNoCLvMTc4J4SdLxlUhwaQW0py7xCcqJOJwNXVEVJfCYLtqrPj/X/bMiQM1Cz8/0/jjqQCrFjYvZmy5gg==@groups.io
X-Gm-Message-State: AOJu0YxjGGIZi5Hyuhp5wYmZK47ZYcqdzYIZ2Sg4hIY6wdoROV3KjUAY
	sUGD+04qVzjvxvwASUrZVk7nR0uAtMGfMPdczEOwhrlbPtVRnQYUXey0ROUUjJQ=
X-Google-Smtp-Source: AGHT+IFtxQKb63UM6GMG9K81P+QpGYTeQ/j4vQXZODsrfLx3+FWJL3AWzXyf+r6tfdxKhw17DbCfHA==
X-Received: by 2002:a17:906:c113:b0:a8a:835f:4cb9 with SMTP id a640c23a62f3a-a9048105fd9mr184073166b.46.1726221438905;
        Fri, 13 Sep 2024 02:57:18 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:57:18 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Igor Prusov <ivprusov@salutedevices.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sean Anderson <seanga2@gmail.com>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 16/26] phy: dphy: Correct clk_pre parameter
Date: Fri, 13 Sep 2024 11:55:58 +0200
Message-ID: <20240913095622.72377-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:27:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2396

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


