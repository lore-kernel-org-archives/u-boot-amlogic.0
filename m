Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C02C3601D
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 12:34:59 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.19668.1726576492994273342
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Sep 2024 05:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Zh+/I7zT;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c180d123so2612659f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726576491; x=1727181291; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
        b=Zh+/I7zT3AU/vyIh46rBNCNfwokPwjnVr5B3ty9J2ZHbnw0O9xUbmKOzYCulzNNOXS
         33jSW0ZkrlBfBKSUKC9uEfVNgzBeARRhe/NJwzmjRRfRYB2LgBLtglC62EidY0zddaXb
         XGoWWArDrfF69Rsp8nS0xw8Rhg3m5+/ssr2g+uC5JILTAT4Yq6O84foIWsPBpB6DfsNN
         7HSr5txtpJRNMgXokLEwml0rMziV/2SKgXHqhQPeYakWlkDjZ9aiToaxwUgD0xgWM3eQ
         r2uVqmqAFfUOMCIDjF7DoIFvODjUu5S6mck1uihLBiMRKysmIjNamGYdPaHuh0d5jjvb
         fgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726576491; x=1727181291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
        b=gt22HhGS68ja+rkoyCtb/I9IGQYHs4cdWCVc1m9APYbt/bXZZIMv6ZJxZZRiYlTv6D
         Hs9CmDqNETbKAGMOtFTWWU6HgAupvD0afF9EvHBkre6tYaLrwZPXE55UGKyLwoy+MDxi
         JDsRaIhOgp8rkqLMrbsr0bMJaIGEaftwc/sGWvH0bi4bsMLO/2CRn4YaYYNrdrjmjqGI
         00qFUgr17W2PmWC7bPjE2COlWzfNkhqplswxO60oLOuF+mhxmRDTvpKUHbk5/J35SjFI
         MP2Df08zdZsdS78yhjjygvbeXp8V9vRUelKQ/urRVLirBrOTJGfRDJMxfx8qF6lVx6CX
         u2kQ==
X-Gm-Message-State: AOJu0Ywb4b4PK4horUWfYKit13NWqXRzoequ+SF0oqHQ1p0JX5YeH3Bf
	WjhMhg+uwLHkxo7AAg2VhUdEzksSwzky+IKm5EAU7i+XKdh9MV+PjMRDCsx2Isc=
X-Google-Smtp-Source: AGHT+IGAPcu9MP/RJTgChAijBhorhyksjW3VyrvPExXl7X7qlYFTzWCi+zZwYdnHMNNf8XuyxFjPSw==
X-Received: by 2002:a5d:4fc7:0:b0:374:c8dd:ea47 with SMTP id ffacd0b85a97d-378d6253618mr7621200f8f.50.1726576491083;
        Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:34:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Sep 2024 14:34:45 +0200
Subject: [PATCH v2 1/2] board: libretech-ac: move board support into
 dedicated directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-1-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PkfVFZOTXdUMNl5kZ51pRdlVcMTOlH1wQ6hn+etanQs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdnYz6f82WCIqUbu89MJrFSf11/WQgColC8lCjo
 CopY916JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3ZwAKCRB33NvayMhJ0aATD/
 43Fz2mKfTBggMmsmwiyhjlxJWtQYNefpUUz92IJzu/CY4jQTTzXKkUTj/UoP6MyDD5r4cHd9bsiB1i
 cAXSbSuWJRgeDRlENunenlaZLCkjBYB+76Qpj/Kxd281E3VrC42r9RS3UbhaBHrMSKYrywpe1H/wwE
 9o45TwORFuYJZiKwq2sVc6jEfqxtWYWf/NX/cvU7VkA7FUQt6JUMM0x3v2Co0lXfIk1bCk/exepVjl
 md/6SbT00gakp+5XJlAsmbFFSbckJHyp/Jx5cXgT+wTMIslo+AMOmmtj5/OC3fTylQa/PGaNJKjjqA
 tXPngOPiHMmjtcJdJULdh/V7hvCgZCQoREwU1bq7op5FAFLDX/ThtA9M49zyyjm1oyJbBQKajUj17S
 r/f67laF8USdUGAvWtpkIAYcp2ko9/NnhiDmpJvGCQnAV+L6b79+3mkI+g+OQkdzv4CrCZCjHvD2Fe
 0RhoERhOIqTzPwvTIaNjPBZMPCOA17GALhi1Dhbk4/Z+Mnq3oizRxn7V1u1diYJ/PpSixy3F36LtFU
 /J+qN7OGLpqR7ifvyx7g9l9Tl1a5BTpKzifbe99GoCd3whn4vRYeFUH87oyX7ZRPPwcQQwXcPNrM4j
 JMeT7mkP7eDARbq2QQhMheKHXd2dCKsfHMep4uIiNddkeKJvG440733al/1g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 12:34:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2392

The libretech-ac aka aml-s805x-ac supports mainline U-boot
from a dedicated SPI flash, move the board support into
a dedicated vendor/board subdirectory in order to support
vendor specific customization.

It also aligns with the vendor downstream changes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 ++++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 +++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 47 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  2 +
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index b2e3205fdf0..e73a4e52c1f 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -5,11 +5,9 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
 F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
-F:	configs/libretech-ac_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/libretech-cc_v2_defconfig
 F:	configs/p212_defconfig
 F:	doc/board/amlogic/p212.rst
-F:	doc/board/amlogic/libretech-ac.rst
 F:	doc/board/amlogic/libretech-cc.rst
 F:	doc/board/amlogic/khadas-vim.rst
diff --git a/board/libre-computer/aml-s805x-ac/MAINTAINERS b/board/libre-computer/aml-s805x-ac/MAINTAINERS
new file mode 100644
index 00000000000..7cbc08aeb6c
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/MAINTAINERS
@@ -0,0 +1,8 @@
+LIBRE-COMPUTER AML-S805X-AC
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/aml-s805x-ac/
+F:	include/configs/libretech-ac.h
+F:	configs/libretech-ac_defconfig
+F:	doc/board/amlogic/libretech-ac.rst
diff --git a/board/libre-computer/aml-s805x-ac/Makefile b/board/libre-computer/aml-s805x-ac/Makefile
new file mode 100644
index 00000000000..b4367ea522b
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= aml-s805x-ac.o
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
new file mode 100644
index 00000000000..ae9834c0bf8
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+#define EFUSE_SN_OFFSET		20
+#define EFUSE_SN_SIZE		16
+#define EFUSE_MAC_OFFSET	52
+#define EFUSE_MAC_SIZE		6
+
+int misc_init_r(void)
+{
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
+	ssize_t len;
+
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
+					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
+		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
+			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
+	}
+
+	if (!env_get("serial#")) {
+		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
+			EFUSE_SN_SIZE);
+		serial[len] = '\0';
+		if (len == EFUSE_SN_SIZE)
+			env_set("serial#", serial);
+	}
+
+	return 0;
+}
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 6ad04570022..11d9795e05d 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -1,5 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_CONFIG_NAME="libretech-ac"
+CONFIG_SYS_VENDOR="libre-computer"
+CONFIG_SYS_BOARD="aml-s805x-ac"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1

-- 
2.34.1


