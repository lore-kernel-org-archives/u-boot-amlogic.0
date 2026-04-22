Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0792FA1FCC
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:43 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85868.1776872622072461928
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=ah/LkfvW;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.184, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfcF8go68PRtOC+4ci5teOFRZ8Bsm/SltKbjrKX6o8g=;
	b=ah/LkfvW2CAG1xtKvGikwLv+noI3rUM7ZiVr1RbvLBiIqwb5ERxTgUAyVOAJwISau+eGV8
	TH/I8mUgLYhz/igCRw03A4HVPLGDYM+eujPvG2mca9pTVE5wqEOE+jGKFY491dUYTbRxiC
	+8oB30ZTKdc5LA/0GWbiSdtsp7wmU1vGfe94BMKNFDM3JPHURlvr6/hLdNa9fe0PeHLm33
	2Eviu3dJrH4YmRGFLstJY20K7lAr/IysOrKnw8MtuM6AndKUgnZeYMM2j4OdEm5MJAXRM6
	8p1llG8xGENzWgi2yKdam+Fd7zI297KUyRbvFtPeBQF+NFHDU8NkpQbuPLUqGw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:25 +0000
Subject: [PATCH v3 3/4] configs: libretech-ac_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-3-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=828;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=bBnzaFTiKpP3JoUbits1MCXh6AWRwr3MZCW9LgEPemY=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OyjmvAnzJMplJXt0JgK4yMSw1jg9xLcy6DK4
 NaHhhEVS+mJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsowAKCRCEr8vQ14ma
 A9x+EACV8pTGJcbt1mSEeTbhosuqUzEw/gjouvBztol/bEaXcyiIZ/idtEpQChqMqInOCUY1rwU
 rSZplSYcMiPNCWdYIUGxd/M3pcDymKv17AZyz98RQ8UC6dtYaLdO4DZYFzhduOcZiIYywA0kZLG
 vlO5MKBeXHGZHfTreF+zBkgcC6KS8xVFd1pdw8a+5ozaJVAQ3SpRTDopdyA1hvZVZ+w/citi487
 Ul7ACBZHd84nPlVsnQvos9kXi8FaThYG7eD012Vxnu1W4fJd4XNwzpZPVXb82RV4VZ0aqGw+uHR
 rcM6AUx96+0o5uOOz/oJPdCN46c4yJfFOALU9IPAgStruHfSgxas6GXnZvIpaW29+La35MHOoB9
 YvT52jE8ujd0gCUSErCBFn8h+EA74faNAXULpaX5lxOHRKN025fzWSs+4SpQfI57/M+L4w0XB5U
 0DuVFV5zyLTlCdtIxzYIrP3dv9YGXCVTA2FW5EonDhiwtrRplyxkux1d9eTz0rYspOV/c151r5k
 yYeawn5iYL81yiRnIl4Bk0HxxpE81Qt4TIgCN8mLCtgEQaupQ2hobXwhXq4cgRwVAfkjFfb0gfx
 6ceEzHzo1K3L4Ah0Dc6fQtd0/MMplb9AOO6bXDUs5F6Di2n1mY0qb2d0raWIonSZuBRgfVfLKAi
 pxR30nCTL96NXig==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:43:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2976

Everything is already in place for EFI capsule updates, so enabling
Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
flash from Linux using fwupd's Capsule support.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-ac_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 1a67ca734b8..17d54655017 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y

-- 
2.53.0


