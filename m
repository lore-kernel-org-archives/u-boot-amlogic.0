Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D0F9EDF9
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:39:33 +0000 (UTC)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85668.1776872368979023357
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=rpKaJtJ2;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.177, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7YPzW7ar84iuQsUv9oCtS64vTevJoRF13hjgsyAL9E=;
	b=rpKaJtJ2RwTCaxR8s/YNt3NFlNKGKhi5lgHe1+UZJ091uUcVFXFkKJ36vBkN2XIR/HuSLs
	/Loxn5IDqL9zI2TrgAV92gVzX55iu4W1D0V+kL906mjRcXpqibkFH8LbqjC7mtxriXAPH8
	OpfoRhxX632N3uyux1sEUnUAKfIxNLAamFu1f96GEe/L4kw5TDDrN9v/sp/z8y3Kd5CrQ+
	YCcq+ZMG1qbDGABurqYVbPbvjvdvzdohURvQxGCZ2IdBZo2ARxhVbO333xh/CXEQUshBA7
	zmgY0jzNpT1HFpt4o1h6cj8jzb5gY8+VmbNr0boy+0cjdSw0QKKG5Vg0ruo6Bw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:04 +0000
Subject: [PATCH v2 1/4] arm: mach-meson: provide reset_cpu only when
 SYSRESET is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-1-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=IoO1gOKnt0cbf2RWK6vS8f3st5C63IkFCn5XCxBr6JE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OurM30dyG39f/ZDeIGGGBjFXuxGpZObzaIXB
 /BjzOEaCKGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejrqwAKCRCEr8vQ14ma
 AxKED/4rAbnk0qgBNPlLNeLi5/57N4/kU4nHk0iEAagOwidYekS0jJLgodX2OcAryYmvhjWMbXE
 NOytOT5BlTLM4q3V3qmumQYGj3/NebzXSLuilFR43c3tnHWtepRh881YkOQBNLYW5cQe9fkyXUD
 RduLc/sYhk7CvyRo1+P/9FNft+GHyb6F2bUbq4jRmXIv33umoCf1MSJx6kLnpcfvxB8BGjFwXzY
 aHQReFwrQm65gvgXyc7O4NzPcG1w7eB80nlvPShlrJHnzlC9fYsS7K7wyhMNa+Ap19KnC+Mlugo
 Fd98uMfUzGxv0XVQVm227diosKIGJ00L38BjYW0ctwe6VNSAI6aWTWvTMhddxcfnJ7vadmOik22
 kJuLorZRbpLbavhY7TteDHq/a9dLrOwDGf5vF7LAygPo9Z+PFNPz0xnVkGI1Bk9/CDJ6C2fo9Iv
 5w4mfOPDvP9NmDLcGoMMH+7Wsl0g8izXGamyqKMLYOGwGqzgatB4YFlYAjOY/pfeB6skuHVuJvl
 S6QEOCAZkRE63FQg8INwdshqzqreJyWXXVTAU/UuvH5u1uJugsDRbBcnPYW43slbgzO7yy3Q8e4
 wxMLahbQb28J0LF2M5JRHmmnZmOymXkJ1rTDcjVKnSfj8nid7Cq71golDip9Mc1lLb7bv2c8bp1
 8UIolNoxrx+sLeA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:39:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2968

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


