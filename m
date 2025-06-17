Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CFEC77B73
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.13392.1750148235721259582
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=g37JJJKd;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=mAbSyfjQ;
 spf=pass (domain: mailbox.org, ip: 80.241.56.151, mailfrom: marek.vasut+renesas@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bM08m5tZtz9swL;
	Tue, 17 Jun 2025 10:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwoPJRPRTqqVrPkam43GUzS8fdj+4R9STOqtuVLiWcs=;
	b=g37JJJKdZf4Fl5oLJ1kDRz/gaRQmFKVCGe8q38qj6iS0PH5NmzxtCrPtaDYZuQI3XXmcpF
	+szL6Lr3o0FhNfEzAaZ/KFe7VAuLedj0e5hH1TyB/9A5z0kkCtAcTfhP7m+LWQfVJVCvAN
	v/p7tTOIgaeeoo/XAOvL/V5E1pycWftwo6NL3C85upCq5EwunUkNZECtsSWqRTyton3NTL
	l25dzIsHzaNXXyPo/Q36yGzNBC/X4QYybls0qOHdJude7ThnGdotqwXghZH8Z00aTfPEoX
	xzAMgJaTVcWHKmhbdYWY4R9C+6+6zQR2sskEGcm5Xdhc959fx88FBI/+qzjBPA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwoPJRPRTqqVrPkam43GUzS8fdj+4R9STOqtuVLiWcs=;
	b=mAbSyfjQL/9GxHBM8fg5PW0MMbVne4dEcDN7gZ7z8PyfqF4oYrqMpqTrNstubJihWaxg0w
	UdaQEaAaNRwg7SRvw5cMPIQKs8FjS5iDW/zkIKP6lWptKFTGleJcfNztVISoKvNWN+x4Qk
	kTNEXcKQ877mMjeKbxfJHET/hoM6vydFgDqql233xz0V/F0xrepLxOaZ32vz34QxjZ0P0T
	B/TMzpHxyjHx4KZqoAKiGBRfZ4MkFlZ8eHqQ9uDErAouEyzjSzmoCD/Q50PtuAm6vPGcoC
	toENht/FRXKjDiLENdkctZoDJG8vhImPGkt4qcKdce+U3j9+tnUyQvY63+EbrQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Crispin <john@phrozen.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Simon Glass <sjg@chromium.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io
Subject: [PATCH 3/6] pci: pcie_dw_qcom: Use dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:29 +0200
Message-ID: <20250617081641.8385-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: e3wt73y1au67my1jddic3rus1myg5kss
X-MBO-RS-ID: 380f6469c229cd87810
X-Rspamd-Queue-Id: 4bM08m5tZtz9swL
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2713

Use dw_pcie_link_set_max_link_width() instead of local implementation
of the same functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: John Crispin <john@phrozen.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/pci/pcie_dw_qcom.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 39b4cd4efe2..978754e8472 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -213,17 +213,6 @@ static void qcom_pcie_clear_hpc(struct qcom_pcie *pr=
iv)
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
=20
-static void qcom_pcie_set_lanes(struct qcom_pcie *priv, unsigned int lan=
es)
-{
-	u8 offset =3D pcie_dw_find_capability(&priv->dw, PCI_CAP_ID_EXP);
-	u32 val;
-
-	val =3D readl(priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
-	val &=3D ~PCI_EXP_LNKCAP_MLW;
-	val |=3D FIELD_PREP(PCI_EXP_LNKCAP_MLW, lanes);
-	writel(val, priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
-}
-
 static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *priv)
 {
 	/* iommu map structure */
@@ -299,15 +288,9 @@ static void qcom_pcie_configure(struct qcom_pcie *pr=
iv)
 	val &=3D ~PORT_LINK_FAST_LINK_MODE;
 	val |=3D PORT_LINK_DLL_LINK_EN;
 	val &=3D ~PORT_LINK_MODE_MASK;
-	val |=3D PORT_LINK_MODE_2_LANES;
 	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
=20
-	val =3D readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
-	val |=3D PORT_LOGIC_LINK_WIDTH_2_LANES;
-	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-
-	qcom_pcie_set_lanes(priv, 2);
+	dw_pcie_link_set_max_link_width(&priv->dw, 2);
=20
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
--=20
2.47.2


