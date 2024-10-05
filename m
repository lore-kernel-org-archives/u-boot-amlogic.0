Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2ED1A43A
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:52 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by mx.groups.io with SMTP id smtpd.web11.7898.1728117083689005229
 for <u-boot-amlogic@groups.io>;
 Sat, 05 Oct 2024 01:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@neoninteger.au header.s=protonmail header.b=QMpavc6V;
 spf=pass (domain: neoninteger.au, ip: 185.70.40.18, mailfrom: callum@neoninteger.au)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neoninteger.au;
	s=protonmail; t=1728117080; x=1728376280;
	bh=rEkcA/Gu3nRasoafcHbWrXhIbKjSFJMb/V3hiduL+KE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QMpavc6Vb5bFIKpW0vv7K23ZFCBV0z0n6w1LJYoOd/Xs3LVbr2qz2u08Wu/xH2zA0
	 aw17ggIbDe4pBxTliBAlh4GwdVuXxM40TBa+JSPAAiHTpBBrxaF6xKpdki3dWS5P+1
	 JMZjU+4jqVieDqkDy4a70oA79CXv3hWa1UUPm29PiEIbhqLLIMdh8veYWFQZe6I/1O
	 ItT/D7UC2wHL/i2u4/3wG/ZpzqgV5Svxd2k4LEK58IZ/awCBqjWq3+OW7ENrps7y6m
	 xOz8TfmXCuQ5MeyzeFx5YwRrnwyMiyJnIglkOcSzsgd4xnsczvlPzpA/GPDM0MRg1W
	 QKLVg6ZY/4TIw==
Date: Sat, 05 Oct 2024 08:31:16 +0000
To: u-boot-amlogic@groups.io
From: "Callum Parsey" <callum@neoninteger.au>
Cc: Callum Parsey <callum@neoninteger.au>
Subject: [PATCH] configs: meson64: Ensure commands for boot targets are available
Message-ID: <20241005083008.34265-1-callum@neoninteger.au>
Feedback-ID: 62309085:user:proton
X-Pm-Message-ID: cedeb8bc90b9f579492c4edc027cb1586164e160
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:00:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2458

When populating BOOT_TARGET_DEVICES on Amlogic Meson platforms, verify
that the shell commands for accessing the relevant media have been
enabled in the build configuration.

This was already being done for USB, NVME and SCSI devices, but not
for MMC devices or network boot. This meant that configuring U-Boot
without the networking or MMC subsystems/drivers would cause an error
to be thrown during preprocessing.

Signed-off-by: Callum Parsey <callum@neoninteger.au>
---
 include/configs/meson64.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index ccb8ea2e71..f3275b37a5 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -77,6 +77,15 @@
 	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance)
 #endif
=20
+#ifdef CONFIG_CMD_MMC
+	#define BOOT_TARGET_MMC(func) \
+		func(MMC, mmc, 0) \
+		func(MMC, mmc, 1) \
+		func(MMC, mmc, 2)
+#else
+	#define BOOT_TARGET_MMC(func)
+#endif
+
 #ifdef CONFIG_CMD_USB
 #define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
 #else
@@ -95,18 +104,27 @@
 	#define BOOT_TARGET_SCSI(func)
 #endif
=20
+#if defined(CONFIG_CMD_DHCP) && defined(CONFIG_CMD_PXE)
+	#define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
+	#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
+#elif defined(CONFIG_CMD_DHCP)
+	#define BOOT_TARGET_PXE(func)
+	#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
+#else
+	#define BOOT_TARGET_PXE(func)
+	#define BOOT_TARGET_DHCP(func)
+#endif
+
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
 	func(USB_DFU, usbdfu, na)  \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
+	BOOT_TARGET_MMC(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_NVME(func) \
 	BOOT_TARGET_SCSI(func) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
+	BOOT_TARGET_PXE(func) \
+	BOOT_TARGET_DHCP(func)
 #endif
=20
 #define BOOTM_SIZE		__stringify(0x1700000)
--=20
2.46.2



