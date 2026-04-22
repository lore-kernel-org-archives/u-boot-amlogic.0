Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317AFA1FC7
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:43 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85866.1776872619821563643
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Kp4WK7c4;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7YPzW7ar84iuQsUv9oCtS64vTevJoRF13hjgsyAL9E=;
	b=Kp4WK7c4wPEb0AC6BmEajLrrl+w72SUdlkbERfYFSuD4DbLuAenCKu6qEiT4kcW857VrGa
	sQJSK8jRiBmu+ryRv9TLjjvLcyYRvuI4D4UUpdQ2NIPs65iHpuuKv1ScSBhY9HfL78P1Vr
	oR/Bd5xuZSXEw0T8tC4RjCojJD3ZhpmcmyCrhb5GIbV5oEldcWfoHKEWLfBTa50EOiAo9a
	f/6oSMQeklBTgf/1ddF6fzDPsbAG+dS7xrv5qf3krcWLUO5ktkmnPnm2o3ootXM5bH/X2c
	ArPpY3Kn04gWXu/xEAY+Fzij/aTEy/TI96yTYsCJ+gcIEqtEXSdtGYNdeIjYxg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:23 +0000
Subject: [PATCH v3 1/4] arm: mach-meson: provide reset_cpu only when
 SYSRESET is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=IoO1gOKnt0cbf2RWK6vS8f3st5C63IkFCn5XCxBr6JE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OyiD+/FeSVSupsuN9+ByzDbJBfvzZZ1s0FXQ
 SOyjPdkj9uJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsogAKCRCEr8vQ14ma
 AwoHD/448ZNhM7XwwsPT9attJ/Wq6HlxLhSfhia/mKMhr1S/PamlQCxx2kmIuIc/PXY7Nj4q432
 B0wHm9L4mDMU4cdDq27xOtKlRVuB0BFiOVlkONByTYSQc2gx/Vav0DcZl+2EKOWGd4cR6sS64u3
 IN6mwNGY8wa/0ywWavvJJpU2bTDDOJDnIbq/EnJR8HOEmfJtDYX2HCylFem2H5D8OCQtb5i93Ty
 eXyNZWssKH5HSnvv+JvUy2bEFWP0tSZkuZVa3DXwP9nWMcnnfx9sr2bkeD50UqiIyx9lo50KYkJ
 qATdShUy4f6/jTLTy7pfBuQzJ4qrYRYqdFPAiZfLpFOIPQsGTIgruyoSPdcArLwr63/JFq8/+f6
 PVuAfdKU+yVsAk4FxSyinzbwFAJuUq7mXwoXwS8hF4KoR2lobg1cL1jMa9FfVD+wCyB+n0euUaX
 cnCpb1PU43R+AUau8+FSG8cjiqLhnZMilR2MOue6s6MgbRuutA8cGM/+QsJxwrBEfdodJtnrPDO
 DKy30s+OI6dwpGsBTpBsDZzj9pENChAgtdXJS/0FfQjIn8KGuGa8BqKnrwz2d/YfqOO9xIUunaO
 miSt0vRFe0mKdJkhE5q2c4FWg14GzQDO+HXQMqo81ZXT25YP4iBhXM70dpQTru1YsNLw5ILriQI
 94nzUrmdXmZBTWA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:43:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2974

This is in preparation of enabling SYSRESET across all Amlogic boards by
default. SYSRESET brings its own reset_cpu implementation which will
conflict with the one defined in board-common.c.
SPL however will not have SYSRESET enabled (due to overhead in the final
image, as we have very little space to work with), and thus will still
need that reset_cpu to be defined. Furthermore, some boards do not enable
PSCI support in U-Boot, so they may still need this implementation.
Guard reset_cpu inside #ifdef to only compile it in when SYSRESET is not
enabled.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/board-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index a5afc2d75c0..c34b81e5e78 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -155,16 +155,14 @@ int board_late_init(void)
 	return meson_board_late_init();
 }
 
+#if defined(CONFIG_XPL) || !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
-#if CONFIG_SPL_BUILD
 	/*
 	 * We do not have BL31 running yet, so no PSCI.
 	 * Instead, let the watchdog reset the board.
 	 */
 	for (;;)
 		;
-#else
-	psci_system_reset();
-#endif
 }
+#endif

-- 
2.53.0


