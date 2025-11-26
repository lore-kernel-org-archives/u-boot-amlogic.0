Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8ED10F2E
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 12:17:45 +0000 (UTC)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11791.1764159462334191879
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 04:17:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=M7bLwJ2x;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.172, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764159460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5w3G5+jJ80JH0+11X3sN2NQveP4GrQbceClBlgZop8=;
	b=M7bLwJ2xKVDWW67BF80Iou8Tlf/msdZ5gHR+Mb85FVsKMpVQcmHB1Osb4yOat7s2C/+kAI
	9K9F5A3C4KrBBXl4JuUfatI6CNNCq91a75dsG1UXR/3f+R7oexF8uTaMjdzKedztb5jSGt
	ozewXadbrznQwXyrmve+CJ7tMUhbs4xg9GSlY8OV3OPG33RpucOyQtLeY7LpEpcEM0k1Uu
	teXQ8i5KJMfaX9eQiS0EHASpQ0dYCIuOqwNGhSN9AwLbtPZ+JhAeJKXqKheLV3v8ItBAOK
	9iXikRFGN2X6wjyEkz8Nt3qDO/usVC4f9yQw3VD9wzv5t0G/0r1KgqzaItOA/w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:10 +0000
Subject: [PATCH v5 08/10] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251126-spl-gx-v5-8-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5712;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=C4S9pQIp+LaB6zzOnV84Ei9aOHwtxpZhVOG1cdJ9iSA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/Z0uvidZTrZgxPBa38e8r4iTg8OhSlwP8HI
 m4hmNPMgg6JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2QAKCRCEr8vQ14ma
 AyIdD/0aJm6ijqwTKeZ/c7B05nETIxDobcvV8p3i+9Bp8eqwNZ0YNhu545EVtGTBD7np2QPsu1k
 aelaJS1bIhO8tI7axPuAbpnnswyUUA6+iDVSBMpEXoEYO+O+XFnc81L1a5Qr/TjWKRaujXN4EeF
 mRc49gySqhJ6/0OffQL7/VcnjKWYJ/wZNgKdOZvb4IzmvdVGQaN+9pZ/2xpKFiMYPPkjipmA5ua
 tTIUK/g/vS8S3UervEbSqoA6X0ZYhyuHyItnbjMVKF4VkQg7O6dJ3rOE3jZ90ZP1Av3cMtEVQfz
 MdQDJwkxyWSlQ9VG2DsMa7QArkDssAW/8wqU6nclDDEqmjsjCcr475upJttBRoIHTtPrbbviMGI
 9B+Q8s3FLz94lhGp6SI9zdwK7EQVoane+3a4blx2f0fy4BmXrWS8h2ySqvclSTl4Bb4WRBMTCu9
 vefXNh/PkeSuORskXq45Be0+jnRlg80D+VqdlYDj4bVUktMNEIuj4nUR0Oa9QOCXBvTpZ07fWE4
 McOcFUGBGxg29x63eX3n9OK9/K86oXIjCXHGbVPfiGEs1RkmCu9GGxxn1rcEsCFoMcBE1vOYDLu
 VQPFh7zRc1lTJNPWCH2ORmY+01CpH0YxMd19P2he7TeqZw3XT2hzqOX0nJ3JRO1TYc9yak5lYZU
 3uvmv3hAcIj/zpg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 12:17:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2859

Add kconfig fragments for building SPL binaries for:
 =C2=B7 ODROID-C2
 =C2=B7 Videostrong KII Pro
 =C2=B7 Libre Computer LePotato (1 GB and 2 GB variants)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/amlogic/p200/spl-odroid-c2.config           | 38 +++++++++++++++++=
+++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 39 +++++++++++++++++=
++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 36 +++++++++++++++++=
++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 38 +++++++++++++++++=
+++++
 4 files changed, 151 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200=
/spl-odroid-c2.config
new file mode 100644
index 00000000000..f3497c54153
--- /dev/null
+++ b/board/amlogic/p200/spl-odroid-c2.config
@@ -0,0 +1,38 @@
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
+CONFIG_SPL_SHA256=3Dy
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
index 00000000000..62df2333717
--- /dev/null
+++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
@@ -0,0 +1,39 @@
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
+CONFIG_SPL_SHA256=3Dy
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
index 00000000000..be414c8770e
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
+CONFIG_SPL_SHA256=3Dy
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
index 00000000000..9f7b81fd6e9
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
+CONFIG_SPL_SHA256=3Dy
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
2.51.2


