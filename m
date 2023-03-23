Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.66693.1679555063524552829
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 00:04:23 -0700
Received: by mail-wr1-f44.google.com with SMTP id v1so13242965wrv.1
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679555062;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElkB90fxduV7LU53xTO7ih5CA9DN7CXC/xHmCsQ75jE=;
        b=YmVXGtyHJrezqJTkEq7GiBl8yIZhAg2d27mWu3yr+PGCBduEuEqLgDchCWA19u5z6C
         fmtgv0EmARBr7/Xvq9fJT1ylwNb9rsZTdOHRWug3nEcw0gY/lzbcj29EvzUN/aGET0EI
         uEZW9it79MdwPkHIA5M6ea6/jFU8764jOr+jqdRVL1x+TBkc6CkgEBIaj/s46VNngZr6
         jmDQThj6GSf43NAo2WYpBL/xRJsJ0LvFrF1kGkJzG51fYYgSVx/RsMYX01MI4qRPGqMf
         nW/io5zT2fVc7lcOEI6tMEik5DbS5m3fYfiwoxnkOhNgDsrKR4K2D3ijyVvnrTJBD0a3
         KOcA==
Return-Path: <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH 12/13] boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
From: "Christian Hewitt" <christianshewitt@gmail.com>
In-Reply-To: <174EF9F0421CB2CD.22739@groups.io>
Date: Thu, 23 Mar 2023 11:04:18 +0400
Message-Id: <61A15528-D55A-413A-ACCC-CFCE6422DFCA@gmail.com>
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <174EF9F0421CB2CD.22739@groups.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>



> On 23 Mar 2023, at 10:54 am, Christian Hewitt via groups.io <christianshe=
witt=3Dgmail.com@groups.io> wrote:
>=20
> Add configurations for the WeTek Hub and WeTek Play2 boards along
> with files for the wetek-gxbb board family to ensure the ethernet
> MAC is correctly discovered. Set myself as the maintainer for the
> board family.

^ should read just "Add configurations for the WeTek Hub and WeTek Play2
boards=E2=80=9D as the board-family changes were dropped (not needed). I ca=
n
send a v2 for this patch alone (or would you prefer the series?)

Christian

>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> board/amlogic/p200/MAINTAINERS |  2 +
> configs/wetek-hub_defconfig    | 70 ++++++++++++++++++++++++++++++++++
> configs/wetek-play2_defconfig  | 70 ++++++++++++++++++++++++++++++++++
> 3 files changed, 142 insertions(+)
> create mode 100644 configs/wetek-hub_defconfig
> create mode 100644 configs/wetek-play2_defconfig
>=20
> diff --git a/board/amlogic/p200/MAINTAINERS b/board/amlogic/p200/MAINTAIN=
ERS
> index 33ca3df5c6..264218e3be 100644
> --- a/board/amlogic/p200/MAINTAINERS
> +++ b/board/amlogic/p200/MAINTAINERS
> @@ -7,6 +7,8 @@ F:	board/amlogic/p200/
> F:	configs/nanopi-k2_defconfig
> F:	configs/odroid-c2_defconfig
> F:	configs/p200_defconfig
> +F:	configs/wetek-hub_defconfig
> +F:	configs/wetek-play2_defconfig
> F:	doc/board/amlogic/p200.rst
> F:	doc/board/amlogic/nanopi-k2.rst
> F:	doc/board/amlogic/odroid-c2.rst
> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> new file mode 100644
> index 0000000000..634833f7fe
> --- /dev/null
> +++ b/configs/wetek-hub_defconfig
> @@ -0,0 +1,70 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_LOAD_ADDR=3D0x1000000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" wetek-hub"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-wetek-hub"
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> +CONFIG_OF_BOARD_SETUP=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_USB=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SARADC_MESON=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_MESON=3Dy
> +CONFIG_DM_MMC=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_MESON_GXBB_USB_PHY=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXBB=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_MESON_EE_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy
> +CONFIG_SYSINFO=3Dy
> +CONFIG_SYSINFO_SMBIOS=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_DM_USB=3Dy
> +CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_KEYBOARD=3Dy
> +CONFIG_VIDEO=3Dy
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
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
> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfi=
g
> new file mode 100644
> index 0000000000..6d33b09a94
> --- /dev/null
> +++ b/configs/wetek-play2_defconfig
> @@ -0,0 +1,70 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_TEXT_BASE=3D0x01000000
> +CONFIG_SYS_LOAD_ADDR=3D0x1000000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" wetek-play2"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-wetek-play2"
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> +CONFIG_OF_BOARD_SETUP=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_ADC=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_USB=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SARADC_MESON=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_MESON=3Dy
> +CONFIG_DM_MMC=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_ETH_DESIGNWARE_MESON8B=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_MESON_GXBB_USB_PHY=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXBB=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_MESON_EE_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy
> +CONFIG_SYSINFO=3Dy
> +CONFIG_SYSINFO_SMBIOS=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_DM_USB=3Dy
> +CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_KEYBOARD=3Dy
> +CONFIG_VIDEO=3Dy
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
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
> 2.34.1
>=20
>=20
>=20
>=20
>=20
>=20

