Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1927.1794715080072280873
 for <u-boot-amlogic@groups.io>;
 Sat, 14 Nov 2026 19:58:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=KGvDXLkf;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 010AA6184A;
	Sun, 15 Nov 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794714634;
	b=OOeTG2eC9Mf1oaZ/tGA+J0lM5BYpuMU4XaB2fr6phsemwVgpdXS1cKbhhCfi/DodIhgG
	 +PLLtQgAE4B3wegbk/maIETj0r3ctdzPlFXWxE6rGZ2dvNnqXLYjj6Mi/4B7iOnnMCilK
	 oB6DXsws1oynLCTRjGy8uaez8PEwqjmtBXKpMB+fwngpMRQ++eJ8yWxGoONJAx22QSKx+
	 ZqJ21rcQezhKagqVZ2XovSeko/ydXr4GU1sVddL48C9HHoiWISvS5kIksjfzqna86aZEY
	 1MtioKZs0UQWbTaFWyjusN5Yz8/YhUTdfAiXMGg5lGJ4p77yM07Fl4sYf+SQpWT3iIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714634;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jzBHawrSi2BsPVL+Ic5A72BcVVlzspUs+xjYOYJxrdk=;
	b=kydkJgjUXN8PKcD8FEkfv7mWVgLeF3xivUpSX6nj9cu6yZa99HhPeJv854PlddROqZT4
	 NvoFiHnx2RX8ByDXgoMlycj7FQ6Rn+KHK2hriG+X6Q+cP3UhCsOlXZO0VqzHMnk+85jRn
	 OLBwXHYaXg/mdzebGdNdTIYwWTn8rQyRMKj63Ae5ahggpQdOYLtfqLtg9aMF8nUQOoNOu
	 scMLI+0IUaGT9ts+nB9EuWEHoZ4Lf6r+Z71pOICxu+2T+Bg2WotbvV5Jt3ph/rLYPRGGo
	 1mTbEeqYA9OBekig0CPhxjMdomZdR61dFqQ5U+SCluup2ogEI77/zdoYgC+6cc4ZXGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 081CE1F000C7;
	Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714634;
	bh=jzBHawrSi2BsPVL+Ic5A72BcVVlzspUs+xjYOYJxrdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KGvDXLkfwAc88yLsf5YoeA1yBxVlaQNmztpMwyWO3Al8V3AJE1acj5C2M+eua031i
	 br+xyb5BMpjCsiVe5NwFj3RsWJJYZ5XZr9pQ0aQj2wDnqU9tmiYXMxX8ynJo4zew7L
	 AKjE8cK/Yr01LbppUpc8+JIX44q8meupfLrrz9b86VDl5kOqTgsTgL5pyGhR4UO7PE
	 WdwCXbJdIYvVOd01BSgl338mOhq0R4Ux5SAw+Vhw9JTdAvW+brRsJDw/P39XlQUVQg
	 JX99sMSHEDPdPM1b6np+pydSrFDWZSrQh9+usDgL16wGimxSuwfODfgK/o8uMIapUO
	 rSgeET0EBUFqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AB3449F61;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 15 Nov 2026 03:50:32 +0000
Subject: [PATCH 3/3] configs: odroid-c4, odroid-hc4: enable Wake-on-LAN from suspend
MIME-Version: 1.0
Message-Id: <20261115-b4-meson-scp-wol-v1-3-80c3e9f4deda@iav.lv>
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=TR7+WSUw912x4EZh77Z+Wcm/UCk/rDcRO5KtEgwiol8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/dTgiX8SIPuY++9jozibj8weXz5lx9O2Bp++28Tcoa
 YYFe92Y01HKwiDGxSArpsgy4ZDGrYwlV//6e5g/gJnDygQyhIGLUwAmUj2X4Z/u4qVr2R973hUN
 +una0cPo8ftPZuU1sTnL03pm/he5vzyJ4a9Q59b8bzkfdqterz1qoyyiniC4NMzo76brqxguVF1
 u+cEOAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3156

From: Igor Velkov <iav@iav.lv>

Enable CONFIG_MESON_G12A_SCPI so that U-Boot tells BL301 whether to
wake the board on the Ethernet PHY in suspend, and describe it in the
board docs.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 configs/odroid-c4_defconfig      | 1 +
 configs/odroid-hc4_defconfig     | 1 +
 doc/board/amlogic/odroid-c4.rst  | 9 +++++++++
 doc/board/amlogic/odroid-hc4.rst | 9 +++++++++
 4 files changed, 20 insertions(+)

diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index f42fa0789d6..55e62f7f1cf 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-c4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
+CONFIG_MESON_G12A_SCPI=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 694db0684e7..1d18070d265 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-odroid-hc4"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_MESON_G12A=y
+CONFIG_MESON_G12A_SCPI=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
index 6994b958cf8..2df7afd71bc 100644
--- a/doc/board/amlogic/odroid-c4.rst
+++ b/doc/board/amlogic/odroid-c4.rst
@@ -141,3 +141,12 @@ Then write the image to SD or eMMC with:
     $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Wake-on-LAN from suspend
+------------------------
+
+The BL301 firmware built from the Hardkernel sources wakes the board on the
+Ethernet PHY interrupt, and keeps the VCCK_B and 3.3 V rails on in suspend
+for it, only when told to. With ``CONFIG_MESON_G12A_SCPI``, U-Boot tells it
+to when the PHY node of the device tree passed to the OS has the
+``wakeup-source`` property, and tells it not to otherwise.
diff --git a/doc/board/amlogic/odroid-hc4.rst b/doc/board/amlogic/odroid-hc4.rst
index 1d37be2d80e..ccf30de5350 100644
--- a/doc/board/amlogic/odroid-hc4.rst
+++ b/doc/board/amlogic/odroid-hc4.rst
@@ -140,3 +140,12 @@ Then write U-Boot to SD or SPI-NOR with:
     $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Wake-on-LAN from suspend
+------------------------
+
+The BL301 firmware built from the Hardkernel sources wakes the board on the
+Ethernet PHY interrupt, and keeps the VCCK_B and 3.3 V rails on in suspend
+for it, only when told to. With ``CONFIG_MESON_G12A_SCPI``, U-Boot tells it
+to when the PHY node of the device tree passed to the OS has the
+``wakeup-source`` property, and tells it not to otherwise.

-- 
2.43.0


