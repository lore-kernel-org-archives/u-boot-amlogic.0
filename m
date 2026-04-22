Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2196FA1FC2
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:39:33 +0000 (UTC)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85761.1776872370042399447
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Oy9qLHBS;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.170, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eorrzyy9BK13S5Pam9Bg5mFPoJsYn/bMPfbU4fT/ZzE=;
	b=Oy9qLHBSzVIz0geSD0naRXwH+yjaAYYa35n8l265apCquWnVdfwenmCsS/VRP/N0dDbxAa
	mrG+Q5G/I/89bWX8UJJ0OsSPhh6/7zFlvVcTgTuBUt/q3cs5FWEelV+7pIBf6AFizpme3Y
	mkzNnXpvWOvB0TZoODNPW829L4iy5OVNyPyke4e+U1lW7PgR25nzuYXvc6FM+aP3FyNPFs
	TAmiZXukfL5uMBaByrEB1oa7HEmEiQ0bzvEGlNObxklxS3EEZQGpKpCQp+swq10BZTCF3/
	9NQJEzKq3kttAb8s/175X5eS7uRnkGnLYGTEP0ySG9IPam9+AysBw/xVMwGe7w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:05 +0000
Subject: [PATCH v2 2/4] arm: meson: enable SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-2-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=997;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=g5YWUMtB5XwtBVRq1DeGDQ/bK7z/GRAg8nbP1JG+Un4=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6Our5yPLYYcfUF57F4f7M14ND/ldNCo0p/cHX
 J7Kc+N2QYCJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejrqwAKCRCEr8vQ14ma
 A6cSD/9wA7D0L3WdXvqZuz08FptrSGXz7LNNL9iwcI5ByHBWSOm0mnJGlCA30MSBaOajpKEaxDT
 hrsjNGDQdwjLpRHCYjx1mM6v/fKQHUv+8NzVQGguD+QqM2tdhwOdBSxATWJp/hT9iKQ9gC14f6U
 UoosYqQnQmRGX1P6ufuHM/TnqRC6cXUL4owHS1wGeQrW70abZGsFN65cdUodEGM1ApVz5ESx49C
 vyVZEs0R48Q81S0nEVLUF8nJ4i5Z0+5di/rXgSRPsToOB5dCcxH3k80nSVj6neLFCut6v+4ceMh
 H8FnICR+0KyPkOAvXRWstx9oaBpIhrqe5GnIhYqX4ksDlDVp21Z2xURz+CjwwhNVtTfEBtnHAyi
 kAHBHVArLBsu4bIppVO+7Zw1sjC/JGL1+bTc09pkOzC/vD8qCWxqAvFEQhJQLInhHWbpcdTeUHL
 NGBCQtv4oM6PpOLqXMSyK7G5INAqkRPUBhOfYjSBh7CmOSdPRMQaz8TUEGo5T7/chzVPETKsVrf
 drMPrvuQW/MkvTHqUNqOfEeER1QlSnqdVrUmRVmTvkBCOvHqkI6z4D5obeKrIYBY4J837f1XYIW
 yq7wv9by71ZTaHhq8b9tinOF65ZjLc7K0qtBj0aO9TGDBGOofDzCH+19KtDGIzeQah8PoBhfcyd
 awuG5rft0lLQyfA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:39:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2969

Previously, Amlogic SoCs defined their own reset_cpu() implementation
that essentially just did what the sysreset PSCI driver already
supports. To reduce duplication (and allow for EFI Capsule on Disk
support), make use of it instead of a board-specific reset_cpu.

This does not affect SPL, as in that stage we do not actually have PSCI
(BL31 is not loaded yet at that point). Also, boards that don't select
PSCI support in their config will not have it enabled.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index ef86129b535..c687ef822a2 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -12,6 +12,8 @@ config MESON64_COMMON
 	select MMC_PWRSEQ
 	select BOARD_LATE_INIT
 	select MESON_SM
+	imply SYSRESET
+	imply SYSRESET_PSCI
 	imply CMD_DM
 
 config MESON_GX

-- 
2.53.0


