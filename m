Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web09.5147.1637580473971694288
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 03:27:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1637580470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/WqEmJTJx4o4QSgTBz+DDBCgyNvnqYIej9LVclmPYDA=;
	b=H8E0tHNWiI1HrfkPHKNqk3XZkQ83sTqyml1JRr97RpwymWiUvr+pH9wD4syIGUDnlF6Mpp
	f8PPRWtlyZ29mfx8niKLy9gDZ0+yfXQsufPUSjjHE8fUz+LVR/KAtXpP5Fv3LV+mk6vNLN
	CF5OCjHyNtF23XYjT1dIPfe1BPaJQStRPBx/DlTpr03Pqgy2NYNmupjiPhkOThw5dsiJ+k
	/nGIbbvI+BWLCR1SjU3gIrJ+baJ3+oZMbHFFOi5yukvoU6YxPIr/GifG+f/PQsWko3V47n
	FgdG1ibHy2q9SlVPaqPI9YX1oTxFifZLOGvpHvfBhuwszMd7h6lNAPoAYLuOfg==
Message-ID: <bf457a1e-2571-c674-f7a9-c32cacb4b371@lexina.in>
Date: Mon, 22 Nov 2021 14:27:49 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR when unnecessary
References: <20211122110710.1038893-1-narmstrong@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <20211122110710.1038893-1-narmstrong@baylibre.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, christianshewitt@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Sounds right for jethub boards.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

