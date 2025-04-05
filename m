Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F83C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.14982.1743891207721316384
 for <u-boot-amlogic@groups.io>;
 Sat, 05 Apr 2025 15:13:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=oWpusEOI;
 spf=pass (domain: chromium.org, ip: 209.85.215.172, mailfrom: sjg@chromium.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ad5236e6fd6so2870309a12.0
        for <u-boot-amlogic@groups.io>; Sat, 05 Apr 2025 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743891207; x=1744496007; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqRN4BOJRz5HuTYf5bcnlogkD6JTsPSyi60mFnFlM8k=;
        b=oWpusEOIHo5Gz651UQXvJgikovHbItij3NxTeOyzeldlBLhWCxToUC1j5FZb+i4rYE
         XaKR9bpsaHLTmY9fyHyDjRNVcoxHP+EBYXEZrjIwZKWby/0bKtqXz+QJFj+n5BGQ2sxo
         5mV+K0Rh1PWzgitvMSkOqZOuVcuraRrgDOII0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891207; x=1744496007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqRN4BOJRz5HuTYf5bcnlogkD6JTsPSyi60mFnFlM8k=;
        b=JYcMt4vxAq/VA2PfIuh26Kqfi6vhUDJ3C2knx6HfQEa7+TMtPuGsG0g3BcNhqok7qc
         bcXBlaxb94XhdkdwZ42mweeBC4kgdwFkj0tr1NUVeGi2ekB4b0DwiFyV72N/KBUtandJ
         irpBwxDr6f+hpc7RiJgZPHdQrS3419wo9DkeKV5DF/mWYsWrV27eSyZJTeHTlZR7q6i5
         AqEzhWveY60c0aFmdTFb9gEqyuig16zkaATVtr46S82stkBJiftEUWuQGTrjrbz0rUJZ
         YW/qv6/r11jFp+Fci0ZPfRFZCcu//35xvsbwIt9Gh/o0jj9MzRztA7/3yrfA+BBZ0hAW
         yhZg==
X-Forwarded-Encrypted: i=1; AJvYcCXGqMjWZMFxp/kNVCt8SH2hXDuJuKMt1tHXT+0yzHzi32yDCvPu3yijY3BSHTxBSq4nP2kKcUW57wHw6V/G7Q==@groups.io
X-Gm-Message-State: AOJu0YyrL6h2c/D7gKllkSgYN1ZYNvukFawgx73157X4HNQr4zfKt3A3
	dgbpmpPv56nBQUFFGICFOoqLYzRaG9U/00+mCeXB/Pbf8nD9SmFgnvDUBIGpGg==
X-Gm-Gg: ASbGncvibed6JolJDqygjl3R3U7KXJh1BCf3qTolSQpcpPkFOeHJmPyHYk72O3oCN5t
	afFQZmMuyY00jVCmujgxV9mAIFsr1IvI0MZdgLCoX7ZZBsBbYkW6YVLjG4Zs2zMMby3qC/yNG/y
	R9oxn37pkTgElj1Jehdb6ygX7GcFMmQXpqmbyFVwNM0PkyJuQCZcoF1ADIgV5A/cayObQ48lMDX
	OlDzCUXSOZ55uFCcXkPWPKTnVji4qZ2Pyq8K24gE9yBStWzp+qonLRvPRG4bsVKycc4xnGdUXN/
	4BpcRTPy73bl8RQFnaI/GwKR3NRR+cgr8sxIWBD+mdY=
X-Google-Smtp-Source: AGHT+IHSchHkvLwFTljc4pmaAMwO4NXUDeOWljG2BNk3f6NG0zzoKa8X1Ot9qHUasxR8KtEeO9ASUw==
X-Received: by 2002:a17:902:c94e:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22a8a0b38bdmr87775605ad.43.1743891207123;
        Sat, 05 Apr 2025 15:13:27 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e612sm54431615ad.200.2025.04.05.15.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:13:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	neil.armstrong@linaro.org,
	Simon Glass <sjg@chromium.org>,
	=?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
	Jim Liu <jim.t90615@gmail.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Kongyang Liu <seashell11234455@gmail.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
	Ramon Fried <rfried.dev@gmail.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 2/3] designware: Use the remove() method with related drivers
Date: Sun,  6 Apr 2025 10:12:46 +1200
Message-ID: <20250405221308.498047-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405221308.498047-1-sjg@chromium.org>
References: <20250405221308.498047-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2660

Several drivers make use of the designware Ethernet driver but do not
implement the remove() method. Add this so that DMA is stopped when the
OS is booted to avoid memory corruption, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
---

 drivers/net/designware.c    |  2 +-
 drivers/net/designware.h    | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c |  6 ++++++
 drivers/net/dwmac_s700.c    |  6 ++++++
 drivers/net/dwmac_socfpga.c |  6 ++++++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index eebf14bd51a..d4d31925fca 100644
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
index fde4aabbace..b2152f8da9b 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -145,6 +145,11 @@ static int dwmac_meson8b_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_meson8b_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static const struct udevice_id dwmac_meson8b_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
 	{ .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
@@ -158,6 +163,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
 	.probe		= dwmac_meson8b_probe,
+	.remove		= dwmac_meson8b_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3..cfb37c3aa71 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -44,6 +44,11 @@ static int dwmac_s700_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_s700_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static int dwmac_s700_of_to_plat(struct udevice *dev)
 {
 	return designware_eth_of_to_plat(dev);
@@ -60,6 +65,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
 	.probe  = dwmac_s700_probe,
+	.remove	= dwmac_s700_remove,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a9e2d8c0972..8e7a9975d28 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -130,6 +130,11 @@ static int dwmac_socfpga_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_socfpga_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static const struct udevice_id dwmac_socfpga_ids[] = {
 	{ .compatible = "altr,socfpga-stmmac" },
 	{ }
@@ -141,6 +146,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
 	.probe		= dwmac_socfpga_probe,
+	.remove		= dwmac_socfpga_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
-- 
2.43.0

base-commit: bcfa94be955ef263d37918ef4b8f898ee8964c61
branch: eth

