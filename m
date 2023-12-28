Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB410C4828F
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.125298.1703778872855176978
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 07:54:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Co281Gwg;
 spf=pass (domain: konsulko.com, ip: 209.85.128.171, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e89ba9810aso49776777b3.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703778872; x=1704383672; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMeZqhR7TVFJvMZx5rKUgSF028JbyZWvLpkkGUXmnrI=;
        b=Co281GwgsuMXZfrDEneGOUZ6XQGCKIOW5iCyEKCYvY2x8byWYEYJlyvin/N2swQX/L
         LDE7rBsaORKKaRbq8XPw+5Lto+zBwl1Az2M59XJf93fFiExoTxT2FloHFApWR8Lv5rkw
         PKHBks93Pwg3YfPjpcsElP/gJ1uE95tI/808c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703778872; x=1704383672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMeZqhR7TVFJvMZx5rKUgSF028JbyZWvLpkkGUXmnrI=;
        b=i6dyUvLp1Ox46Yht0dFbrN9fi08xAxAjFlJKfgRtpdhUfQbtg7x40gYNbaPxLeOIta
         lMj1dOSREKsu8BEMdm/eoUC9cr7L7Jzn2cCizjrIUUUAkmlbRjEZDQtWiyoMhyuNEG0/
         fxPegb3S5vyWcAinZyehv6zVkwjKjZ7ebLtFC5z3LsAv/WLg0D2sZL2Cd6GCs9mBIlWB
         RjDaUSeByr/9IEW2crVFkQCMFfdDAH1shDSZAqV4KjfY/DYCA70NKE2jil1/SAGdlpTt
         QR5OCmhol8F0m1PQJDgrE4pgwsO3oqEimQB698du5Dn27ICRkolu8tPanYs/qkpwNQKB
         miyg==
X-Gm-Message-State: AOJu0YxNdzLUWOhHzobBHp2AiHLWn7dzwB3QczDdZOGglnSTtmu2vnC2
	jml8gakg8W9W10o7xwgY8z9atlFktI1VTg==
X-Google-Smtp-Source: AGHT+IFlLy7FCRpbbRm2umrrBOCT0ZCoz+0mA0qESdkDNCcuSB0z0zgdQqtu1eNMNZxVm8vfN2SQcQ==
X-Received: by 2002:a81:8ac4:0:b0:5e8:7a0b:2a9c with SMTP id a187-20020a818ac4000000b005e87a0b2a9cmr7803031ywg.89.1703778872003;
        Thu, 28 Dec 2023 07:54:32 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id c123-20020a814e81000000b005e181bc7d2esm7596877ywb.54.2023.12.28.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 07:54:31 -0800 (PST)
Date: Thu, 28 Dec 2023 10:54:28 -0500
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
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Message-ID: <20231228155428.GI2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=MR5pUtUTc9QQBtdRYvCs"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2006

--Groupsio=MR5pUtUTc9QQBtdRYvCs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> Hi Tom, Sumit,
>=20
> On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > Hi Sumit,
> > >
> > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > Allow platform owners to mirror devicetree files from devitree-reba=
sing
> > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). =
Then
> > > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH=
)/dts
> > > > directory. Also add a new Makefile for arm64.
> > > >
> > > > This will help easy migration for platforms which currently are com=
pliant
> > > > with upstream Linux kernel devicetree files.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > --------------
> > > > - Minor commit message update
> > > >
> > > > Changes in v2:
> > > > --------------
> > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > >
> > > >  dts/Kconfig             | 11 +++++++++++
> > > >  dts/Makefile            | 17 ++++++++++++++---
> > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > >  create mode 100644 dts/arch/arm64/Makefile
> > > >
> > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > --- a/dts/Kconfig
> > > > +++ b/dts/Kconfig
> > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > >           enables a live tree which is available after relocation,
> > > >           and can be adjusted as needed.
> > > >
> > > > +config OF_UPSTREAM
> > > > +       bool "Enable use of devicetree imported from Linux kernel r=
elease"
> > > > +       help
> > > > +         Traditionally, U-Boot platforms used to have their custom=
 devicetree