22.11.2021 14:07, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Meson GXL, GXM, AXG, G12A, G12B & SM1 SoCs, we can generate an unique
> MAC address if none valid found in the eFuses storage.
>=20
> Only the GXBB based boards doesn't have a fallback way to generate an
> unique MAC address, so we rely on CONFIG_NET_RANDOM_ETHADDR to have
> a valid one.
>=20
> An exception is the Radxa Zero board who doesn't have Ethernet on board
> so depends on an (or multiple) eventual USB adapters, so leaving the
> CONFIG_NET_RANDOM_ETHADDR configs seems safer.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   configs/bananapi-m5_defconfig        | 1 -
>   configs/beelink-gsking-x_defconfig   | 1 -
>   configs/beelink-gtking_defconfig     | 1 -
>   configs/beelink-gtkingpro_defconfig  | 1 -
>   configs/jethub_j80_defconfig         | 1 -
>   configs/khadas-vim2_defconfig        | 1 -
>   configs/khadas-vim3_defconfig        | 1 -
>   configs/khadas-vim3l_defconfig       | 1 -
>   configs/khadas-vim_defconfig         | 1 -
>   configs/libretech-ac_defconfig       | 1 -
>   configs/libretech-cc_defconfig       | 1 -
>   configs/libretech-cc_v2_defconfig    | 1 -
>   configs/libretech-s905d-pc_defconfig | 1 -
>   configs/libretech-s912-pc_defconfig  | 1 -
>   configs/odroid-c4_defconfig          | 1 -
>   configs/odroid-hc4_defconfig         | 1 -
>   configs/odroid-n2_defconfig          | 1 -
>   configs/p212_defconfig               | 1 -
>   configs/s400_defconfig               | 1 -
>   configs/sei510_defconfig             | 1 -
>   configs/sei610_defconfig             | 1 -
>   configs/u200_defconfig               | 1 -
>   configs/wetek-core2_defconfig        | 1 -
>   23 files changed, 23 deletions(-)
>=20
> diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfi=
g
> index 7ca14a5f6a..4bf81b2faa 100644
> --- a/configs/bananapi-m5_defconfig
> +++ b/configs/bananapi-m5_defconfig
> @@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
> diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-=
x_defconfig
> index 54ac1c9315..e60e754f56 100644
> --- a/configs/beelink-gsking-x_defconfig
> +++ b/configs/beelink-gsking-x_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
>   CONFIG_DM_MTD=3Dy
> diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_de=
fconfig
> index 7735c70e3f..2ec3221563 100644
> --- a/configs/beelink-gtking_defconfig
> +++ b/configs/beelink-gtking_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
>   CONFIG_DM_MTD=3Dy
> diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtking=
pro_defconfig
> index 93c5739672..60d316d80a 100644
> --- a/configs/beelink-gtkingpro_defconfig
> +++ b/configs/beelink-gtkingpro_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
>   CONFIG_DM_MTD=3Dy
> diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
> index ad6bec0c43..eb1e4c4a53 100644
> --- a/configs/jethub_j80_defconfig
> +++ b/configs/jethub_j80_defconfig
> @@ -33,7 +33,6 @@ CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_PARTITION_TYPE_GUID=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_DM_I2C=3Dy
>   CONFIG_SYS_I2C_MESON=3Dy
> diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfi=
g
> index c852f7f3f9..81cff3cee8 100644
> --- a/configs/khadas-vim2_defconfig
> +++ b/configs/khadas-vim2_defconfig
> @@ -29,7 +29,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
> diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfi=
g
> index a225a564b2..65050efd3f 100644
> --- a/configs/khadas-vim3_defconfig
> +++ b/configs/khadas-vim3_defconfig
> @@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_BUTTON=3Dy
> diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defcon=
fig
> index 9d94c31891..b9162c9f1e 100644
> --- a/configs/khadas-vim3l_defconfig
> +++ b/configs/khadas-vim3l_defconfig
> @@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_BUTTON=3Dy
> diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
> index 5565635ab1..81eeff4982 100644
> --- a/configs/khadas-vim_defconfig
> +++ b/configs/khadas-vim_defconfig
> @@ -27,7 +27,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_PHY_MESON_GXL=3Dy
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defcon=
fig
> index fa4427a815..7dcd8540a9 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -34,7 +34,6 @@ CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defcon=
fig
> index b729308c8e..b4413ed9b7 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_PHY_MESON_GXL=3Dy
> diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_=
defconfig
> index 9f8a914bb7..99a0b28d16 100644
> --- a/configs/libretech-cc_v2_defconfig
> +++ b/configs/libretech-cc_v2_defconfig
> @@ -30,7 +30,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s90=
5d-pc_defconfig
> index bde2bb877c..6e8c8a497e 100644
> --- a/configs/libretech-s905d-pc_defconfig
> +++ b/configs/libretech-s905d-pc_defconfig
> @@ -32,7 +32,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912=
-pc_defconfig
> index 536f9e8d12..b08ca44abe 100644
> --- a/configs/libretech-s912-pc_defconfig
> +++ b/configs/libretech-s912-pc_defconfig
> @@ -31,7 +31,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index bc778a641a..1ea003f3f8 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
> diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
> index 2fe761e939..d632670db0 100644
> --- a/configs/odroid-hc4_defconfig
> +++ b/configs/odroid-hc4_defconfig
> @@ -29,7 +29,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_SATA=3Dy
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index 8e9e8f8fb7..7f87504a9c 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_ADC=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
> diff --git a/configs/p212_defconfig b/configs/p212_defconfig
> index b1d2ca8350..bca0fa8404 100644
> --- a/configs/p212_defconfig
> +++ b/configs/p212_defconfig
> @@ -25,7 +25,6 @@ CONFIG_CMD_USB=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_PHY_MESON_GXL=3Dy
>   CONFIG_DM_ETH=3Dy
> diff --git a/configs/s400_defconfig b/configs/s400_defconfig
> index 4467e66929..8483694685 100644
> --- a/configs/s400_defconfig
> +++ b/configs/s400_defconfig
> @@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_PHY_REALTEK=3Dy
>   CONFIG_DM_ETH=3Dy
> diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
> index 690a0ca8d4..5e2496edbe 100644
> --- a/configs/sei510_defconfig
> +++ b/configs/sei510_defconfig
> @@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_MMC=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SYS_MMC_ENV_DEV=3D2
>   CONFIG_SYS_MMC_ENV_PART=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>   CONFIG_FASTBOOT_BUF_ADDR=3D0x6000000
>   CONFIG_FASTBOOT_FLASH=3Dy
> diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
> index 63080aec2d..df53c91d8b 100644
> --- a/configs/sei610_defconfig
> +++ b/configs/sei610_defconfig
> @@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_MMC=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SYS_MMC_ENV_DEV=3D2
>   CONFIG_SYS_MMC_ENV_PART=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>   CONFIG_FASTBOOT_BUF_ADDR=3D0x6000000
>   CONFIG_FASTBOOT_FLASH=3Dy
> diff --git a/configs/u200_defconfig b/configs/u200_defconfig
> index 144c394010..7f46dcf5c2 100644
> --- a/configs/u200_defconfig
> +++ b/configs/u200_defconfig
> @@ -25,7 +25,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_DM_ETH=3Dy
>   CONFIG_DM_MDIO=3Dy
> diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfi=
g
> index ce947b5625..006cebc711 100644
> --- a/configs/wetek-core2_defconfig
> +++ b/configs/wetek-core2_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB_MASS_STORAGE=3Dy
>   CONFIG_CMD_REGULATOR=3Dy
>   CONFIG_OF_CONTROL=3Dy
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>   CONFIG_SARADC_MESON=3Dy
>   CONFIG_MMC_MESON_GX=3Dy
>   CONFIG_MTD=3Dy
>=20
