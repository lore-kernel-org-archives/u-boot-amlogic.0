Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.100016.1671016578037328410
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Dec 2022 03:16:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671016576;
	bh=7SrGlfV8wb0ix38lfwu186LU0KR4RhZjYW0+fN2T5do=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=if9eANXztTwspJAlnmgLlw+6/DKWIT4m3zbYLH2FVp7iIKWrK17pQ8vx5t9ag4U2X
	 wRw395DeAtuU2GQuus1BHj2pVL08n8455eBS6fxLE6ULx09clZ+cSVOVelfjmtOGRd
	 eFmdsincJAzVRcx906f3HzEynAw92O1JNb01BnXNYn2yBF6ki9NuQ5YImLt1R7jBCf
	 bwMi56FArOTLgzVrvMhwbmKbUPoyVmOTstMJf9TSPkQUpOsDEBt63Xda6KTm7B5swN
	 ey93Xb3Q9sSFzlVVkVOQRw2JxaojHHDNFadm5l/PVVZH4jTWtS+0RcuPBERHfK+1v6
	 QT0UioaY4JtkA==
From: Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: [PATCH v2 0/3] arch-meson: introduce efusedump command
Date: Wed, 14 Dec 2022 11:16:15 +0000
Message-ID: <20221214111610.uhuyxplnjgj4zsuf@cab-wsm-0029881.sigma.sbrf.ru>
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
 <CAPnjgZ09iXy42Xd4c1D0u6j1KN4yGGCT7x-Gah4CvHRtRU8yXQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ09iXy42Xd4c1D0u6j1KN4yGGCT7x-Gah4CvHRtRU8yXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45434E2C370BD24A9E7B0B0E970D6855@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "trini@konsulko.com" <trini@konsulko.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Hello!

On Tue, Dec 13, 2022 at 08:39:43PM -0800, Simon Glass wrote:
> Hi Alexey,
>=20
> On Tue, 13 Dec 2022 at 10:31, Alexey Romanov <avromanov@sberdevices.ru> w=
rote:
> >
> > Keeping the commands code in an arch/ is not correct. This patchset
> > moves the meson smc commands from arch/arm/mach-meson to cmd/meson
> > folder and also adds a new 'efusedump' command with which user can
> > print efuse memory.
> >
> > Alexey Romanov (3):
> >   asm/arch-meson: add missing meson_sm_write_efuse signature
> >   arm/mach-meson: move smc commands in cmd/meson
> >   cmd/arm: meson: sm: introduce efusedump command
> >
> >  MAINTAINERS                          |   1 +
> >  arch/arm/include/asm/arch-meson/sm.h |   2 +
> >  arch/arm/mach-meson/sm.c             | 144 ---------------------
> >  cmd/Kconfig                          |   7 +
> >  cmd/Makefile                         |   3 +
> >  cmd/meson/Makefile                   |   5 +
> >  cmd/meson/sm.c                       | 187 +++++++++++++++++++++++++++
> >  7 files changed, 205 insertions(+), 144 deletions(-)
> >  create mode 100644 cmd/meson/Makefile
> >  create mode 100644 cmd/meson/sm.c
> >
> > --
> > 2.25.1
> >
>=20
> It might be a good time to add some documentation in doc/usage/cmd/meson =
?
>=20
> Regards,
> Simon

Yeah, I'll add docs in v3 patchest.

--=20
Thank you,
Alexey
