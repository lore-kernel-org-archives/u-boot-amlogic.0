Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E945C7EE24
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web10.13390.1750148231461961933
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:17:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=X5tuOysb;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=QoamdNLo;
 spf=pass (domain: mailbox.org, ip: 80.241.56.172, mailfrom: marek.vasut+renesas@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bM08j3dQmz9smB;
	Tue, 17 Jun 2025 10:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSMO/BLjDEs0jGnvchY+T89tfQOiTxtFct0VpnnHWCE=;
	b=X5tuOysbd0WuA/z3kdLOG/u932x0ASLDicrSBqi/YFxnrAUYCvIONZTjYXI9m7YmKLLQWW
	CzZtIus+zGfM6wbOdspUhMVSGtCCtyGR8K5MVWkcRTGEDwcSKOBR11vra+Z79VuzqW7X3r
	Oan0dbt2G9mN70zfJ5uf3pI+ASY3n0sbuHCZxT/P+Eyx/mTuxdpk78ZVbjiRi6lHIpQNfO
	VGLlW3wLOjGVKtJja8QHPGGIqGbm3a21k4KMzy0K20NRBdh8WbB9qnMLy/RVV5kHi93ltB
	dIIQ1zLyPg+HrWpYKpXWZCpMDeTtJZ61Gr81w+RzG6G3djlzzhUi2LiftrfAjA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSMO/BLjDEs0jGnvchY+T89tfQOiTxtFct0VpnnHWCE=;
	b=QoamdNLon2aqYSUnkl219kukEOEJ66llL4swfuL5pxFjEfVDWskC6tsYTF2sBdwdnUsB4a
	De75O8B2K3/UwgmvfY0v9E/X68HH5/+vS8k1g2rvYm/FNAajPw+kuFpSYM3OhRx8ThIVZ5
	rNnRc12FrU7w/X8nQlAQBAqMSNrPvha+KMTAGx72xs3tLV2yfgGqcPfZRe8u6SCiMoeosW
	vlHKAQRB1wmKMA0VdMb5asdCGbjTe/gyWUhXOn82GzlJ7qPVRt5X9AdxCPBGRA4idn03SP
	4aXFZUsUVwvjb5rQEkdNQSREqMRulowdAqDFOuV1lNDhk1Kf4JwzhGvXy26aSw==
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
Subject: [PATCH 2/6] pci: pcie_dw_meson: Use dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:28 +0200
Message-ID: <20250617081641.8385-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: kd5asew6ynbi93557i5ngsbeswmh4dta
X-MBO-RS-ID: eba0aa1e4e0fe73ba2f
X-Rspamd-Queue-Id: 4bM08j3dQmz9smB
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2720

Use dw_pcie_link_set_max_link_width() instead of local implementation
of the same functionality. This does change the behavior slightly, as
the dw_pcie_link_set_max_link_width() implementation also programs the
LNKCAP register MLW, this should however be correct and is now aligned
with Linux kernel behavior.

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
 drivers/pci/pcie_dw_meson.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
index bb78e7874b1..483b07ce078 100644
--- a/drivers/pci/pcie_dw_meson.c
+++ b/drivers/pci/pcie_dw_meson.c
@@ -115,13 +115,9 @@ static void meson_pcie_configure(struct meson_pcie *=
priv)
 	val &=3D ~PORT_LINK_FAST_LINK_MODE;
 	val |=3D PORT_LINK_DLL_LINK_EN;
 	val &=3D ~PORT_LINK_MODE_MASK;
-	val |=3D PORT_LINK_MODE_1_LANES;
 	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
=20
-	val =3D readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
-	val |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
-	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_link_set_max_link_width(&priv->dw, 1);
=20
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
--=20
2.47.2


