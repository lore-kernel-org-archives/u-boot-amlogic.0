Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF27FA1FC1
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:39:33 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85764.1776872372581534364
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=RIe4onnS;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.189, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNPhg45MzTi1ZtvS4xQLym0Inbjtyod1lrkB+jfBc+o=;
	b=RIe4onnSwGu0oLZ/y1paZq1v7phdmB257GZv5l65yd+WaQHGf+zDi2yGhfw6mGxOjJHmfX
	fUbeGTmNZnkjQ+v+E4mBH8xsRaHyjtf7eKXvmSks9AXm2pldIc2AAaH7TcrKkldC34rj+n
	Ik9SItiYsNzx6HRXfF/Px2MJ/a6rU8myCDepWL8olE3OMimVjlYWagDikQVPHpMId6Idva
	fPjkIm39+K1EDvV3Fhgx0K/iqlbvwZpD/pGjuIpGoQsW93E46hgaW3zeHEAkq5d3CTTA7v
	e7CYmRlPL8qWBX73eqGd/At2ENiqyUu1envI1hL+gBMEpgQ9SlILW1UQ9CTSMw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:07 +0000
Subject: [PATCH v2 4/4] configs: libretech-cc_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-4-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=LMGF3fO18XQ6NCapMDLKdOuMoeXUFmiMa4p/kVkgmOs=;
 b=kA0DAAoBhK/L0NeJmgMByyZiAGno66yjGbsKF9LuqvrpHIsZJbnQiv+qipR0oprp5ioVoZ4Ay
 okCMwQAAQoAHRYhBAMBvDf7VVys/XmL7oSvy9DXiZoDBQJp6OusAAoJEISvy9DXiZoDvG0P/0xg
 0+LLH5lAyseaEww8sJ7RaylZPOAiQyidflFcYMM5Pk09eMhtpHlKccLOZ5RmBmwlchqYvEbdZKo
 GVN0I12myiRtppuaP7PoXQytW9eB78EqTgNCEXtasx/nddpA8Bq0cU7V1Jl8Gbe64fmotSeY2Yp
 Kh575OEvA3q/CZf7dnNYF/9hfBfpnb6C60uY2sdelko6ls/HMCfMnscaiaIafKtcEUJ5hiWnYYg
 kpc13nZNncb2RU6wCWk4m64R8rGAXP3LozVck3RacLgtwfefdwGoupNz+Hk5eY5IZ89Hi6rf2Uo
 cYN+mbEQj1pPe8FPTEuHKaKk56wxBNs1IkmURX2LPJwewBm5h92thqmN/ka84EZ54cxryX6gnNu
 b8J1p59oYbmB40N/k5beFBEqlIzM1LjjmuuCGRNM3MSQmSVGu9JCJHHqJUYu/ueBeWlorSNmxvW
 0U7m/dClenLe0AKPtuQ322wd9cVN9WiNCSpwVQS+TDVND+CIzkMLx5mcnHdr4odasQw1GLpI03l
 Hlbibs2qayuz04qmNxhTwAtKWpzGtDo3jhvQw/GTxtvXzD0iYMKzL9LXPSHmb3+1BTE+VficWl4
 oOeO0qBffXUivqHqLBWbw7JK23hT+zJolKqLfEw2xfY2MmhI2IMcaVpsc/gTST6XnJT00VsF6lu
 Jp5wZ
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:39:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2971

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


