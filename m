Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B39FC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web10.13399.1750148244165203816
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=TDhArHd9;
 dkim=fail reason="dkim: body hash did not verify" header.i=@mailbox.org header.s=mail20150812 header.b=xGY1TUYx;
 spf=pass (domain: mailbox.org, ip: 80.241.56.171, mailfrom: marek.vasut+renesas@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bM08y4Sjyz9tVJ;
	Tue, 17 Jun 2025 10:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd5lZ/5VgUehwyBdhYvMTdDBDC1Ty5xhG3GE+ksee+U=;
	b=TDhArHd9hDaiFBpcjnw2PImdvcDG7GI6J4vVqNAtSN1V4Y5bmReujS0kR1LXsmVCA4i+j6
	l1+IrIFbgsr2Gbxx9dPgZzSchw284AcSmxfbRL6qGYAPinIB6rD6YCLdHlnkd1B6MFj/v0
	zsYu11BYF44sH2conIivrBu9GIJtiyTUCfzMFpHONzNIyCZe5Hst/q6AtgoEmcJwiSEohJ
	XuMneTvzmaSEObvexrweLkby5NDpnBfihe5P5A+/fmEzXgaxs8E7IlUPUlCW5qDWbaAfL6
	9S+JtA+kY8phyIPZWxuVPmx/ETXWI6cLsdPly6/+3cTnW/ITUsMR0nsRp+SbVg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750148240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd5lZ/5VgUehwyBdhYvMTdDBDC1Ty5xhG3GE+ksee+U=;
	b=xGY1TUYxlZCsntgt+cO49Z14PCwluf+ZI4pI6q/s6D+M2hWIDxnub7BxCVtyJCKcIKFle5
	nuOYVijPZnxu14+ssMFlz1DBA1RBYIlcK7/5GOPZVYnHCUn7kDWH1OelkWvZS3mX5Z7QFf
	BMecj1SSJ9O8R7mtv4tqEtdq42s2hZUBD8LNHCGiBb5RaA2+SdgN6gAlRpf0KqEMQe2LDJ
	vMPIbxyb2BMcECSLDsQCxVwB87CGTY+U4pWFnbVo/2BpOxsvi02tHjAttJ7RuCBUZRv1aL
	7e4tGHx36ZlV9EGk5cfPm77u/J5v6Fk6v+FPcDmmmgT4Z6fEtwFgzrmJsAyXdA==
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
Subject: [PATCH 6/6] arm64: dts: renesas: r8a779g3: Enable PCIe/NVMe on Retronix R-Car V4H Sparrow Hawk board
Date: Tue, 17 Jun 2025 10:16:32 +0200
Message-ID: <20250617081641.8385-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: jsgodad4kfnn341qoopcxx6qhfzu33mr
X-MBO-RS-ID: 63bc324e6a0e2716d0a
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2715

Enable support for R-Car Gen4 PCIe controller and NVMe storage
on Retronix R-Car V4H Sparrow Hawk board .

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
 configs/r8a779g3_sparrowhawk_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sp=
arrowhawk_defconfig
index 7202828cd66..9aa8dc83317 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -24,7 +24,12 @@ CONFIG_CMD_REMOTEPROC=3Dy
 CONFIG_GPIO_HOG=3Dy
 CONFIG_REMOTEPROC_RENESAS_APMU=3Dy
 CONFIG_BITBANGMII=3Dy
+CONFIG_CMD_PCI=3Dy
 CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_NVME_PCI=3Dy
+CONFIG_PCI=3Dy
+CONFIG_PCI_RCAR_GEN4=3Dy
+CONFIG_PCI_REGION_MULTI_ENTRY=3Dy
 CONFIG_PHY_MICREL=3Dy
 CONFIG_PHY_MICREL_KSZ90X1=3Dy
 CONFIG_RENESAS_RAVB=3Dy
--=20
2.47.2


