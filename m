Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF9FA1FC5
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:43 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85776.1776872621297474384
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:43:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=BSaJDaz3;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.177, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0V3QlndohzzlYz1okw1AgiYSB64R/OZdcQrVzZNtjJs=;
	b=BSaJDaz30wZ17xbKMhVk2wk+EiPkCdd8k4f+HJG3pktiC+IzRwNt+LxbG85mUYMeXvYfu3
	Z1w6V6n87mfJ9xb36G+MKaoruEZYirqD2IAkan2ED+aURoyUR0WFiL9hulAxwt46OiBMOK
	BbWIIzlrmle9IXYDmPG4g391azfV1nbdlIjsppGeiOx3WL7Dwrv2czI0ZRhO5Yrj6Hpx6h
	R+pbaqUf6jDUap82c5E6MEog13vDq82g7T61lNwi+g8ShduwUEVhtRPq2jIeThMZTO0SUE
	ifVgEF9OEv/tBtzOg/jZKLBHOutK3340jPbePxvLRNEnBluW8xPMxAh26Ge87Q==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:24 +0000
Subject: [PATCH v3 2/4] arm: meson: enable SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-2-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=PTw8kghj7hEsw059H5GhzvPOKzRW6E4JD27MUyh/VdA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6Oyi6PuNLFRsto27zK5Nu4dJqpwmk8P1bftKY
 gyVstI+G92JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsogAKCRCEr8vQ14ma
 AxPTEACtjgOxsRieRmo+e/WokxrDp+ZI0txRZJY+l5jAKg4Wc28Zl4M/SVNHmC066iy/DHoMVOS
 7GQmfgCrpepYtswN/SghHVi4XA+4teompi2BUwuM2dNzR7nWd8lrNnYGIVjqs6YNJUnASH6I+S6
 7C+3e1Fktm63vFxNzbfr6qjtfSv7pdpnKf01qYxLiFMXnhnVLTfQeZkmwVjEsm9+JDu91lUXTWM
 qVvm2PMuUZCnj/gpXLpuEta0jdY4NvfWJzbGwc7714kPOltzFhdkXYE948pxJkMflMylomjuo8b
 Ii5w924WeDwuZUWd3VbfvpttGWYw0RjpDlF5BV0wJCR7WXvT8bvxJsdT8GKOclKOj1Ha+xTvn6A
 sJhuc46hk/sWJJvcL5P+yfqpn1x193bKKn8MJNjcMQYhp8NIavwVuLtvrTAAxh0Q4xP4gUH/Pbt
 A1En/djvAk85gqc9eaTg3cihtGU++daWAcpmXia3k3nn99QRLFIZmj1HIJfSbZJLkPCHkrZvkZ4
 tDkuRCSEdacEVO3dkrpc7YJfVS5ziu1Gj+Z9joa8pSuK5rlQY+1WUcvaJXgo8g9WmlrJrPZhcds
 E6grS4lMnngyFZeA9YWEqFGWsjpMOh+t9U4YunRSXvGFH95b3eQNwGXNWka/woqUOXXp8PlVJkv
 Iei9aFZBq1MvTiA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:43:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2975

Previously, Amlogic SoCs defined their own reset_cpu() implementation
that essentially just did what the sysreset PSCI driver already
supports. To reduce duplication (and allow for EFI Capsule on Disk
support), make use of it instead of a board-specific reset_cpu.

This does not affect SPL, as in that stage we do not actually have PSCI
(BL31 is not loaded yet at that point). Also, boards that don't select
PSCI support in their config will not have it enabled.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


