Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B5CAC591
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 18:13:53 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
 by mx.groups.io with SMTP id smtpd.web11.26240.1757528029668457924
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 11:13:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=ofGe4W2p;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.189, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757528028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4HKzf41yblwb5ZEi3hIbNyvurngWxBH+txeqauhEWc=;
	b=ofGe4W2pPUdohn4qlvl1r+lTeTob1xpmRCzyLXBNPYd8Pn3QBuCaeD0asgs83PTV0WelX9
	Vwd9okgVb2NEts35iu+cnkd54XtZV/wFAwEAaVLSUj9UK/u5KtInL+Y/Tvty8KkUEmMk7A
	Bl7WkaMQGuvZC1Nvm97K306fxvTHRkkBZuyVDF48A1p7g0cjbYPHuOBycNldSIIxCP4hlV
	SgOBXnd3X1FZ7ZvMcOGvneipF1DJtr6XjouPBlKodcdECXdGY7SoOO/jIMuXXa/2BYvd2b
	KF8df6PUPFhc06zdEsanZ9YPvYlII50aVmS8bS7IYnrWRahlEdbSO1YCM9osyg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 10 Sep 2025 18:13:27 +0000
Subject: [PATCH RFC v2 7/8] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250910-spl-gx-v2-7-8f52aac47e04@postmarketos.org>
References: <20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org>
In-Reply-To: <20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org>
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
 b=kA0DAAoBhK/L0NeJmgMByyZiAGjBv9KjIn34qvUT5Ja/irkeQ+myMm0xnr3VKH875pHJ3Y7Wq
 4kCMwQAAQoAHRYhBAMBvDf7VVys/XmL7oSvy9DXiZoDBQJowb/SAAoJEISvy9DXiZoDNsQP/i32
 TBevWezByKn6WbLFQZ+d5P4b8LsW6IJIRpL9CwVNILSaFTeDp+hfeKmY8RkphmaNQxAnAt5HZnb
 DB2ysrWDDfNi1l2mXvdnvW+BzdqS0knvWkcqn7TGiQPx9/HS4GUMb+PYwD1tscyb0VHZuuwW49d
 iHoQiFdChlP1EdUCjugH+W5Z4HxGgVzy22vVY1sBrOXefprD4fkHfO1j/0RScDvQqAj2cf6uJ6l
 iE8IPr/LUtXdNxnKav6vSnyLVQmKLHaSyPZaS7CBGtzhxwggjsoi27vF+1z9wWDUy5zAqa0i1ZS
 zMObJTNRk648o5NYPZvh+kGmdBZ8yO8EeSAc4y1L//RVQlJvIcyqIvDe7PbFEpWVgHe43ILW4Di
 XmfT25XJTZsDRxUxLT5AuWwpuFjqxJyVtIjnxlxHC+bZJoVYm4AnrYcKDUeMo5dFdDAR2GnQ305
 lYUzETtu5+frc5o9baNuUibtDcT4t4tQg885NT1GRKMFb2lwxmxLztuiDR8aa2/bQtlLsC0JsHI
 W1u795NRTU5N0zOfJhK+x/tp6jZRMQMU8HAVc6TwpEa1IIC12qMRJxLFsT9O68E1jc8wZw0J+GP
 7TXHrV3fy6Cwe8TU+0ApmJPFbawjQKRYvgTkvAQnPArqRI1OVqdnjNDyRfzJx1ufHNdCVx9IoKU
 73Su2
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 18:13:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2771

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


