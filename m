Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web08.8189.1610453563225677300
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Jan 2021 04:12:44 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210112121241euoutp02197957337e5e21254a393294b10306a4~Zevs2i4fu2450424504euoutp021
	for <u-boot-amlogic@groups.io>; Tue, 12 Jan 2021 12:12:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210112121241euoutp02197957337e5e21254a393294b10306a4~Zevs2i4fu2450424504euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1610453561;
	bh=NuXIxTvMZZaW0wrJxpN7nv0BPyX6WrQfiCRwST/pOUQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=NEs1n5XoIvCNtta3emu0TOP5R6ph6B9STHWp8e6owjVAXAuCNDV6QBkS9BoLcTWir
	 Td7jhjsVC78B4Tnn6IAIJsF4YzL4wg6bGfMieiGtW4G7nuOl+ZDsWGwN98jC5vhg47
	 hAZU2QcAJp0tNkfj/5NEpyqHNITAJjRALF40L0RQ=
Subject: Re: [PATCH] board: amlogic: vim3: fix setup ethernet mac from efuse
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <769748ab-3c63-4f68-8c0a-d1cec1e6e42c@samsung.com>
Date: Tue, 12 Jan 2021 13:12:39 +0100
MIME-Version: 1.0
In-Reply-To: <20210112050308.774189-1-art@khadas.com>
References: <CGME20210112050446eucas1p1908335956fcb516ca635c3865c9d8495@eucas1p1.samsung.com>
	<20210112050308.774189-1-art@khadas.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi Artem,

On 12.01.2021 06:03, Artem Lapkin wrote:
> Fix reading built-in ethernet MAC address from efuse
>
> NOTE: MAC is stored in ASCII format, 1bytes =3D 2characters by 0 offset
>
> if mac from efuse not valid we use meson_generate_serial_ethaddr
>
> NOTE: remake odroid-n2.c variant from Neil Armstrong <narmstrong@baylib=
re.com>
>
> Signed-off-by: Artem Lapkin <art@khadas.com>

First of all, thanks pointing again at this issue.

I've implemented reading of MAC address from EFUSE for VIM boards and I=20
was convinced that it is stored in binary format. I've based my=20
assumptions on the vendor code, especially the message from the vendor=20
kernel:

[=C2=A0=C2=A0=C2=A0 4.028236] efusekeynum: 1
[=C2=A0=C2=A0=C2=A0 4.031072] efusekeyname:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac=C2=A0=C2=A0=C2=A0 offset:=C2=
=A0=C2=A0=C2=A0=C2=A0 0 size:=C2=A0=C2=A0=C2=A0=C2=A0 6
[=C2=A0=C2=A0=C2=A0 4.037542] efuse efuse: probe OK!

and the vendors dts:

https://github.com/khadas/linux/blob/khadas-vims-4.9.y/arch/arm64/boot/dt=
s/amlogic/kvim3_linux.dts#L506

which both points that the EFUSE key has only 6 bytes, what means binary=20
format. I didn't check it further what is really stored there.

Now I checked again and it looks that the DTS (and thus vendor's kernel=20
message) is incorrect, as the MAC is stored in ASCII and occupies 12=20
bytes in efuse. One can check that with vendor's kernel:

# cat /sys/class/efuse/userdata
0x00: 43 38 36 33 31 34 37 30 41 38 44 37 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
...

This means that your patch is correct, although I would change it a bit.

BTW, the Odroid N2/C4 boards don't have MAC stored explicitly in the=20
EFUSE, but the boards UUID. The original code use the last bytes of the=20
UUID as the MAC address.

> ---
>   board/amlogic/vim3/vim3.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 824fff8262..87d9fe1f02 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -139,26 +139,42 @@ int meson_ft_board_setup(void *blob, struct bd_in=
fo *bd)
>   }
>  =20
>   #define EFUSE_MAC_OFFSET	0
> -#define EFUSE_MAC_SIZE		6
> +#define EFUSE_MAC_SIZE		12
> +#define MAC_ADDR_LEN		6
>  =20
>   int misc_init_r(void)
>   {
> -	uint8_t mac_addr[EFUSE_MAC_SIZE];
> +	uint8_t mac_addr[MAC_ADDR_LEN];
> +	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>   	ssize_t len;
>  =20
>   	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  =20
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len =3D meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> -					  mac_addr, EFUSE_MAC_SIZE);
> +					  efuse_mac_addr, EFUSE_MAC_SIZE);
>   		if (len !=3D EFUSE_MAC_SIZE)
>   			return 0;
>  =20
> +		/* MAC is stored in ASCII format, 1bytes =3D 2characters */
> +		for (int i =3D 0; i < 6; i++) {
> +			tmp[0] =3D efuse_mac_addr[i * 2];
> +			tmp[1] =3D efuse_mac_addr[i * 2 + 1];
> +			tmp[2] =3D '\0';
> +			mac_addr[i] =3D simple_strtoul(tmp, NULL, 16);
> +		}
> +
>   		if (is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   		else
>   			meson_generate_serial_ethaddr();

Now the above code is the same as for Odroid N2/C4, so it can be moved=20
to arch/arm/mach-meson/board-common.c, maybe as=20
meson_read_efuse_mac_addr() with the offset as parameter, so it can be=20
directly used by Odroids and VIMs.

> +
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
> +		printf("[i] setup onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			mac_addr[0],mac_addr[1],mac_addr[2],
> +			mac_addr[3],mac_addr[4],mac_addr[5]);

I'm not really convinced that this message has to be displayed. If so,=20
then use "%pM" for printing MAC address.

>   	}
>  =20
>   	return 0;
>   }
> +

Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

