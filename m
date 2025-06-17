Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13589C71157
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.web10.13393.1750148237756763218
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=HEw4Dr/L;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=uL13hceg;
 spf=pass (domain: mailbox.org, ip: 80.241.56.161, mailfrom: marek.vasut+renesas@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bM08q66yvz9t8H;
	Tue, 17 Jun 2025 10:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xE+dx8Y4QXyRL5+o6FLEKrTvZCHx6HoZp9XoNaOs4Go=;
	b=HEw4Dr/Lhwis8NU1yr2UGTA4E1y5H6VhkHh/abTbPrCSOKqXMfI4+GC8pNxu2gq/kqqKM5
	dPUJ5pXQUk/Q/A03QeMC7RRZXxovGRnqmQr1hQIxPga8PKTHEv+nveIvVFn1VHM/yMWjx5
	YDPpNTJZVro+znmdIZwB4CF1oMfaje6hRswx+0GWRDUrRi3Wt109aaWjLOYonvxR3nzKdm
	CvlNgjXMrDLibL1aXZ1nGCtbcq197WuxKcIvRhOjP/+ZPJk3rVbZqYemJaFJAMjCJIeDbX
	eqCoJVSdoH/wm2ULXBHTG/b+GVq3ah4siQFsmiLPBjuFBGf41rwTeXRqKtEBnw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xE+dx8Y4QXyRL5+o6FLEKrTvZCHx6HoZp9XoNaOs4Go=;
	b=uL13hcegUpFu7NralYEmQIv5tj8ig+gYKXo+1YSu9kNmGgQddQsHupLJLnjuKhTVXvyTDN
	b81Alq8+pu/tJXzZ2HUhLKri1/jdb820jkPEIoVxD3bjA5zPIa5Q/7mWu6r3q0+SL5n6pK
	1Y4RClcMFoGO4gtnH3P9QHEp7ppEA5DFxnOmA/Zgf/6tU6PmDaPBS4l1xSGlVQwLue2qFy
	Ptwrg89G7Gqgqz4/1A6PAYqihKzF9mSxWHmGLepHFoGvkVki3UQoK/+sJKjSnGhM8K/3Ag
	oJhI12PHccF+AtRVBjiE40i9TvhypDeupF3Y+PEVSM8o94GdQY4MptcSUKoR2Q==
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
Subject: [PATCH 4/6] pci: pcie_dw_rockchip: Use dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:30 +0200
Message-ID: <20250617081641.8385-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: m3gw3kz1kotzfcuw7t8o68cuioweickj
X-MBO-RS-ID: 218f44eb7c00e8c089a
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2714

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
 drivers/pci/pcie_dw_rockchip.c | 39 +---------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchi=
p.c
index ac7faa4cc19..208aa30463a 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -158,8 +158,6 @@ static inline void rk_pcie_writel_apb(struct rk_pcie =
*rk_pcie, u32 reg,
  */
 static void rk_pcie_configure(struct rk_pcie *pci)
 {
-	u32 val;
-
 	dw_pcie_dbi_write_enable(&pci->dw, true);
=20
 	/* Disable BAR 0 and BAR 1 */
@@ -175,43 +173,8 @@ static void rk_pcie_configure(struct rk_pcie *pci)
 			TARGET_LINK_SPEED_MASK, pci->gen);
=20
 	/* Set the number of lanes */
-	val =3D readl(pci->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
-	val &=3D ~PORT_LINK_FAST_LINK_MODE;
-	val |=3D PORT_LINK_DLL_LINK_EN;
-	val &=3D ~PORT_LINK_MODE_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |=3D PORT_LINK_MODE_1_LANES;
-		break;
-	case 2:
-		val |=3D PORT_LINK_MODE_2_LANES;
-		break;
-	case 4:
-		val |=3D PORT_LINK_MODE_4_LANES;
-		break;
-	default:
-		dev_err(pci->dw.dev, "num-lanes %u: invalid value\n", pci->num_lanes);
-		goto out;
-	}
-	writel(val, pci->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
-
-	/* Set link width speed control register */
-	val =3D readl(pci->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pci->num_lanes) {
-	case 1:
-		val |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
-		break;
-	case 2:
-		val |=3D PORT_LOGIC_LINK_WIDTH_2_LANES;
-		break;
-	case 4:
-		val |=3D PORT_LOGIC_LINK_WIDTH_4_LANES;
-		break;
-	}
-	writel(val, pci->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
=20
-out:
 	dw_pcie_dbi_write_enable(&pci->dw, false);
 }
=20
--=20
2.47.2