> > > > +         files or copy devicetree files from Linux kernel which ar=
e hard to
> > > > +         maintain and can usually get out-of-sync from Linux kerne=
l. This
> > > > +         option enables platforms to migrate to devicetree-rebasin=
g repo where
> > > > +         a regular sync will be maintained every major Linux kerne=
l release
> > > > +         cycle. However, platforms can still have some custom u-bo=
ot specific
> > > > +         bits maintained as part of *-u-boot.dtsi files.
> > >
> > > My only other suggestion here is to mention that this should be set i=
n
> > > Kconfig, for the SoC as a whole. So I believe that means that it
> > > should be hidden, with no string for the 'bool':
> > >
> > >       bool  # Enable use of devicetree imported from Linux kernel rel=
ease
> >
> > I think we can just keep prompting for it now, to make the transition
> > easier, before this option just goes away in time, hopefully.
> >
> > > Also, this doesn't seem to work for me. Before this series I get thes=
e
> > > files when building firefly-rk3399:
> > >
> > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > rk3399-rock-4c-plus.dtb
> > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock=
-4se.dtb
> > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock=
960.dtb
> > >
> > > Afterwards I get this:
> > >
> > > make[3]: *** No rule to make target
> > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > >
> > > So I set this manually for that one board:
> > >
> > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > >
> > > and get:
> > >
> > > make[3]: *** No rule to make target
> > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop=
.
> > >
> > > I am not sure how to fix this, nor how this can be made to build all
> > > the DTs for rk3399, as it does today.
> >
> > Looking at the patch for amlogic boards, you need to make the link to
> > devicetree-rebasing inside dts/...
>=20
> OK, let me give up on rk3399 for now...that doesn't seem to work even
> with the link.
>=20
> Using odroid-c2 with -next I see:
>=20
> $ ls /tmp/b/odroid-c2/arch/arm/dts/
> meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
>     meson-gxl-s905x-libretech-cc.dtb
> meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
>     meson-gxl-s905x-libretech-cc-v2.dtb
> meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
>     meson-gxl-s905x-p212.dtb
> meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
>     meson-gxm-gt1-ultimate.dtb
> meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
>     meson-gxm-khadas-vim2.dtb
> meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
>     meson-gxm-s912-libretech-pc.dtb
> meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
>     meson-gxm-wetek-core2.dtb
> meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
>     meson-sm1-bananapi-m2-pro.dtb
> meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
>     meson-sm1-bananapi-m5.dtb
> meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
>     meson-sm1-khadas-vim3l.dtb
> meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
>     meson-sm1-odroid-c4.dtb
> meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
>     meson-sm1-odroid-hc4.dtb
> meson-g12b-odroid-go-ultra.dtb
> meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
> meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
> $
> With this series (sort of, since I am really not sure how to
> cherry-pick the commits from the PR) I see nothing:
>=20
> $ ls /tmp/b/odroid-c2/arch/arm/dts/
> $
>=20
> This shows some of the files:
>=20
> $ find /tmp/b/odroid-c2/ -name "*.dtb"
> /tmp/b/odroid-c2/dts/dt.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
> /tmp/b/odroid-c2/u-boot.dtb
>=20
> but where are the rest? Also, is it possible to put the output .dtb
> files into the same directory? Otherwise we may have some pain with
> binman.

What do you mean by same directory? But maybe also, what's an example of
a board you think might end up having problems? Converting that in a
follow-up series is likely a good idea, to highlight and address these
issues sooner rather than later.

--=20
Tom

--Groupsio=MR5pUtUTc9QQBtdRYvCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNmjEACgkQFHw5/5Y0
tyyl1Av+I+9mmrHHAzKLpWM1LcsArUouSKMw8k83ATiyTFU6lpHQTXoMEz93XHW8
Qd7mQyekAkEo6jr1ScEHMgN9gpBUlkMQX7Od760sSDncWNjG5/jzCpiJoCUiv9js
O5haU5clwFBHTkrxavliuAZSwdv053C8pZ6UY2B5N1fwcygrSWbJBZKsWmu/YYgk
mho8c+bH1+M5d1QyIF95Db8Xs+yl0lvabQ+gBECPS1XtmMPm7WtbwelA1HlDhl1e
UgKPhTDWhTlHoW40pAl/SQkCdX8v58XlzKp6MgQaLjicPAkxfP9nw87shX5PnVQr
eq+d0Bgky6jFsyhxIJam5pnbqZ7MzeEWnhTA5AvPbnU6dYD8jvwrCFEDXG9KISqP
D6krvtmaGUI1wulJ3/El4JCVwCNQsh/mthaxhKyuiRgv80wwg3hS9ZQrT5j6gsal
AZfk9GVULaMbzyASIuJeOmyC26hihwN+4co+KxGeRThpRlJD7Yj2xufMt0Rmqb4u
djtgkuyr
=tqxe
-----END PGP SIGNATURE-----

--Groupsio=MR5pUtUTc9QQBtdRYvCs--

