Received: by mail-wm1-f66.google.com with SMTP id o25so17766311wmf.5
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=lkB0MU9e8c2xs5aHscWJmRPDst9/Dmw408i416cSgH8=;
        b=WbNG2Dx8Mq4r/Ix+j83uKvf0OwzJaZV9BuY6YEqrjcKiWKDvI2n3BnIQ4vN8Knqfmf
         NK1eBgJR4xr3UpmGKJXE09XfykE1sX4gTsIakdobnYwd5EMwyNi3yxN+f59N1sxEqsA8
         hGuE2nEK+n1bYOX48DJnmRT2nX31QwnFKkvoGz5LJs4y8jZl5irCoolEfZDNFmTVfqIM
         Ak0U7rSZJno3W1l0ebpKNxZFnocfZApmG5OjQXWXwudv+LeHy3qhdRWojFwokchfEpmz
         ZmWL66ti/M/FM2+10Tjv0kC29xkC8TM0ivo9eEC0cAO2ecueoXxbqg5wYfBueYbVg6CG
         tNnA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH v2 3/3] mach-meson: g12a: add DWC2 peripheral mode support
References: <20190401124657.29736-1-narmstrong@baylibre.com>
 <20190401124657.29736-4-narmstrong@baylibre.com>
 <20190419081722.6941a8a7@jawa>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9e88b584-363e-5310-9efc-5ae3a19a0aaf@baylibre.com>
Date: Tue, 23 Apr 2019 11:31:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190419081722.6941a8a7@jawa>
Content-Type: multipart/mixed; boundary="Groupsio=0zmcsHXNq5GkVD5ZzzXU"
To: Lukasz Majewski <lukma@denx.de>
Cc: marex@denx.de, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=0zmcsHXNq5GkVD5ZzzXU
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 19/04/2019 08:17, Lukasz Majewski wrote:
> Hi Neil,
>=20
>> Adds support for Amlogic G12A USB Device mode.
>>
>> The DWC2 Controller behind the Glue can be connected to an OTG
>> capable PHY. The Glue setups the PHY mode.
>>
>> This patch implements Device mode support by adding a
>> board_usb_init/cleanup setting up the DWC2 controller and switch the
>> OTG capable port to Device before starting the DWC2 controller in
>> Device mode.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>=20
> I wanted to apply this series, but it turned out that it depends on:
> [U-Boot] [PATCH v2 0/6] ARM: meson: Add support for G12A based U200
> board
>=20
> Let's wait till the above one is pulled to master.

I just sent a PR to Tom, will ping you when pulled to master.

Thanks,
Neil

