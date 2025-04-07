Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B282C369A7
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.37364.1743989741068845245
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 18:35:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=GkQ/mnrg;
 spf=pass (domain: chromium.org, ip: 209.85.214.174, mailfrom: sjg@chromium.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2279915e06eso33579165ad.1
        for <u-boot-amlogic@groups.io>; Sun, 06 Apr 2025 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743989740; x=1744594540; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2X8KJewfU5JWVH+GKLrxtiYMARmXughHoHsMBbsu6U=;
        b=GkQ/mnrgmoURWchbmiOLCcVQacMeABpz4xtRoDlO/Wj1eXZweNoUZja65OjFTHcl3N
         7nA2QbTPzTx5fP4WuQfl4GAqKgHBmKvMym7wEbGwan1UMjvR05dSIc/EvOroEBA/Uglr
         xQxNks38EUvb5C8o81SvIII+Qwp8/0iBXUSmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743989740; x=1744594540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2X8KJewfU5JWVH+GKLrxtiYMARmXughHoHsMBbsu6U=;
        b=VgAG2SIvT7Kn5YmJY1UfQ2qox+UYjP/Av5RUpTiiIInvAwKtJm6uMwOb8dj2vYtE4P
         U2D8s8mnHKc6/WxMz5Uyz4YYE269P0LFpBQYwuxLxxgd2ZrSsOTdbEvyr9s1hbBCUOED
         g6HfwW+qwchEtwEZrde4kBoJRG6U7T/4Rwr7sn7pdUI4QZ3XPO3tXcDvY0v9MnLqLFed
         sBcpQfietxLyv9RK5xoqxGOZ3D1Nd+FuL7fBT86t510v6Su8Ycq9EyujVUtAB3EpvqtN
         cU95YJP79448HbVQgCKcSkUcrk1UUU8ytDGIbNta1MkatldWkNI9yCiqOaRP0AUayzpN
         Ph5w==
X-Forwarded-Encrypted: i=1; AJvYcCVPrsJL47lOgvNn+lyDIZnq7dZv2bpmUIZ4zqdyF/I5euS0XPMswZHGJFn+GghnMOnWsARnFh8GMmbI6mXs3g==@groups.io
X-Gm-Message-State: AOJu0YwQEbaH7dOSHS2dEy0eZsU+Cmz6A6IMLfBgbunPNxQyPw3WYly0
	TSj9Hi1zu2wb/KqUdUh4HHsI9TpF5yEmefdjPu8UIt29XejNDG2RPwgrIalSZg==
X-Gm-Gg: ASbGncuMrwE0ACeDKUKTltLLzD1XglXooKT5NXprI4jiZOQ1RnR4/OMVRoPjNK053KR
	Zrjal0S5r0+xR7+c0nZGfNwM+tdCyoDz4BjATAKW/XqmVaemyDbiUrZRazvn1B+x0gDuhkvQ/3S
	9m/q/GXYS5dLmrHLF51qDCYUw/fVV6JymaFrRXImE22Ri8Kobs+xHGTkdH1HTMAMyB/I375zUP8
	mVAiDKcxQSkPutKrkUG5d0O1y8j/dPesKuxYlbFW9twnbbruLLRreOrMg3fWxOJ2OuN7TpZqCi4
	S2yIgkc3t8/YH3ALPix1i5/ogysEs/j9GZF2Rs7o39ZqiZXn
X-Google-Smtp-Source: AGHT+IHFpxTWjZ2KwunxG9odW3T+YFoM6ECGGTFQ7hzlYI9PeB30MEsB3O/DhaQ6q7SO2q/a/Eviqw==
X-Received: by 2002:a17:903:22cc:b0:223:6657:5008 with SMTP id d9443c01a7336-22a8a06b7f6mr176075605ad.24.1743989740421;
        Sun, 06 Apr 2025 18:35:40 -0700 (PDT)
Received: from chromium.org ([161.29.84.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 18:35:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	neil.armstrong@linaro.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Simon Glass <sjg@chromium.org>,
	=?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
	Jim Liu <jim.t90615@gmail.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Kongyang Liu <seashell11234455@gmail.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Ramon Fried <rfried.dev@gmail.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 1/4] designware: Use the remove() method with related drivers
Date: Mon,  7 Apr 2025 13:35:07 +1200
Message-ID: <20250407013513.638110-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2654

Several drivers make use of the designware Ethernet driver but do not
implement the remove() method. Add this to keep things tidy.

Note that the Ethernet uclass calls each driver's stop() method on
removal, so there is no need to do that here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
---

Changes in v2:
- Use the designware_eth_remove() method directly
- Add gmac_rockchip too
- Reword the commit message to mention the uclass' actions

 drivers/net/designware.c    |  2 +-
 drivers/net/designware.h    | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c |  1 +
 drivers/net/dwmac_s700.c    |  1 +
 drivers/net/dwmac_socfpga.c |  1 +
 drivers/net/gmac_rockchip.c |  1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 07b0f49ef58..5385849ea6b 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -805,7 +805,7 @@ clk_err:
 	return err;
 }
 
-static int designware_eth_remove(struct udevice *dev)
+int designware_eth_remove(struct udevice *dev)
 {
 	struct dw_eth_dev *priv = dev_get_priv(dev);
 
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index e47101ccaf6..8c9d0190e03 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -247,6 +247,18 @@ struct dw_eth_dev {
 
 int designware_eth_of_to_plat(struct udevice *dev);
 int designware_eth_probe(struct udevice *dev);
+
+/**
+ * designware_eth_remove() - Remove the device
+ *
+ * Disables DMA and marks the device as remove. This must be called before
+ * booting an OS, to ensure that DMA is inactive.
+ *
+ * @dev: Device to remove
+ * Return 0 if OK, -ve on error
+ */
+int designware_eth_remove(struct udevice *dev);
+
 extern const struct eth_ops designware_eth_ops;
 
 struct dw_eth_pdata {
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbace..bf94e50842d 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -158,6 +158,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
 	.probe		= dwmac_meson8b_probe,
+	.remove		= designware_eth_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3..e78193f3376 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -60,6 +60,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
 	.probe  = dwmac_s700_probe,
+	.remove	= designware_eth_remove,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a9e2d8c0972..dda33f90d65 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -141,6 +141,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
 	.probe		= dwmac_socfpga_probe,
+	.remove		= designware_eth_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 8cfeeffe95b..5c542d62bd8 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -756,6 +756,7 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.of_match = rockchip_gmac_ids,
 	.of_to_plat = gmac_rockchip_of_to_plat,
 	.probe	= gmac_rockchip_probe,
+	.remove	= designware_eth_remove,
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct gmac_rockchip_plat),
-- 
2.43.0


