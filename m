Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
 by mx.groups.io with SMTP id smtpd.web10.12792.1587060904773097151
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Apr 2020 11:15:05 -0700
Received: by mail-qk1-f193.google.com with SMTP id b62so22361667qkf.6
        for <u-boot-amlogic@groups.io>; Thu, 16 Apr 2020 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hmugZyl7/vkpoNB3PqTGyEIhsE0g8Lr75chs6SYKFTU=;
        b=ko/Y3fcMYlVCNeoOSS5pRLBTY0jQOvJKveFIvJztWRAYux9xuulZrx9f0fhwDRL50p
         HTA7PEB7OVOkYAMcS5w4jAWkYVgicHQljE6QFcByLNVPDwKgAwudna08qi7sG32Ceuez
         n+muvTs9I+6LglnM6VV9e6VYbJVjLlNq3IypQ=
Return-Path: <trini@konsulko.com>
Date: Thu, 16 Apr 2020 14:15:00 -0400
From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/10] generic-phy: add generic_phy_get_by_node()
Message-ID: <20200416181500.GZ12111@bill-the-cat>
References: <20200330092732.7198-1-narmstrong@baylibre.com>
 <20200330092732.7198-2-narmstrong@baylibre.com>
 <3980a842-2242-f033-0778-c62b59515f68@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <3980a842-2242-f033-0778-c62b59515f68@baylibre.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufMBWnG1WFkAvCRz"
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, marex@denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--ufMBWnG1WFkAvCRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 06:14:18PM +0200, Neil Armstrong wrote:
> Tom, Marek,
>=20
> On 30/03/2020 11:27, Neil Armstrong wrote:
> > Add generic_phy_get_by_node() to get a PHY phandle from a node instead
> > of a udevice.
> >=20
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/phy/phy-uclass.c | 17 ++++++++++++-----
> >  include/generic-phy.h    | 27 +++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+), 5 deletions(-)
>=20
>=20
> Are you ok with this change ?

Reviewed-by: Tom Rini <trini@konsulko.com>

>=20
> Neil
>=20
> >=20
> > diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> > index e201a90c8c..de2c3d2b8e 100644
> > --- a/drivers/phy/phy-uclass.c
> > +++ b/drivers/phy/phy-uclass.c
> > @@ -31,20 +31,20 @@ static int generic_phy_xlate_offs_flags(struct phy =
*phy,
> >  	return 0;
> >  }
> > =20
> > -int generic_phy_get_by_index(struct udevice *dev, int index,
> > -			     struct phy *phy)
> > +int generic_phy_get_by_node(ofnode node, int index, struct phy *phy)
> >  {
> >  	struct ofnode_phandle_args args;
> >  	struct phy_ops *ops;
> >  	struct udevice *phydev;
> >  	int i, ret;
> > =20
> > -	debug("%s(dev=3D%p, index=3D%d, phy=3D%p)\n", __func__, dev, index, p=
hy);
> > +	debug("%s(node=3D%s, index=3D%d, phy=3D%p)\n",
> > +	      __func__, ofnode_get_name(node), index, phy);
> > =20
> >  	assert(phy);
> >  	phy->dev =3D NULL;
> > -	ret =3D dev_read_phandle_with_args(dev, "phys", "#phy-cells", 0, inde=
x,
> > -					 &args);
> > +	ret =3D ofnode_parse_phandle_with_args(node, "phys", "#phy-cells", 0,
> > +					     index, &args);
> >  	if (ret) {
> >  		debug("%s: dev_read_phandle_with_args failed: err=3D%d\n",
> >  		      __func__, ret);
> > @@ -88,6 +88,12 @@ int generic_phy_get_by_index(struct udevice *dev, in=
t index,
> > =20
> >  err:
> >  	return ret;
> > +}
> > +
> > +int generic_phy_get_by_index(struct udevice *dev, int index,
> > +			     struct phy *phy)
> > +{
> > +	return generic_phy_get_by_node(dev_ofnode(dev), index, phy);
> >  }
> > =20
> >  int generic_phy_get_by_name(struct udevice *dev, const char *phy_name,
> > diff --git a/include/generic-phy.h b/include/generic-phy.h
> > index 95caf58341..5873ffb2e0 100644
> > --- a/include/generic-phy.h
> > +++ b/include/generic-phy.h
> > @@ -193,6 +193,33 @@ int generic_phy_power_off(struct phy *phy);
> >  int generic_phy_get_by_index(struct udevice *user, int index,
> >  			     struct phy *phy);
> > =20
> > +/**
> > + * generic_phy_get_by_node() - Get a PHY device by integer index on of=
node
> > + *
> > + * @node:	the device node
> > + * @index:	The index in the list of available PHYs
> > + * @phy:	A pointer to the PHY port
> > + *
> > + * This looks up a PHY device for a client device based on its ofnode =
and on
> > + * its position in the list of the possible PHYs.
> > + *
> > + * example:
> > + * usb1: usb_otg_ss@xxx {
> > + *       compatible =3D "xxx";
> > + *       reg =3D <xxx>;
> > + *   .
> > + *   .
> > + *   phys =3D <&usb2_phy>, <&usb3_phy>;
> > + *   .
> > + *   .
> > + * };
> > + * the USB2 phy can be accessed by passing index '0' and the USB3 phy =
can
> > + * be accessed by passing index '1'
> > + *
> > + * @return 0 if OK, or a negative error code
> > + */
> > +int generic_phy_get_by_node(ofnode node, int index, struct phy *phy);
> > +
> >  /**
> >   * generic_phy_get_by_name() - Get a PHY device by its name.
> >   *
> >=20
>=20

--=20
Tom

--ufMBWnG1WFkAvCRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6YoJ4ACgkQFHw5/5Y0
tywShQwApUsB8ezSj20zwFa7CTfoMbzssvSCDUcZjwF1KlG9F1ATcsnViBBA7NJ4
IYpsoSlN11M7P6PyVALXk3SycSnYP/V6EFsTicPIEisI4bIq/7Yt1KxlnHaDU4on
ltuVg21hLZLzRa8ysEwSJUI308H/0eqpMoWQ75UAXDVkspl3qnfy2ic1OvOgEaa5
p1DavrAx7LUvIH2NPYA17VxYg5VKoLd91moqRYbFuhdY6IYGuAg8uA4qMd1PJUgP
RVQc3pqSr2xLJWqMXxJOwcV1e00pgm1+dyckOiTH9Ng6UHIFMHl4fKUyCulkg1sB
acS+BC5fPeSfjQ5FQXfx9UIvkqkHKoNsKEc3eKEOyO1J9Q6iBc8PDlWDG9PktDeX
S3rkQuXTEYPbMHk/zFBA7KGhn2p1E5f68BydcErsbkUxJ2tfXUJR6E8IbtyelvRX
8WpRYpFQczOFOqK8KP6tjeuZ7/RB8d8lOMZ5Y2DMV0JOhR6b2FWE+drDAY+bTj/l
v1O0gPFf
=k/sH
-----END PGP SIGNATURE-----

--ufMBWnG1WFkAvCRz--