>=20
>> ---
>>  arch/arm/include/asm/arch-meson/usb.h |  12 +++
>>  arch/arm/mach-meson/board-g12a.c      | 126
>> ++++++++++++++++++++++++++ 2 files changed, 138 insertions(+)
>>  create mode 100644 arch/arm/include/asm/arch-meson/usb.h
>>
>> diff --git a/arch/arm/include/asm/arch-meson/usb.h
>> b/arch/arm/include/asm/arch-meson/usb.h new file mode 100644
>> index 0000000000..b794b5ce77
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arch-meson/usb.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#ifndef __MESON_USB_H__
>> +#define __MESON_USB_H__
>> +
>> +int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode
>> mode); +
>> +#endif /* __MESON_USB_H__ */
>> diff --git a/arch/arm/mach-meson/board-g12a.c
>> b/arch/arm/mach-meson/board-g12a.c index fc3764b960..1652970fbd 100644
>> --- a/arch/arm/mach-meson/board-g12a.c
>> +++ b/arch/arm/mach-meson/board-g12a.c
>> @@ -12,7 +12,12 @@
>>  #include <asm/io.h>
>>  #include <asm/armv8/mmu.h>
>>  #include <linux/sizes.h>
>> +#include <usb.h>
>> +#include <linux/usb/otg.h>
>> +#include <asm/arch/usb.h>
>> +#include <usb/dwc2_udc.h>
>>  #include <phy.h>
>> +#include <clk.h>
>>  
>>  DECLARE_GLOBAL_DATA_PTR;
>>  
>> @@ -148,3 +153,124 @@ void meson_eth_init(phy_interface_t mode,
>> unsigned int flags) /* Enable power gate */
>>  	clrbits_le32(G12A_MEM_PD_REG_0, G12A_MEM_PD_REG_0_ETH_MASK);
>>  }
>> +
>> +#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
>> +	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
>> +static struct dwc2_plat_otg_data meson_g12a_dwc2_data;
>> +
>> +int board_usb_init(int index, enum usb_init_type init)
>> +{
>> +	struct fdtdec_phandle_args args;
>> +	const void *blob =3D gd->fdt_blob;
>> +	int node, dwc2_node;
>> +	struct udevice *dev, *clk_dev;
>> +	struct clk clk;
>> +	int ret;
>> +
>> +	/* find the usb glue node */
>> +	node =3D fdt_node_offset_by_compatible(blob, -1,
>> +
>> "amlogic,meson-g12a-usb-ctrl");
>> +	if (node < 0) {
>> +	=09debug("Not found usb-control node\n");
>> +	=09return -ENODEV;
>> +	}
>> +
>> +	if (!fdtdec_get_is_enabled(blob, node)) {
>> +	=09debug("usb is disabled in the device tree\n");
>> +	=09return -ENODEV;
>> +	}
>> +
>> +	ret =3D uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS,
>> node, &dev);
>> +	if (ret) {
>> +	=09debug("Not found usb-control device\n");
>> +	=09return ret;
>> +	}
>> +
>> +	/* find the dwc2 node */
>> +	dwc2_node =3D fdt_node_offset_by_compatible(blob, node,
>> +
>> "amlogic,meson-g12a-usb");
>> +	if (dwc2_node < 0) {
>> +	=09debug("Not found dwc2 node\n");
>> +	=09return -ENODEV;
>> +	}
>> +
>> +	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
>> +	=09debug("dwc2 is disabled in the device tree\n");
>> +	=09return -ENODEV;
>> +	}
>> +
>> +	meson_g12a_dwc2_data.regs_otg =3D fdtdec_get_addr(blob,
>> dwc2_node, "reg");
>> +	if (meson_g12a_dwc2_data.regs_otg =3D=3D FDT_ADDR_T_NONE) {
>> +	=09debug("usbotg: can't get base address\n");
>> +	=09return -ENODATA;
>> +	}
>> +
>> +	/* Enable clock */
>> +	ret =3D fdtdec_parse_phandle_with_args(blob, dwc2_node,
>> "clocks",
>> +	=09	=09	     "#clock-cells", 0, 0,
>> &args);
>> +	if (ret) {
>> +	=09debug("usbotg has no clocks defined in the device
>> tree\n");
>> +	=09return ret;
>> +	}
>> +
>> +	ret =3D uclass_get_device_by_of_offset(UCLASS_CLK, args.node,
>> &clk_dev);
>> +	if (ret)
>> +	=09return ret;
>> +
>> +	if (args.args_count !=3D 1) {
>> +	=09debug("Can't find clock ID in the device tree\n");
>> +	=09return -ENODATA;
>> +	}
>> +
>> +	clk.dev =3D clk_dev;
>> +	clk.id =3D args.args[0];
>> +
>> +	ret =3D clk_enable(&clk);
>> +	if (ret) {
>> +	=09debug("Failed to enable usbotg clock\n");
>> +	=09return ret;
>> +	}
>> +
>> +	meson_g12a_dwc2_data.rx_fifo_sz =3D fdtdec_get_int(blob,
>> dwc2_node,
>> +
>> "g-rx-fifo-size", 0);
>> +	meson_g12a_dwc2_data.np_tx_fifo_sz =3D fdtdec_get_int(blob,
>> dwc2_node,
>> +	=09	=09	=09	"g-np-tx-fifo-size",
>> 0);
>> +	meson_g12a_dwc2_data.tx_fifo_sz =3D fdtdec_get_int(blob,
>> dwc2_node,
>> +
>> "g-tx-fifo-size", 0); +
>> +	/* Switch to peripheral mode */
>> +	ret =3D dwc3_meson_g12a_force_mode(dev,
>> USB_DR_MODE_PERIPHERAL);
>> +	if (ret)
>> +	=09return ret;
>> +
>> +	return dwc2_udc_probe(&meson_g12a_dwc2_data);
>> +}
>> +
>> +int board_usb_cleanup(int index, enum usb_init_type init)
>> +{
>> +	const void *blob =3D gd->fdt_blob;
>> +	struct udevice *dev;
>> +	int node;
>> +	int ret;
>> +
>> +	/* find the usb glue node */
>> +	node =3D fdt_node_offset_by_compatible(blob, -1,
>> +
>> "amlogic,meson-g12a-usb-ctrl");
>> +	if (node < 0)
>> +	=09return -ENODEV;
>> +
>> +	if (!fdtdec_get_is_enabled(blob, node))
>> +	=09return -ENODEV;
>> +
>> +	ret =3D uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS,
>> node, &dev);
>> +	if (ret)
>> +	=09return ret;
>> +
>> +	/* Switch to OTG mode */
>> +	ret =3D dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_HOST);
>> +	if (ret)
>> +	=09return ret;
>> +
>> +	return 0;
>> +}
>> +#endif
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
>=20



--Groupsio=0zmcsHXNq5GkVD5ZzzXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcvtuNAAoJEHfc29rIyEnRpvsP+wVeeSoWQlXxeTW7sEMJmt8o
TdyYE1DQbvG9PsT8fAhaw3xdhjTm6RAlffduRdxJ4sBkLb0i6tOfoYsJK8V6gP0x
IUIcoGcTyaPH3pRVE0tjxVGS01bDXt1id1kTfJHOy6UXdzXqWQHat8L0/iwGBfO5
9qmcjwdlhQSmQCfbQO+m10hYKaZtfLbXMwDxhwd4v0ebleeYhDRniFCqp3gbGe7f
ZrPlBOQD7EBH8DVKjrBhiMyS6Pst6HGsOKXR8vzDutgIcIVLqtQ3aAMghMJ2U2Io
Rafo+pkTagJFjp/ilyHWbWReGliXSqbcwwXKRwmYzlq4vXHrYvdPI8F0XMhEr124
PIR5CNNR8NFZotFCJS5wJS492HMscYZyjHpK8pcLJFL0q9oo5lVXDPwWbg/MijP+
wuteH1NLQiGbz0SJtHZlG81VaezXeSsIv2byZgltf15ApcHURqV6x+mOvdD7Msdj
rJ7xFwKQrEuXQHXQbha/jB4mOkiaINuoe4bJHVH99LEAM7j0K8tE9qsbZV6oFINe
/Zg86wiNURHhtxHLjSykOKgeyTyFAewZ/MBB3g279i8ls/1FyfpSpn+faW21o98j
viDDU/Yb1rfT1kMX+uuhKDbUqaR+VVNXM/dD9tkZ0Jm9xk6dtcnvOLjaeRRvzQl3
Or8kUfi2KyMl364pkx1H
=0jqg
-----END PGP SIGNATURE-----

--Groupsio=0zmcsHXNq5GkVD5ZzzXU--
