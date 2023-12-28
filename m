Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F14C4828A
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web11.131350.1703795533338274564
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 12:32:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ksFUz6RJ;
 spf=pass (domain: konsulko.com, ip: 209.85.128.173, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5efb0e180f0so4165827b3.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703795532; x=1704400332; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua/+LSP8qEmi8u8U7bui2a7+7/ZLwmw7r0Rdiu5I8po=;
        b=ksFUz6RJgDtj35Wjjsf2z3IHHxcZsj1gzSmehyp+X12CUKxF4YiNC84INqOyTOYc8f
         qevXDYjvozA1kClfxQSlSFGtFxd5A6PtfKJ1arVJBc4uAOyAsJgSvb60iP0/01O4kpnb
         5hv4O/Xji7MXXxQ6WYMXezG27jTQMwB2bJNk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703795532; x=1704400332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua/+LSP8qEmi8u8U7bui2a7+7/ZLwmw7r0Rdiu5I8po=;
        b=S6Ghwf/cgsJknl1F1GevnyM70C7uqc5a0oSGVv5I7SOFL7CdSr+TFYrxAZM14oA4i5
         EbhVz3qgPbS/TTQ93QG39NS/htV4VQdd2EWgmhc8sX/BXD4a+GoSGyZdq6qSNc5DZwvv
         qGSIcM9wnMjk8y1jo5bj+4d59OH6Iq9temc17TH7KrbPWbghTD+1Cvf/MhAtlHohqcV7
         QIFG5Y+mIZOI9QSG3FvymcCahcAMK3ZBqsMuF0ZeP5vSpG02i6vHrF5VuH+j7uPwwyhj
         14o6uF+7GPsU3KOxwAL2qXoTphuqAtKKJ4XkWcwwfssU6Ge7hpw/Hv4kWFg7nsMhxbd6
         Yfrw==
X-Gm-Message-State: AOJu0YwGBug9FD0t/UpdTXc4id72YEaU7pLd8aKPLKoijmaDGFxy9h1z
	ao7M7hNpFbdHTO5YnoT9hTuikZFtOAO9pQ==
X-Google-Smtp-Source: AGHT+IHPeVjLgZTrEOkYORx4qXd+LcJftuRMb8Y1Kko3UshK1j15ZlxbE3hq9D7qOeB7YpyIQOKJVw==
X-Received: by 2002:a81:4c95:0:b0:5ec:2eb3:e80e with SMTP id z143-20020a814c95000000b005ec2eb3e80emr3640247ywa.1.1703795532524;
        Thu, 28 Dec 2023 12:32:12 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id a128-20020a0df186000000b005c5a08c5c15sm7789805ywf.136.2023.12.28.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:32:11 -0800 (PST)
Date: Thu, 28 Dec 2023 15:32:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231228203209.GP2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
 <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat>
 <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
 <20231228152504.GF2652760@bill-the-cat>
 <CAFLszTh24c1L4xfab7EmgSYJt6HhwfK+0h6quEMNt9QxW01DqA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTh24c1L4xfab7EmgSYJt6HhwfK+0h6quEMNt9QxW01DqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=VEn2Zj6BxAXSyQBPQ2se"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2010

--Groupsio=VEn2Zj6BxAXSyQBPQ2se
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 07:48:13PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 3:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > > > Hi Sumit,
> > > > >
> > > > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@l=
inaro.org> wrote:
> > > > > >
> > > > > > Although there were still some variations in board DTS files ba=
sed on
> > > > > > meson-gxbb SoC but I think those were minor differences from up=
stream
> > > > > > and shouldn't impact boot on these devices.
> > > > > >
> > > > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby d=
irectly
> > > > > > building DTB from there including *-u-boot.dtsi files from
> > > > > > arch/$(ARCH)/dts/ directory.
> > > > > >
> > > > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v3:
> > > > > > --------------
> > > > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC inst=
ead.
> > > > > >
> > > > > > Changes in v2:
> > > > > > --------------
> > > > > > - Picked up review tag
> > > > > >
> > > > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > > > >  configs/odroid-c2_defconfig           | 2 +-
> > > > > >  configs/p200_defconfig                | 2 +-
> > > > > >  configs/p201_defconfig                | 2 +-
> > > > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > > > >  configs/wetek-hub_defconfig           | 2 +-
> > > > > >  configs/wetek-play2_defconfig         | 2 +-
> > > > > >  dts/arch/arm64/amlogic                | 1 +
> > > > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > > > >  create mode 120000 dts/arch/arm64/amlogic
> > > > > >
> > > > >
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/=
Kconfig
> > > > > > index d6c89058061..8ddb59161a0 100644
> > > > > > --- a/arch/arm/mach-meson/Kconfig
> > > > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > > > @@ -25,6 +25,7 @@ choice
> > > > > >  config MESON_GXBB
> > > > > >         bool "GXBB"
> > > > > >         select MESON_GX
> > > > > > +       imply OF_UPSTREAM
> > > > > >         help
> > > > > >           Select this if your SoC is an S905
> > > > > >
> > > > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_de=
fconfig
> > > > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > > > --- a/configs/nanopi-k2_defconfig
> > > > > > +++ b/configs/nanopi-k2_defconfig
> > > > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > > > >  CONFIG_ENV_SIZE=3D0x2000
> > > > > >  CONFIG_DM_GPIO=3Dy
> > > > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > > > >  CONFIG_DM_RESET=3Dy
> > > > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > > > >
> > > > > So now I am wondering if we can (later) have the SoC be implied w=
hen
> > > > > using OF_UPSTREAM so we can do:
> > > > >
> > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > >
> > > > > and it will add the 'amlogic/' automatically?
> > > > >
> > > > > Perhaps that might be a way to bridge the gap in terms of file la=
yout?
> > > >
> > > > That's going to start to look real ugly real quick I suspect and I'=
m not
> > > > sure what it really gets us? It seems to me that the convention of
> > > > "vendor/board" has already been well enough adapted outside of the
> > > > kernel, with the odd sticking point being getting everyone used to
> > > > whatever will be happening for 32bit boards long term. So I think h=
iding
> > > > the vendor part of the string here will be more, not less, confusin=
g
> > > > long term.
> > >
> > > Now that I dig in a bit, I see that the devicetree-rebasing tree does
> > > not have any Makefiles in it. How does Linux build with it? Does
> > > anyone have instructions?
> >
> > Linux doesn't build with it, it's the relevant parts of the kernel tree
> > extracted for other projects to more easily use (more or less).
>=20
> Hmmm, in that case can we add Makefiles into the U-Boot version of the
> tree, for U-Boot use?

No? Why would we do that? I think you're missing how the amlogic
conversion works.

--=20
Tom

--Groupsio=VEn2Zj6BxAXSyQBPQ2se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWN20kACgkQFHw5/5Y0
tyxMJQv7Bc09zQHFh6GMjIEM5tOgzRQv4OYN+BE/wpHovFZ7N3oA01K4KpGzGXFo
qwTrJaaj0VOE6N9BruRrlMwMdxBycJonbDh/74tt2DHXUra9fEdim2BxAFwpJ3ki
jGbdAKTqtaZ6xSbBA3o6qea3owsOAey6yjp55Bxq4jOJ9+YCl6ltSo3B16TpvP+x
qe+sKdmYLqfeVdxiWSidCgA7hRDekEb9cIIyhjvECtE+TzKdUxA3L4tTfAXVfNQI
pHcl2vxsFpqAtOXP3MXGiHis4DDBspdz7cN8eGyAANWhoKue4xELak4+PPYELr2P
iAKmgb9wtgP+ZiMewsiP6XcFwlFTRqVTMqgL7X0wFHwku/CRbf8+Pk7y2F3kcfaJ
60fCNWte+Q/YiH+FOs0P/Jf8p0U0HDuYuzdGiHJackeXMHziBIhZIwUz5TSoZR0i
NcdNArshrJiGtmjKhACe3XocAoFFg8cYWEduIuACTbJbjDHcAuH3BZpvVlNHJhIU
+nq5JM7k
=Za0o
-----END PGP SIGNATURE-----

--Groupsio=VEn2Zj6BxAXSyQBPQ2se--

