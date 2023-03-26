Received: from m204-238.eu.mailgun.net (m204-238.eu.mailgun.net [161.38.204.238])
 by mx.groups.io with SMTP id smtpd.web11.4527.1679809245792336421
 for <u-boot-amlogic@groups.io>;
 Sat, 25 Mar 2023 22:40:46 -0700
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1679809244; x=1679816444; h=Message-Id: In-Reply-To: To:
 To: References: Date: Subject: Subject: Mime-Version:
 Content-Transfer-Encoding: Content-Type: From: From: Sender: Sender;
 bh=Qeb3RGfwQpa+2H8zxFm0q6mrySX8oR5mHP9CRRTyuWo=;
 b=HHk2SQb07KalcT6TtlFHNe4EtzGbaHR5vVCju/kG99n5uRhWgOUt7CiWvkOm1UeZTJh8aHkVDua0LLaE7/+woUW93Qgt4WfnGmIkZKRVKOuMHu5s+JRmIaKCpyqHJhR9K5cgLiahl1Ow4nI2IqpFRJ/4wEQbQdcyi6w38rMv4RxLTKVuKe6hD/38gQ3ImYLD1XKbkSYpGwfDDd1eXlMLUsLqqlhnne0VTczh+FWNk9Y5lygLz9J1ixdV58gNWovhTxmur88KYc9qxkSP2fhZyudUIZIwjVrLWuXhl5OSHPdw1rCJYuB7zb3EMO61hfvhGsFJ7K4VSE/8Fe9ycU1Xmg==
Sender: christian@hewittfamily.org.uk
From: Christian Hewitt <christian@hewittfamily.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCHv3 2/3] boards: amlogic: add Beelink GT1 Ultimate defconfig
Date: Sun, 26 Mar 2023 09:40:30 +0400
References: <gcKv.1679807404474266618.kYEF@groups.io>
In-Reply-To: <gcKv.1679807404474266618.kYEF@groups.io>
Message-Id: <786D5A9F-1A6E-4B64-AF19-DB3A2D972DF4@hewittfamily.org.uk>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, exkc_maillist@list.ru
List-ID: <u-boot-amlogic@groups.io>

> On 26 Mar 2023, at 9:10 am, exkc_maillist via groups.io <exkc_maillist=3D=
list.ru@groups.io> wrote:
>=20
> Add configuration for the Beelink GT1 Ultimate board.
>=20
> Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>
> ---
> configs/beelink-gt1-ultimate_defconfig | 85 ++++++++++++++++++++++++++
> 1 file changed, 85 insertions(+)
> create mode 100644 configs/beelink-gt1-ultimate_defconfig
>=20
> diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1=
-ultimate_defconfig
> new file mode 100644
> index 0000000000..b5ed30fab4
> --- /dev/null
> +++ b/configs/beelink-gt1-ultimate_defconfig
> @@ -0,0 +1,85 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> +CONFIG_ENV_SIZE=3D0x10000

> +CONFIG_ENV_OFFSET=3D0xFFFF0000
> +CONFIG_ENV_SECT_SIZE=3D0x10000

^ Not required

> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxm-gt1-ultimate"
> +CONFIG_DM_RESET=3Dy
> +CONFIG_MESON_GXM=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" gt1-ultimate"
> +CONFIG_SYS_LOAD_ADDR=3D0x1000000
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_OF_BOARD_SETUP=3Dy

> +CONFIG_USE_PREBOOT=3Dy

^ Not required (as CONFIG_PREBOOT not used)

> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=3Dy
> +CONFIG_SYS_MAXARGS=3D32
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy

> +CONFIG_CMD_SF_TEST=3Dy

^ Not required

> +CONFIG_CMD_SPI=3Dy

^ The GT1 schematics show no SPI chip on the board

> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_USB_MASS_STORAGE=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy

> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy

^ Not possible because no SPI

=3D> add CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy

> +CONFIG_SARADC_MESON=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_MTD=3Dy

> +CONFIG_DM_SPI_FLASH=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy

^ Again..

> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_MDIO_MUX=3Dy
> +CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
> +CONFIG_MDIO_MUX_MMIOREG=3Dy
> +CONFIG_MESON_GXL_USB_PHY=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXL=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_MESON_EE_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy

> +CONFIG_SPI=3Dy
> +CONFIG_DM_SPI=3Dy
> +CONFIG_MESON_SPIFC=3Dy

^ And again..

> +CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
> +CONFIG_USB_DWC3=3Dy
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_MESON_GXL=3Dy
> +CONFIG_USB_KEYBOARD=3Dy
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=3D0xfada
> +CONFIG_USB_GADGET_DWC2_OTG=3Dy
> +CONFIG_USB_GADGET_DOWNLOAD=3Dy
> +CONFIG_VIDEO=3Dy
> +CONFIG_SYS_WHITE_ON_BLACK=3Dy
> +CONFIG_VIDEO_MESON=3Dy
> +CONFIG_VIDEO_DT_SIMPLEFB=3Dy
> +CONFIG_SPLASH_SCREEN=3Dy
> +CONFIG_SPLASH_SCREEN_ALIGN=3Dy
> +CONFIG_VIDEO_BMP_RLE8=3Dy
> +CONFIG_BMP_16BPP=3Dy
> +CONFIG_BMP_24BPP=3Dy
> +CONFIG_BMP_32BPP=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> --=20

I=E2=80=99m guessing the config is derived from VIM2 (which has
an SPI-NOR chip). GT1/GT1-Ultimate don=E2=80=99t have it.

Christian

> 2.39.2
>=20
>=20
>=20
>=20
>=20

