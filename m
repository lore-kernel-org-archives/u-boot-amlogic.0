Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 by mx.groups.io with SMTP id smtpd.web11.1411.1693418022237847726
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Aug 2023 10:53:42 -0700
Date: Wed, 30 Aug 2023 17:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1693418018; x=1693677218;
	bh=gaG7VuiuzeBoCrlddmGSrxFjPIdkHsg1kk6y2rsdpJ8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FHhphKz1hvI2qBXyszqDvoXPPB4cvftqd74i4Btt93ojsZC+OUHQ8YjLHe+ONSE3z
	 fA1j6Eb5XlkKptW57MtE141YMNjrbQyIKE+BbtdQA/13zqL10UzIVJvbkchbpUqUZt
	 00QmdfcpBcJAAFXmd8Hjbv/bkWkxEnEbExXYa27Jx+B5ELSLmN641hZmhjHPFE0gQF
	 U2hihEGaOIpS30XiFjYAAcO18KFNuZYbdirk77kETCAvbdYWxGvMVvAOyV2DpfJRfh
	 ZYmxLTJ+UN3KorQ2MFTlQ3QwI0bvHG9Ffr3fqo11HtGo/Mb/vKd1Xi4+uP754zatX7
	 1MVGp03ggC8Xg==
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce the image
Message-ID: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: sjg@chromium.org
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org, alpernebiyasak@gmail.com, neil.armstrong@linaro.org, da@lessconfused.com
List-ID: <u-boot-amlogic@groups.io>

Hi Simon,

> So I wonder how best to move this forward so that we can build things
> using binman and everything works?

It's still not ready yet, but I'm working on porting U-Boot SPL to some
Amlogic SoCs [1]. I'm currently working on Amlogic S905 boards, but
eventually I'll work on Amlogic S905X devices too. And speaking of
signing, Jonas Karlman wrote amlimage, and integrated it into mkimage,=20
and I applied his patch to my tree. There's a few things to be aware of=20
about Amlogic signing and binaries in general, however.

amlimage was intended for use with U-Boot SPL, which obviously has=20
no support for Amlogic's FIP format and as such amlimage will only do as=20
little as possible to get the bootROM to load U-Boot SPL. Most of the=20
packaging format is handled by BL2. The fact that the signing process is
completly different across SoC generations makes it difficult to
implement them all into one single tool (and by which I mean all of it,
not just signing BL2 for the bootROM to run it, that's mostly the same
across SoCs). amlimage has been confirmed to work on GXBB (ODROID-C2 and
the KII Pro set-top box), GXL (librecomputer lepotato), and SM1 (ODROID-C4)=
.

My U-Boot SPL port is still rather incomplete. As of today, it still
can't boot anything from any storage device. The goal eventually is to
be able to load upstream TF-A BL31 and U-Boot+linux.

While Amlogic distributes proprietary BL31 binaries upstream Trusted=20
Firmware-A has a port for some Amlogic SoCs [2], but as far as I know=20
SM1 (which is the SoC generation your ODROID-C4 is using) is still
unsupported. GXBB, GXL, AXG, and G12A are all supported however, but the
overall port still lacks some features the proprietary implementation
has.

As for the SCP firmware (aka. BL30) I'm not aware of any
reverse-engineering efforts for that.

Honestly, in my opinion, including proprietary and poorly-written=20
Amlogic utilities lacking a proper license, into U-Boot looks like a bad id=
ea.

[1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=3Dwip/=
spl
[2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/=
amlogic

Cheers.

