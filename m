Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D22CC41535
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 09:30:31 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.32521.1702459822191259859
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Dec 2023 01:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=NGwhb0ao;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3331752d2b9so4415981f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 13 Dec 2023 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702459820; x=1703064620; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb+HF1PPlgWJ5vSvv5zwE9PzUMBCQyQC6W64EY5QSn0=;
        b=NGwhb0aoqmwXxgBFmPaYeg27Oy7j/D11vmfNsFn69HmPX7tBaTGP1+reAuAU11mpzr
         zD8W2WWNtFXsxo3ZvagaXhWVjejswbjXnNgU7xzVZjqDf0xRMtdaCiO9XXWPPgdLhyYF
         f7Gbrb9IhRT96PSJSwbiB9ZJMQADVRMXlkVcSbrizMzuIcA9oBOJknSvFmKoHO05m+31
         hPirWBK1mtzNKiS0oXB+smTCybCrX5gry726z4jNu6awsQrENJ9fKFbHP/upqsHRsK6z
         zYLxteyZFKkexcqROV1GcHgnhr6jgDIJ2qdxwdOJJPF9bipUMreJzkhWpp/z1iMjQXmH
         CJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702459820; x=1703064620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb+HF1PPlgWJ5vSvv5zwE9PzUMBCQyQC6W64EY5QSn0=;
        b=qgyv4zsnwyORKYCdEbbxeCYrV2oGY3CXTTVGPOYjeEkOeuFJAOmL2Rbk6LKCf0tpkZ
         /y3hw3qz/GdWmllSpSzqBsln0CpV5ZCYF9gzNPTPkdLOYAHp1WrWJMnqueyl8Mk8c6TI
         ve/1shwEhaWb6+TkQGUdLmwhmbUVHACt/wubyUrt4IzTwpQXlghncpdbwDaNfYFRDiGO
         ZCcttSiiWh+JQYFvL+v2IGSF+ERZvbQcgz/jBM9aPx731eabLyUQY6/39Uhss+w86rif
         BXVCFd1w+ilZwPckS9NBl3DYgTs+VaQu4z95xjTFaGLXcxU45QiiNiz/MCS+lhAkgeOB
         ZPMw==
X-Gm-Message-State: AOJu0YxJRcWWXxy8DOpLZh/t07jeN/osh/KBBOc+crm4Ja19bqUr99Hq
	z668965c/Bsxu2nhYYi/bKqLOg==
X-Google-Smtp-Source: AGHT+IFAc0uYXf3JS8n8Xb/qtCyVLfDLOuAFagrl9K4g4qzfCNdETt8VP1BFrl1JcylIaQ0cEAaXlA==
X-Received: by 2002:adf:e4c4:0:b0:336:1b08:be28 with SMTP id v4-20020adfe4c4000000b003361b08be28mr3443489wrm.61.1702459820526;
        Wed, 13 Dec 2023 01:30:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d504c000000b003333521a1cesm678817wrt.57.2023.12.13.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:30:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Dec 2023 10:30:12 +0100
