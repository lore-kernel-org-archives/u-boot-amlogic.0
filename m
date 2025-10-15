Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC68CCD19F
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:24 +0000 (UTC)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
 by mx.groups.io with SMTP id smtpd.web11.22372.1760545579413090734
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 09:26:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=JpJxPk7t;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.188, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760545577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCzjoNx85kQjnqtELcVZiI/0ZNha2YwcXg2IRVevnj8=;
	b=JpJxPk7tdiR7T6WbxlfRYjsYPHX/xZ3u32zNmM0pXF0YgMPgqCNMXFQ1cMExjTyM2iq0yJ
	NW7miSyXdhhE/jZnAIphJWFU/zxpRMyKm2sWfeJjRCdqq3F6WAcNDT6H2FomQbfXs/Q6C4
	/ORuxf3DkioPX4/cIVSg7d3pU8LOwbVeSgl4kqbSYQw/yrlHr4qFX5TigEvrHIYxB6CAyb
	Kvt1iOKb8O23BEmsN0YNEuMpEDFhNydRmRJRkMkJzEw06pAHrn6c88TAqcOfvZ3L/IALV9
	yG+K4ovJD6QG7B14VNQw7GIl/UduaeyKqq7gpUYretqaT6hyb3jCLzueBnv/mg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:54 +0000
Subject: [PATCH v4 7/8] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251015-spl-gx-v4-7-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5624;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=n9dcM1NaWv1N3tiHVLTyEWnkCB0OZsXRcVilFoSK+pA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sfZZGbJAzF6qkeA0raXdqmqqOMHQow1rwGC
 Mao7wMyfAiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHwAKCRCEr8vQ14ma
 A8PQEACjMOWTsWQ7fxRqWqv45Wc1qk2BtqPwsgfKSSHylD1VCqCV60/QrVuCwjRVLd7PoyqlukZ
 wiSgPzoUCpAk4jLt6o5F2jvUrQWxIb+Rn8BLyYVxu36mBRNlwn4HbLMjKWk8VKE2ouIiNU4ziu5
 WiSN7BLtKCdw2g5YbyIyXm8+pqYtCTv5HhJpAzgomTOuuoRTq3ZKuyM22qVIQetx9eOMbAk0I7u
 W/kZTBalmxRN3FjYc47k5ecrYyzPXo4Q4eCbDsrivRHRXLcED4I0siudfQUHxodn5+TSnUw4Rz1
 TMExeUM2HDsHFFFeZAijpd/VnaLviGOhy8Jbkl783k0+FFlMu0NbuPJ33QBCGfbwjtA4cMGH6j1
 Zk6uiX3n7QKQsd3AM/gLj1Cciw71PU6KSKsbEzOzlv/8A7WkVH2zOK67+okNwv3fgK+8Jc/nABW
 VzvmrxuyXO7z1UbI8eTvl1HZ2lz3MPyAzRyolU67H6qFveiCumnHvCC5r0JGybFd5L27ub1Lp6C
 a/ukhvKAoCtb0ZZQTqx5jfceH3hmr3QuFMgCFzMzg5r6f4CfJ2SeELVUVYu6BoR2SK0yNbjiZhO
 V7DqZjossgbQAyU4ofeCnUwD1zo268Sm8rGfr2V0Xhyh/m5x47KmMCFwgCwyyFn1eLVAvnu25EX
 KbzFMNCI0GzoIJg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 16:26:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2818

Add kconfig fragments for building SPL binaries for:
 =C2=B7 ODROID-C2
 =C2=B7 Videostrong KII Pro
 =C2=B7 Libre Computer LePotato (1 GB and 2 GB variants)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/amlogic/p200/spl-odroid-c2.config           | 37 +++++++++++++++++=
+++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 38 +++++++++++++++++=
++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 35 +++++++++++++++++=
++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 37 +++++++++++++++++=
+++++
 4 files changed, 147 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200=
/spl-odroid-c2.config
new file mode 100644
index 00000000000..d5ea295bc6d
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
index 00000000000..5b3ba9d9908
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
index 00000000000..0969f9b7444
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
@@ -0,0 +1,35 @@
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
index 00000000000..e2d9cc765cb
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
@@ -0,0 +1,37 @@
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


