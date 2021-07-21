Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web12.773.1626848359636358204
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Jul 2021 23:19:19 -0700
Received: by mail-pg1-f172.google.com with SMTP id r21so894445pgv.13
        for <u-boot-amlogic@groups.io>; Tue, 20 Jul 2021 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MhAsZ8VCXI0f2xxk15CTJFd4NBoMiTgL9GgPwLwWcmU=;
        b=V7axgiBkIH+6QKBe3mWLBTnxYJK7PTwoH3RHs/wQYuZOtmYHiwuvnIvKLOZV6EMkkm
         WjsbLZrKgMnzA9nDAePzt406sWeWqeGjaRBx97goDpn3up4jE9sy4U4FDC1NMCQHtM/5
         /+vtG2ngBL+KbaGiX1XxVpfala9GcvN9WIWfhLAVWwYywIUjijahWDjGjUsiLgiEs3RM
         Zh556lKrkTCj2XLZOw/aKJ2jaNhN8aI8y6PDyP5kT/uJhqtwcdS7K4dxW7YK8UJo2LIo
         QIgTObS14IrbSq27tYOPF/4BX9YMLCT3eB4ObrCG0ImW/s0j+GZ/BP66DTSlLLYIxis8
         GaCQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] net: designware: improve ethernet DMA reset
Date: Wed, 21 Jul 2021 14:19:10 +0800
Message-Id: <20210721061910.776977-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com, joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Problem: uboot ethernet always have "DMA reset timeout" after
linux usage, detected on VIM2 VIM3 VIM3L amlogic devices,
mainline uboot and mainline linux > 5.1? .

How-to reproduce:

1) Poweron device => ethernet uboot work fine.
2) Linux start and ethernet interface up and same works.
3) Reboot to uboot again and we cant use ethernet anymore.
uboot always have "DMA reset timeout" inside designware_eth_init()
only poweroff/poweron cycle can solve this problem.

Solution: add phy_reset() into waiting DMA reset cycle,
this insertion doesn't break normal behaviour (maybe).

Note: same need explore real problem why its happens! because this 
patch may be just hack.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/net/designware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 5d92257e..6485c46d 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -371,6 +371,7 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
 	struct eth_dma_regs *dma_p = priv->dma_regs_p;
 	unsigned int start;
 	int ret;
+	int phy_reset_force = 0;
 
 	writel(readl(&dma_p->busmode) | DMAMAC_SRST, &dma_p->busmode);
 
@@ -389,6 +390,9 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
 			printf("DMA reset timeout\n");
 			return -ETIMEDOUT;
 		}
+		// forced phy reset after 0.2s can help with DMAMAC_SRST
+		if (phy_reset_force++ == 2)
+			phy_reset(priv->phydev);
 
 		mdelay(100);
 	};
-- 
2.25.1

