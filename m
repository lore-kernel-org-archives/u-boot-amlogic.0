Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E3C36007
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:49 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.4458.1742415660362034658
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Mar 2025 13:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=iTDwo7xw;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6858110000D;
	Wed, 19 Mar 2025 23:20:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6858110000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1742415658;
	bh=H3WE+GS7B6YVabiOijgU/qFvdi56abgkSCgGv3g16sM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iTDwo7xw6hyus4AAcjCZUliNdp8PKOIddTy1rzlUMfOkBMxYfa7oQimZE/O0DS/rW
	 fTuNBVe8J23vWyKvz3w8T469BAM9dG+6BLV/XzoHs9JIE8teDZSOED2JXtHaW4bnI8
	 SsT1I8n2pzplwf9tvZ5YBOORZrvRW9JiqZOLy9eBP38XEtRHtUu6o9hzNVpDYjOLwE
	 HTuBezhj/XrpwvmxJVczUz4UVeZO4wUwLpAeT2bm3L0eg+2KBUlNydMTAbOjL4d13N
	 m8IATH/Vp4biXqkAUwQDteH4oFAK89fqA4DcF40NTuVZ4eYlb511nIxP7l5c1MKs2C
	 R2AqKyFlcRVIA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 19 Mar 2025 23:20:58 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
	Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
	Simon Glass <sjg@chromium.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, <oxffffaa@gmail.com>,
	<avkrasnov@salutedevices.com>, Vladimir Mitrofanov
	<vvmitrofanov@salutedevices.com>, Evgeny Bachinin
	<EABachinin@salutedevices.com>
Subject: [PATCH v1 01/11] arch: arm: meson: sm: add commands to reboot device in different modes
Date: Wed, 19 Mar 2025 23:20:35 +0300
Message-ID: <20250319202045.1407-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/19 17:18:00 #27803216
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Mar 2025 14:56:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2641

From: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>

There are several commands to reboot device in specific mode
(cold, normal, etc.), these commands helps to enter flashing mode
and set boot source device:

1) MESON_SMC_CMD_BL1_FIRST_BOOT_SRC_SET

  This command tells BL1 that it must load BL2 from USB data path. It is
  used in ADNL protocol logic when burning process is started from the
  U-Boot command line: when 'adnl' is entered, this command tells BL1 to
  load BL2 from USB, then board is rebooted. After reboot BL2 and next
  stage loaders will be loaded from USB, sticky register has value that
  we are in ADNL mode, thus booted U-Boot enters ADNL mode to start data
  burning.

  Used in adnl-based SoC families: a1, s4, c1, =D1=812, sc2, t7, etc.

2) MESON_SMC_CMD_REBOOT_MODE_SET
  Used in optimus-based SoC families: axg, g12a, g12b, sm1, etc.

3) MESON_SMC_CMD_USB_BOOT_MODE_SET
  Used in optimus-based SoC families: axg, g12a, g12b, sm1, etc.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/sm.h | 98 +++++++++++++++++++++++++++-
 arch/arm/mach-meson/sm.c             | 39 +++++++++++
 drivers/sm/meson-sm.c                |  3 +
 include/meson/sm.h                   |  3 +
 4 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/ar=
ch-meson/sm.h
index 4d614955fc2..087f8b4d5fa 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -83,7 +83,7 @@ int meson_sm_get_serial(void *buffer, size_t size);
  */
 int meson_sm_get_chip_id(struct meson_sm_chip_id *chip_id);
