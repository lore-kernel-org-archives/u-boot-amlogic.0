Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D0E77199
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
 by mx.groups.io with SMTP id smtpd.web10.35938.1736072788878204970
 for <u-boot-amlogic@groups.io>;
 Sun, 05 Jan 2025 02:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=djJVivq1;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.171, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1736072786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QqDQNWvbQ3pAk5drlBiTTGtgvN02Aqv1kV8hsi7jCg=;
	b=djJVivq1mtwUpWVGX3bfmzo0XnANZRHGH1aqG/rHjRu6Uy/4+PzZntdhRcyX6deVREBWcz
	axlOVk3ISdTeGazL+Z9ktECVkmoZG0e4T4up1X01j+dwzTbRqF2nAkihACUpn74gjxiutO
	Ty71OUnfzS66DfdHWr85mupgfsDckkLils/UIevhWNy0fj45icZvjh6qwKD7wn6vKg5MgO
	D2rTWUmjgAA7gBvpRJHuxLSBQIj45lWJQdPBKTQIpeDfU9x5ffi9zMBJwqcAYish1ihty+
	xBnDfW+KlfV0k3sqHTwebZeX5fPIQJ1xTAhpnSGTqDhsliX1tWYM7oSJUfuUMw==
Date: Sun, 05 Jan 2025 10:24:53 +0000
Message-Id: <D6U2EP1PJ78I.1N5VAOTOWIPZY@postmarketos.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Tom Rini"
 <trini@konsulko.com>, <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
To: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
 <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
 <754d7695-f184-4096-980e-90df66fb2b87@kwiboo.se>
In-Reply-To: <754d7695-f184-4096-980e-90df66fb2b87@kwiboo.se>
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2605

Hi Jonas and Simon,

On Sat Jan 4, 2025 at 10:23 PM UTC, Jonas Karlman wrote:
> Hi Simon,
>
> On 2025-01-04 20:31, Simon Glass wrote:
> > Hi Jonas,
> >=20
> > On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> GXBB BL1 only tries to read boot image from sector 0 on eMMC and secto=
r
> >> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
> >> and SD-card.
> >>
> >> Vendor BL2 have solved the issue with different offsets by considering
> >> where BL2 was loaded from to adjust the offset where BL3 is read from.
> >>
> >> This provide a different solution to create a boot image that can be
> >> booted from both eMMC and SD-card and where the offset for reading nex=
t
> >> stage loader can be shared for both boot options.
> >>
> >> Inject code, that relocate the payload located at 0x1200 offset in TZR=
AM
> >> to the expected offset of 0x1000, into the padding area at offset 0x20=
0
> >> when a normal GXBB boot image is created. A special GXBB eMMC header c=
an
> >> then be created that have the payload offset point to this relocate
> >> code, BL1 will jump to this relocate code when booted from eMMC instea=
d
> >> of the normal payload start. One effect of this is that the payload si=
ze
> >> limit must be reduced by 512 bytes on GXBB.
> >>
> >> Example of how to use it:
> >>   # Create a normal boot image
> >>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
> >>
> >>   # Create a boot image with a special eMMC header
> >>   tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
> >>
> >>   # Write normal boot image to sector 1 of eMMC/SD-card
> >>   dd if=3Dbl2.bin of=3D/path/to/dev bs=3D512 seek=3D1
> >>
> >>   # Write eMMC header, 112 bytes, to start of eMMC
> >>   dd if=3Dbl2-emmc.bin of=3D/path/to/dev bs=3D1 count=3D112
> >>
> >> Or with binman using something like:
> >>   binman {
> >>         multiple-images;
> >>
> >>         u-boot-gxbb-sd {
> >>                 filename =3D "u-boot-gxbb-sd.bin";
> >>                 pad-byte =3D <0xff>;
> >>
> >>                 mkimage {
> >>                         filename =3D "bl2.bin";
> >>                         args =3D "-n", "gxbb", "-T", "amlimage";
> >>
> >>                         u-boot-spl {
> >>                         };
> >>                 };
> >>         };
> >>
> >>         u-boot-gxbb-emmc {
> >>                 filename =3D "u-boot-gxbb-emmc.bin";
> >>                 pad-byte =3D <0xff>;
> >>
> >>                 mkimage {
> >>                         filename =3D "bl2-emmc.bin";
> >>                         args =3D "-n", "emmc", "-T", "amlimage";
> >>
> >>                         blob-ext {
> >>                                 filename =3D "bl2.bin";
> >>                         }
> >>                 };
> >>         };
> >>   };
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  tools/amlimage-gxbb-relocate.c | 79 +++++++++++++++++++++++++++++++++=
+
> >>  tools/amlimage.c               | 37 ++++++++++++++++
> >>  2 files changed, 116 insertions(+)
> >>  create mode 100644 tools/amlimage-gxbb-relocate.c
> >>
> >=20
> > I sent [1] some years ago and would quite like to enable the odroid-c2
> > in my lab. Is that an older version of what you are supporting here?
>
> The amlimage type in this series is only for creating an image format
> that the SoCs BootROM (BL1) can understand. This image type will most
> likely only be useful together with Ferass El Hafidi's U-Boot SPL work
> or for someone wanting to run bare metal code from SRAM on these SoCs.