Subject: [PATCH v2 1/2] net: Add Amlogic GXL MDIO Mux driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-u-boot-gxl-mdio-mux-v2-1-c56bb02a75ea@linaro.org>
References: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
In-Reply-To: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5612;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8zFHpbaCfpky6TcLUOMzXDzzHLvfk+56YGGbydKVkWo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleXmohPdC3pm4mweZQrtsK+AUsw6g4xtf8ld9P
 03tSilv6CyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXl5qAAKCRB33NvayMhJ
 0b2UEACw0I2RnUmlEeNUwqH8Ekfoj7tttNV+sN3EYlBM3AI9+QrxO/QcwWPBv5gR7kC/WXDmAFb
 YsUKgzVsf5q/r9iqC4jxTDOvCRN92MbvPsS6PyWrPRpeVR5BE/xgJ+v5KoeggHbCCC16TXzQJDA
 A4Dbh7g6nriRwmVbPz6rYoGFmgADcI2/Hi15syChPv3gjnKDVQ/XPYw/xHzdKkGAKqlfLfwiG1I
 poeKMWbkZmThI8kYleWyiDR/64DLH2xHGYEWJJh/74QOf985Vh0OJ40I+S49C1mWqqJgcsF7lpm
 w+SKPRX/rkyQPFR0y8Ysd6tuMjbFdONYGlnaaTGwrqrdPFfHh7n5lSuDabxJKZ4+FEZp+os+2zt
 6ctfJQlCwM4nIbmyiqKbyC2E8ujwOTLxAmYzfvp4JrEzGGj5zijEki7mAbjh23Iu4aOMljELVwW
 2N2xBM6zlLSKq96yrL1u6zIujqMy7pQ08YJs6OiXXvj+RCMUVhbvZajHNNeNSqMxjwMYtlKJUys
 dmE4mdvwJnS8sIQr5uy7sQojQ5I/xLGBCg7rW20Obz8XIQKMT4cuiI0xrhdrZOcEo6S9ah3vQly
 WcI5q+wu8gDS/6iUZF68t3TfN1VFR5lyrB30LHdqTon/sIp0ilrAGjE95gv/NrQQmEdyhN4Z1nw
 o6pixB62sTJanQQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 Dec 2023 09:30:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1914

Port the mdio-mux-meson-gxl.c Linux driver introduced in [1],
and adapt it to U-Boot.

This driver is needed to boot U-Boot with Linux DT since v6.4,
since it switched the MDIO mux from the mmio to a proper GXL driver.

[1] 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/net/Kconfig              |   7 ++
 drivers/net/Makefile             |   1 +
 drivers/net/mdio_mux_meson_gxl.c | 138 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ebab4d9f2e..18ec910d12 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -988,4 +988,11 @@ config MDIO_MUX_MESON_G12A
 	  This driver is used for the MDIO mux found on the Amlogic G12A & compatible
 	  SoCs.
 
+config MDIO_MUX_MESON_GXL
+	bool "MDIO MUX for Amlogic Meson GXL SoCs"
+	depends on DM_MDIO_MUX
+	help
+	  This driver is used for the MDIO mux found on the Amlogic GXL & compatible
+	  SoCs.
+
 endif # NETDEVICES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 1ce6fea323..3794609fd2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
+obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
 obj-$(CONFIG_MDIO_MUX_MMIOREG) += mdio_mux_mmioreg.o
 obj-$(CONFIG_MDIO_MUX_SANDBOX) += mdio_mux_sandbox.o
 obj-$(CONFIG_MDIO_SANDBOX) += mdio_sandbox.o
