Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web10.30058.1641811613251255995
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Jan 2022 02:46:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1641811609;
	bh=QPW8rTEz//ifQg699nvzbwuA1zn6CYdH1AVGWYi0w3E=;
	h=From:To:Cc:Subject:Date:From;
	b=LZ7ZOUY3llF8ArLXP7CodIG5BJYkRDTLoZhWom7dkhgZKTltxc1Or0PGhkfzhWMTf
	 IDHMCePzJeYVtecyNKj6Niy92b3rtFBMCN1BLDDJE8ieFhrcI3ScsX7RZIfwjvUK1G
	 mSHpScdtgpZqlPWZy3L1lKIGrwUb3wW/cfjpLWspbNoGyJ2XM4H4G1Ka2XWV8qXUIo
	 nChxY1+sdFcSBiJCuKq1420z7SLCKgebYpp0RQOI2FxRNGAD/moneGveD0YGheyCmV
	 mW3JANJYwWpqK3YpVhRAhXdTNCLT7TlaYuk8wq/tm3mMKnC4hHsKITpG1zKoMZBzTY
	 wz5oJFF3/IDNg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-dm v2] fdt_support: Add fdt_for_each_node_by_compatible() helper macro
Date: Mon, 10 Jan 2022 11:46:39 +0100
Message-Id: <20220110104639.13744-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, Tom Warren <twarren@nvidia.com>, Aaron Williams <awilliams@marvell.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, York Sun <yorksun@freescale.com>, Priyanka Jain <priyanka.jain@nxp.com>, Oliver Graute <oliver.graute@kococonnector.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Biwen Li <biwen.li@nxp.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Anji J <anji.jagarlmudi@nxp.com>, Michael Walle <michael@walle.cc>, Stefan Roese <sr@denx.de>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>, Vladimir Oltean <vladimir.oltean@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>, Igal Liberman <igall@marvell.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

From: Marek Beh=C3=BAn <marek.behun@nic.cz>

Add macro fdt_for_each_node_by_compatible() to allow iterating over
fdt nodes by compatible string.

Convert various usages of
    off =3D fdt_node_offset_by_compatible(fdt, start, compat);
    while (off > 0) {
        code();
        off =3D fdt_node_offset_by_compatible(fdt, off, compat);
    }
and similar, to
    fdt_for_each_node_by_compatible(off, fdt, start, compat)
        code();

Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
Reviewed-by: Stefan Roese <sr@denx.de>
---
Simon, as in v1, this applies on top of marvell/next and we have another
patch for marvell/next that depends on this.
Could we let him apply it there after it is reviewed?
Thanks.

Changes since v1:
- removed extra space after macro name:
    fdt_for_each_node_by_compatible (...)
  to
    fdt_for_each_node_by_compatible(...)
  as requested by Stefan
---
 arch/arm/cpu/armv8/fsl-layerscape/fdt.c    |  9 ++-------
 arch/arm/cpu/armv8/fsl-layerscape/icid.c   |  5 +----
 arch/arm/mach-tegra/gpu.c                  |  5 +----
 arch/mips/mach-octeon/octeon_fdt.c         | 11 ++---------
 arch/powerpc/cpu/mpc85xx/liodn.c           |  9 ++-------
 board/Marvell/octeon_ebb7304/board.c       |  9 +++------
 board/congatec/cgtqmx8/spl.c               |  7 ++-----
 board/freescale/lx2160a/lx2160a.c          |  5 +----
 common/fdt_support.c                       | 22 ++++++++--------------
 drivers/misc/fsl_portals.c                 |  6 +-----
 drivers/net/fm/fdt.c                       |  3 +--
 drivers/pci/pcie_layerscape_fixup_common.c | 12 ++----------
 drivers/phy/marvell/comphy_a3700.c         | 10 +++++-----
 drivers/video/meson/simplefb_common.c      |  7 ++-----
 drivers/video/sunxi/simplefb_common.c      |  5 ++---
 include/fdt_support.h                      |  6 ++++++
 16 files changed, 41 insertions(+), 90 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c b/arch/arm/cpu/armv8=
