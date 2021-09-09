Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web08.6001.1631186985760289344
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Sep 2021 04:29:45 -0700
Received: by mail-qk1-f178.google.com with SMTP id t190so1325999qke.7
        for <u-boot-amlogic@groups.io>; Thu, 09 Sep 2021 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q20/BKEmrzTDP2Q800P3rC5c6bHVWtvrQj+r9bjuawI=;
        b=QnLHbWV8pZTVafmLmOtXjGE569J7Bm7/J9dhhrdOx+XLPRprwgJGIb1WgVRJxxs6/L
         yK3kL6UVDXxqEE6Q3I3FXjyvQMp/c5cb+Z4o1RYdVFV+hozVORW1urYPGo6+oTwZz28g
         WDGXHDnXQkVnv3NA5kRSwTLXfPhXO0cvWW4Ac=
Return-Path: <trini@konsulko.com>
Date: Thu, 9 Sep 2021 07:29:42 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/9] ARM: meson: Sync Amlogic DT from Linux 5.14
Message-ID: <20210909112942.GV12964@bill-the-cat>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
 <20210908154606.GF12964@bill-the-cat>
 <e5cbdedc-5c62-ba35-c5fc-194042870875@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <e5cbdedc-5c62-ba35-c5fc-194042870875@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74hf9PSALuoWtOh/"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--74hf9PSALuoWtOh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 09, 2021 at 11:42:34AM +0200, Neil Armstrong wrote:
> Hi Tom,
>=20
> On 08/09/2021 17:46, Tom Rini wrote:
> > On Wed, Sep 08, 2021 at 04:17:20PM +0200, Neil Armstrong wrote:
> >=20
> >> Import Amlogic DT changes from Linux commit 7d2a07b76933 ("Linux 5.14"=
),
> >> dt-bindings clock changes and new meson-g12b-gsking-x.dts,
> >> meson-sm1-bananapi-m5 & odroid-hc4 boards.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >=20
> > Given some other related email threads, I'm curious.  Does this mean
> > that everything U-Boot specific is currently in -u-boot.dtsi files?  Or
> > is there some manual syncing within the main dts files (aside from
> > perhaps needing to #include a -u-boot.dtsi) ?  Thanks!
>=20
> The dts, dtsi and bindings files are copied verbatim from Linux and all
> the U-Boot specific changes are in the -u-boot.dtsi files indeed.
>=20
> Is this an issue somehow ?

Great, that's exactly what I was hoping to hear.

--=20
Tom

--74hf9PSALuoWtOh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmE58B4ACgkQFHw5/5Y0
tyye3QwAsYHonXCoBvcXOH6fyObCvrOe0jhPJMhVOCffheHE3tmKna2+MpesSqEp
0iDt5LyVUp9pGF6/81kb4XvVmSTPqXnCz+wrpjSoM7HgzipAE1aTe2f9QMEJVXdN
fAEwOMkSy0Xz2/CXlj6vk4LD7N2ojSmtMccwMCIqT4RdolEkS3qPgYKz/feYRD3D
mP5UPzmIoceMzVF7loHq/IyLEyjNlKNl8V57qLiQxVdnZAsMUVRauDpIGG32vn4A
tsWAg4U6QmwcbQ27W0ZrdczsuYsvRRqC7n+z6VL9KKQV4so0Zu8VAETbUhtLo6ge
XjtrGKjrsqiMweEEHxhDUPj5VDni3YL66ULcN/Ydbq/R6x5oNM86h/4O5iL7IlD0
aUe4s2rx+DMSpSDW8CzybVvA8GGBlWt2u14lkMXoJA7+4EXVt/MrLqTstMEe5tQs
fTWKce5cdEqZbvnjS+xL0ZlO0VSF7f8xghMuczKzXjlCpwsr+JA60vjfVpSuwk+Y
QjPALP1o
=RPud
-----END PGP SIGNATURE-----

--74hf9PSALuoWtOh/--
