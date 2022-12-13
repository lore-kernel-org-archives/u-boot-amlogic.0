Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web10.73870.1670940388743909936
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 06:06:28 -0800
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3c090251d59so192687557b3.4
        for <u-boot-amlogic@groups.io>; Tue, 13 Dec 2022 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iio3GaxpfdUeggAm8rVvBBcHIxXy+nmfjvAEBuAY7wo=;
        b=VSVL9YK8JHh5jPVyCwPz0YE4jErKailwIste2uI0awz3yUhU1+9x4W4d1S2V4thQOT
         JtuJXxC35D26LfLNjaTUXNLXR6AxLddCZqBPPeSLxBSFqxefmz2NplMgpYvWkKLEbWSw
         mwJPkepMZsCjPg5tJ06i0EmhOKMWxbX+lPal0=
Return-Path: <trini@konsulko.com>
Date: Tue, 13 Dec 2022 09:06:25 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] arch/arm: sm: introduce efusedump command
Message-ID: <20221213140625.GU3787616@bill-the-cat>
References: <20221209125204.62960-1-avromanov@sberdevices.ru>
 <20221212160834.GX3787616@bill-the-cat>
 <20221213135856.zhy66q2ude3webro@cab-wsm-0029881.lan>
MIME-Version: 1.0
In-Reply-To: <20221213135856.zhy66q2ude3webro@cab-wsm-0029881.lan>
Content-Type: multipart/mixed; boundary="Groupsio=FM8DAA2ks6GfZ2Km10tX"
To: Alexey Romanov <AVRomanov@sberdevices.ru>
Cc: "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=FM8DAA2ks6GfZ2Km10tX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 01:59:01PM +0000, Alexey Romanov wrote:
> Hello!
>=20
> On Mon, Dec 12, 2022 at 11:08:34AM -0500, Tom Rini wrote:
> > On Fri, Dec 09, 2022 at 03:52:04PM +0300, Alexey Romanov wrote:
> >=20
> > > Using this command user can print efuse memory:
> > >=20
> > > $ sm efusedump 0 10
> > >   00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...
> > >=20
> > > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> > > ---
> > >  arch/arm/mach-meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 35 insertions(+), 1 deletion(-)
> >=20
> > This needs to be moved done under cmd/ somewhere, perhaps cmd/meson/
> >=20
> > --=20
> > Tom
>=20
>=20
> Do you mean it must be moved by a different patchset? From my point of vi=
ew,=20
> your comment is totally right, because arch dependent commands are locate=
d at=20
> cmd/ARCH path. But I'm afraid my patchset is just about new helper comman=
d.=20
>=20
> Anyway, I can send a new different patchset with refactoring suggested by=
 you.=20
> But, please, comment out some words about new efuse command if possible.

I think your changes are fine, I'd like to see this as a 2 part patch
where part 1 is just moving the code and 2 is adding your changes.

--=20
Tom

--Groupsio=FM8DAA2ks6GfZ2Km10tX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmOYhtwACgkQFHw5/5Y0
tyzRDQwAm85lp/4ZXm7pYXgtfKM8ufJyZYXmvl9dquO+guuzhcIaQlIzfljTAk7a
GcAAwCdFIDKqT6VCCLsN8bFlBIEIJyV+/fWP6wLNw/EKh1GnoyloZBPPZ8QPl7RP
dDvA7Vr88xT05/0qjhIGMHl09YB5NNC1EdkZMEZs2OvJ5tj1YQE9sgXXDTbg3clT
CShLMYmnqk9VtOxW6v46+kUfHGigRtbziX7hmRfBmzaoBziZXMcUk9j6SmSkOXxf
h6b2qGks6K3IEZMnB712qxZ1WbLvvoQ8CUG1PguUpWvVRKJsvbd2UCG3DnKnIC8A
33FdgYW+rWcNw72oPOk5QVUoAfMLcysF6ak5h5FOR+ZVEMmGbgMZ3rvE9Rn97JWE
tjzhJ94R92xxwmPHJDWYFv+bpCL49DE7MYZxGdV51q1jNxyNrg1s6YplxGXrGcxD
AG0GQR45/0rmbmELOgFp84xwxKFpzQm0CqQsozifV3s75MoWmgv3q4oXgT/cXf8f
sWOyvrpI
=zhha
-----END PGP SIGNATURE-----

--Groupsio=FM8DAA2ks6GfZ2Km10tX--
