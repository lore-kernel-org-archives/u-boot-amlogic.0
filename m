Date: Fri, 19 Apr 2019 08:17:22 +0200
From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [U-Boot] [PATCH v2 3/3] mach-meson: g12a: add DWC2 peripheral mode support
Message-ID: <20190419081722.6941a8a7@jawa>
In-Reply-To: <20190401124657.29736-4-narmstrong@baylibre.com>
References: <20190401124657.29736-1-narmstrong@baylibre.com>
	<20190401124657.29736-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KqKqogL2vtBPqf2FMOpa2WP"; protocol="application/pgp-signature"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: marex@denx.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--Sig_/KqKqogL2vtBPqf2FMOpa2WP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Neil,

> Adds support for Amlogic G12A USB Device mode.
>=20
> The DWC2 Controller behind the Glue can be connected to an OTG
> capable PHY. The Glue setups the PHY mode.
>=20
> This patch implements Device mode support by adding a
> board_usb_init/cleanup setting up the DWC2 controller and switch the
> OTG capable port to Device before starting the DWC2 controller in
> Device mode.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I wanted to apply this series, but it turned out that it depends on:
[U-Boot] [PATCH v2 0/6] ARM: meson: Add support for G12A based U200
board

Let's wait till the above one is pulled to master.

> ---
>  arch/arm/include/asm/arch-meson/usb.h |  12 +++
>  arch/arm/mach-meson/board-g12a.c      | 126
> ++++++++++++++++++++++++++ 2 files changed, 138 insertions(+)
>  create mode 100644 arch/arm/include/asm/arch-meson/usb.h
>=20
> diff --git a/arch/arm/include/asm/arch-meson/usb.h
> b/arch/arm/include/asm/arch-meson/usb.h new file mode 100644
> index 0000000000..b794b5ce77
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-meson/usb.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#ifndef __MESON_USB_H__
> +#define __MESON_USB_H__
> +
> +int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode
> mode); +
> +#endif /* __MESON_USB_H__ */
> diff --git a/arch/arm/mach-meson/board-g12a.c
> b/arch/arm/mach-meson/board-g12a.c index fc3764b960..1652970fbd 100644
> --- a/arch/arm/mach-meson/board-g12a.c
> +++ b/arch/arm/mach-meson/board-g12a.c
> @@ -12,7 +12,12 @@
>  #include <asm/io.h>
>  #include <asm/armv8/mmu.h>
>  #include <linux/sizes.h>
> +#include <usb.h>
> +#include <linux/usb/otg.h>
> +#include <asm/arch/usb.h>
> +#include <usb/dwc2_udc.h>
>  #include <phy.h>
> +#include <clk.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -148,3 +153,124 @@ void meson_eth_init(phy_interface_t mode,
> unsigned int flags) /* Enable power gate */
>  	clrbits_le32(G12A_MEM_PD_REG_0, G12A_MEM_PD_REG_0_ETH_MASK);
>  }
> +
> +#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
> +	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +static struct dwc2_plat_otg_data meson_g12a_dwc2_data;
> +
> +int board_usb_init(int index, enum usb_init_type init)
> +{
> +	struct fdtdec_phandle_args args;
> +	const void *blob =3D gd->fdt_blob;
> +	int node, dwc2_node;
> +	struct udevice *dev, *clk_dev;
> +	struct clk clk;
> +	int ret;
> +
> +	/* find the usb glue node */
> +	node =3D fdt_node_offset_by_compatible(blob, -1,
> +
> "amlogic,meson-g12a-usb-ctrl");
> +	if (node < 0) {
> +		debug("Not found usb-control node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, node)) {
> +		debug("usb is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS,
> node, &dev);
> +	if (ret) {
> +		debug("Not found usb-control device\n");
> +		return ret;
> +	}
> +
> +	/* find the dwc2 node */
> +	dwc2_node =3D fdt_node_offset_by_compatible(blob, node,
> +
> "amlogic,meson-g12a-usb");
> +	if (dwc2_node < 0) {
> +		debug("Not found dwc2 node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
> +		debug("dwc2 is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	meson_g12a_dwc2_data.regs_otg =3D fdtdec_get_addr(blob,
> dwc2_node, "reg");
> +	if (meson_g12a_dwc2_data.regs_otg =3D=3D FDT_ADDR_T_NONE) {
> +		debug("usbotg: can't get base address\n");
> +		return -ENODATA;
> +	}
> +
> +	/* Enable clock */
> +	ret =3D fdtdec_parse_phandle_with_args(blob, dwc2_node,
> "clocks",
> +					     "#clock-cells", 0, 0,
> &args);
> +	if (ret) {
> +		debug("usbotg has no clocks defined in the device
> tree\n");
> +		return ret;
> +	}
> +
> +	ret =3D uclass_get_device_by_of_offset(UCLASS_CLK, args.node,
> &clk_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (args.args_count !=3D 1) {
> +		debug("Can't find clock ID in the device tree\n");
> +		return -ENODATA;
> +	}
> +
> +	clk.dev =3D clk_dev;
> +	clk.id =3D args.args[0];
> +
> +	ret =3D clk_enable(&clk);
> +	if (ret) {
> +		debug("Failed to enable usbotg clock\n");
> +		return ret;
> +	}
> +
> +	meson_g12a_dwc2_data.rx_fifo_sz =3D fdtdec_get_int(blob,
> dwc2_node,
> +
> "g-rx-fifo-size", 0);
> +	meson_g12a_dwc2_data.np_tx_fifo_sz =3D fdtdec_get_int(blob,
> dwc2_node,
> +							"g-np-tx-fifo-size",
> 0);
> +	meson_g12a_dwc2_data.tx_fifo_sz =3D fdtdec_get_int(blob,
> dwc2_node,
> +
> "g-tx-fifo-size", 0); +
> +	/* Switch to peripheral mode */
> +	ret =3D dwc3_meson_g12a_force_mode(dev,
> USB_DR_MODE_PERIPHERAL);
> +	if (ret)
> +		return ret;
> +
> +	return dwc2_udc_probe(&meson_g12a_dwc2_data);
> +}
> +
> +int board_usb_cleanup(int index, enum usb_init_type init)
> +{
> +	const void *blob =3D gd->fdt_blob;
> +	struct udevice *dev;
> +	int node;
> +	int ret;
> +
> +	/* find the usb glue node */
> +	node =3D fdt_node_offset_by_compatible(blob, -1,
> +
> "amlogic,meson-g12a-usb-ctrl");
> +	if (node < 0)
> +		return -ENODEV;
> +
> +	if (!fdtdec_get_is_enabled(blob, node))
> +		return -ENODEV;
> +
> +	ret =3D uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS,
> node, &dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Switch to OTG mode */
> +	ret =3D dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_HOST);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +#endif




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/KqKqogL2vtBPqf2FMOpa2WP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAly5Z/IACgkQAR8vZIA0
zr1jHgf/XfpjsRuxYVspr9+pmCBJy3rAPLcMmC/jB64miagV9CnoV4Scf0AvZ9Ld
ntEuJ23pkhIIoj/ETiRGRz/FtAZSbOslByb3g8eXVdkJdtCs1csKhNb5TykSBUBk
TMwNku8FHA349+if5Vfceijdms9f5LZeC0MhfpDRHcU6UW7SgzYV7wHIPqOfVwtT
y9XW2IILHQ9VYn1lzDT/MkvqG9Qi2LvMK54UsN+igBDw6ca75ZFqE74cCtAt+WI5
jgD/cYnqof3UoqyEmfB1ZODISQ+X9/vZYC7Tmm8E24qvD6qaksk5KSElQ2Q0TEFT
egG6wI6AQ2FYaRq/MJp5acGE1N4puA==
=fm5C
-----END PGP SIGNATURE-----

--Sig_/KqKqogL2vtBPqf2FMOpa2WP--
