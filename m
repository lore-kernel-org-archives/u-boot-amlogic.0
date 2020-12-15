Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web12.7708.1608017150915200114
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 23:25:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1608017147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQYkIyfBRWr1RQrGh17ZfWocF9n3EEUqE5Swh910iX8=;
	b=c/ZPhaUMJt6vY0LBkoWybdsN+BmqBPQN0YidD5RH5q3Ks3yElo/487ZrlKwWqkLt/rvmR2
	1+8OpyEFM1hQtyjJkxUteBrzT5Fo7/Sqmcm3dBnVHOeKw7tX2sZb6NkFuEoOhoZiYFJvnf
	dp2Q3mhZxWa4TzEl1HcEgZc71b+RGjc=
MIME-Version: 1.0
Date: Tue, 15 Dec 2020 08:25:47 +0100
From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] mmc: meson-gx: change clock phase value on AGX SoCs
In-Reply-To: <8a87b241-2573-3575-43ea-2343103ab7e7@samsung.com>
References: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
 <CGME20201214185836epcas1p34e12a8f346e812ba7e414043c4805f47@epcas1p3.samsung.com>
 <bd392bb1-8d7a-a72f-a927-0e47ae77641f@baylibre.com>
 <8a87b241-2573-3575-43ea-2343103ab7e7@samsung.com>
Message-ID: <ecf4f412a7b56eee8730391347f39409@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, peng.fan@nxp.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 2020-12-15 06:19, Jaehoon Chung wrote:
> Hi,
>=20
> On 12/15/20 3:58 AM, Neil Armstrong wrote:
>> Hi,
>>
>> On 07/12/2020 18:15, Stefan Agner wrote:
>>> Amlogic AGX SoCs seem to have issue communicating with some eMMC
>>> devices (in particular with a Micron 128GB eMMC 5.1). The device
>>> is detected with 1-bit bus width, and at higher temperature loading
>>> pretty much anything from the storage fails: (e.g. fs_devread read er=
ror
>>> - block).
>>>
>>> When phase is set to 270=C2=B0 it is detected with 8-bit bus width an=
d is
>>> working fine accross all temperatures.
>>
>> This is new to G12, I only had such issues and reports for SM1 only un=
til now.
>>
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>> Hi Neil,
>>>
>>> I debugged this issue today on an ODROID N2+ not booting reliably. I =
am
>>> not sure if we can safely switch to 270=C2=B0 for all SoCs with
>>> amlogic,meson-axg-mmc, but I guess we have to try and see what happen=
s?
>>> I will do a bit broader testing in the comming days here.
>>
>> amlogic,meson-axg-mmc covers too much SoCs, I'll prefer if you introdu=
ce
>> an u-boot only amlogic,meson-g12b-mmc compatible like I did for SM1.
>>
>>>
>>> Btw, I do see that 180=C2=B0 is also set in Linux. Do you have a patc=
h to
>>> address this in Linux?
>>
>> I never had such reports on Linux, I think because eMMCs are directly =
used
>> in HS200 mode and 180=C2=B0 is the right configuration for HS200...
>=20
> I have checked mainline kernel with Odroid-C4.
> Linux Kernel is using PHASE_180 and enabled HS200 by default. That's
> why this issue doesn't report.
> It's working fine with PHASE_180. But if mode is downgrade as DDR50 or
> lower mode than HS200.
> It's also broken, like u-boot.

That make sense. It seems that HS200 is really required to have a stable
SD communication on this platform.

>=20
> When i have changed from PHASE_180 to PHASE_270, it's working fine
> about all modes.
>=20
> [    2.689222] mmc1: new HS200 MMC card at address 0001
> [    2.692070] xhci-hcd xhci-hcd.0.auto: irq 34, io mem 0xff500000
> [    2.697491] mmcblk1: mmc1:0001 BJTD4R 29.1 GiB
>=20
> Current meson_gx_mmc doesn't support HS200 on u-boot side. (It needs
> to implement more things.)
> So I think that it's right way to set to PHASE_270 on U-boot side.=20
> If it needs to fix this on kernel side, i will send the patch.

After more testing, we found that a 64GB eMMC stopped working when using
270=C2=B0. We now switched back to 180=C2=B0 and lowered frequency to 24M=
Hz. This
setting works on all eMMCs we had around to test, across temperature
ranges (booting when cold, as well as booting when heated up slightly).

Downstream U-Boot seems to use 40MHz clock, and switches phase depending
on frequency:
co-phase 0x3, tx-dly 0, clock 400000
co-phase 0x1, tx-dly 0, clock 40000000

I tried to implement this in a quick hack, but it did not work reliably.
However, as far as I can tell downstream U-Boot also does HS200 link
training etc... So it seems HS200 link training is required to make
things work properly.

--
Stefan


>=20
> Best Regards,
> Jaehoon Chung
>=20
>>
>> Neil
>>
>>>
>>> --
>>> Stefan
>>>
>>>
>>>  arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
>>>  drivers/mmc/meson_gx_mmc.c                | 9 +++++----
>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/inc=
lude/asm/arch-meson/sd_emmc.h
>>> index cb16f75fc6..db5e058098 100644
>>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> @@ -14,6 +14,7 @@
>>>
>>>  enum meson_gx_mmc_compatible {
>>>  	MMC_COMPATIBLE_GX,
>>> +	MMC_COMPATIBLE_AGX,
>>>  	MMC_COMPATIBLE_SM1,
>>>  };
>>>
>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>> index 5facbfdd9a..2c27113c10 100644
>>> --- a/drivers/mmc/meson_gx_mmc.c
>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>> @@ -64,14 +64,15 @@ static void meson_mmc_config_clock(struct mmc *mm=
c)
>>>
>>>  	/*
>>>  	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
>>> +	 * AGX SoCs don't work reliable with some eMMCs with CLK_CO_PHASE_1=
80
>>>  	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
>>>  	 * Other SoCs use CLK_CO_PHASE_180 by default.
>>>  	 * It needs to find what is a proper value about each SoCs.
>>>  	 */
>>> -	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
>>> -		meson_mmc_clk |=3D CLK_CO_PHASE_270;
>>> -	else
>>> +	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_GX))
>>>  		meson_mmc_clk |=3D CLK_CO_PHASE_180;
>>> +	else
>>> +		meson_mmc_clk |=3D CLK_CO_PHASE_270;
>>>
>>>  	/* 180 phase tx clock */
>>>  	meson_mmc_clk |=3D CLK_TX_PHASE_000;
>>> @@ -327,7 +328,7 @@ int meson_mmc_bind(struct udevice *dev)
>>>
>>>  static const struct udevice_id meson_mmc_match[] =3D {
>>>  	{ .compatible =3D "amlogic,meson-gx-mmc", .data =3D MMC_COMPATIBLE_=
GX },
>>> -	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE=
_GX },
>>> +	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE=
_AGX },
>>>  	{ .compatible =3D "amlogic,meson-sm1-mmc", .data =3D MMC_COMPATIBLE=
_SM1 },
>>>  	{ /* sentinel */ }
>>>  };
>>>
>>
>>
