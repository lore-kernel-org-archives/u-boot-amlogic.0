Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web08.6602.1608009534644673694
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 21:18:55 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201215051851epoutp02b7d4831c34b7896ff3664908976e1e87~QzCZEER_81647116471epoutp02I
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 05:18:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201215051851epoutp02b7d4831c34b7896ff3664908976e1e87~QzCZEER_81647116471epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608009531;
	bh=SJvSn4efB2ADCzVyIz87n7SkZtzEyW+0QVGRo/7jMkE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=HLeZz2K9NIRzjwwtv5Q4BC3x3Z84wGelQ6Ho4N3pnOQ/KEH3FXwHmU8aV5ffDZuhC
	 R881cqascBWQ1fUYlXmc6JhMX3cyjLuJDxc902s4hIr2P7orHp6I54GvxK8G1GGxHd
	 gZmwojldIoG7EKm91I+/vfMQAQgpAs07Rfj3NPbs=
Subject: Re: [PATCH] mmc: meson-gx: change clock phase value on AGX SoCs
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <8a87b241-2573-3575-43ea-2343103ab7e7@samsung.com>
Date: Tue, 15 Dec 2020 14:19:11 +0900
MIME-Version: 1.0
In-Reply-To: <bd392bb1-8d7a-a72f-a927-0e47ae77641f@baylibre.com>
References: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
	<CGME20201214185836epcas1p34e12a8f346e812ba7e414043c4805f47@epcas1p3.samsung.com>
	<bd392bb1-8d7a-a72f-a927-0e47ae77641f@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Stefan Agner <stefan@agner.ch>
Cc: peng.fan@nxp.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 12/15/20 3:58 AM, Neil Armstrong wrote:
> Hi,
>=20
> On 07/12/2020 18:15, Stefan Agner wrote:
>> Amlogic AGX SoCs seem to have issue communicating with some eMMC
>> devices (in particular with a Micron 128GB eMMC 5.1). The device
>> is detected with 1-bit bus width, and at higher temperature loading
>> pretty much anything from the storage fails: (e.g. fs_devread read err=
or
>> - block).
>>
>> When phase is set to 270=C2=B0 it is detected with 8-bit bus width and=
 is
>> working fine accross all temperatures.
>=20
> This is new to G12, I only had such issues and reports for SM1 only unt=
il now.
>=20
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Hi Neil,
>>
>> I debugged this issue today on an ODROID N2+ not booting reliably. I a=
m
>> not sure if we can safely switch to 270=C2=B0 for all SoCs with
>> amlogic,meson-axg-mmc, but I guess we have to try and see what happens=
?
>> I will do a bit broader testing in the comming days here.
>=20
> amlogic,meson-axg-mmc covers too much SoCs, I'll prefer if you introduc=
e
> an u-boot only amlogic,meson-g12b-mmc compatible like I did for SM1.
>=20
>>
>> Btw, I do see that 180=C2=B0 is also set in Linux. Do you have a patch=
 to
>> address this in Linux?
>=20
> I never had such reports on Linux, I think because eMMCs are directly u=
sed
> in HS200 mode and 180=C2=B0 is the right configuration for HS200...

I have checked mainline kernel with Odroid-C4.
Linux Kernel is using PHASE_180 and enabled HS200 by default. That's why =
this issue doesn't report.
It's working fine with PHASE_180. But if mode is downgrade as DDR50 or lo=
wer mode than HS200.
It's also broken, like u-boot.

When i have changed from PHASE_180 to PHASE_270, it's working fine about =
all modes.

[    2.689222] mmc1: new HS200 MMC card at address 0001
[    2.692070] xhci-hcd xhci-hcd.0.auto: irq 34, io mem 0xff500000
[    2.697491] mmcblk1: mmc1:0001 BJTD4R 29.1 GiB

Current meson_gx_mmc doesn't support HS200 on u-boot side. (It needs to i=
mplement more things.)
So I think that it's right way to set to PHASE_270 on U-boot side.=20
If it needs to fix this on kernel side, i will send the patch.

Best Regards,
Jaehoon Chung

>=20
> Neil
>=20
>>
>> --
>> Stefan
>>
>>
>>  arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
>>  drivers/mmc/meson_gx_mmc.c                | 9 +++++----
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/incl=
ude/asm/arch-meson/sd_emmc.h
>> index cb16f75fc6..db5e058098 100644
>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
>> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
>> @@ -14,6 +14,7 @@
>> =20
>>  enum meson_gx_mmc_compatible {
>>  	MMC_COMPATIBLE_GX,
>> +	MMC_COMPATIBLE_AGX,
>>  	MMC_COMPATIBLE_SM1,
>>  };
>> =20
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index 5facbfdd9a..2c27113c10 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -64,14 +64,15 @@ static void meson_mmc_config_clock(struct mmc *mmc=
)
>> =20
>>  	/*
>>  	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
>> +	 * AGX SoCs don't work reliable with some eMMCs with CLK_CO_PHASE_18=
0
>>  	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
>>  	 * Other SoCs use CLK_CO_PHASE_180 by default.
>>  	 * It needs to find what is a proper value about each SoCs.
>>  	 */
>> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
>> -		meson_mmc_clk |=3D CLK_CO_PHASE_270;
>> -	else
>> +	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_GX))
>>  		meson_mmc_clk |=3D CLK_CO_PHASE_180;
>> +	else
>> +		meson_mmc_clk |=3D CLK_CO_PHASE_270;
>> =20
>>  	/* 180 phase tx clock */
>>  	meson_mmc_clk |=3D CLK_TX_PHASE_000;
>> @@ -327,7 +328,7 @@ int meson_mmc_bind(struct udevice *dev)
>> =20
>>  static const struct udevice_id meson_mmc_match[] =3D {
>>  	{ .compatible =3D "amlogic,meson-gx-mmc", .data =3D MMC_COMPATIBLE_G=
X },
>> -	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_=
GX },
>> +	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_=
AGX },
>>  	{ .compatible =3D "amlogic,meson-sm1-mmc", .data =3D MMC_COMPATIBLE_=
SM1 },
>>  	{ /* sentinel */ }
>>  };
>>
>=20
>=20

