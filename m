Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.100595.1671016479711830195
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Dec 2022 03:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671016478;
	bh=LapFAb9dMUmrwU4npRv2k5daRVMsSiCvfW17StHFnKU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=IgOUEjsmXoQLlpiaYcMsCg0W4b0g5q9gwklXz4PFTSXTooaw68ot/UNHTcayg8h/u
	 H439/TceMXGG/AqFYQXitfQOXDPTJXyPsBf8KgwNyHgVAZ9NFOgrEpLybVgtHZiWZ9
	 LdIkYoghnJWFWvLdVU7SrY35CuJuQyW02PMkMZz7+krPCGFIGmF+IzvxwhrqucoRAt
	 gO6chAVRHnMHgXuVGrfTqwmMTOG/iYkgdbsMuGvwqWc4qZ2BGqR4o8is0TtVqNWQAs
	 ITYGYW2/KAL90RdRMhq+oTuQ+rNuhrBy0MO2nXlpBrnGo6gA/gXKo0nIMd9g4FJ/nC
	 CvcEskVR/8a0A==
From: Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: [PATCH v2 1/3] asm/arch-meson: add missing meson_sm_write_efuse signature
Date: Wed, 14 Dec 2022 11:14:37 +0000
Message-ID: <20221214111431.lhc6r3kwua6vhd2g@cab-wsm-0029881.sigma.sbrf.ru>
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
 <20221213183129.75915-2-avromanov@sberdevices.ru>
 <CAPnjgZ2CEz=L=cAstFYOszMxDN8FZ3UmG2UQ-=8GY4913ogGLw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2CEz=L=cAstFYOszMxDN8FZ3UmG2UQ-=8GY4913ogGLw@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5EFF5E5718AC241BF1FF6EC4D723E42@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "trini@konsulko.com" <trini@konsulko.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Hello!

On Tue, Dec 13, 2022 at 08:39:46PM -0800, Simon Glass wrote:
> Hi Alexey,
>=20
> On Tue, 13 Dec 2022 at 10:32, Alexey Romanov <avromanov@sberdevices.ru> w=
rote:
> >
> > This function can be used by other modules.
> >
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> > ---
> >  arch/arm/include/asm/arch-meson/sm.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/as=
m/arch-meson/sm.h
> > index f3ae46a6d6b..b68edf842e4 100644
> > --- a/arch/arm/include/asm/arch-meson/sm.h
> > +++ b/arch/arm/include/asm/arch-meson/sm.h
> > @@ -8,6 +8,8 @@
> >
> >  ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t siz=
e);
> >
> > +ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t si=
ze);
> > +
> >  #define SM_SERIAL_SIZE 12
> >
> >  int meson_sm_get_serial(void *buffer, size_t size);
> > --
> > 2.25.1
> >
>=20
> Should add function comments.
>=20
> Also, you might consider adding a uclass for this. It seems like an
> important use case that is not handled right now.
>=20
> Regards,
> Simon

I'm afraid we can't generalize sm API for each arch types. It's very close =
to Secure Monitor=20
vendor implementation and can provide various APIs for different purposes.

--=20
Thank you,
Alexey
