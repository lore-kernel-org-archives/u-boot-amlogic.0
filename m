Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318ACA5FBA
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2896.1790705253330044697
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=bIPgr3ru;
 spf=pass (domain: brivo.com, ip: 74.125.230.232, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166acdso353769185a.0
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705252; x=1791310052; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
        b=bIPgr3ruTlicJWpSYCtszaLCiNTgkx870kEd4k4shGUuMQmIINoWDWEKECHsf/JmLE
         uh/n+qegw0c50NSr+LONY2zucxVFMsC4ug8b0rJlk6liDyExwS3EhcZYezxoFzwiceCM
         svUQGyEqEdXjTBswAf5UUrShZmYZhh59h49mq8elAJBWPtMatjEUwmo++drOcNKwV8hc
         EBCXYADO4XfnC5UinYkZW7BAdHXZwWZYrUcBgokClV60K/qqdklopp29I5afbgq5EMyq
         YaztL9sDIRjUQXQOLAlRiA90UnEf0bqvrUwYK61btfg3WYl5kEIFk3TWOFwLwjqK9+Ae
         +ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705252; x=1791310052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
        b=p24LFEx+TieZwVEpa2mn+yrm0lp2Fgm7PMlA9njeOowBYqF2LLQs+IvxwkSjkS3dWL
         xXOaRBSORTaSRd6SKBN+TENYIAayHg0Xon201xqi73hiYl3BAeyif3DWfzD0dHaWl7eg
         uJlxdPGFZQE1t9TfGypZb7y9OeOagYvTZx0S7cF+FQfQhKkh54R5qI0+rkuur43cceBg
         CwTQbxTVsIUYEHvKG7dc2v74ZmZGLHuSZktjmFwtlMvrAw5cpm6MVGFTKnvu8etNaZ3V
         +o4PogAXcTHmAQfIM0PpfAs2zY1D7zQNwhlzInByNdHYZ2R2JubqDlus1125r/0wtTHq
         Fm3w==
X-Gm-Message-State: AFuF++mSkzPzQApOEemjocFDH0f49M4bPW1R/3gBavd4KJ/owPsgZ5iJ
	LzG1KmCKFDtXm4oCfmhrQsaX4n+Gcb+HUHvJzFW5DU4QnxeBPt6JRrlB6qiUg/2D9p8dZdBMT4Y
	h73abTVbv4GAraLchhFYkiNVOBITxfi64btphOB/D6dPKuNUUqYJUug==
X-Gm-Gg: AYBFou1eTdqB4xy+MX30vAwEEAc1Iby7JJovw9CAD8iZzrMMU9MzBT0W78O7juhE1Lu
	8T41PFtxLQiq5QGeemKYMct5V0PoXkH293VhDH87CcKYRpcywbeMEPwood2LgWbVbhlKVGKMytB
	jI3JGpXeJXOOeQC1mGiW4M3BHFdmNX2ClAUzK+uZ4CWd/vMgxjXHeYLnrx1iENm+h8f9Rr9T2yU
	570BXVHklKfOyY4xkQTassdxt6Q0dh6GtPyvIJAg2m8U9e+fD3etLkc3pYLSAZOFkm6Z9QQTz6O
	mVDZaRWhizGZJJS5Bhab+pRhIeQ2QRph8tthcCqDL7ZjK8ZSx0Lv1Xeou+LjNGw08ibZadjB2CL
	K7mmhaY8oTiYZpxf9HwYkToyTprSRHNIYPATC+kLQxbX+bkb2z95jAd4ov95TBcZ8n/LXFDmxuj
	rJR9T/YeiBhiPSutbhuSq28IfO2JuNchKiwL+5j/2KE7r7dwCTaGEBmx0nhFocdEvp
X-Received: by 2002:a05:620a:4384:b0:937:5ab5:53f7 with SMTP id af79cd13be357-93c9f8d51ddmr74015185a.43.1790705251989;
        Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 9/9] meson: Add Khadas VIM1S support
Date: Tue, 29 Sep 2026 14:06:31 -0400
Message-ID: <20260929180721.3440839-10-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3112

This adds basic support for the Khadas VIM1S [1]. I have tested the
following features when booting from the SD card:

- Distro boot
- SD card
- Ethernet (tested with TFTP)
- GPIO/ADC Buttons [*]
- RTC [*]

