Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF5CAC584
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:49 +0000 (UTC)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
 by mx.groups.io with SMTP id smtpd.web11.19693.1757255800114270483
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=WBiPKH9S;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.174, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWKJx0LwHUYxvc7wgZkeGDtU6MGLz2jpp59UGnoHuz4=;
	b=WBiPKH9SteyEk5nrJ/OmiPnYIu56DO/uSkdxm9eqnKvjmEDLh1pAWts2tZ4iPr5ucCfYTG
	NbAmOqExWQzs7f97djSZ4V7eZ+S9035OWdk/eIMKNgjn9/5eCt0aRW+FrMiOMA9nFeyJPi
	mSv0SeZfoR+zYiYcYXm8kVaevKOYSoqMPswo5dh+AEyv3P+L6wn4cNrytTnUf/B8Ez7EI9
	LoMEQKSV+RXbV2EEyB4zH+y2U2THBaWUsfqiDeq1QIetuMGds7Gm2SLsTuUnQLRMb1kFjD
	dp7r99kys/PWa/wi2Hie/uQ2fwtbH2/d+NkD/CGMlNzUuhmHpAWaMMcpGR7+NQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:14 +0000
Subject: [PATCH RFC 8/9] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250907-spl-gx-v1-8-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5876;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=hAgGbmunyWRg1cwNGvnURgZ+uUWG4J6aWslG35oSdQc=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhsDiX3FqMIzYk8Qhb5WFWrTyB0LXwVMG+Ka
 zOspmkRzoqJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YbAAKCRCEr8vQ14ma
 AxpbD/9WgrVjF82cHzPrMU0u7K3lOCEy/GVWSjY1EBRsPm61pwfrfLacxGc3fG1AIR7P0knuwUp
 auhXXrh2AIvbdJo4QbFAUA0hjqJkViIk5131duhxJ3AtHgqyMHi471fzIHm7sIb1EtXlIbCaMaB
 H39ZHih3f2iim4lcV8/nAG4nIIJ4KBaxm+j1H18bkNOtsECfh7S8nEBAI5U0ajCszP3QTAmYlan
 scSQhsZTqs/1l1NkbRIEGcysGMQ+epRyVwTvvDWG7K3N79H9zuPk9FxB6jIn2U1thW9E10iddXU
 mokWj47j/H/bWx7b2ZxokMnQRHrdVSJO8C/X6m/vMl8ef5AqXqAofJt93Mb2JvcK3a86Tof5tCS
 Uc5Bga9qfFWjxccGlC2rIrPEXKYDQrzWO8nbBrUEu4zYtzdztz0u9XMOLGkCQjt0wWa3Hl3dyLW
 aVbiQzEKrNJMlLEZM9yBJ9YXSnvOVnnnoqUX5TZ/+1wqZYBO7Vwv7ndfxmwCNnevn08RdY/50BU
 +lwWM8U4OeI4WC8/8wY92mhQmp905x5OIjzJV9nNVZZWb1OyxfabTinOcombyGkHGQf+tDH3EuM
 TwjGIUdEYwU/mEh3wo/BIkKYda3274Rl/umNnbl479+T9OfrdwXGRVhOEf70zSHOtSlw0YKt34n
 2SYNo0QZkaK9jCA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2751

Add kconfig fragments for building SPL binaries for:
 =C2=B7 ODROID-C2
 =C2=B7 Videostrong KII Pro
 =C2=B7 Libre Computer LePotato (1 GB and 2 GB variants)

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/amlogic/p200/spl-odroid-c2.config           | 37 +++++++++++++++++=
+++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 38 +++++++++++++++++=
++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 36 +++++++++++++++++=
++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 38 +++++++++++++++++=
++++++
 4 files changed, 149 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200=
