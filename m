Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.11531.1679842127089174335
 for <u-boot-amlogic@groups.io>;
 Sun, 26 Mar 2023 07:48:47 -0700
Received: by mail-wr1-f45.google.com with SMTP id m2so6126808wrh.6
        for <u-boot-amlogic@groups.io>; Sun, 26 Mar 2023 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679842125;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTMuuvR9opaYTKwbwzCyjsoScTEaiBiaZ8rxJsgwJmk=;
        b=NajHo9NAtucFQf48JpP2Cojeq9Xqix8QpbEz5FGGduPAKkyY+RH4OTw4TqCHTwj876
         NXOpiWyrqvw2aeMb/MXS4VBDwKq6/ZGZUsfu1minR5Y4Iz8NHLmpa3LuAnNEHS85Qvqx
         gHwquKgmx+WhVMu5RqZSShIXRHNrK9WpB17TmnAxNwYeALbu/NIkR6zHEnju9cJO+NxN
         J6rLczKuAE3UCT61ewu+jcgHaJJvvENX19JvM75nc8NtbAs/4Mjq5+UPApEn0sYUoZyj
         FsK/enc0Q5r8d7AW3ljMLu7vUUUPgpZvlETU/YULW6GxTjMOpRvT+WtTuYubwzJrWBCe
         HiJQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCHv4 2/3] boards: amlogic: add Beelink GT1 Ultimate defconfig
Date: Sun, 26 Mar 2023 18:48:42 +0400
References: <ATp5.1679834635062570198.puAq@groups.io>
In-Reply-To: <ATp5.1679834635062570198.puAq@groups.io>
Message-Id: <C1C4DEF5-D2C9-429A-A064-9BC9CA31AADB@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, exkc_maillist@list.ru
List-ID: <u-boot-amlogic@groups.io>

> On 26 Mar 2023, at 4:43 pm, exkc_maillist via groups.io <exkc_maillist=3D=
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

^ Are these two really needed?

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

^ not required

> +CONFIG_CMD_SPI=3Dy

^ not required (board has no SPI)

> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_USB_MASS_STORAGE=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_ENV_IS_IN_SPI_FLASH=3Dy

^ not possible if no SPI

> +CONFIG_SARADC_MESON=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_MTD=3Dy

> +CONFIG_DM_SPI_FLASH=3Dy
> +CONFIG_SPI_FLASH_GIGADEVICE=3Dy

^ These two not required if no SPI

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

^ These three not required if no SPI

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

GT1 does not have SPI-NOR flash on the board so SPI options
are not required in the board config.

Christian


> --=20
> 2.39.2
>=20
>=20
>=20
>=20
>=20