Features marked with [*] require v7.2 of dts/upstream. The following
features do not work:

- The eMMC scans properly but I can only read zeros. I've never seen
  this kind of failure before.
- The PWM LED does not seem to work [2].
- USB is not currently supported in upstream Linux, but I do have some
  patches for it locally (adapted from Khadas's tree). I will try to
  submit these at some point.
- I have made no attempt to get HDMI working.

I have submitted the stdout fix upstream as [3].

[1] https://www.khadas.com/vim1s
[2] https://lore.kernel.org/u-boot/20260929175239.3298566-1-sanderson@brivo.com
[3] https://lore.kernel.org/linux-arm-kernel/20260929163457.3237394-1-sanderson@brivo.com/

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- Use our own board instead of reusing q200
- Enable more peripherals (buttons, LEDs, etc.)
- Use defaults where possible (commands, distro boot, etc.)
- Set mac address the same way Khadas does
- Set config/stdout-path so we can find the serial

 .../meson-s4-s905y4-khadas-vim1s-u-boot.dtsi  |  5 ++
 board/amlogic/vim1s/MAINTAINERS               |  7 ++
 board/amlogic/vim1s/Makefile                  |  1 +
 board/amlogic/vim1s/vim1s.c                   | 26 ++++++++
 configs/khadas-vim1s_defconfig                | 66 +++++++++++++++++++
 5 files changed, 105 insertions(+)
 create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
 create mode 100644 board/amlogic/vim1s/MAINTAINERS
 create mode 100644 board/amlogic/vim1s/Makefile
 create mode 100644 board/amlogic/vim1s/vim1s.c
 create mode 100644 configs/khadas-vim1s_defconfig

diff --git a/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi b/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
new file mode 100644
index 00000000000..9dcc9391eae
--- /dev/null
+++ b/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
@@ -0,0 +1,5 @@
+/ {
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
diff --git a/board/amlogic/vim1s/MAINTAINERS b/board/amlogic/vim1s/MAINTAINERS
new file mode 100644
index 00000000000..f774f348e69
--- /dev/null
+++ b/board/amlogic/vim1s/MAINTAINERS
@@ -0,0 +1,7 @@
+VIM1S
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+R:	Sean Anderson <sanderson@brivo.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/vim1s/
+F:	configs/khadas-vim1s_defconfig
diff --git a/board/amlogic/vim1s/Makefile b/board/amlogic/vim1s/Makefile
new file mode 100644
index 00000000000..bc4b9dad861
--- /dev/null
+++ b/board/amlogic/vim1s/Makefile
@@ -0,0 +1 @@
+obj-y := vim1s.o
diff --git a/board/amlogic/vim1s/vim1s.c b/board/amlogic/vim1s/vim1s.c
new file mode 100644
index 00000000000..d58f3b6299d
--- /dev/null
+++ b/board/amlogic/vim1s/vim1s.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Brivo Inc.
+ */
+
+#include <env.h>
+#include <net-common.h>
+#include <asm/io.h>
+
+#define SYSCTRL_SEC_STATUS_REG18	0xfe010348
+
+int misc_init_r(void)
+{
+	/* This procedure copied from Khadas's downstream fork */
+	u32 val = readl(SYSCTRL_SEC_STATUS_REG18);
+	unsigned char addr[ARP_HLEN] = {
+		0x02,
+		0xad,
+		val >> 24,
+		0x01,
+		(val >> 8) & 0xff,
+		val & 0xff,
+	};
+
+	return eth_env_set_enetaddr("ethaddr", addr);
+}
diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
new file mode 100644
index 00000000000..af9d14644e0
--- /dev/null
+++ b/configs/khadas-vim1s_defconfig
@@ -0,0 +1,66 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim1s"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x0
+CONFIG_SYS_MALLOC_LEN=0x8000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_MESON_S4=y
+CONFIG_SYS_LOAD_ADDR=0x20000000
+CONFIG_IDENT_STRING=" vim1s"
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_ADC=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_RTC=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_LED=y
+CONFIG_LED_PWM=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PHY_MESON_GXL=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_S4=y
+CONFIG_DM_REGULATOR=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MESON=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_PCF8563=y
+CONFIG_BAUDRATE=888888
+CONFIG_MESON_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MESON_GXBB=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.53.0


