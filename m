Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B8C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 08:32:13 +0000 (UTC)
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by mx.groups.io with SMTP id smtpd.web10.2268.1707781485060362701
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Feb 2024 15:44:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@canonical.com header.s=20210705 header.b=wVSmZqiN;
 spf=pass (domain: canonical.com, ip: 185.125.188.121, mailfrom: heinrich.schuchardt@canonical.com)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 03EDB3FE92;
	Mon, 12 Feb 2024 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707781482;
	bh=mB8P2p4xehFPfs5Qn71qtVXYBxmTSZuPg5NOcgWPnBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=wVSmZqiNg0+I+eN1557wo21E/mPivj1K8nidb3yJ2jcCWNP0WiR6NQAXkdp32TZm6
	 Np/GaQUeGJICGH9XMYIDQ4q8L5J5FQfh0nmebHKG4RaNWP4aVfiN3bo2JLyp8QIm8H
	 NbnAHdv+xynNs6WPn813vULzCbH/M7K11MbbGjb4hx6Hfi3hmUj1Tpam3yVeRYzn3v
	 f7VrIM7wLNptc513oz/qBLsLayJJTPe5EIOk6WJSMPPvQCNLeyzpWT3uSjzSKBDciR
	 SZxQ0ye17CcWpDfLVFFgZ/Pu+J6cUgtmsgFc8HafCDNiq+b9I2gHDoYhiwiBiEowSI
	 mq92MiQpziJ8g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Kovacic <luka.kovacic@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Simon Glass <sjg@chromium.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Etienne Carriere <etienne.carriere@linaro.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexey Romanov <avromanov@salutedevices.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Lin Jinhan <troy.lin@rock-chips.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Grzegorz Szymaszek <gszymaszek@short.pl>,
	u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rng: eliminate common.h include from RNG drivers
Date: Tue, 13 Feb 2024 00:44:47 +0100
Message-ID: <20240212234448.39552-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 13 Feb 2024 08:32:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2124

Usage of common.h is deprecated.

* Remove common.h from RNG drivers.
* Sort includes.
* Add time.h to sandbox driver.
* Add linux/types.h to rng.h to provide size_t.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rng/arm_rndr.c     | 3 +--
 drivers/rng/iproc_rng200.c | 3 +--
 drivers/rng/meson-rng.c    | 1 -
 drivers/rng/msm_rng.c      | 5 ++---
 drivers/rng/npcm_rng.c     | 1 -
 drivers/rng/optee_rng.c    | 2 --
 drivers/rng/rng-uclass.c   | 1 -
 drivers/rng/rockchip_rng.c | 6 +++---
 drivers/rng/sandbox_rng.c  | 3 +--
 drivers/rng/smccc_trng.c   | 1 -
 drivers/rng/stm32_rng.c    | 4 +---
 include/rng.h              | 2 ++
 12 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
index 4512330e68..bf54aec4f1 100644
--- a/drivers/rng/arm_rndr.c
+++ b/drivers/rng/arm_rndr.c
@@ -9,11 +9,10 @@
=20
 #define LOG_CATEGORY UCLASS_RNG
=20
-#include <common.h>
 #include <dm.h>
-#include <linux/kernel.h>
 #include <rng.h>
 #include <asm/system.h>
+#include <linux/kernel.h>
=20
 #define DRIVER_NAME	"arm-rndr"
=20
diff --git a/drivers/rng/iproc_rng200.c b/drivers/rng/iproc_rng200.c
index 85ac15bf9c..4c49aa9e44 100644
--- a/drivers/rng/iproc_rng200.c
+++ b/drivers/rng/iproc_rng200.c
@@ -5,11 +5,10 @@
  * Driver for Raspberry Pi hardware random number generator
  */
=20
-#include <common.h>
 #include <dm.h>
-#include <linux/delay.h>
 #include <rng.h>
 #include <asm/io.h>
+#include <linux/delay.h>
=20
 #define usleep_range(a, b) udelay((b))
=20
diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
index fd2988e91b..49037d1165 100644
--- a/drivers/rng/meson-rng.c
+++ b/drivers/rng/meson-rng.c
@@ -5,7 +5,6 @@
  * Driver for Amlogic hardware random number generator
  */
=20
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <rng.h>
diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
index 29e7354ece..658c153d3e 100644
--- a/drivers/rng/msm_rng.c
+++ b/drivers/rng/msm_rng.c
@@ -9,12 +9,11 @@
  * Based on Linux driver
  */
=20
-#include <asm/io.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
-#include <linux/bitops.h>
 #include <rng.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
=20
 /* Device specific register offsets */
 #define PRNG_DATA_OUT		0x0000
diff --git a/drivers/rng/npcm_rng.c b/drivers/rng/npcm_rng.c
index 70c1c032b6..3922acad5b 100644
--- a/drivers/rng/npcm_rng.c
+++ b/drivers/rng/npcm_rng.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
=20
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <rng.h>
diff --git a/drivers/rng/optee_rng.c b/drivers/rng/optee_rng.c
index 410dfc053f..f692681022 100644
--- a/drivers/rng/optee_rng.c
+++ b/drivers/rng/optee_rng.c
@@ -4,8 +4,6 @@
  */
 #define LOG_CATEGORY UCLASS_RNG
=20
-#include <common.h>
-
 #include <rng.h>
 #include <tee.h>
 #include <dm/device.h>
diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
index 53108e1b31..06ddfa14ac 100644
--- a/drivers/rng/rng-uclass.c
+++ b/drivers/rng/rng-uclass.c
@@ -5,7 +5,6 @@
=20
 #define LOG_CATEGORY UCLASS_RNG
=20
-#include <common.h>
 #include <dm.h>
 #include <rng.h>
=20
diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 705b424cf3..ce5cbee30a 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -2,14 +2,14 @@
 /*
  * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
  */
+
+#include <dm.h>
+#include <rng.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/io.h>
-#include <common.h>
-#include <dm.h>
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
 #include <linux/string.h>
-#include <rng.h>
=20
 #define RK_HW_RNG_MAX 32
=20
diff --git a/drivers/rng/sandbox_rng.c b/drivers/rng/sandbox_rng.c
index cc5e1f6e25..071a3228e8 100644
--- a/drivers/rng/sandbox_rng.c
+++ b/drivers/rng/sandbox_rng.c
@@ -3,11 +3,10 @@
  * Copyright (c) 2019, Linaro Limited
  */
=20
-#include <common.h>
 #include <dm.h>
 #include <rand.h>
 #include <rng.h>
-
+#include <time.h>
 #include <linux/string.h>
=20
 static int sandbox_rng_read(struct udevice *dev, void *data, size_t len)
diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
index 3a4bb33941..5bb7ebe8a4 100644
--- a/drivers/rng/smccc_trng.c
+++ b/drivers/rng/smccc_trng.c
@@ -5,7 +5,6 @@
=20
 #define LOG_CATEGORY UCLASS_RNG
=20
-#include <common.h>
 #include <dm.h>
 #include <linker_lists.h>
 #include <log.h>
diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index c397b4d95c..61d5ed6158 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -5,16 +5,14 @@
=20
 #define LOG_CATEGORY UCLASS_RNG
=20
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
 #include <reset.h>
 #include <rng.h>
+#include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-
-#include <asm/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
=20
diff --git a/include/rng.h b/include/rng.h
index 37af554363..87e26f5647 100644
--- a/include/rng.h
+++ b/include/rng.h
@@ -6,6 +6,8 @@
 #if !defined _RNG_H_
 #define _RNG_H_
=20
+#include <linux/types.h>
+
 struct udevice;
=20
 /**
--=20
2.43.0


