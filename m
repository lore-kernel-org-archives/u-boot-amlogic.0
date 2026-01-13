Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A1D29DC5
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:15:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61692.1768317972261509384
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Jan 2026 07:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=BoSk4yiC;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+forbidden405.outlook.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A2ACF60017;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 592BAC19421;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317381;
	bh=tYZ5hj1B9DhuygI/o/PSZw/9AcGv0jZ0XhuOsUi0Voo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BoSk4yiCbYyTskK6GMLZYQFp6h6iyRYiSj42TCtLSzn9kSbixMj8IQpjKykRv+ZPT
	 6LlEOBY7oGeESWomXsaXUymfZQD6GT2uwoOK/6MkSZYTbcHG1TdR6hGcG5bitB8Fc8
	 CLBxRn9FcPSdzRWpXcAxvUngKf3oKnmfETlkLYfpt2NckraOnbqUT4QDmTzFwUBcT3
	 TaQK4BW7zbC/mFDm6eDxMgPp0BTZQcPRoqGH1RQ1/IkfDF1CcPh3JrmITuWlNYjuBq
	 o15RYuwONi0uVJVtGn0h2R2JMx0Gwf/vRYH7KFKHd+Qe91wFWX+x0cf5+2s/Yt3/kZ
	 TfFoyEjUraxsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49774D2F32A;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 13 Jan 2026 23:16:15 +0800
Subject: [PATCH RFC 1/2] net: dwmac_meson8b: replace setbits() with clrsetbits()
MIME-Version: 1.0
Message-Id: <20260113-aml_eth-v1-1-3dd74db37c4f@outlook.com>
References: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
In-Reply-To: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768317381; l=4115;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=gHhFLguZETRuvn1ptF4TGpP8+u1e6lfmwRCpP93Z7sU=;
 b=980RnZ7CyrCH2deXDg8iIIzoAuuA/6hPhbZE/nxprH8ZzUpfbMT3gs1Mgh8HGZyaUkDb/OfHo
 T+a+jwISnqcDTONbTjd/FOw49/E9W3c9Cd3fyOMwMLB60HKuSSmwlnn
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: forbidden405@outlook.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Jan 2026 10:15:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2884

From: Yang Xiwen <forbidden405@outlook.com>

setbits() only sets the specified bits and leave other bits untouched.
This is incorrect for ETH_REG_0_TX_PHASE and ETH_REG_0_TX_RATIO fields
assignment. They contain multiple bits and should be cleared before
setting new bits. Otherwize the old value is OR'ed with the new value.
(e.g. 0x2 | 0x4 becomes 0x6)

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/dwmac_meson8b.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbacec..b1a3946ce684 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -16,7 +16,9 @@
 #define ETH_REG_3		0x1c
 
 #define GX_ETH_REG_0_PHY_INTF		BIT(0)
+#define GX_ETH_REG_0_TX_PHASE_MASK	GENMASK(6, 5)
 #define GX_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
+#define GX_ETH_REG_0_TX_RATIO_MASK	GENMASK(9, 7)
 #define GX_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
 #define GX_ETH_REG_0_PHY_CLK_EN	BIT(10)
 #define GX_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
@@ -24,7 +26,9 @@
 
 #define AXG_ETH_REG_0_PHY_INTF_RGMII	BIT(0)
 #define AXG_ETH_REG_0_PHY_INTF_RMII	BIT(2)
+#define AXG_ETH_REG_0_TX_PHASE_MASK	GENMASK(6, 5)
 #define AXG_ETH_REG_0_TX_PHASE(x)	(((x) & 3) << 5)
+#define AXG_ETH_REG_0_TX_RATIO_MASK	GENMASK(9, 7)
 #define AXG_ETH_REG_0_TX_RATIO(x)	(((x) & 7) << 7)
 #define AXG_ETH_REG_0_PHY_CLK_EN	BIT(10)
 #define AXG_ETH_REG_0_INVERT_RMII_CLK	BIT(11)
@@ -59,20 +63,24 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		/* Set RGMII mode */
-		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
-						     AXG_ETH_REG_0_TX_PHASE(1) |
-						     AXG_ETH_REG_0_TX_RATIO(4) |
-						     AXG_ETH_REG_0_PHY_CLK_EN |
-						     AXG_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				AXG_ETH_REG_0_TX_PHASE_MASK | AXG_ETH_REG_0_TX_RATIO_MASK,
+				AXG_ETH_REG_0_PHY_INTF_RGMII |
+				AXG_ETH_REG_0_TX_PHASE(1) |
+				AXG_ETH_REG_0_TX_RATIO(4) |
+				AXG_ETH_REG_0_PHY_CLK_EN |
+				AXG_ETH_REG_0_CLK_EN);
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
-		setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
-						     AXG_ETH_REG_0_TX_RATIO(4) |
-						     AXG_ETH_REG_0_PHY_CLK_EN |
-						     AXG_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				AXG_ETH_REG_0_TX_PHASE_MASK | AXG_ETH_REG_0_TX_RATIO_MASK,
+				AXG_ETH_REG_0_PHY_INTF_RGMII |
+				AXG_ETH_REG_0_TX_RATIO(4) |
+				AXG_ETH_REG_0_PHY_CLK_EN |
+				AXG_ETH_REG_0_CLK_EN);
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
@@ -97,21 +105,25 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		/* Set RGMII mode */
-		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
-						     GX_ETH_REG_0_TX_PHASE(1) |
-						     GX_ETH_REG_0_TX_RATIO(4) |
-						     GX_ETH_REG_0_PHY_CLK_EN |
-						     GX_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				GX_ETH_REG_0_TX_PHASE_MASK | GX_ETH_REG_0_TX_RATIO_MASK,
+				GX_ETH_REG_0_PHY_INTF |
+				GX_ETH_REG_0_TX_PHASE(1) |
+				GX_ETH_REG_0_TX_RATIO(4) |
+				GX_ETH_REG_0_PHY_CLK_EN |
+				GX_ETH_REG_0_CLK_EN);
 
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
-		setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
-						     GX_ETH_REG_0_TX_RATIO(4) |
-						     GX_ETH_REG_0_PHY_CLK_EN |
-						     GX_ETH_REG_0_CLK_EN);
+		clrsetbits_le32(plat->regs + ETH_REG_0,
+				GX_ETH_REG_0_TX_PHASE_MASK | GX_ETH_REG_0_TX_RATIO_MASK,
+				GX_ETH_REG_0_PHY_INTF |
+				GX_ETH_REG_0_TX_RATIO(4) |
+				GX_ETH_REG_0_PHY_CLK_EN |
+				GX_ETH_REG_0_CLK_EN);
 
 		break;
 

-- 
2.43.0



