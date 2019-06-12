Received: by mail-wr1-f65.google.com with SMTP id x17so870790wrl.9
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2019 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URIjQjlNsfsd++fz6mDWEFYflv3utJwf4LriwUGZB6E=;
        b=QtQ+MywNZm1+H414cQze2NhNjWmLprgpwuPfcQlqhJBguTaodT9QmU2f86x39qs65s
         ucajjDhyBIXsPGIECLJXrNyaohTzRL0OXZoXyiaeGcdvvayDWfIRYiwW/N6TZHIfXSB1
         wCStKDfiW1DPdLwKbBBQgDJWPOMDx8Tb+pISnSAxvUbKfOAstl7p9cJNhr5zW016V4Ms
         9gWx//PCUwy/DhaXvQzJixR+9hyQ5qDYpTM8CpLZBvbDAOTFj3zfYPDlycQFriJGce/Z
         KXp5vEIURGQgqtqdLhpwekOEHhrmSPaT2zHI1XjoYBJ1fziWb4M58sKhtYlqaBJvf/a9
         vNSg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] ARM: meson: add unique MAC address generation
Date: Wed, 12 Jun 2019 11:49:07 +0200
Message-Id: <20190612094908.24858-3-narmstrong@baylibre.com>
In-Reply-To: <20190612094908.24858-1-narmstrong@baylibre.com>
References: <20190612094908.24858-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for generating an unique MAC address using the SoC internal
serial number from the Secure Monitor interface.

The algorithm generates an unicast locally administered 6bytes minus 2bits
address using an crc16 of the serial for the top 16bits with the lower 2 bits
masked to setup the unicast locally administered property and a crc24 for
the lower 24bits.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/eth.h |  3 +++
 arch/arm/include/asm/arch-meson/sm.h  |  3 +++
 arch/arm/mach-meson/board-common.c    | 31 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/eth.h b/arch/arm/include/asm/arch-meson/eth.h
index 08acc5cbf7..f765cd7c4c 100644
--- a/arch/arm/include/asm/arch-meson/eth.h
+++ b/arch/arm/include/asm/arch-meson/eth.h
@@ -19,4 +19,7 @@ enum {
  */
 void meson_eth_init(phy_interface_t mode, unsigned int flags);
 
+/* Generate an unique MAC address based on the HW serial */
+int meson_generate_serial_ethaddr(void);
+
 #endif /* __MESON_ETH_H__ */
diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
index a5bac5abda..60d04ae228 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -7,6 +7,9 @@
 #define __MESON_SM_H__
 
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
+
+#define SM_SERIAL_SIZE	12
+
 int meson_sm_get_serial(void *buffer, size_t size);
 
 #endif /* __MESON_SM_H__ */
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 8c41301674..18383f774e 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -7,6 +7,7 @@
 #include <asm/arch/boot.h>
 #include <linux/libfdt.h>
 #include <linux/err.h>
+#include <environment.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sm.h>
 #include <asm/armv8/mmu.h>
@@ -67,6 +68,36 @@ void meson_board_add_reserved_memory(void *fdt, u64 start, u64 size)
 	}
 }
 
+int meson_generate_serial_ethaddr(void)
+{
+	u8 mac_addr[ARP_HLEN];
+	char serial[SM_SERIAL_SIZE];
+	u32 sid;
+	u16 sid16;
+
+	if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
+		sid = crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
+		sid16 = crc16_ccitt(0, (unsigned char *)serial,	SM_SERIAL_SIZE);
+
+		/* Ensure the NIC specific bytes of the mac are not all 0 */
+		if ((sid & 0xffffff) == 0)
+			sid |= 0x800000;
+
+		/* Non OUI / registered MAC address */
+		mac_addr[0] = ((sid16 >> 8) & 0xfc) | 0x02;
+		mac_addr[1] = (sid16 >>  0) & 0xff;
+		mac_addr[2] = (sid >> 24) & 0xff;
+		mac_addr[3] = (sid >> 16) & 0xff;
+		mac_addr[4] = (sid >>  8) & 0xff;
+		mac_addr[5] = (sid >>  0) & 0xff;
+
+		eth_env_set_enetaddr("ethaddr", mac_addr);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
 static void meson_set_boot_source(void)
 {
 	const char *source;
-- 
2.21.0

