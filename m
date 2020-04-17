Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web10.2868.1587135894708961020
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Apr 2020 08:04:54 -0700
Received: by mail-qt1-f195.google.com with SMTP id w24so2129713qts.11
        for <u-boot-amlogic@groups.io>; Fri, 17 Apr 2020 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VCLLQ/Nu/gF+lAIKDqzMRilbj7IWK2UBCJ7x7k8384M=;
        b=RrB9WFW5HaAG+M5+fv87P2W8SS8dHhrSeOIDYkbvj/N5veqSuu4oHGjdT4nz33+0Bu
         qSri9ESINcSEwAW0nDEA0n4/kSMRowvwO6yg0wG47STGMra5W54JCzvixU9hWcoHJj/5
         ivBmR5vZkb8+82dManxDPGb+jHDARjOkFSOcE=
Return-Path: <trini@konsulko.com>
Date: Fri, 17 Apr 2020 11:04:50 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20200417
Message-ID: <20200417150450.GB4555@bill-the-cat>
References: <8fa8ff4a-5965-8a27-9394-729b5692d9a9@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <8fa8ff4a-5965-8a27-9394-729b5692d9a9@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 11:53:51AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> This PR enables RNG on meson boards for UEFI, fixes the SMBIOS informatio=
n for ODROID-C2,
> fixes HDMI Video Output broken on GXBB/GXL/GXM based boards and adds supp=
ort for USB gadget
> on GXL/GXM boards.
>=20
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/2800
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 142a07f2a44262d76fec609e1fcde51794a456=
eb:
>=20
>   Merge branch 'master' of git://git.denx.de/u-boot-marvell (2020-04-14 0=
8:47:07 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20200417
>=20
> for you to fetch changes up to e8b6dd8263e84f52d91bc0ac3e2582cb6e832307:
>=20
>   configs: libretech-s912-pc: Enable USB gadget with Mass Storage functio=
n (2020-04-17 09:52:13 +0200)
>=20

NAK, this breaks dragonboard410c:
+(dragonboard410c) In file included from ../drivers/usb/gadget/../host/ehci=
=2Eh:13,
+(dragonboard410c)                  from ../drivers/usb/gadget/ci_udc.c:24:
+(dragonboard410c) ../include/generic-phy.h:221:29: error: unknown type nam=
e 'ofnode'
+(dragonboard410c)   221 | int generic_phy_get_by_node(ofnode node, int ind=
ex, struct phy *phy);
+(dragonboard410c)       |                             ^~~~~~
+(dragonboard410c) make[2]: *** [drivers/usb/gadget/ci_udc.o] Error 1
+(dragonboard410c) make[1]: *** [drivers/usb/gadget] Error 2

--=20
Tom

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6ZxYgACgkQFHw5/5Y0
tyyKOgv9Fu4lGEo/dyJ5x8T1IAT1sLje7PAQLJNgNqZqcF6+EukEFDZ68QzFXNGG
0ZP2faDLMBZuKhxfcw/IcI3zs9MWsVKz6iog82FkywCLQYQHX4PDNF9XWPcXQh2q
ZDeDQ3MLWs9GEG4zST29LOMv1meL7GHd6afQtBjZ6v+IDKtAaF6e+lwwR2y2RmcT
h7lSrmxYpje+r143JziFF7pX+tAsqX9uF5k1ShJvaVu5BOKL3KEg9bUi2UXAcMfe
EzBhM2eGZyZ86njG/l9dFeb/nrusr+b6RQfjORnRf+NApO3UwynK5Q9oUMfYmDPL
NoTg+54K3uaqHp9MhRD/OGRNhWt6w2lNB0xXi+Uk0AOzoe9AMmJ34gwBoflnninC
8f2L/P1Q4pS4cuAEbOoc0vITTD/nrNsQYW5eoA9dnIxBXVhWMnd2Wn5yflTEMxGX
nJH41NIQBFKdYVapl5TVlkfXogXmWBwG5c++BchYCRI7pc2hMq1ZTGTTMo4HK+vm
KMh6A6sm
=rinO
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
