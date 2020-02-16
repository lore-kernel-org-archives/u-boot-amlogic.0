Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web12.9828.1581842949932798429
 for <u-boot-amlogic@groups.io>;
 Sun, 16 Feb 2020 00:49:10 -0800
Date: Sun, 16 Feb 2020 09:48:59 +0100
From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 1/1] clk: meson-g12a: missing break
Message-ID: <20200216094859.465ff909@jawa>
In-Reply-To: <20200215201054.5139-1-xypron.glpk@gmx.de>
References: <20200215201054.5139-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/Hx.Vh_OPTe0CYMUcXBaLE1d"; protocol="application/pgp-signature"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Sig_/Hx.Vh_OPTe0CYMUcXBaLE1d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Feb 2020 21:10:54 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Add missing break for CLKID_PCIE_PLL in switch statement.
>=20
> Reported by CppCheck.
>=20
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Fixes: 08e09c263fdf ("clk: meson-g12a: Add PCIE PLL support")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> Looking at the code it seems obvious that something is wrong in commit
> 08e09c263fdf but I have no board for testing.
> ---
>=20
>  drivers/clk/meson/g12a.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 686d94ebfe..cada80e6b5 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -804,6 +804,7 @@ static ulong meson_clk_get_rate_by_id(struct clk
> *clk, unsigned long id) break;
>  	case CLKID_PCIE_PLL:
>  		rate =3D meson_pcie_pll_get_rate(clk);
> +		break;
>  	case CLKID_VPU_0:
>  		rate =3D meson_div_get_rate(clk, CLKID_VPU_0_DIV);
>  		break;
> --
> 2.25.0
>=20

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Hx.Vh_OPTe0CYMUcXBaLE1d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl5JAfsACgkQAR8vZIA0
zr3C/wgAtJF/cop8wn/XTlsCvJe5jrpTzXRXG9OfKODh3ZNG6HK6TN3/p376mz3y
3w4P7KRTje9c0b+K2gmPJSGx6Xmg2IsE/TDfFlTe9qSUZwDiQmHUkuxMr6/qcoXv
+ofQd879qhJLCS+iMpN9/XSWonw61KQPGMde7Ixohc3XMpj8hQnjnbuMahyLSBHY
W3uPY46Y4Fx1ENbA46YvpLdhZd4zaxpPbbP2bF9BRlZ9CEeL72eeWrwbKCDhtSM4
xyp/62ObxSFprk7ZtSGmHN0e/4nqhInm4gRGPeafavE21SJBSIsEQBqijZ7dsKSP
p1KEtKStW3M649tG8rLp3jDFrKGN9g==
=20dB
-----END PGP SIGNATURE-----

--Sig_/Hx.Vh_OPTe0CYMUcXBaLE1d--