/fsl-layerscape/fdt.c
index 4ec0dbf516..85c7b1f46b 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
@@ -161,14 +161,9 @@ void fsl_fdt_disable_usb(void *blob)
 	 * controller is used, SYSCLK must meet the additional requirement
 	 * of 100 MHz.
 	 */
-	if (CONFIG_SYS_CLK_FREQ !=3D 100000000) {
-		off =3D fdt_node_offset_by_compatible(blob, -1, "snps,dwc3");
-		while (off !=3D -FDT_ERR_NOTFOUND) {
+	if (CONFIG_SYS_CLK_FREQ !=3D 100000000)
+		fdt_for_each_node_by_compatible(off, blob, -1, "snps,dwc3")
 			fdt_status_disabled(blob, off);
-			off =3D fdt_node_offset_by_compatible(blob, off,
-							    "snps,dwc3");
-		}
-	}
 }
=20
 #ifdef CONFIG_HAS_FEATURE_GIC64K_ALIGN
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv=
8/fsl-layerscape/icid.c
index 82c5a8b123..25cd82f16e 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -116,8 +116,7 @@ void fdt_fixup_fman_port_icid_by_compat(void *blob, i=
nt smmu_ph,
 	int noff, len, icid;
 	const u32 *prop;
=20
-	noff =3D fdt_node_offset_by_compatible(blob, -1, compat);
-	while (noff > 0) {
+	fdt_for_each_node_by_compatible(noff, blob, -1, compat) {
 		prop =3D fdt_getprop(blob, noff, "cell-index", &len);
 		if (!prop) {
 			printf("WARNING missing cell-index for fman port\n");
@@ -137,8 +136,6 @@ void fdt_fixup_fman_port_icid_by_compat(void *blob, i=
nt smmu_ph,
 		}
=20
 		fdt_set_iommu_prop(blob, noff, smmu_ph, (u32 *)&icid, 1);
-
-		noff =3D fdt_node_offset_by_compatible(blob, noff, compat);
 	}
 }
=20
diff --git a/arch/arm/mach-tegra/gpu.c b/arch/arm/mach-tegra/gpu.c
index 13ffade040..36538e7f96 100644
--- a/arch/arm/mach-tegra/gpu.c
+++ b/arch/arm/mach-tegra/gpu.c
@@ -46,11 +46,8 @@ int tegra_gpu_enable_node(void *blob, const char *comp=
at)
 	if (!_configured)
 		return 0;
=20
-	offset =3D fdt_node_offset_by_compatible(blob, -1, compat);
-	while (offset !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(offset, blob, -1, compat)
 		fdt_status_okay(blob, offset);
-		offset =3D fdt_node_offset_by_compatible(blob, offset, compat);
-	}
=20
 	return 0;
 }
diff --git a/arch/mips/mach-octeon/octeon_fdt.c b/arch/mips/mach-octeon/o=
cteon_fdt.c
index 199f692516..5c5a14e87a 100644
--- a/arch/mips/mach-octeon/octeon_fdt.c
+++ b/arch/mips/mach-octeon/octeon_fdt.c
@@ -424,12 +424,8 @@ void __octeon_fixup_fdt_mac_addr(void)
 		}
=20
 	/* Assign 78XX addresses in the order they appear in the device tree. *=
/
-	node =3D fdt_node_offset_by_compatible(working_fdt, -1, "cavium,octeon-=
7890-bgx-port");
-	while (node !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(node, working_fdt, -1, "cavium,octeon-7=
890-bgx-port")
 		octeon_set_one_fdt_mac(node, &mac);
-		node =3D fdt_node_offset_by_compatible(working_fdt, node,
-						     "cavium,octeon-7890-bgx-port");
-	}
 }
 #endif
=20
@@ -450,11 +446,8 @@ void __octeon_fixup_fdt_uart(void)
 	/* Device trees already have good values for fast simulator
 	 * output, real boards need the correct value.
 	 */
