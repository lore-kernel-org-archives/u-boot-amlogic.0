Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web08.326.1607378362598797114
 for <u-boot-amlogic@groups.io>;
 Mon, 07 Dec 2020 13:59:23 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201207215919epoutp02b492957416095e199b1fa0090481089e~OjhoWBFZ50152001520epoutp02h
	for <u-boot-amlogic@groups.io>; Mon,  7 Dec 2020 21:59:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201207215919epoutp02b492957416095e199b1fa0090481089e~OjhoWBFZ50152001520epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607378359;
	bh=IV3zSEta6FHfiKVmFpE7dpnfHO/DgxvtrPvaBzXCbq4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=Xei0mvKI4UoYOCq78wxa2XLm1nK9vsk+AVh5C/bmhJop5mvCTpglZA7FbyTmXQD5a
	 jgSzvKM6oD4gW+rJAkSu8jFfxzjRxXMrbpLxyblyeVrfol1XIbpsRcc99T67pIPdZZ
	 1hz1x6utKzm1H0z/psteeC227yzrg6YnpmDDVYXk=
Subject: Re: [PATCH] mmc: meson-gx: change clock phase value on AGX SoCs
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <d1d6b2a1-887a-acb4-c794-f698cdd9e76c@samsung.com>
Date: Tue, 8 Dec 2020 06:59:41 +0900
MIME-Version: 1.0
In-Reply-To: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
References: <CGME20201207171541epcas1p3a19169ac6c6dc64731ad159255c68a1d@epcas1p3.samsung.com>
	<132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Agner <stefan@agner.ch>, narmstrong@baylibre.com
Cc: peng.fan@nxp.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 12/8/20 2:15 AM, Stefan Agner wrote:
> Amlogic AGX SoCs seem to have issue communicating with some eMMC
> devices (in particular with a Micron 128GB eMMC 5.1). The device
> is detected with 1-bit bus width, and at higher temperature loading
> pretty much anything from the storage fails: (e.g. fs_devread read erro=
r
> - block).
>=20
> When phase is set to 270=C2=B0 it is detected with 8-bit bus width and =
is
> working fine accross all temperatures.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Neil,
>=20
> I debugged this issue today on an ODROID N2+ not booting reliably. I am
> not sure if we can safely switch to 270=C2=B0 for all SoCs with
> amlogic,meson-axg-mmc, but I guess we have to try and see what happens?
> I will do a bit broader testing in the comming days here.

Some SoCs don't work fine with 180'. So I have changed 270' phase and Nei=
l had applied SoC compatible.
I guess that it's relevant to controlling clock. But In u-boot, meson_gx_=
mmc doesn't follow Linux kernel fully.
I will refactor meson_gxm_mmc file after finished my other work.

>=20
> Btw, I do see that 180=C2=B0 is also set in Linux. Do you have a patch =
to
> address this in Linux?

I didn't check Linux kernel yet in more detail. Also, i will investigate =
to check a meson mmc driver after finished my other job.

Best Regards,
Jaehoon Chung

>=20
> --
> Stefan
>=20
>=20
>  arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
>  drivers/mmc/meson_gx_mmc.c                | 9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inclu=
de/asm/arch-meson/sd_emmc.h
> index cb16f75fc6..db5e058098 100644
> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
> @@ -14,6 +14,7 @@
> =20
>  enum meson_gx_mmc_compatible {
>  	MMC_COMPATIBLE_GX,
> +	MMC_COMPATIBLE_AGX,
>  	MMC_COMPATIBLE_SM1,
>  };
> =20
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 5facbfdd9a..2c27113c10 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -64,14 +64,15 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> =20
>  	/*
>  	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
> +	 * AGX SoCs don't work reliable with some eMMCs with CLK_CO_PHASE_180
>  	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
>  	 * Other SoCs use CLK_CO_PHASE_180 by default.
>  	 * It needs to find what is a proper value about each SoCs.
>  	 */
> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
> -		meson_mmc_clk |=3D CLK_CO_PHASE_270;
> -	else
> +	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_GX))
>  		meson_mmc_clk |=3D CLK_CO_PHASE_180;
> +	else
> +		meson_mmc_clk |=3D CLK_CO_PHASE_270;
> =20
>  	/* 180 phase tx clock */
>  	meson_mmc_clk |=3D CLK_TX_PHASE_000;
> @@ -327,7 +328,7 @@ int meson_mmc_bind(struct udevice *dev)
> =20
>  static const struct udevice_id meson_mmc_match[] =3D {
>  	{ .compatible =3D "amlogic,meson-gx-mmc", .data =3D MMC_COMPATIBLE_GX=
 },
> -	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_G=
X },
> +	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_A=
GX },
>  	{ .compatible =3D "amlogic,meson-sm1-mmc", .data =3D MMC_COMPATIBLE_S=
M1 },
>  	{ /* sentinel */ }
>  };
>=20