diff --git a/drivers/net/mdio_mux_meson_gxl.c b/drivers/net/mdio_mux_meson_gxl.c
new file mode 100644
index 0000000000..8ef3ae598b
--- /dev/null
+++ b/drivers/net/mdio_mux_meson_gxl.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Baylibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <miiphy.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+
+#define ETH_REG2		0x0
+#define  REG2_PHYID		GENMASK(21, 0)
+#define   EPHY_GXL_ID		0x110181
+#define  REG2_LEDACT		GENMASK(23, 22)
+#define  REG2_LEDLINK		GENMASK(25, 24)
+#define  REG2_DIV4SEL		BIT(27)
+#define  REG2_ADCBYPASS		BIT(30)
+#define  REG2_CLKINSEL		BIT(31)
+#define ETH_REG3		0x4
+#define  REG3_ENH		BIT(3)
+#define  REG3_CFGMODE		GENMASK(6, 4)
+#define  REG3_AUTOMDIX		BIT(7)
+#define  REG3_PHYADDR		GENMASK(12, 8)
+#define  REG3_PWRUPRST		BIT(21)
+#define  REG3_PWRDOWN		BIT(22)
+#define  REG3_LEDPOL		BIT(23)
+#define  REG3_PHYMDI		BIT(26)
+#define  REG3_CLKINEN		BIT(29)
+#define  REG3_PHYIP		BIT(30)
+#define  REG3_PHYEN		BIT(31)
+#define ETH_REG4		0x8
+#define  REG4_PWRUPRSTSIG	BIT(0)
+
+#define MESON_GXL_MDIO_EXTERNAL_ID 0
+#define MESON_GXL_MDIO_INTERNAL_ID 1
+
+struct mdio_mux_meson_gxl_priv {
+	phys_addr_t regs;
+};
+
+static int meson_gxl_enable_internal_mdio(struct mdio_mux_meson_gxl_priv *priv)
+{
+	u32 val;
+
+	/* Setup the internal phy */
+	val = (REG3_ENH |
+	       FIELD_PREP(REG3_CFGMODE, 0x7) |
+	       REG3_AUTOMDIX |
+	       FIELD_PREP(REG3_PHYADDR, 8) |
+	       REG3_LEDPOL |
+	       REG3_PHYMDI |
+	       REG3_CLKINEN |
+	       REG3_PHYIP);
+
+	writel(REG4_PWRUPRSTSIG, priv->regs + ETH_REG4);
+	writel(val, priv->regs + ETH_REG3);
+	mdelay(10);
+
+	/* NOTE: The HW kept the phy id configurable at runtime.
+	 * The id below is arbitrary. It is the one used in the vendor code.
+	 * The only constraint is that it must match the one in
+	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
+	 */
+	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	       priv->regs + ETH_REG2);
+
+	/* Enable the internal phy */
+	val |= REG3_PHYEN;
+	writel(val, priv->regs + ETH_REG3);
+	writel(0, priv->regs + ETH_REG4);
+
+	/* The phy needs a bit of time to power up */
+	mdelay(10);
+
+	return 0;
+}
+
+static int meson_gxl_enable_external_mdio(struct mdio_mux_meson_gxl_priv *priv)
+{
+	/* Reset the mdio bus mux to the external phy */
+	writel(0, priv->regs + ETH_REG3);
+
+	return 0;
+}
+
+static int mdio_mux_meson_gxl_select(struct udevice *mux, int cur, int sel)
+{
+	struct mdio_mux_meson_gxl_priv *priv = dev_get_priv(mux);
+
+	debug("%s: %x -> %x\n", __func__, (u32)cur, (u32)sel);
+
+	/* if last selection didn't change we're good to go */
+	if (cur == sel)
+		return 0;
+
+	switch (sel) {
+	case MESON_GXL_MDIO_EXTERNAL_ID:
+		return meson_gxl_enable_external_mdio(priv);
+	case MESON_GXL_MDIO_INTERNAL_ID:
+		return meson_gxl_enable_internal_mdio(priv);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct mdio_mux_ops mdio_mux_meson_gxl_ops = {
+	.select = mdio_mux_meson_gxl_select,
+};
+
+static int mdio_mux_meson_gxl_probe(struct udevice *dev)
+{
+	struct mdio_mux_meson_gxl_priv *priv = dev_get_priv(dev);
+
+	priv->regs = dev_read_addr(dev);
+
+	return 0;
+}
+
+static const struct udevice_id mdio_mux_meson_gxl_ids[] = {
+	{ .compatible = "amlogic,gxl-mdio-mux" },
+	{ }
+};
+
+U_BOOT_DRIVER(mdio_mux_meson_gxl) = {
+	.name		= "mdio_mux_meson_gxl",
+	.id		= UCLASS_MDIO_MUX,
+	.of_match	= mdio_mux_meson_gxl_ids,
+	.probe		= mdio_mux_meson_gxl_probe,
+	.ops		= &mdio_mux_meson_gxl_ops,
+	.priv_auto	= sizeof(struct mdio_mux_meson_gxl_priv),
+};

-- 
2.34.1


