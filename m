Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.87804.1696265954007097322
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 525D8120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265951;
	bh=f/z1DcuYBfjZ2kNEpnuYXXkIZllyCQtrwgIaVz+WtuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=G6XnvTIGHoInjd66MKPsQw5iNG1fyjCwfyf2vHwaRsUQSnLqOIe22pdtsOmIk37C+
	 oYXuhsuVJVKxn2BthtFL7DvxWPMmYm5XaiHncZOPkxUDV6+VHTGuXtN5luBJxkL9eA
	 um8IknlzS6bPqTp/dZh9Z/WdnlERY87l+dZQBy2Bc9Zricsxycppp+gEpc5DZA9uO4
	 VjRf/KIrkN9yne42d7HGJvta1iJEyWzCb3pCd2HXzkctAgnG5so2vOVBgVP84fkTu9
	 9jFrDzN8pjcp386Jn8Rg8PpBa3LQzybz8ak306VG3QpcwYiaFi8W3WcGeeWTjfH/m0
	 htZ0GFO9KpMow==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 8/8] arch: a1: introduce USB initialization functionality
Date: Mon, 2 Oct 2023 19:58:52 +0300
Message-ID: <20231002165857.19512-9-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

This is entrypoint for USB stack initialization. Function
board_usb_init will be called from cmd/fastboot.c code.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/mach-meson/board-a1.c | 89 ++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.=
c
index 967bb67182..781d5cfb33 100644
--- a/arch/arm/mach-meson/board-a1.c
+++ b/arch/arm/mach-meson/board-a1.c
@@ -4,12 +4,17 @@
  */
=20
 #include <common.h>
+#include <dm.h>
+#include <usb.h>
 #include <asm/arch/a1.h>
 #include <asm/arch/boot.h>
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <linux/sizes.h>
+#include <linux/usb/otg.h>
+#include <asm/arch/usb.h>
+#include <usb/dwc2_udc.h>
=20
 phys_size_t get_effective_memsize(void)
 {
@@ -57,3 +62,87 @@ static struct mm_region a1_mem_map[] =3D {
 };
=20
 struct mm_region *mem_map =3D a1_mem_map;
+
+#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
+	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
+
+static struct dwc2_plat_otg_data meson_a1_dwc2_data;
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	int node, dwc2_node;
+	const void *blob =3D gd->fdt_blob;
+	struct udevice *dev;
+	int ret;
+
+	node =3D fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-a1-usb-ctrl");
+	if (node < 0) {
+		pr_err("not found usb-control node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, node)) {
+		pr_err("usb is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	ret =3D uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
+	if (ret) {
+		pr_err("not found usb-control device\n");
+		return ret;
+	}
+
+	dwc2_node =3D fdt_node_offset_by_compatible(blob, node,
+						  "amlogic,meson-a1-usb");
+	if (dwc2_node < 0) {
+		pr_err("not found dwc2 node\n");
+		return -ENODEV;
+	}
+
+	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
+		pr_err("dwc2 is disabled in the device tree\n");
+		return -ENODEV;
+	}
+
+	meson_a1_dwc2_data.regs_otg =3D fdtdec_get_addr(blob, dwc2_node, "reg");
+	if (meson_a1_dwc2_data.regs_otg =3D=3D FDT_ADDR_T_NONE) {
+		pr_err("can't get base address\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.rx_fifo_sz =3D fdtdec_get_int(blob, dwc2_node,
+						"g-rx-fifo-size", 0);
+	if (meson_a1_dwc2_data.rx_fifo_sz < 0) {
+		pr_err("failed to get g-rx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.np_tx_fifo_sz =3D fdtdec_get_int(blob, dwc2_node,
+						"g-np-tx-fifo-size", 0);
+	if (meson_a1_dwc2_data.np_tx_fifo_sz < 0) {
+		pr_err("failed to get g-np-tx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	meson_a1_dwc2_data.tx_fifo_sz =3D fdtdec_get_int(blob, dwc2_node,
+						"g-tx-fifo-size", 0);
+	if (meson_a1_dwc2_data.tx_fifo_sz < 0) {
+		pr_err("failed to get g-tx-fifo-size value\n");
+		return -ENODATA;
+	}
+
+	ret =3D dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
+	if (ret) {
+		pr_err("failed to force usb mode to peripheral\n");
+		return ret;
+	}
+
+	return dwc2_udc_probe(&meson_a1_dwc2_data);
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	return 0;
+}
+#endif
--=20
2.25.1

