Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.73998.1670939945130050611
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 05:59:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1670939942;
	bh=918Brl4sy+fZCulTRTrqx8MI7eW81t2GXbSCIKO7Kgs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=I1dP+r/QFIuDII5LJ2LbsWIzQIPu9CruEYnX/0JQyRjAd0VW8FvPgp8CWXDRQD0zX
	 Esv8LiSTD4jOth9wnUeDZGVUwYlMuLI5MBJUjyf57xV01Fls1yffHiXx5POV4udxpk
	 hDw+lmtvo/0CtivRLR0PAmZDwDXb4EnL510A39X9xwr2WK2+yb9COs1O0uv8MytOLW
	 iJv8/X5B2UWBMXVdLBoHWdnfiS5pZQf7cSExVPQvedcfSJ1ToRtLNhVUNczHR0SxCG
	 LdwkrLbDJQGPdJobhEJGyzNcRKFl6smhCbQQ0b+gjnK99zXX61Znomot42oUo3RFII
	 yNgV6qziob9sA==
From: Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: [PATCH v1] arch/arm: sm: introduce efusedump command
Date: Tue, 13 Dec 2022 13:59:01 +0000
Message-ID: <20221213135856.zhy66q2ude3webro@cab-wsm-0029881.lan>
References: <20221209125204.62960-1-avromanov@sberdevices.ru>
 <20221212160834.GX3787616@bill-the-cat>
In-Reply-To: <20221212160834.GX3787616@bill-the-cat>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35B2A01FA9B12344B89C003D81E3B14B@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
To: Tom Rini <trini@konsulko.com>
Cc: "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Hello!

On Mon, Dec 12, 2022 at 11:08:34AM -0500, Tom Rini wrote:
> On Fri, Dec 09, 2022 at 03:52:04PM +0300, Alexey Romanov wrote:
>=20
> > Using this command user can print efuse memory:
> >=20
> > $ sm efusedump 0 10
> >   00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> > ---
> >  arch/arm/mach-meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> This needs to be moved done under cmd/ somewhere, perhaps cmd/meson/
>=20
> --=20
> Tom


Do you mean it must be moved by a different patchset? From my point of view=
,=20
your comment is totally right, because arch dependent commands are located =
at=20
cmd/ARCH path. But I'm afraid my patchset is just about new helper command.=
=20

Anyway, I can send a new different patchset with refactoring suggested by y=
ou.=20
But, please, comment out some words about new efuse command if possible.

--=20
Thank you,
Alexey