/spl-odroid-c2.config
new file mode 100644
index 0000000000000000000000000000000000000000..d5ea295bc6d281f3d7770cc84=
1ccbae5aee468a4
--- /dev/null
+++ b/board/amlogic/p200/spl-odroid-c2.config
@@ -0,0 +1,37 @@
+#
+# U-Boot SPL fragment for odroid-c2
+#
+
+CONFIG_SPL=3Dy
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_SPL_TEXT_BASE=3D0xd9001000
+CONFIG_SPL_STACK=3D0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
+CONFIG_SPL_BSS_START_ADDR=3D0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=3Dy
+CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
+CONFIG_SPL_MMC=3Dy
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=3Dy
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=3Dy
+CONFIG_SPL_MAX_SIZE=3D0xb000
+CONFIG_SPL_PAD_TO=3D0x1fe00
+CONFIG_SPL_ATF=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+# DRAM configuration
+CONFIG_DRAM_SIZE=3D2048
+CONFIG_DRAM_2T_MODE=3Dy
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=3Dy
diff --git a/board/amlogic/p200/spl-videostrong-kii-pro.config b/board/am=
logic/p200/spl-videostrong-kii-pro.config
new file mode 100644
index 0000000000000000000000000000000000000000..5b3ba9d990840411ef3cef3db=
3c6aa9d7085b3ef
--- /dev/null
+++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for videostrong-kii-pro
+#
+
+CONFIG_SPL=3Dy
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_SPL_TEXT_BASE=3D0xd9001000
+CONFIG_SPL_STACK=3D0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
+CONFIG_SPL_BSS_START_ADDR=3D0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=3Dy
+CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
+CONFIG_SPL_MMC=3Dy
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=3Dy
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=3Dy
+CONFIG_SPL_MAX_SIZE=3D0xb000
+CONFIG_SPL_PAD_TO=3D0x1fe00
+CONFIG_SPL_ATF=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+# DRAM configuration
+CONFIG_DRAM_SIZE=3D2048
+CONFIG_DRAM_2T_MODE=3Dy
+CONFIG_DRAM_TWO_DIFF_RANKS=3Dy
+
diff --git a/board/amlogic/p212/spl-libretech-cc-1gb.config b/board/amlog=
ic/p212/spl-libretech-cc-1gb.config
new file mode 100644
index 0000000000000000000000000000000000000000..f58bb69325980d582d2d826eb=
bf28e4700965dfb
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
@@ -0,0 +1,36 @@
+#
+# U-Boot SPL fragment for libretech-cc (1 GB variant)
+#
+
+CONFIG_SPL=3Dy
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_SPL_TEXT_BASE=3D0xd9001000
+CONFIG_SPL_STACK=3D0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
+CONFIG_SPL_BSS_START_ADDR=3D0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=3Dy
+CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
+CONFIG_SPL_MMC=3Dy
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=3Dy
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=3Dy
+CONFIG_SPL_MAX_SIZE=3D0xb000
+CONFIG_SPL_PAD_TO=3D0x1fe00
+CONFIG_SPL_ATF=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+# DRAM configuration
+CONFIG_DRAM_2T_MODE=3Dy
+CONFIG_DRAM_DQS_CORR=3Dy
diff --git a/board/amlogic/p212/spl-libretech-cc-2gb.config b/board/amlog=
ic/p212/spl-libretech-cc-2gb.config
new file mode 100644
index 0000000000000000000000000000000000000000..65d700558e65ca8d819f397a0=
153be8bf07ae702
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for libretech-cc (2 GB variant)
+#
+
+CONFIG_SPL=3Dy
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_SPL_TEXT_BASE=3D0xd9001000
+CONFIG_SPL_STACK=3D0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
+CONFIG_SPL_BSS_START_ADDR=3D0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=3Dy
+CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
+CONFIG_SPL_MMC=3Dy
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=3Dy
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=3Dy
+CONFIG_SPL_MAX_SIZE=3D0xb000
+CONFIG_SPL_PAD_TO=3D0x1fe00
+CONFIG_SPL_ATF=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+# DRAM configuration
+CONFIG_DRAM_SIZE=3D2048
+CONFIG_DRAM_2T_MODE=3Dy
+CONFIG_DRAM_DQS_CORR=3Dy
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=3Dy

--=20
2.51.0


