Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD78A10F997E
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:28 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.116009.1775680226255189440
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Apr 2026 13:30:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=cGUK6IZl;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.186, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1775680224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSR7ycAPH/8ip9z+10dIFTdBYOwKZhw6MR+BtiNFG0c=;
	b=cGUK6IZl+XXlbUP3VAc2ZbkUu3Yn5165z0/HQWnZ5op2F9NzkrwvisDZH/POybBNWRc49u
	o41lc6A3dfTvSou4cAnB8BFiSGvEJwqsOZwdSqpxTiVjCJHxG5sXypMenogAyGGgJTwQf0
	P5caY4tEuIUsx51xIseAiKUSGm97xPoe1xy6wpytx6VvAfRZVX4IBdBgfChErCTbVeuBYq
	MccCOAHDAMEdxwazGzWS5sNtbq7Bry4Q1IoRF/dy1Q1W4+x4pXNsFdSWg27TmeclclI0Qk
	yVtRa+C7t9bGdIhES79Q5T3vpQ1EVMHxuYD4ezSbMWMWuS6L2NWGh9Ye3Xg0FA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:13 +0000
Subject: [PATCH 2/4] arm: meson: enable SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-2-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=Gxp3GAIXrBnp462RNs+PPcQQYjHfLyf+ZcX3PQ+wncs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbpbnC3HsysF78UJMhK1KOUgSvrsyY/RBtx
 RlaoZCzHGGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 AzN0D/9JmilcrdlCGTKeOv9a48R9O0eOAjvd/YBmwyxwjBOlxcHoUbyyI+MQKO8N07ziDzb9Xgs
 1DjFPoIegUrjMADrltIQf0pUNfCCmpxp5vmL20hiAc6JDZ0TvTkgoMTYlukblQcWFtCykV/RHv+
 iyTg7qDDinipAvmmo5MEhzo4YjtgpUTlbTR2G/UW5H44Tiq+whdHz1ZOFkbEcp1A7duQfm9iy6l
 AhXlMmpMpd4tVBXmlotmo+Kg0q9Kvul6yCdoyqew/VDGPblAihYtARqWkkCTlqqATrTwU8ITHtL
 biuoXBgQ8oKB+4Cn7TcxBS/RX9P5ow9EfY8/y4Ucyrvk7YkpzKBx5ja8bQBYvHPuJAnHxcmhlPr
 DmlS3o89el8tXzjh+cLzBkSGie8ZhEZzgj0hINeJSGmxrBDgp9QzCbrKsnq9HBaqqzPrwMzmrKf
 fito/1eSKc9OykEcDb0NvptNMEdK3P0Z3cKEM5f5VcusCAWYHIqk1dICjXuN03ywZ1MLmTJbOhH
 Ib1L6X6qSQn9byWkgWvp6q0MMdtz0+iGqFOIJaRrERYhn4pzPhVpv5+h8e/mI+KkbBtPkEz9k9M
 WAqNIK6eFbJNKra2Ae92Y0Tt/HXYvNmcQCYBZqPyWnJATmyMdr4IEBKGrb42oAqF8VEPrIETqXV
 1ir9/CfvEicb4rg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Apr 2026 20:30:28 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2954

Previously, Amlogic SoCs defined their own reset_cpu() implementation
that essentially just did what the sysreset PSCI driver already
supports. To reduce duplication (and allow for EFI Capsule on Disk
support), make use of it instead of a board-specific reset_cpu.

This does not affect SPL, as in that stage we do not actually have PSCI
(BL31 is not loaded yet at that point).

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index ef86129b535..a615d871095 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -7,6 +7,8 @@ config MESON64_COMMON
 	select DM
 	select DM_SERIAL
 	select SYSCON
+	select SYSRESET
+	select SYSRESET_PSCI
 	select REGMAP
 	select PWRSEQ
 	select MMC_PWRSEQ

-- 
2.53.0