=20
-enum {
+enum meson_reboot_mode {
 	REBOOT_REASON_COLD =3D 0,
 	REBOOT_REASON_NORMAL =3D 1,
 	REBOOT_REASON_RECOVERY =3D 2,
@@ -134,4 +134,100 @@ int meson_sm_pwrdm_set(size_t index, int cmd);
 #define meson_sm_pwrdm_on(index) \
 	meson_sm_pwrdm_set(index, PWRDM_ON)
=20
+/*
+ * Below is the list of SCPI_CMD commands, issued by U-Boot and passed to =
SCP
+ * co-processor via SMC to BL31 (TF-A). BL31 routes these commands to SCP
+ * via mailbox.
+ *
+ * Commands instruct the SCP how to set/control POC pins in order to choos=
e
+ * first boot source, specified by the particular command below. These POC=
 pins
+ * are readable by BootROM and used to determine the boot sequence. Usuall=
y,
+ * the normal default boot sequence, seen on production device is
+ *     NAND/eMMC -> SD -> USB
+ *
+ * Commands below change the first boot source.
+ *
+ * NOTE:
+ * these commands are used along with meson_sm_set_bl1_first_boot_source()=
 on
+ * Amlogic SoCs where ADNL burning protocol is utilized.
+ * Refer to meson_sm_set_usb_boot_mode() for the same functionality but on=
 SoCs
+ * with Optimus burning protocol.
+ */
+
+/**
+ * define SCPI_CMD_USB_BOOT - sets the first boot source into USB with tim=
eout
+ *
+ * Additionally, force the BootROM (BL1) to wait for the Host's enumeratio=
n
+ * with timeout
+ */
+#define SCPI_CMD_USB_BOOT 0xB0
+
+/**
+ * define SCPI_CMD_USB_UNBOOT - sets the first boot source into USB w/o ti=
meout
+ *
+ * Additionally, force the BootROM to wait for the Host's enumeration with
+ * uninterruptible wait, i.e. forever
+ */
+#define SCPI_CMD_USB_UNBOOT 0xB1
+
+/**
+ * define SCPI_CMD_SDCARD_BOOT - sets the first boot source into SD card
+ */
+#define SCPI_CMD_SDCARD_BOOT 0xB2
+
+/**
+ * define SCPI_CMD_CLEAR_BOOT - sets the first boot source into default on=
e
+ *
+ * BootROM follows a pre-defined boot sequence stored in SoC ROM code.
+ */
+#define SCPI_CMD_CLEAR_BOOT 0xB3
+
+/**
+ * meson_sm_set_bl1_first_boot_source - sets the first boot source for Boo=
tROM.
+ * @cmd: command to set first boot source visible to BootROM during boot.
+ *       Use SCPI_CMD_* as commands.
+ *
+ * BootROM checks POC-pins (POC0, POC1, POC2) to determine in which order =
it
+ * must probe the various methods of booting the system. The order is usua=
lly
+ * pre-defined. But function changes the first boot source of that pre-def=
ined
+ * order.
+ *
+ * @return: zero on success or error code on failure.
+ */
+int meson_sm_set_bl1_first_boot_source(u64 cmd);
+
+/**
+ * meson_sm_reboot - reboots device in a appropriate mode
+ * All possible modes described in &enum meson_reboot_mode
+ *
+ * @mode: reboot mode.
+ * @return: zero on success or error code on failure.
+ */
+int meson_sm_reboot(u64 mode);
+
+/**
+ * enum meson_usb_boot_mode - modes for meson_sm_set_usb_boot_mode()
+ * @FORCE_USB_BOOT: Forces BootROM to boot with firmware transferred by PC
+ * 		    burning tool via USB. This mode has influence despite of the
+ * 		    previously selected boot source. This mode persists between
+ * 		    reboots and must be cleared.
+ * @CLEAR_USB_BOOT: Clears previous mode.
+ *
+ * These modes are used in conjunction with meson_sm_set_usb_boot_mode() o=
n
+ * Amlogic SoCs where Optimus burning protocol is utilized.
+ */
+enum meson_usb_boot_mode {
+	CLEAR_USB_BOOT =3D 1,
+	FORCE_USB_BOOT =3D 2,
+};
+
+/**
+ * meson_sm_set_usb_boot_mode - sets the mode of usb interface that will b=
e used during boot
+ * All possible modes described in &enum meson_usb_boot_mode
+ *
+ * @mode: reboot mode.
+ * @return: zero on success or error code on failure.
+ */
+int meson_sm_set_usb_boot_mode(u64 mode);
+
 #endif /* __MESON_SM_H__ */
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index b1f91ca29ce..53b07e1dfe9 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -236,6 +236,17 @@ int meson_sm_get_reboot_reason(void)
 	return FIELD_GET(REBOOT_REASON_MASK, reason);
 }
=20
+static int meson_sm_call(u32 smc, struct pt_regs *regs, s32 *retval)
+{
+	struct udevice *dev;
+
+	dev =3D meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	return sm_call(dev, smc, retval, regs);
+}
+
 int meson_sm_pwrdm_set(size_t index, int cmd)
 {
 	struct udevice *dev;
@@ -256,3 +267,31 @@ int meson_sm_pwrdm_set(size_t index, int cmd)
=20
 	return err;
 }
+
+int meson_sm_set_bl1_first_boot_source(u64 cmd)
+{
+	struct pt_regs regs =3D { 0 };
+
+	regs.regs[1] =3D cmd;
+
+	return meson_sm_call(MESON_SMC_CMD_BL1_FIRST_BOOT_SRC_SET,
+			     &regs, NULL);
+}
+
+int meson_sm_reboot(u64 mode)
+{
+	struct pt_regs regs =3D { 0 };
+
+	regs.regs[1] =3D mode;
+
+	return meson_sm_call(MESON_SMC_CMD_REBOOT_MODE_SET, &regs, NULL);
+}
+
+int meson_sm_set_usb_boot_mode(u64 mode)
+{
+	struct pt_regs regs =3D { 0 };
+
+	regs.regs[1] =3D mode;
+
+	return meson_sm_call(MESON_SMC_CMD_USB_BOOT_MODE_SET, &regs, NULL);
+}
diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
index 87eba1486db..f413d8335b3 100644
--- a/drivers/sm/meson-sm.c
+++ b/drivers/sm/meson-sm.c
@@ -168,8 +168,11 @@ static const struct meson_sm_data meson_sm_gxbb_data =
=3D {
 	.cmd =3D {
 		SET_CMD(MESON_SMC_CMD_EFUSE_READ,  0x82000030),
 		SET_CMD(MESON_SMC_CMD_EFUSE_WRITE, 0x82000031),
+		SET_CMD(MESON_SMC_CMD_USB_BOOT_MODE_SET, 0x82000043),
 		SET_CMD(MESON_SMC_CMD_CHIP_ID_GET, 0x82000044),
+		SET_CMD(MESON_SMC_CMD_BL1_FIRST_BOOT_SRC_SET, 0x82000087),
 		SET_CMD(MESON_SMC_CMD_PWRDM_SET,   0x82000093),
+		SET_CMD(MESON_SMC_CMD_REBOOT_MODE_SET, 0x84000009),
 	},
 };
=20
diff --git a/include/meson/sm.h b/include/meson/sm.h
index fbaab1f1ee0..b9621f95cbe 100644
--- a/include/meson/sm.h
+++ b/include/meson/sm.h
@@ -13,6 +13,9 @@ enum meson_smc_cmd {
 	MESON_SMC_CMD_EFUSE_WRITE, /* write efuse memory */
 	MESON_SMC_CMD_CHIP_ID_GET, /* readh chip unique id */
 	MESON_SMC_CMD_PWRDM_SET,   /* do command at specified power domain */
+	MESON_SMC_CMD_BL1_FIRST_BOOT_SRC_SET, /* setup first boot source for Boot=
ROM */
+	MESON_SMC_CMD_REBOOT_MODE_SET, /* Reboot device in desired mode */
+	MESON_SMC_CMD_USB_BOOT_MODE_SET, /* Run boot from USB device */
 	MESON_SMC_CMD_COUNT,
 };
=20
--=20
2.30.1