I'm happy to announce that U-Boot SPL can now boot on gxbb and gxl SoCs,
and I'll be sending some patches to upstream that work later on.

>
> Vendor bl2.bin blobs is based on TF-A, is already in correct image
> format and expect next stage payload to be signed using a Amlogic FIP
> format. For this you will still need to use vendor tools or open source
> tools like meson-tools, gxlimg or meson64-tools.
>
> The amlogic-boot-fip repo [2] has blobs, vendor tools and Makefiles to
> combine the blobs with a U-Boot proper u-boot.bin to create a firmware
> image that should boot for a wide range of boards.
>
> [2] https://github.com/LibreELEC/amlogic-boot-fip
>
> >=20
> > I heard that there are people working on open source tools, but it has
> > been a few years and I'd be quite OK to just use vendor tools.
>
> Open-source tools exist to replace the binary-only Amlogic tools:
> - https://github.com/afaerber/meson-tools (GXBB, GXL & GXM only)
> - https://github.com/repk/gxlimg (GXBB, GXL, GXM & AXG only)
> - https://github.com/angerman/meson64-tools (developed for G12B, should w=
ork on G12A & SM1)

gxlimg now also supports G12A/G12B, but it does not support GXBB at the
time of writing.

>
> Would be nice if someone would combine those into a mkimage amlfip type
> or similar (a different format than this amlimage format).
>
> >=20
> > For your docs, could you put them in doc/ instead?
>
> Not fully sure what you want me to put in doc/, please be specific. The
> code comments and commit message should already document as much as
> possible until there is upstream use of the GXBB eMMC header workaround.
>
> At such time something like following could be documented:
>
>   Write image to SD-card or eMMC module:
>     dd if=3Du-boot-amlogic.bin of=3D/path/to/dev bs=3D512 seek=3D1 conv=
=3Dfsync,notrunc
>
>   Write the eMMC header to eMMC module:
>     dd if=3Du-boot-gxbb-emmc.bin of=3D/path/to/dev bs=3D1 count=3D112 con=
v=3Dfsync,notrunc
>
> Until Ferass El Hafidi's U-Boot SPL work has made its way upstream such
> commands and information would purely be speculative and will be easier
> to document in a future series.

Yes, my tree has documentation on how to make use of images generated by
amlimage.  I believe such documentation should be documented when there
actually is U-Boot SPL support as well.

Best regards.

>
> Regards,
> Jonas
>
> >=20
> > [..]
> >=20
> > Regards,
> > Simon
> >=20
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699=
821-8-sjg@chromium.org/

