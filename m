Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306BDC73C66
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web10.13389.1750148228759533062
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:17:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=WKr8fK/I;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=g61eqPjF;
 spf=pass (domain: mailbox.org, ip: 80.241.56.171, mailfrom: marek.vasut+renesas@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bM08f3y02z9sj8;
	Tue, 17 Jun 2025 10:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tXwLfxZl7b5bpFdvtoVG2h6MNJIZ3sUK2eC8lIB3PCo=;
	b=WKr8fK/IUJPPzg/R5gxAkCRgPFMhAlsyXm7u6zOddZvSs/+gX461qDc2GUi2dSKNsGnd1q
	Dfn40RnZlUwd4q9sT63T1LVOhEJFy5kEPFBliQAdHYZ1XRoQ2BOKGK4TvJiexQpTK9q3pd
	pdX5uQnXHKtG87yeo+L1n3R7ZPtXqn8ldlyZOJhvCIQCl6xnD01AXgHcgf6XWJmdiir17b
	QQSYWOEPZ7YJjCVZe437m4k8LLDwepOaSrKTUuNeIdjpAJq3fqNZFNKtUI06gQ6MUFfOVN
	LFuA5l6f2RhIxWFN8+yAUB6ZmxsiSV9AAOUvkqtVAl3XNLn3h35hncZlfu6itA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tXwLfxZl7b5bpFdvtoVG2h6MNJIZ3sUK2eC8lIB3PCo=;
	b=g61eqPjFLQJ9dbvAF0YOD0VM+MV5mpkQFfGCO195f/kGnevciVvL+1rSiTcrc5nUbUs5VZ
	W3N04yBAX8UbqPd1khckrKpuzw3gAr3+6MovO4eqp1ixxP19Stq88NTVts2PPuDbz0x0x/
	3HAPGJNu6piJLo7UgR5IG1bGHXggnmTdYpiU6oT8CLCtDRiwPjFQsCMgk6Xg3oITPWxoqM
	UjqfRaBRYqVIioq8Q5UChG5JeDIPkd0yIzMd5Uy7Qa4az2uFOn/Xm/TVK0JFPimjZf3UFt
	3+wONkfrDgS1ZBU5P0DDOGuqNjeqnvHizy8EWFL3fFEUvEL0hU5WgF3zfGpiJg==
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
Subject: [PATCH 1/6] drivers: pci: pcie_dw_common: Add dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:27 +0200
Message-ID: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: jsqh458kah7znud1zek95ui56fbjitua
X-MBO-RS-ID: 190a0fa05b78b32e24d
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2717

Add dw_pcie_link_set_max_link_width() implementation ported from Linux ke=
rnel
as of commit 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW hand=
ling").
This is common code which is already duplicated in multiple drivers.

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
 drivers/pci/pcie_dw_common.c | 45 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 78961271a8e..c4cad019373 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -13,6 +13,7 @@
 #include <pci.h>
 #include <dm/device_compat.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include "pcie_dw_common.h"
=20
@@ -28,6 +29,50 @@ int pcie_dw_get_link_width(struct pcie_dw *pci)
 		PCIE_LINK_STATUS_WIDTH_MASK) >> PCIE_LINK_STATUS_WIDTH_OFF;
 }
=20
+void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes)
+{
+	u32 lnkcap, lwsc, plc;
+	u8 cap;
+
+	if (!num_lanes)
+		return;
+
+	/* Set the number of lanes */
+	plc =3D readl(pci->dbi_base + PCIE_PORT_LINK_CONTROL);
+	plc &=3D ~PORT_LINK_FAST_LINK_MODE;
+	plc &=3D ~PORT_LINK_MODE_MASK;
+
+	/* Set link width speed control register */
+	lwsc =3D readl(pci->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+	lwsc &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
+	lwsc |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
+	switch (num_lanes) {
+	case 1:
+		plc |=3D PORT_LINK_MODE_1_LANES;
+		break;
+	case 2:
+		plc |=3D PORT_LINK_MODE_2_LANES;
+		break;
+	case 4:
+		plc |=3D PORT_LINK_MODE_4_LANES;
+		break;
+	case 8:
+		plc |=3D PORT_LINK_MODE_8_LANES;
+		break;
+	default:
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
+		return;
+	}
+	writel(plc, pci->dbi_base + PCIE_PORT_LINK_CONTROL);
+	writel(lwsc, pci->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
+
+	cap =3D pcie_dw_find_capability(pci, PCI_CAP_ID_EXP);
+	lnkcap =3D readl(pci->dbi_base + cap + PCI_EXP_LNKCAP);
+	lnkcap &=3D ~PCI_EXP_LNKCAP_MLW;
+	lnkcap |=3D FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
+	writel(lnkcap, pci->dbi_base + cap + PCI_EXP_LNKCAP);
+}
+
 static void dw_pcie_writel_ob_unroll(struct pcie_dw *pci, u32 index, u32=
 reg,
 				     u32 val)
 {
diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
index 8cb99a12ea1..ccd423081eb 100644
--- a/drivers/pci/pcie_dw_common.h
+++ b/drivers/pci/pcie_dw_common.h
@@ -130,6 +130,8 @@ int pcie_dw_get_link_speed(struct pcie_dw *pci);
=20
 int pcie_dw_get_link_width(struct pcie_dw *pci);
=20
+void dw_pcie_link_set_max_link_width(struct pcie_dw *pci, u32 num_lanes)=
;
+
 int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index, int=
 type, u64 cpu_addr,
 				     u64 pci_addr, u32 size);
=20
--=20
2.47.2


