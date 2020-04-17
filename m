Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.44.1587139293186792828
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Apr 2020 09:01:34 -0700
Received: by mail-wr1-f68.google.com with SMTP id a25so3684640wrd.0
        for <u-boot-amlogic@groups.io>; Fri, 17 Apr 2020 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=27XThHgakv3nZ6OtE5K7vCVZu1NLWppmfCAdSGo/UZ4=;
        b=xvKRpCcbRts7YvxNL/EhxeHtaE8TRpeiAik1kmQhnGHanMFrJX2gflshCVEXr6l+qm
         xucygS9Qv3bHTqleFDxZgPaH8LJtQIXX4q5wVKLNLa6tEHSyA6DxzBY3ToHnpCYRHBM1
         HEna2EpxX1dta3HOFrDfOJrzKwUcHZH/MY0zlHFhyJgSS5ARxcCknhVA2KfTluv9jYmn
         vrNj7Hq/N3rTovaNk8hJafpMKH2Dsars4+IOI3+p5FXOBwzwJ1MZVCZtpGqP4k48vn0q
         J0LmWZmNyNhtGi95kZBL6ZERRyU+KEGxiIVdjhk5fY6tMaSbxH7ss4pVX0l5Xis6XJ7M
         7tnQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200417
References: <8fa8ff4a-5965-8a27-9394-729b5692d9a9@baylibre.com>
 <20200417150450.GB4555@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9750ac1d-6e42-0af7-b922-2f3b9b51098b@baylibre.com>
Date: Fri, 17 Apr 2020 18:01:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200417150450.GB4555@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=13P6i5xCrL5Fc3GcuHC0"
To: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=13P6i5xCrL5Fc3GcuHC0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/04/2020 17:04, Tom Rini wrote:
> On Fri, Apr 17, 2020 at 11:53:51AM +0200, Neil Armstrong wrote:
>=20
>> Hi Tom,
>>
>> This PR enables RNG on meson boards for UEFI, fixes the SMBIOS informat=
ion for ODROID-C2,
>> fixes HDMI Video Output broken on GXBB/GXL/GXM based boards and adds su=
pport for USB gadget
>> on GXL/GXM boards.
>>
>> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogi=
c/pipelines/2800
>>
>> Thanks,
>> Neil
>>
>> The following changes since commit 142a07f2a44262d76fec609e1fcde51794a4=
56eb:
>>
>>   Merge branch 'master' of git://git.denx.de/u-boot-marvell (2020-04-14=
 08:47:07 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-bo=
ot-amlogic-20200417
>>
>> for you to fetch changes up to e8b6dd8263e84f52d91bc0ac3e2582cb6e832307=
:
>>
>>   configs: libretech-s912-pc: Enable USB gadget with Mass Storage funct=
ion (2020-04-17 09:52:13 +0200)
>>
>=20
> NAK, this breaks dragonboard410c:
> +(dragonboard410c) In file included from ../drivers/usb/gadget/../host/e=
hci.h:13,
> +(dragonboard410c)                  from ../drivers/usb/gadget/ci_udc.c:=
24:
> +(dragonboard410c) ../include/generic-phy.h:221:29: error: unknown type =
name 'ofnode'
> +(dragonboard410c)   221 | int generic_phy_get_by_node(ofnode node, int =
index, struct phy *phy);
> +(dragonboard410c)       |                             ^~~~~~
> +(dragonboard410c) make[2]: *** [drivers/usb/gadget/ci_udc.o] Error 1
> +(dragonboard410c) make[1]: *** [drivers/usb/gadget] Error 2
>=20

Right, will fix.

Thanks,
Neil


--Groupsio=13P6i5xCrL5Fc3GcuHC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAl6Z0tgACgkQd9zb2sjI
SdEaNA//a72FwgJ6eMwLGjUB4QiIi+H2IEIVXHhRB23WA2wy7ueJ3TeDd4cbf8Jk
l+c/b/sSYFGMf18YtSUfK9nfSVDeXMdPRqe4QNMQpC1yZVIvmKdNhFS1GpOptfMh
SWE+UzvXltg+LTd/izSpilWcvxWbEyc9nd7xz1caD8lLPk4NQaLM1WZJYe8Wt+DC
hRmz+HY5a3c85PMRufqbZxs0txYRFRqnOuTRdTK9xMuFFu+fFkVbZcQDRvazglQf
ttjK6ktdQJDruWeIgZ/aNKMScr3h7SuULG7/sneG/69LAYOQIs7erq8vEEJCQIgU
A2iXfFIR5LgLkm3lf+f0vdpdG5Z1ahLGCHOH3V0YtCxFmQLVdRI6ZQ6MrpEwmDh4
A7mlZ9LZuMiscZidPxLrd94OGuGrxIK2qvus9A3WiEX/EciV9Lhm6ct06GS4gZNG
5xZZkHDMEotLbscK34W66eUcQxBxe+WlUrM/GfTHw/n4Mt3BWrlcvcgq8+seWqXi
/ZbYs67jHLSaF/CRIFX/y4kVHfbeiHgqllNbxzbkwHLjr4pZsGnv9rBosFG41yTw
xCFqWe/dSpVZO0EkDUTGS0puC+l5uDfxcgnygYkAzRtEx6bwCOFnNQppd+NMC91+
hN5rFAdHkxvNFU3ZwXf1CvqfnLiwJQ5NPLjlKBrM35d7LIH29O8=
=C8b7
-----END PGP SIGNATURE-----

--Groupsio=13P6i5xCrL5Fc3GcuHC0--
