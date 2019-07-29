Received: by mail-wm1-f66.google.com with SMTP id s15so32181881wmj.3
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mndbx5rbQt3LUjArcWC9v7xyQgvrncxMbiMItnXPync=;
        b=KYvprysGEKvZOSyLLVJAdHTtZVlsJognE/VyeIWNnVWGrl6GM2r8pC/0DLzowwyqJi
         NX03HWEXweA0mh1icLYDljJ+ZUiyoprjJCsQQW9GAVPqQOzrxNmTPTqV7DHq5TbUvpme
         MngDQs6GgT49HsaOyXYw6V56D6xsflLFSDt5BSjQpeDGY2M8RlGUyrhqE3ljyU6mwnIg
         OdWpplyzaG86t7UVEIUTZ6LEsG34JD8+z0oZUu0GWzpbBPCPCX21S+zcDMEU3bqjuZPV
         /D+oc1NvQBqEF3h4C1UAkkZPslY19of+87niTEO2BVzWa5reI14exoqW2xK35CEMVa+s
         sY6Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/3] ARM: meson-g12a: Handle 4GiB DRAM size
Date: Mon, 29 Jul 2019 15:45:51 +0200
Message-Id: <20190729134552.8860-3-narmstrong@baylibre.com>
In-Reply-To: <20190729134552.8860-1-narmstrong@baylibre.com>
References: <20190729134552.8860-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

When configured with 4GiB DRAM size, only 3.8GiB is available, the
I/O beeing mapped in the last 256MiB of the first 4GiB physical memory/

First fixup the mm_region to handle the first 3.8GiB as memory and the
last 256MiB as I/O.

Then limit the real memory reported by the firmware to the available
physical space, 3.8GiB aligned with the mm_region memory zone size.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index 1652970fbd..546b9f6039 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -62,21 +62,21 @@ void meson_init_reserved_memory(void *fdt)
 phys_size_t get_effective_memsize(void)
 {
 	/* Size is reported in MiB, convert it in bytes */
-	return ((readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_MEM_SIZE_MASK)
-			>> G12A_AO_MEM_SIZE_SHIFT) * SZ_1M;
+	return min(((readl(G12A_AO_SEC_GP_CFG0) & G12A_AO_MEM_SIZE_MASK)
+			>> G12A_AO_MEM_SIZE_SHIFT) * SZ_1M, 0xf5000000);
 }
 
 static struct mm_region g12a_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
-		.size = 0x80000000UL,
+		.size = 0xf5000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
-		.virt = 0xf0000000UL,
-		.phys = 0xf0000000UL,
-		.size = 0x10000000UL,
+		.virt = 0xf5000000UL,
+		.phys = 0xf5000000UL,
+		.size = 0x0b000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
@@ -129,6 +129,7 @@ void meson_eth_init(phy_interface_t mode, unsigned int flags)
 			     G12A_ETH_REG_0_TX_RATIO(4) |
 			     G12A_ETH_REG_0_PHY_CLK_EN |
 			     G12A_ETH_REG_0_CLK_EN);
+		g12a_enable_external_mdio();
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
-- 
2.22.0

