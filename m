Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.14108.1660062784948576046
 for <u-boot-amlogic@groups.io>;
 Tue, 09 Aug 2022 09:33:05 -0700
Received: by mail-qv1-f41.google.com with SMTP id h8so8948728qvs.6
        for <u-boot-amlogic@groups.io>; Tue, 09 Aug 2022 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dPmytUMttmfWJqpPwpj5werRhARQCBgH4Trz712S6Kg=;
        b=G9SEDiNcv+Dtwb1lOP5wNQmQV08dOVWTqqpVA5w1O2TgyB9F4BSP1zffahQiGh+t7w
         Be+Ol7vA1/EYo6lNTm4Gp21R05D+Qm4/gdCGegUQYs7BCTDl04QTHGLed6Gw6yRoA104
         SQU9lwkLAZuJyOb219AsY1YR6nwzR9PerNevg=
Return-Path: <trini@konsulko.com>
Date: Tue, 9 Aug 2022 12:33:01 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20220809
Message-ID: <20220809163301.GX1146598@bill-the-cat>
References: <7635ad28-344c-4a83-03aa-c23c3fd866d0@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <7635ad28-344c-4a83-03aa-c23c3fd866d0@baylibre.com>
Content-Type: multipart/mixed; boundary="Groupsio=kj57WGhUK457LyxQz63l"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=kj57WGhUK457LyxQz63l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2022 at 10:21:42AM +0200, Neil Armstrong wrote:

>=20
> Hi Tom,
>=20
> Here's changes for next release:
> - fixup error on efuse commands return
> - add documentation on boot flow
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/13087
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 2d2c61ff0460740d9ec5a44dbef9255a8c6906=
96:
>=20
>   Merge tag 'efi-2022-07-rc7' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2022-07-06 09:17:08 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20220809
>=20
> for you to fetch changes up to 3145e0d0ff0837647351f2ca261b4cde779f83e0:
>=20
>   ARM: meson: fixup error on efuse commands return (2022-08-08 09:56:38 +=
0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=kj57WGhUK457LyxQz63l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLyjDcACgkQFHw5/5Y0
tyxb5gv/etPUOnBzARXnWNd9gqPF8M0+9FyEowRHB/vUYrGjeRw2WGLFw13SWO/v
M16yKyN9KlOe4+AOvp2NsxCQKV0UC3qp1IvjHpbe48pe1OBqkojsvGTScG5pz0t9
9HZReVYLX13jg/Daa2D2W5HRQ3KvFlJXeU9sZLEdR4Sk9xEtZyEH7NvQ11b9C0jI
Ngvcg7/0/4O0OX/3WdnsLjkb3ewTnX6AsyZG5qxfpE0rV+oUzf/qjNHTSyCgSL39
ZlJN0Jl8RhMZhwStfWEX1cuInSWt7idB+gxNNMyq8oMxT2e0tNkQ9V8rOKrt35hg
AqmRvcamzWZ4tgMoqTF56Ofg3XaM7aPLVtHCMzEG8ju4Xx4nVkPiXhHF3R+0J5gB
dge2yDXELOEjFAKHIHCENic1OM0J2ZH2uYvj6lErVT+McLqIIVzDYHuPG9xUfRPd
7S0P0EnljRhhtfJiNYvuugqeIgtxU78qZXnDavvOoy0ZWbkz3MROwJbv3TMjSH4L
Zj8PzQyM
=K9Aa
-----END PGP SIGNATURE-----

--Groupsio=kj57WGhUK457LyxQz63l--
