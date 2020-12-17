Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.4759.1608190038394915034
 for <u-boot-amlogic@groups.io>;
 Wed, 16 Dec 2020 23:27:19 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201217072701euoutp021636b40d3c523f98b1c6463a16856221~RcE26iHlJ0873908739euoutp02q
	for <u-boot-amlogic@groups.io>; Thu, 17 Dec 2020 07:27:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201217072701euoutp021636b40d3c523f98b1c6463a16856221~RcE26iHlJ0873908739euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608190021;
	bh=6HXGVy0vs+JH5gQhNHksnoTv+uhTeIpuVxmsYjMg0PU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BUHBthbeiPSe9ZVm1/w0M9p1Z67GTgLJXyLACVS2OVs3KWjLF3KAearRWh1u0MfXg
	 Gg3yvZIl/74MLGPgi9LMUKBh0fBU4cAgTmPhvYW44XuKVa18SlkWDIHYVY0QfXPxwE
	 +DOUtq4DqcIqZV41yGW+OJGWhUBEHsEULX2RFfQE=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] board: amlogic: vim3: read ethernet MAC address from efuse
Date: Thu, 17 Dec 2020 08:26:42 +0100
Message-Id: <20201217072642.1319-1-m.szyprowski@samsung.com>
References: <CGME20201217072655eucas1p123aa0a548e4de21a8ac580dbc990c760@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Add the board specific code for reading built-in ethernet MAC address
from efuse.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 board/amlogic/vim3/vim3.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 09ef39ff30..a36df61583 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -11,6 +11,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/eth.h>
+#include <asm/arch/sm.h>
 #include <i2c.h>
 #include "khadas-mcu.h"
 
@@ -129,9 +130,27 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 
+#define EFUSE_MAC_OFFSET	0
+#define EFUSE_MAC_SIZE		6
+
 int misc_init_r(void)
 {
+	uint8_t mac_addr[EFUSE_MAC_SIZE];
+	ssize_t len;
+
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
 
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
+					  mac_addr, EFUSE_MAC_SIZE);
+		if (len != EFUSE_MAC_SIZE)
+			return 0;
+
+		if (is_valid_ethaddr(mac_addr))
+			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
+	}
+
 	return 0;
 }
-- 
2.17.1