-	node =3D fdt_node_offset_by_compatible(working_fdt, -1, "cavium,octeon-=
3860-uart");
-	while (node !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(node, working_fdt, -1, "cavium,octeon-3=
860-uart")
 		fdt_setprop_inplace_cell(working_fdt, node, "clock-frequency", clk);
-		node =3D fdt_node_offset_by_compatible(working_fdt, node, "cavium,octe=
on-3860-uart");
-	}
 }
=20
 /**
diff --git a/arch/powerpc/cpu/mpc85xx/liodn.c b/arch/powerpc/cpu/mpc85xx/=
liodn.c
index e552378e78..a084002494 100644
--- a/arch/powerpc/cpu/mpc85xx/liodn.c
+++ b/arch/powerpc/cpu/mpc85xx/liodn.c
@@ -268,15 +268,10 @@ static void fdt_fixup_pci_liodn_offsets(void *fdt, =
const char *compat,
 	 * Count the number of pci nodes.
 	 * It's needed later when the interleaved liodn offsets are generated.
 	 */
-	off =3D fdt_node_offset_by_compatible(fdt, -1, compat);
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, compat)
 		pci_cnt++;
-		off =3D fdt_node_offset_by_compatible(fdt, off, compat);
-	}
=20
-	for (off =3D fdt_node_offset_by_compatible(fdt, -1, compat);
-	     off !=3D -FDT_ERR_NOTFOUND;
-	     off =3D fdt_node_offset_by_compatible(fdt, off, compat)) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, compat) {
 		base_liodn =3D fdt_getprop(fdt, off, "fsl,liodn", &rc);
 		if (!base_liodn) {
 			char path[64];
diff --git a/board/Marvell/octeon_ebb7304/board.c b/board/Marvell/octeon_=
ebb7304/board.c
index c6c7c13483..eb7bf7aeb4 100644
--- a/board/Marvell/octeon_ebb7304/board.c
+++ b/board/Marvell/octeon_ebb7304/board.c
@@ -103,9 +103,7 @@ static int get_lmac_fdt_node(const void *fdt, int sea=
rch_node, int search_bgx, i
 	int parent;
=20
 	/* Iterate through all bgx ports */
-	node =3D -1;
-	while ((node =3D fdt_node_offset_by_compatible((void *)fdt, node,
-						     compat)) >=3D 0) {
+	fdt_for_each_node_by_compatible(node, (void *)fdt, -1, compat) {
 		/* Get the node and bgx from the physical address */
 		parent =3D fdt_parent_offset(fdt, node);
 		reg =3D fdt_getprop(fdt, parent, "reg", &len);
@@ -146,9 +144,8 @@ static int get_mix_fdt_node(const void *fdt, int sear=
ch_node, int search_index)
 	int node;
=20
 	/* Iterate through all the mix fdt nodes */
-	node =3D -1;
-	while ((node =3D fdt_node_offset_by_compatible((void *)fdt, node,
-						     "cavium,octeon-7890-mix")) >=3D 0) {
+	fdt_for_each_node_by_compatible(node, (void *)fdt, node,
+					"cavium,octeon-7890-mix") {
 		int parent;
 		int len;
 		const char *name;
diff --git a/board/congatec/cgtqmx8/spl.c b/board/congatec/cgtqmx8/spl.c
index 37b7221c52..492446e1de 100644
--- a/board/congatec/cgtqmx8/spl.c
+++ b/board/congatec/cgtqmx8/spl.c
@@ -29,13 +29,10 @@ void spl_board_init(void)
 			continue;
 	}
=20
-	offset =3D fdt_node_offset_by_compatible(gd->fdt_blob, -1, "nxp,imx8-pd=
");
-	while (offset !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(offset, gd->fdt_blob, -1,
+					"nxp,imx8-pd")
 		lists_bind_fdt(gd->dm_root, offset_to_ofnode(offset),
 			       NULL, NULL, true);
-		offset =3D fdt_node_offset_by_compatible(gd->fdt_blob, offset,
-						       "nxp,imx8-pd");
-	}
=20
 	uclass_find_first_device(UCLASS_POWER_DOMAIN, &dev);
=20
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/freescale/lx2160a/=
lx2160a.c
index bda665624d..c9835f9299 100644
--- a/board/freescale/lx2160a/lx2160a.c
+++ b/board/freescale/lx2160a/lx2160a.c
@@ -123,8 +123,7 @@ int board_fix_fdt(void *fdt)
 	if (IS_SVR_REV(get_svr(), 1, 0))
 		return 0;
=20
-	off =3D fdt_node_offset_by_compatible(fdt, -1, "fsl,lx2160a-pcie");
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, "fsl,lx2160a-pcie") {
 		fdt_setprop(fdt, off, "compatible", "fsl,ls-pcie",
 			    strlen("fsl,ls-pcie") + 1);
=20
@@ -166,8 +165,6 @@ int board_fix_fdt(void *fdt)
 		}
=20
 		fdt_setprop(fdt, off, "reg-names", reg_names, names_len);
-		off =3D fdt_node_offset_by_compatible(fdt, off,
-						    "fsl,lx2160a-pcie");
 	}
=20
 	return 0;
diff --git a/common/fdt_support.c b/common/fdt_support.c
index b2ba0825df..7579ca05d4 100644
--- a/common/fdt_support.c
+++ b/common/fdt_support.c
@@ -371,12 +371,9 @@ void do_fixup_by_compat(void *fdt, const char *compa=
t,
 		debug(" %.2x", *(u8*)(val+i));
 	debug("\n");
 #endif
-	off =3D fdt_node_offset_by_compatible(fdt, -1, compat);
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, compat)
 		if (create || (fdt_get_property(fdt, off, prop, NULL) !=3D NULL))
 			fdt_setprop(fdt, off, prop, val, len);
-		off =3D fdt_node_offset_by_compatible(fdt, off, compat);
-	}
 }
=20
 void do_fixup_by_compat_u32(void *fdt, const char *compat,
@@ -996,10 +993,9 @@ void fdt_fixup_mtdparts(void *blob, const struct nod=
e_info *node_info,
=20
 	for (i =3D 0; i < node_info_size; i++) {
 		idx =3D 0;
-		noff =3D -1;
=20
-		while ((noff =3D fdt_node_offset_by_compatible(blob, noff,
-						node_info[i].compat)) >=3D 0) {
+		fdt_for_each_node_by_compatible(noff, blob, -1,
+						node_info[i].compat) {
 			const char *prop;
=20
 			prop =3D fdt_getprop(blob, noff, "status", NULL);
@@ -1473,14 +1469,12 @@ out:
 int fdt_node_offset_by_compat_reg(void *blob, const char *compat,
 					phys_addr_t compat_off)
 {
-	int len, off =3D fdt_node_offset_by_compatible(blob, -1, compat);
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	int len, off;
+
+	fdt_for_each_node_by_compatible(off, blob, -1, compat) {
 		const fdt32_t *reg =3D fdt_getprop(blob, off, "reg", &len);
-		if (reg) {
-			if (compat_off =3D=3D fdt_translate_address(blob, off, reg))
-				return off;
-		}
-		off =3D fdt_node_offset_by_compatible(blob, off, compat);
+		if (reg && compat_off =3D=3D fdt_translate_address(blob, off, reg))
+			return off;
 	}
=20
 	return -FDT_ERR_NOTFOUND;
diff --git a/drivers/misc/fsl_portals.c b/drivers/misc/fsl_portals.c
index 02bc3f86ca..59df57a9ac 100644
--- a/drivers/misc/fsl_portals.c
+++ b/drivers/misc/fsl_portals.c
@@ -208,8 +208,7 @@ void fdt_fixup_qportals(void *blob)
 			     maj, min, ip_cfg) + 1;
 	compat_len +=3D sprintf(compat + compat_len, "fsl,qman-portal") + 1;
=20
-	off =3D fdt_node_offset_by_compatible(blob, -1, "fsl,qman-portal");
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, blob, -1, "fsl,qman-portal") {
 #if defined(CONFIG_PPC) || defined(CONFIG_ARCH_LS1043A) || \
 defined(CONFIG_ARCH_LS1046A)
 #ifdef CONFIG_FSL_CORENET
@@ -295,9 +294,6 @@ err:
 			       fdt_strerror(err));
 			return;
 		}
-
-		off =3D fdt_node_offset_by_compatible(blob, off,
-						    "fsl,qman-portal");
 	}
 }
=20
diff --git a/drivers/net/fm/fdt.c b/drivers/net/fm/fdt.c
index 3855d7d58f..9828753412 100644
--- a/drivers/net/fm/fdt.c
+++ b/drivers/net/fm/fdt.c
@@ -115,8 +115,7 @@ void fdt_fixup_fman_firmware(void *blob)
 	}
=20
 	/* Find all other Fman nodes and point them to the firmware node. */
-	while ((fmnode =3D fdt_node_offset_by_compatible(blob, fmnode,
-		"fsl,fman")) > 0) {
+	fdt_for_each_node_by_compatible(fmnode, blob, fmnode, "fsl,fman") {
 		rc =3D fdt_setprop_cell(blob, fmnode, "fsl,firmware-phandle",
 				      phandle);
 		if (rc < 0) {
diff --git a/drivers/pci/pcie_layerscape_fixup_common.c b/drivers/pci/pci=
e_layerscape_fixup_common.c
index faccf6c141..095874a927 100644
--- a/drivers/pci/pcie_layerscape_fixup_common.c
+++ b/drivers/pci/pcie_layerscape_fixup_common.c
@@ -48,8 +48,7 @@ static int lx2_board_fix_fdt(void *fdt)
 	const fdt32_t *prop;
 	u32 ob_wins, ib_wins;
=20
-	off =3D fdt_node_offset_by_compatible(fdt, -1, "fsl,lx2160a-pcie");
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, "fsl,lx2160a-pcie") {
 		fdt_setprop(fdt, off, "compatible", "fsl,ls2088a-pcie",
 			    strlen("fsl,ls2088a-pcie") + 1);
=20
@@ -89,14 +88,10 @@ static int lx2_board_fix_fdt(void *fdt)
 		fdt_setprop(fdt, off, "reg-names", reg_names, names_len);
 		fdt_delprop(fdt, off, "apio-wins");
 		fdt_delprop(fdt, off, "ppio-wins");
-		off =3D fdt_node_offset_by_compatible(fdt, off,
-						    "fsl,lx2160a-pcie");
 	}
=20
 	/* Fixup PCIe EP nodes */
-	off =3D -1;
-	off =3D fdt_node_offset_by_compatible(fdt, off, "fsl,lx2160a-pcie-ep");
-	while (off !=3D -FDT_ERR_NOTFOUND) {
+	fdt_for_each_node_by_compatible(off, fdt, -1, "fsl,lx2160a-pcie-ep") {
 		fdt_setprop_string(fdt, off, "compatible",
 				   "fsl,lx2160ar2-pcie-ep");
 		prop =3D fdt_getprop(fdt, off, "apio-wins", NULL);
@@ -113,9 +108,6 @@ static int lx2_board_fix_fdt(void *fdt)
 		fdt_setprop_u32(fdt, off, "num-ib-windows", ib_wins);
 		fdt_setprop_u32(fdt, off, "num-ob-windows", ob_wins);
 		fdt_delprop(fdt, off, "apio-wins");
-
-		off =3D fdt_node_offset_by_compatible(fdt, off,
-						    "fsl,lx2160a-pcie-ep");
 	}
=20
 	return 0;
diff --git a/drivers/phy/marvell/comphy_a3700.c b/drivers/phy/marvell/com=
phy_a3700.c
index 4104353555..32d2c5c9d3 100644
--- a/drivers/phy/marvell/comphy_a3700.c
+++ b/drivers/phy/marvell/comphy_a3700.c
@@ -985,12 +985,12 @@ void comphy_dedicated_phys_init(void)
=20
 static int find_available_node_by_compatible(int offset, const char *com=
patible)
 {
-	do {
-		offset =3D fdt_node_offset_by_compatible(gd->fdt_blob, offset,
-						       compatible);
-	} while (offset > 0 && !fdtdec_get_is_enabled(gd->fdt_blob, offset));
+	fdt_for_each_node_by_compatible(offset, gd->fdt_blob, offset,
+					compatible)
+		if (fdtdec_get_is_enabled(gd->fdt_blob, offset))
+			return offset;
=20
-	return offset;
+	return -1;
 }
=20
 static bool comphy_a3700_find_lane(const int nodes[3], int node,
diff --git a/drivers/video/meson/simplefb_common.c b/drivers/video/meson/=
simplefb_common.c
index 81782326d4..e5e4ed4cb0 100644
--- a/drivers/video/meson/simplefb_common.c
+++ b/drivers/video/meson/simplefb_common.c
@@ -14,15 +14,12 @@ int meson_simplefb_fdt_match(void *blob, const char *=
pipeline)
 	int offset, ret;
=20
 	/* Find a prefilled simpefb node, matching out pipeline config */
-	offset =3D fdt_node_offset_by_compatible(blob, -1,
-					       "amlogic,simple-framebuffer");
-	while (offset >=3D 0) {
+	fdt_for_each_node_by_compatible(offset, blob, -1,
+					"amlogic,simple-framebuffer") {
 		ret =3D fdt_stringlist_search(blob, offset, "amlogic,pipeline",
 					    pipeline);
 		if (ret =3D=3D 0)
 			break;
-		offset =3D fdt_node_offset_by_compatible(blob, offset,
-						"amlogic,simple-framebuffer");
 	}
=20
 	return offset;
diff --git a/drivers/video/sunxi/simplefb_common.c b/drivers/video/sunxi/=
simplefb_common.c
index df6501e4c3..28d2afe92e 100644
--- a/drivers/video/sunxi/simplefb_common.c
+++ b/drivers/video/sunxi/simplefb_common.c
@@ -16,13 +16,12 @@ int sunxi_simplefb_fdt_match(void *blob, const char *=
pipeline)
 	/* Find a prefilled simpefb node, matching out pipeline config */
 	offset =3D fdt_node_offset_by_compatible(blob, -1,
 					       "allwinner,simple-framebuffer");
-	while (offset >=3D 0) {
+	fdt_for_each_node_by_compatible(offset, blob, -1,
+					"allwinner,simple-framebuffer") {
 		ret =3D fdt_stringlist_search(blob, offset, "allwinner,pipeline",
 					    pipeline);
 		if (ret =3D=3D 0)
 			break;
-		offset =3D fdt_node_offset_by_compatible(blob, offset,
-						"allwinner,simple-framebuffer");
 	}
=20
 	return offset;
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 8ec461af6c..852040f66f 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -289,6 +289,12 @@ int fdt_node_offset_by_compat_reg(void *blob, const =
char *compat,
 					phys_addr_t compat_off);
 int fdt_node_offset_by_pathf(void *blob, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
+
+#define fdt_for_each_node_by_compatible(node, fdt, start, compat)	\
+	for (node =3D fdt_node_offset_by_compatible(fdt, start, compat);	\
+	     node >=3D 0;							\
+	     node =3D fdt_node_offset_by_compatible(fdt, node, compat))
+
 int fdt_set_phandle(void *fdt, int nodeoffset, uint32_t phandle);
 unsigned int fdt_create_phandle(void *fdt, int nodeoffset);
 unsigned int fdt_create_phandle_by_compatible(void *fdt, const char *com=
pat);
--=20
2.34.1

