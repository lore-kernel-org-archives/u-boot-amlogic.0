Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.web10.803.1600787302394340485
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Sep 2020 08:08:22 -0700
Received: by mail-qk1-f194.google.com with SMTP id n133so19287862qkn.11
        for <u-boot-amlogic@groups.io>; Tue, 22 Sep 2020 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BilbgUHpinodlQodoycZQjkVDD8wA1UunnQ+0aHcV50=;
        b=rLYTIgRkExg0S2WK//ycHllfkRbS6uiWKODIZGR92bswOzenZnDziRWDtxLJwUJz5N
         ycyGBszjYIJaIIEc97Piz6W5sUODw5agvVUhY7Szt7a3F459xDl8mjvzmarRR2reY/s2
         VENn5AvPO7gG0pxTwDDr1rLKmz2d2arbnZKjw=
Return-Path: <trini@konsulko.com>
Date: Tue, 22 Sep 2020 11:08:16 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 7/7] arm: meson: change trace level for phy errors managed by uclass
Message-ID: <20200922150816.GI14816@bill-the-cat>
References: <20200703153646.28533-1-patrick.delaunay@st.com>
 <20200703153646.28533-8-patrick.delaunay@st.com>
MIME-Version: 1.0
In-Reply-To: <20200703153646.28533-8-patrick.delaunay@st.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wG6oWOmweUVxAUPD"
Content-Disposition: inline
To: Patrick Delaunay <patrick.delaunay@st.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
List-ID: <u-boot-amlogic@groups.io>

--wG6oWOmweUVxAUPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 05:36:46PM +0200, Patrick Delaunay wrote:

> As the error message is now displayed by generic phy functions,
> the pr_err can be change to pr_debug.
>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--wG6oWOmweUVxAUPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl9qE18ACgkQFHw5/5Y0
tyyIngwAuSj9JVhiMwfqaztoAClPPhHDBAP+XeEcwsK5vaRvqC6uMcrSRP5SvEav
omYzUzjRnHzbPNrE1eVK86JhHAlOkjuX7jL1KuuWlB08PeXEpQkxbvUeK8OZ5D8c
o/C9/Rg2HPLYm1c9wgPBjMWCQpM1QP1AVmAkVGp6aW9NUHL8zydbkMK7jOLGZwCP
NGHkC/skLcjLPqXpmVI+sNF0Fg1/hExzqaZHumEdnOYaMxXVamao54SW5XrtJS4t
kpwc04LTdqU4mQoJrFNCyHCaGohoHpgyURafjf4RQHpg50qO9eavy4+hE4o4JQZD
4vdNRSBMarmzE4dOLFJ8XlacZGp5brxNvVVDJ/4HMjirc3wMRZd7klvvyt0FWdwR
VPP+DOuFO+mWi4dp7KnvKgYPg3/hNyUnHyXNACLxQOozcRsPOLUkPsEhL4agu/vl
fjDHlkE5XJApxsR7Nj0M9OWx1KR29Kyovcd10et0DJq1OhCOrP58zZS8POJGnLPB
1zn+mUh1
=blzh
-----END PGP SIGNATURE-----

--wG6oWOmweUVxAUPD--
