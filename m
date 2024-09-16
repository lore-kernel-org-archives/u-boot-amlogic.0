Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E480C3ABB2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:03 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.4802.1726479715827311875
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 02:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=J9KC9j4X;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso32643175e9.0
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726479714; x=1727084514; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
        b=J9KC9j4XabRd+zcLQgteCdWgK1O/BzSkDNBYcPH+mi9i3N2hCxKVT95FGEnGOrLF9c
         YCl0R9VNKlOAX1UI0SVqfICujiu6RegH4Ckl5GiBjWSelr/C/IEePVI2TE8E22QzhJZz
         +TAm0qUqnFbh4IEMrAaYIu5MX++tGj7iWhpivWCRnN1RWhNn2Pw061F9V6okUBmis4hh
         j3mXeU23BUZ24gqq5lRtj5b4Enh+jP/eAzZk3i3b8p5izFHQe9Syu3qDr3V9mu6a6yqd
         qEaTnkN59w95KfRa7fZA0h9FqOO4knwJrMuDLhDjtBdEEOr0H/uSPyXyktqcde8j188x
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726479714; x=1727084514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
        b=QRVA1S2AYGPRUx2B+De5do10slL9y4sPd9ZAABz4Ev0kOPCwTMk+DtJ2Ah3/zZNoXY
         a9OcKYDCzPDEp8J7C6VQAiL5WWhImvq0k5nwSRVLHnr9kg4PRsvmDlcNWgxLP8oIIBGg
         cciE9eVoZ0/LFTkMKFqMxc5roPL5TB6J53vInS+FiVdi9uznPAdn+Wxsn6qLTG1wZWmP
         HF0bcxJSeGQnCPQyoDk61eCcVN8DEr40j8fKmFM0iBHSPOyAm8wl2i4l5MTd6tpXXozV
         focBDwIoBJfUmxTwIuPRyhF0Xyqvi61O5d7VC1ZCZG6N84/Hkdw5JegGSwqyGAEob6tB
         vn1Q==
X-Gm-Message-State: AOJu0YwyvplVO0xNkL9Y/4h4mFzLngpG+tCbaJOfw7qdYKx4/VaTfZd/
	jiixU0uVUDqgJfWV6DqOI/aQk4MC0mZzbvAXklVuJwLyR954DskNydJWPfYkCxM=
X-Google-Smtp-Source: AGHT+IHuQii3EgUXYI2mGoZJ2CkIGFLYqdQgScbm2KR9vg1CPOy5mwIYZ/BO/tUnqDphivsIC6HhzA==
X-Received: by 2002:a05:600c:4e87:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-42cbddcefd1mr132381365e9.7.1726479713594;
        Mon, 16 Sep 2024 02:41:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:41:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 11:41:48 +0200
Subject: [PATCH 1/2] board: libretech-ac: move board support into dedicated
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-1-7e4f48542a0f@linaro.org>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PkfVFZOTXdUMNl5kZ51pRdlVcMTOlH1wQ6hn+etanQs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1f6aRlN14iJL7c1sDv5qCCyozqru4Q5zrm6+23
 bhtieFGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XwAKCRB33NvayMhJ0QmiD/
 0cQGOKPkqX6cU0x9QJJO5kgeLxEWNCMmiaXRq+A2aNCQ+fs8HZdkCoeFGXp0G1UfOml8WdHK5x6lOi
 5OffvM9k6XMNZAeHIE2hnoVEB44DlwfS3vOF1TA/YZF34KOmaCXetlguh1CCe5fmsPYHioItcckNK9
 6fZd6LZ926SYgSZ0hoMkDNVehzNWM4x1za8B55gfVGlZ1G7eyz1NL3mQB2dwApKBGB8Z8Qk+KXkdvr
 m1w90E1RJD8rDrR65439Ile8kz6hWKqKSKCbQcXbyAEo/5YwHGTHGoVQ0P+V5/2SY5quPuoK1XaE5F
 wOXiNhhLzKCJm1ZFi1JC8ThN2n0wFCAvg3bv/NjQejJ1icKzhFD8EmYZH/N5wAVRC6O9rcnnSTzEv7
 rMbgJ6gUDhcHWYa+0qtUPwaD98HrpbedfOyvdHvQhkpUKyAQb6TeduMIdmwnn8MdyxGetcR/14gWiP
 FKXMC/AZ7mmvBa2Vi60qtMoOkbepcYH+o8W9JTCaYfct9gVcKVxNbyLYBnWTny7rmXbO92CfHm1jf0
 J/9/w90cslrXf/oB3/OdQ8MbQhgWwlNKs41cq2nlbmc+Nmp1uM0PNY84db/3brrA1WLJyHvALwpT3Y
 n/1/jzeknh4zYPpP+G2RQ5h3Pz6hbmV0dyG4mI915l8LKYgzL9j7EmAuIh/w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 09:42:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2388

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


