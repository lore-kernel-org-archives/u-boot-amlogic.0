Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261C10F997F
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:38 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.116011.1775680228370433290
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Apr 2026 13:30:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=c/FAhEEv;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.185, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1775680226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNPhg45MzTi1ZtvS4xQLym0Inbjtyod1lrkB+jfBc+o=;
	b=c/FAhEEvKnw++eLyHjWPMkNbg93YGA04cMB7Qf36fzaVnJhoiRyypT8ZIynYZsdNliubU6
	QUqzo+R+sSUnuyILaoi9PxCK+DNFBkyXcTUMxJUY4BFbvHjUFItf4sHSMN0UJEzjnKNnB/
	uFznWLmoXIVZ9YRo8lWcHIx2pvgrWuOrSaua2N9BbM7Se/YY5FDEWkPGZI9KmMdxy5sMk0
	gS37i2nhMnx8bNAl6634TXDTkYbJ6hK0OkELB/0mM+hW+KY3dRblsyApAziGuOlm/p64je
	nPhJ2u2N+1oKJAljI7H4lumBXTbNqKB2X1Wusm0tWLjA6Kvh9zJxAlvxm1/dKQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:15 +0000
Subject: [PATCH 4/4] configs: libretech-cc_defconfig: enable EFI Capsule on
 Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-4-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=LMGF3fO18XQ6NCapMDLKdOuMoeXUFmiMa4p/kVkgmOs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbeAkal0nYzAmxj+fy2G2Hoe9U2Yg8iQbIG
 FfUVRQoqAWJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 A00ZD/9y6P52CCZyNpFtE507QevwwhQapaEMU5d53bgTlEFB9yk2xgbKOZI5xrXC+2MrXMeNyEN
 qkzjwBFBZJUGgyAiiGQ9JJjos/tvLkfcXYfqTNnL3SiYSbB5heNpzzJbCV+qTX/LUkzLxJ1WfH5
 1G/wmDDwbuTwWLf1qNWz03RCWZgn4E8xNDJrYYopYhqGOME3ZyWstJWVgvKSEUzlJ4h7y7ueaiW
 wZiZW6mei4WcJ0ebgvL9A72SqcJEef9K3hCXX8k1t2SWvScKVF2FSPUcc5bvt8aB6Sl4/yjnjOn
 JKyu7qj6L71kKM0C0Q1kQebThHvlCOpNrVP2LyU9IDlOuzfR3uqDKAZmcW/dLnYmiaijsj1vL1C
 r9DToZubR40bkQMmf6Y2d6GiPVTFtu952IIkVT7sh5jOkDuL9aeKxEHu/Qs8YSYUA5rs6y/oUNN
 j3z9czzVLjNq5OEtJdaK6mWGH+G1J274ESeatHJuDLSRY87w6RViV+woXHyfTKH5QR+CcRIF5ey
 OmcC73YZ1HgidlSfCVn9rKCiCeM9sTu4XJxXx7MieC6J6TveDpUSZF8cf1PGlrG/e4MA9Lwl1io
 c9Oz09lmpkOKc71XgRQF+l4I07vd84nFksBI6FMoS4Yn85wClsAhLApJTLBjaREKd4xx7Rjw+r9
 UVkqXvTI6gA6SVg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Apr 2026 20:30:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2955

Everything is in place to allow this board to support EFI Capsule updates.
Enable everything needed to support Capsule updates, as well as Capsule
on Disk. All this allows updating U-Boot on eMMC directly from linux using
fwupd. Also enable DFU_MMC, which is a requirement for EFI Capsule flashing
to eMMC/SD to work.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-cc_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index d5878bdc431..622922e97ee 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -16,6 +16,9 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" libretech-cc"
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
@@ -38,6 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y

-- 
2.53.0


