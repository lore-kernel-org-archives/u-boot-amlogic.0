Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98847D30CDB
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:15:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.61335.1768317972209704600
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Jan 2026 07:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=Po0jQMQO;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+forbidden405.outlook.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 936EC6000A;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ABB8C116C6;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317381;
	bh=rY4/JV3DaI9fBaAujMH30v69WA47tqdcDAHu7tVKel8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Po0jQMQO6DPRkQudN2fxuMoTTxMgaUniYkH7caEUV58TYeN5qpATLls7P183wt9NY
	 NWB5dDDDjq/o9SucqjzoEORAAeq4WPfh8Mgtrjc98/HjV2jDYkPOi0V8mkPjElNdQt
	 zx2pcd+0kPBA4YSCBa0+IRcnqfb7P6h5RVDrglMtK0Oniq7HXcBfkR4tz+g7TF49c+
	 XTQXGAabyPnB0JsSxwkqi3QK78Jp4sVKWQvLPBfy/Rv1miGCvCvOeGm7PlpkGm9cPA
	 Uj/coTAYj+WaP277zFsZk61WMtVkRCoTu4gU6JdUAVsSlhJmA35uWScmNe5CXU3xpn
	 0Mt9UHRcB51Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3AD2F32B;
	Tue, 13 Jan 2026 15:16:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/2] net: dwmac_meson8b: Fix incorrect ETH0 register assignment
Date: Tue, 13 Jan 2026 23:16:14 +0800
Message-Id: <20260113-aml_eth-v1-0-3dd74db37c4f@outlook.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL5hZmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Nj3cTcnPjUkgzdNAPT1DTz5DRzAwMzJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAeZIjgF4AAAA=
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768317381; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rY4/JV3DaI9fBaAujMH30v69WA47tqdcDAHu7tVKel8=;
 b=ElkdPBF9JYECe41/gCUZ8cqRaN2eiEfTr+wH2wZXkhsZhsmUcaVXh6Lz5PUb1yLAuU9hczS3V
 gnlw3/81b3VC5ncOJ+MPIOXTRLF5Wo1XGXUfTlgVP0l8almpfh+DAr7
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2887

The currnet logic for setting ETH0 reg seems broken. It does not conform
to the datasheet and the Linux driver code.

Fix two bugs here:
1. replace setbits() with clrsetbits()
2. set tx radio to 2 rather than 4.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      net: dwmac_meson8b: replace setbits() with clrsetbits()
      net: dwmac_meson8b: Fix incorrect clock divider setting

 drivers/net/dwmac_meson8b.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)
---
base-commit: 711150fc6fe7a125cc1133841acc802570478007
change-id: 20260113-aml_eth-f05ef7cf7006

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>



