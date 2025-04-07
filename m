Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5254CC369A1
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.37366.1743989748714323067
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 18:35:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=inAcUsyF;
 spf=pass (domain: chromium.org, ip: 209.85.214.176, mailfrom: sjg@chromium.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so35505945ad.2
        for <u-boot-amlogic@groups.io>; Sun, 06 Apr 2025 18:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743989748; x=1744594548; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF5RmirvyfqxExHwFlY4cl7F6/Dei/Y1EJbGOnVapEs=;
        b=inAcUsyFLFnlmvG5VGXZMks0lkle/jFVmp0MKpUko7F1mlNXuFakcStRkZrO2Lrmps
         VSvQdG0BwEuvr14cdzcjElzb6A2VsEwDjdf44BosSMA6WDRGXDZlkWqqXl4Dt8PNuerH
         Imz++Y5VkE4EW30Zos3BehFNGv4DNo0rmgRsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743989748; x=1744594548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF5RmirvyfqxExHwFlY4cl7F6/Dei/Y1EJbGOnVapEs=;
        b=QS8eKkXXcKE2VMj4Ut8DECF41iKxOKRhKrz6S1HtrrrUR69QPZ6Oyzzz3HrvSs1FWg
         IGk4uNLGWgysYtpV9suR9fd59xFO50N9NWfhgKPqS022WYqjt66VdQ1pLimexL4Nmae9
         cFOC0O+GRymuCH38NaJkVvcCo/JA98ZDkdjkZnQs3yvX5FurS8zSJw/1a6DxL90eDjcb
         cdww/0aNy9OvvCQfGqOXx2TL0SONkSdnLQuyHax9FwYKaiA9EJjqChlGl+IHlQJ6GOT4
         3V3XccKxRqppmBK11g2w5r4ouUTKfxyGxhgh55wW5C2bL1gpbQ8PXZNqEi7ScAB6a0BI
         VOow==
X-Forwarded-Encrypted: i=1; AJvYcCW+f+44BdehkVfPMmHVCYLTn0amXcQdTr53bAPu/DjNEL1cT9rBVmD+JQFWYqXvP4gGibdfuwNljokejE+4gA==@groups.io
X-Gm-Message-State: AOJu0Ywoy+kMwmQmoGLSvzTGYSwTovHnaoGkwG/jK8uhKyWaPKWnTFDp
	2lAk6Nmk6FDKV9ADW7//iZlN9wzonUNtHxu50C4i30E8sY7cq2YPz9VWC4vFJg==
X-Gm-Gg: ASbGncvKzOtinDMg1LWkKvsB5TZBfogtAA0gAOXYhP7VND3TKTApCGNqlYgsNv6N07s
	lC9yoscwCbAkIhTq0r3ANZQB27IMwpQUix9sdztZIt+JrD/Db/8F4k/Em/Bep3i3yagPxvJUrVE
	fa7Dlae7/KaCc2EfWDe42aFfuhQT0sqCle6u9rDVxasAkIETP22EldSVnEjBMHV6GLtVwgh8+r6
	B0+8/fxxUqgWMKFMevNmpalXae1zeZSiumbR5lhqaiBlPP8NIX7PnEdNZ4XMQdyq6xHMPcTCPaf
	uyJkqGUZD5eQtf0tznaMC5Be+ijF4rgUle93GV9bAzNok1S0
X-Google-Smtp-Source: AGHT+IHpIhp4Qn8PFp2jdifcudSZ3jmYyL/TiQCE104ERfL1RSlgE5ZNwZvJj7nytPrUyFZxx/NOZw==
X-Received: by 2002:a17:902:ef0b:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22a8a0b59fbmr151111045ad.49.1743989748051;
        Sun, 06 Apr 2025 18:35:48 -0700 (PDT)
Received: from chromium.org ([161.29.84.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 18:35:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	neil.armstrong@linaro.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Simon Glass <sjg@chromium.org>,
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
Subject: [PATCH v2 2/4] net: designware: Mark drivers as having active DMA
Date: Mon,  7 Apr 2025 13:35:08 +1200
Message-ID: <20250407013513.638110-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2659

Network devices which use this driver have DMA running while receiving
packages. Add the required flag to driver model so that they will be
removed before starting the OS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a new patch to mark drivers as having active DMA

 drivers/net/designware.c    | 2 +-
 drivers/net/dwmac_meson8b.c | 2 +-
 drivers/net/dwmac_s700.c    | 2 +-
 drivers/net/dwmac_socfpga.c | 2 +-
 drivers/net/gmac_rockchip.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 5385849ea6b..9b2b0a5d602 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -885,7 +885,7 @@ U_BOOT_DRIVER(eth_designware) = {
 	.ops	= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dw_eth_pdata),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
 
 static struct pci_device_id supported[] = {
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index bf94e50842d..95a99a98e99 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -162,5 +162,5 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
-	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index e78193f3376..21df8e3ce81 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -64,5 +64,5 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index dda33f90d65..9f262aaee60 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -145,5 +145,5 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
-	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 5c542d62bd8..52be3a5687f 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -760,5 +760,5 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct gmac_rockchip_plat),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
-- 
2.43.0


