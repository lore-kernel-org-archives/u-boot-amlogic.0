Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web09.7438.1611753704566420705
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Jan 2021 05:21:44 -0800
Received: by mail-qk1-f170.google.com with SMTP id t63so1629640qkc.1
        for <u-boot-amlogic@groups.io>; Wed, 27 Jan 2021 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7al0y5VcXzra3rvGuaJ838yiCQwq8/1IpPa2g6aNtw=;
        b=Q9/Ls+0dFswlWZge7FJNmtJUJL2+l++J3ETw+InZ7S7p/5XPt3E4Egnc/vQUXDZFzN
         Xoh5HuXxDkR9OLNeq1VCYFj36hS2A/3QjLa127FJih1r/RoOHFZbYz4VHDjYbM1+DQ+D
         WqLZ5HR/7Su9up/rbwSia10hZtGYC/wtLzR8k=
Return-Path: <trini@konsulko.com>
Date: Wed, 27 Jan 2021 08:21:40 -0500
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd: pxe_utils: fix ipappend ip config empty vars
Message-ID: <20210127132140.GA7530@bill-the-cat>
References: <20210121074435.2754687-1-art@khadas.com>
MIME-Version: 1.0
In-Reply-To: <20210121074435.2754687-1-art@khadas.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O9T4zNOkGnr0n+A/"
Content-Disposition: inline
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

--O9T4zNOkGnr0n+A/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 03:44:35PM +0800, Artem Lapkin wrote:

> PROBLEM: If ipaddr, serverip, gatewayip or netmask variable undefined
> we can have for example ip=3D192.168.2.33:<NULL>:192.168.2.1:255.255.255.0
> yes its works same for linux kernel, but im think no need print <NULL>
>=20
> SUGGESTED SOLUTION:
> if some variable was undefined we need just print empty place like this
> ip=3D192.168.2.33::192.168.2.1:255.255.255.0
>=20
> Signed-off-by: Artem Lapkin <art@khadas.com>
>=20
> ---
>  cmd/pxe_utils.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/cmd/pxe_utils.c b/cmd/pxe_utils.c
> index 8716e782..2049c0f3 100644
> --- a/cmd/pxe_utils.c
> +++ b/cmd/pxe_utils.c
> @@ -395,9 +395,12 @@ static int label_boot(struct cmd_tbl *cmdtp, struct =
pxe_label *label)
>  	}
> =20
>  	if (label->ipappend & 0x1) {
> +		char *a =3D env_get("ipaddr");
> +		char *b =3D env_get("serverip");
> +		char *c =3D env_get("gatewayip");
> +		char *d =3D env_get("netmask");
>  		sprintf(ip_str, " ip=3D%s:%s:%s:%s",
> -			env_get("ipaddr"), env_get("serverip"),
> -			env_get("gatewayip"), env_get("netmask"));
> +			a ? a : "", b ? b : "", c ? c : "", d ? d : "");
>  	}
> =20
>  #ifdef CONFIG_CMD_NET

If Linux is happily parsing this, I'm not sure it's worth changing.

--=20
Tom

--O9T4zNOkGnr0n+A/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmARaOAACgkQFHw5/5Y0
tyzDRwv+IWTOs3qYFLf9gN7F7um/Eueq1sDEeQKbQeLp5WVECXjt+B43SaU9zDFV
uD5c9H+a91Ep8XXlkLhhKWR5TOmrki+vrtSnB5x2nCtyEkxHe26uZW6gQ9vWtN+p
GJMxcIzrCijVwPsitj3xyGHttrnVGTR8Sq1vl7QdCXHj/oE7NRu23gntm9Fe4G76
VMQv9LbeRk6q45zcJKV13vFJ70C6Fpr25MJmoLwAAWXrA48PYsAAx8DOZZ3L/08T
BdI8A3/xkdHENH3z15lYkngO8wVreJu1qjsoEbPy4UzGxCznKfCJumomsCjIydG1
VCj36Cpge/Y7goex4jPBvplt51gdwlZujcG9vm5H4DAXp1/swzaI+EpFLzBkqorZ
y+bjEWqi0pZDpIxC3aeMpAwBnUpnscn4q0jxCs184cWd8obuq8tcG+gi1hhEY8tL
7gvqZVvno3ynQgmxFfXUYyf3USULmlQ47EI5P4qv+oRR0qcKYPGQIzII4ADOJXnR
zx/2+rWG
=jctG
-----END PGP SIGNATURE-----

--O9T4zNOkGnr0n+A/--
