Received: by mail-wm1-f66.google.com with SMTP id y197so4365373wmd.0
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=pTfzCLQt03L2imv/rD0shS6LfKSeKeK57aNZgbyJta0=;
        b=kB+qfky6iq2NwgF3CNKCjia94aNurRlFu4++UNacEQtc+gTpKxSA1JrqZJXFsNoKj8
         nj1QcczCbJynyYlIt2/deawQGQK43G2Xb+wLOy++0Lt6Kg+/zpvzY7L/JXOyUx5ZM95C
         ZN+EXkLMy/NqOGqfbRwCwe9Ja80mzUaxySEKj+pBqsTV+UqOt28+76k6M/R70ectz9Si
         qCaWb6lVDeumeflTzHsTdThh7z3K83jraPSKwqoGVVacX744deKck2pqCSxlwgDuWjv4
         7oDt7RFmu7YmKgcjxm4rLagCwlnYiQObxuyKy8Fl0njVCqxbknxoh+L9UpUn1XsHY8es
         ulWg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C9604E5.8080107@baylibre.com>
Date: Sat, 23 Mar 2019 11:05:25 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/5] ARM: board: meson: add p200 board
References: <20190315151946.23105-1-mohammad.rasim96@gmail.com> <20190315151946.23105-3-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151946.23105-3-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, jbrunet@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 15/03/2019 16:19, Mohammad Rasim a =E9crit :
> This adds the p200 defconfig
>=20
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  configs/p200_defconfig | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 configs/p200_defconfig
>=20
> diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> new file mode 100644
> index 000000000000..3980e4eb5f1d
> --- /dev/null
> +++ b/configs/p200_defconfig
> @@ -0,0 +1,41 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MESON=3Dy
> +CONFIG_SYS_TEXT_BASE=3D0x01000000
> +CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> +CONFIG_DEBUG_UART_CLOCK=3D24000000
> +CONFIG_IDENT_STRING=3D" p200"
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_MISC_INIT_R=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=3Dy
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_OF_CONTROL=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-p200"
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_MESON=3Dy
> +CONFIG_DM_MMC=3Dy
> +CONFIG_MMC_MESON_GX=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_ETH_DESIGNWARE=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCTRL_MESON_GXBB=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_DEBUG_UART_MESON=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_SKIP_INIT=3Dy
> +CONFIG_MESON_SERIAL=3Dy
> +CONFIG_OF_LIBFDT_OVERLAY=3Dy
> +CONFIG_SYS_BOARD=3D"p200"
> --
> 2.21.0
>=20

Can you update the configs/p200_defconfig here instead of the first patch ?

Thanks,
Neil
