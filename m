Received: by mail-qk1-f196.google.com with SMTP id s145so3105871qke.7
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQxiqa3FoBOP9T4x6ysNzPbP7Ey7KmDF6tj0Z1xbOOg=;
        b=ohmQ5dRJL1dWQ6wTapsloHV4WdY0wAq6ne2z1MKkkTGHoK5kROFLYQ7j7mnhorNyae
         GrNFwYF0nOZEX3Ff26ka0gxzNiWzV0XCjFcobh+0v+pU76W6WLT9htry5h3HaB6nz8pG
         9sB3pabdomp1x5/5dUut8yWMBCugkSsoArT1w=
Return-Path: <trini@konsulko.com>
Date: Thu, 4 Jul 2019 20:01:55 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] board: amlogic: add mailing-list to MAINTAINERS
Message-ID: <20190705000155.GV8554@bill-the-cat>
References: <20190704135938.1193-1-narmstrong@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190704135938.1193-1-narmstrong@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vy3x0i7GCC7mAH4A"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--vy3x0i7GCC7mAH4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 03:59:38PM +0200, Neil Armstrong wrote:

> Add missing mailing-list to the amlogic boards MAINTAINERS file.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Since you're going on vacation and this makes sense for the current
release, I'm grabbing this for you, I hope you don't mind!

Applied to u-boot/master, thanks!

--=20
Tom

--vy3x0i7GCC7mAH4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJdHpNzAAoJEIf59jXTHXZSOS8QAKcp6QZ9tTiM/JjwBDUcvHxQ
311iqTFShF89AyAls0FoHttoMlM2yngvrg5LkOUlLbSQQ3AySfrp2cDSvfhHzRJ8
F/k67ox6jIwuXv2Qe4l2+A50p8KWp5xCxzzHPNmSE/14ENG6dPRz9LQfiV3L230M
gq08E5ygq3gq8HEukpcZ062E6b6V3FtkdUugwUg81M/qDMpugpivfv+PVETfZcQJ
egtanxGre/zlkP+6UPet4/NC5vwE0Gxdp+4XOH9MLjcKk6g/k1FgEWGXBYOEnC1x
w//RwYGuwKLVMiQjgX1Rkdpncl93IJ8C/EfLtrTG9QuZ+yHHPn+WpowYVSq/HRnU
5l5aQ46dHnXFfT8m388uMFYFaN7HEzHPU2sJ7Yfdn1xutoZ3TGDKsM2vLllPOp74
tl+L/myE/uBACe1SkQGxMXGK9XaDXx0uX88KyQyKGpArbO7Gjb45oyQnVPhq6Bj9
X06bIpR6zPSiACwMCD49qEZXkMRYMFVj1co2FK2QwPZKbhxeDNuys4Qph6uZPwjc
bEnJFGS7W2l4Dk4Z/U1Lvwo5Bt+LOQw6kOprvlkKXm51PieAfTBsTipSVcd9OlAV
q8VhuyALDmgmo+/O5P3bu9wBAMEuJMIPWjsqdnXSdUIEjTatlC4RMhkwexTbVBrV
FCqTwlniM9GZXumFSYWb
=mR8w
-----END PGP SIGNATURE-----

--vy3x0i7GCC7mAH4A--
