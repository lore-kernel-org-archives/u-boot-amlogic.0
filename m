Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C4CCD18A
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:01:04 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
 by mx.groups.io with SMTP id smtpd.web10.12151.1759917663986938721
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 03:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=dcRY/PSK;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.178, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759917662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4HKzf41yblwb5ZEi3hIbNyvurngWxBH+txeqauhEWc=;
	b=dcRY/PSKF2A2jZ+CRVrTTJ2FqX6JgVIJ7HthewF7xQWrBAxlGBCMHvbL+vpKzWKkEGuQXs
	UJu4blrFsLOvtf+5wJufGzRAcPXaHmh3NbgaIF8/rnAhi1byhZVtk1lI4VmOcR81BhtwJI
	zjCVZG393SGU/txKXMoA6lDANPXwFo1qSW22PofXA18Pb8Qlhlcr3LDqH4hiz4M3TmdYBg
	BOFRGCfhEHp8XdZEjvXVfcq/zPVAiq28Roun951g6fR04o6RxCkiXd34oVOSujMi96drtc
	wpoNsqojspvNJvMvjqz9ZTjN9HcRdWl0rOqwUfNGBgcXv5Rp2xrDJeiR30GBZg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:43 +0000
Subject: [PATCH RFC v3 7/8] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251008-spl-gx-v3-7-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5933;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ZDCqaT1tKSS5vqVHVNkdoRL3WD8v9gNsgE+cMggnH4E=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZU2Oo6C2ZAfnuNpOK2w2BiufMqObITxPOdp
 joA18uSJ2GJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2VAAKCRCEr8vQ14ma
 A8wiD/4pct6GtOevU2XtrSJzUgK1qSHAu2QgLC6HvwbyL6+MKkg5KVs1x9VBhi12dqx8Pqjbdmw
 i4Fd4Cwvr1pi1GI8UI8En9RiZI/3vlbhAmsIBFYC8cL77LmQheWX4/aZnH8dClkY9D57jgRM9Bh
 u4Up3kvN7t77mZAG9cIqpF0vxcIYCI4kHoM4mNn1GOSI0rGtd0cvAvSGRw6lsDy3xysxRtJ3pNt
 WbwbtDHqk0UxmmI4EAj8Cii+XhpIOtfaJNea5eWL+oKiEvWwXTPnd1tv1U6PI4NHadYlo6cH+UY
 kLp9jvMwR2FaXbfN2UomBv7eK8/k0sQgCl0bsERQikmjQaoKCo1Q6kEC1ss+g2Tj3PWF3jR6mBK
 iuhT56feTxYBaOZ7vYYF8+eB1qeIzuSLngPSLBZH8fQgY1AVJOPPcfqfRKTx5Euu35a6waAyOB/
 DWJFRovHZetJJXXuKg+8jT6Tz5zmeLtIBWTwoC3J+f4IZMMEJBPiMQP2dio2PQAxeXlVtU5OhJ3
 el5K1PKo6/j3EG9XSgOJtlK33R5iVd1RWYPQL0pPgMqZDxPGg0MwmcprIrjv5555KYA0i3956mo
 jszh4BkuzhauhyyuQJC7wA6ZilEVmvEf/rw778NXqElCmvPxfmdUfiCiOonhZcZ3xvzSROFxKZz
 VImNdypeeRk7V4g==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 10:01:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2796

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


