Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FDEC48292
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.3110.1704242503513812824
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 16:41:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=N6qLxlYO;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78106c385a1so951221185a.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 16:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704242502; x=1704847302; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfMwGXsjKVUya9dVG2aZGopUii1G5scBFkrgSE5SaS8=;
        b=N6qLxlYOh97CcVgriKynTx7RBcheRjztmu/pAXqf4TL4TmHZmF9lEDl5YSFnm0Xg/j
         CZJ4sjFjYTaPgjiqtx/wdcV7HCzkuy3masSFppkxUNzhkM2GZpVhiYQr7zou5DUrgFCZ
         UB8d7BYW7AyIY6Ch/IWYvGSp6Fp0U1q23La4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242502; x=1704847302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfMwGXsjKVUya9dVG2aZGopUii1G5scBFkrgSE5SaS8=;
        b=vZdk0ltxXqNuFhPwMCipy1JUW2ZzQ+HoiJ1hIISsYrfjuDi2p6h3BQX893UQPmoA4+
         atwvNnPBUMkhmQ3L7nyrHqRyPYPjDpefGjvq6DY95npz9RU2g+HxPep5jbv5ujJBKOk3
         VPnq6NYI9VaSnr6NQf7nyHyIR8ixb/U2WVHOK0cGsunlkvTs4exSW71VSEB5E9H8k6XC
         /6SFyYtVdBzdm+7hbXiiMjdv+0ZvC7kUhhb+kDEH2dNtu/LJuoY1VeNn/0Q2hGpjkJ2J
         /ApVjry7R1se4ELQ4/Vnt4ThGsgCFqz2m15YmTPvBkOsAQ9nfKNtihpCgVDzYORSDwr3
         vhMQ==
X-Gm-Message-State: AOJu0Yx7Pq5+1/DXlefTAjdCW8ELgIWXx+fynAg49BQePj3qh++2X9ry
	n29P8GQDEZLcyKTD+DtBy0htwfcuw9XfbA==
X-Google-Smtp-Source: AGHT+IHUqX5lToK7JgW17UnaBVCBusCWkrHoAWLC/m0Fo59MUhpvIrxDvks67fwYZMFs7ehOy17Q2A==
X-Received: by 2002:a05:620a:a14:b0:781:5c8c:ba8d with SMTP id i20-20020a05620a0a1400b007815c8cba8dmr14401357qka.57.1704242502317;
        Tue, 02 Jan 2024 16:41:42 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a144b00b007815c55cdf9sm5461995qkl.105.2024.01.02.16.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:41:41 -0800 (PST)
Date: Tue, 2 Jan 2024 19:41:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, sumit.garg@linaro.org,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, caleb.connolly@linaro.org,
	ff@shokubai.tech, daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org, pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Message-ID: <20240103004138.GC1610741@bill-the-cat>
References: <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <20240102151046.GL2652760@bill-the-cat>
 <CAFLszThysDjASn4U7CpBmmp4axjE-CrFk1x6TLhLpmVicpwGbQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszThysDjASn4U7CpBmmp4axjE-CrFk1x6TLhLpmVicpwGbQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=nDFB7Q3FtCAMuejGDx0Q"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2025

--Groupsio=nDFB7Q3FtCAMuejGDx0Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 04:54:15PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, Jan 2, 2024 at 8:10=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Tue, Jan 02, 2024 at 07:06:40AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, Jan 1, 2024 at 4:35=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > On Mon, Jan 01, 2024 at 03:32:41PM -0700, Simon Glass wrote:
> > > > > Hi Mark, Tom,
> > > > >
> > > > > On Sun, Dec 31, 2023 at 5:33=E2=80=AFPM Mark Kettenis <mark.kette=
nis@xs4all.nl> wrote:
> > > > > >
> > > > > > > Date: Sun, 31 Dec 2023 15:39:53 -0500
> > > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > >
> > > > > > > On Sun, Dec 31, 2023 at 07:28:52AM -0700, Simon Glass wrote:
> > > > > > > > Hi Sumit,
> > > > > > > >
> > > > > > > > On Fri, Dec 29, 2023 at 8:30=E2=80=AFAM Sumit Garg <sumit.g=
arg@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 29 Dec 2023 at 01:18, Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom, Sumit,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon G=
lass wrote:
> > > > > > > > > > > > > > Hi Sumit,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit =
Garg <sumit.garg@linaro.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Allow platform owners to mirror devicetree fi=
les from devitree-rebasing
> > > > > > > > > > > > > > > directory into dts/arch/$(ARCH) (special case=
 for dts/arch/arm64). Then
> > > > > > > > > > > > > > > build then along with any *-u-boot.dtsi file =
present in arch/$(ARCH)/dts
> > > > > > > > > > > > > > > directory. Also add a new Makefile for arm64.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This will help easy migration for platforms w=
hich currently are compliant
> > > > > > > > > > > > > > > with upstream Linux kernel devicetree files.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.=
org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Changes in v3:
> > > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > > - Minor commit message update
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > --------------
> > > > > > > > > > > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Bo=
ot/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > > > > > > > > > > >  dts/Makefile            | 17 ++++++++++++++-=
--
> > > > > > > > > > > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > > > > > > > > > > >  3 files changed, 39 insertions(+), 3 deletio=
ns(-)
> > > > > > > > > > > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > > > > > > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > > > > > > > > > > --- a/dts/Kconfig
> > > > > > > > > > > > > > > +++ b/dts/Kconfig
> > > > > > > > > > > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > > > > > > > > > > >           enables a live tree which is availa=
ble after relocation,
> > > > > > > > > > > > > > >           and can be adjusted as needed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > +config OF_UPSTREAM
> > > > > > > > > > > > > > > +       bool "Enable use of devicetree import=
ed from Linux kernel release"
> > > > > > > > > > > > > > > +       help
> > > > > > > > > > > > > > > +         Traditionally, U-Boot platforms use=
d to have their custom devicetree
> > > > > > > > > > > > > > > +         files or copy devicetree files from=
 Linux kernel which are hard to
> > > > > > > > > > > > > > > +         maintain and can usually get out-of=
-sync from Linux kernel. This
> > > > > > > > > > > > > > > +         option enables platforms to migrate=
 to devicetree-rebasing repo where
> > > > > > > > > > > > > > > +         a regular sync will be maintained e=
very major Linux kernel release
> > > > > > > > > > > > > > > +         cycle. However, platforms can still=
 have some custom u-boot specific
> > > > > > > > > > > > > > > +         bits maintained as part of *-u-boot=
.dtsi files.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > My only other suggestion here is to mention tha=
t this should be set in
> > > > > > > > > > > > > > Kconfig, for the SoC as a whole. So I believe t=
hat means that it
> > > > > > > > > > > > > > should be hidden, with no string for the 'bool'=
:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >       bool  # Enable use of devicetree imported=
 from Linux kernel release
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think we can just keep prompting for it now, to=
 make the transition
> > > > > > > > > > > > > easier, before this option just goes away in time=
, hopefully.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Also, this doesn't seem to work for me. Before =
this series I get these
> > > > > > > > > > > > > > files when building firefly-rk3399:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > rk3399-eaidk-610.dtb            rk3399-khadas-e=
dge-v.dtb
> > > > > > > > > > > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dt=
b
> > > > > > > > > > > > > > rk3399-evb.dtb                  rk3399-leez-p71=
0.dtb
> > > > > > > > > > > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dt=
b
> > > > > > > > > > > > > > rk3399-ficus.dtb                rk3399-nanopc-t=
4.dtb
> > > > > > > > > > > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > > > > > > > > > > rk3399-firefly.dtb              rk3399-nanopi-m=
4-2gb.dtb
> > > > > > > > > > > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > > > > > > > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m=
4b.dtb
> > > > > > > > > > > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzan=
ine.dtb
> > > > > > > > > > > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m=
4.dtb
> > > > > > > > > > > > > > rk3399-rock-4c-plus.dtb
> > > > > > > > > > > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-n=
eo4.dtb    rk3399-rock-4se.dtb
> > > > > > > > > > > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r=
4s.dtb     rk3399-rock960.dtb
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Afterwards I get this:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by =
'dtbs'.  Stop.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So I set this manually for that one board:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-f=
irefly"
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > and get:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > make[3]: *** No rule to make target
> > > > > > > > > > > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', n=
eeded by 'dtbs'.  Stop.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I am not sure how to fix this, nor how this can=
 be made to build all
> > > > > > > > > > > > > > the DTs for rk3399, as it does today.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Looking at the patch for amlogic boards, you need=
 to make the link to
> > > > > > > > > > > > > devicetree-rebasing inside dts/...
> > > > > > > > > > > >
> > > > > > > > > > > > OK, let me give up on rk3399 for now...that doesn't=
 seem to work even
> > > > > > > > > > > > with the link.
> > > > > > > > > > > >
> > > > > > > > > > > > Using odroid-c2 with -next I see:
> > > > > > > > > > > >
> > > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > > meson-a1-ad401.dtb                 meson-g12b-odroi=
d-n2l.dtb
> > > > > > > > > > > >     meson-gxl-s905x-libretech-cc.dtb
> > > > > > > > > > > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroi=
d-n2-plus.dtb
> > > > > > > > > > > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > > > > > > > > > > meson-axg-s400.dtb                 meson-g12b-radxa=
-zero2.dtb
> > > > > > > > > > > >     meson-gxl-s905x-p212.dtb
> > > > > > > > > > > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-p=
ro.dtb
> > > > > > > > > > > >     meson-gxm-gt1-ultimate.dtb
> > > > > > > > > > > > meson-g12a-sei510.dtb              meson-gxbb-nanop=
i-k2.dtb
> > > > > > > > > > > >     meson-gxm-khadas-vim2.dtb
> > > > > > > > > > > > meson-g12a-u200.dtb                meson-gxbb-odroi=
dc2.dtb
> > > > > > > > > > > >     meson-gxm-s912-libretech-pc.dtb
> > > > > > > > > > > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.=
dtb
> > > > > > > > > > > >     meson-gxm-wetek-core2.dtb
> > > > > > > > > > > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.=
dtb
> > > > > > > > > > > >     meson-sm1-bananapi-m2-pro.dtb
> > > > > > > > > > > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek=
-hub.dtb
> > > > > > > > > > > >     meson-sm1-bananapi-m5.dtb
> > > > > > > > > > > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek=
-play2.dtb
> > > > > > > > > > > >     meson-sm1-khadas-vim3l.dtb
> > > > > > > > > > > > meson-g12b-gtking.dtb              meson-gxl-s805x-=
libretech-ac.dtb
> > > > > > > > > > > >     meson-sm1-odroid-c4.dtb
> > > > > > > > > > > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-=
libretech-pc.dtb
> > > > > > > > > > > >     meson-sm1-odroid-hc4.dtb
> > > > > > > > > > > > meson-g12b-odroid-go-ultra.dtb
> > > > > > > > > > > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-s=
ei610.dtb
> > > > > > > > > > > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-=
khadas-vim.dtb
> > > > > > > > > > > > $
> > > > > > > > > > > > With this series (sort of, since I am really not su=
re how to
> > > > > > > > > > > > cherry-pick the commits from the PR) I see nothing:
> > > > > > > > > > > >
> > > > > > > > > > > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > > > > > > > > > > $
> > > > > > > > > > > >
> > > > > > > > > > > > This shows some of the files:
> > > > > > > > > > > >
> > > > > > > > > > > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/dt.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
odroidc2.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
nanopi-k2.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
wetek-play2.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
kii-pro.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
p200.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
p201.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-=
wetek-hub.dtb
> > > > > > > > > > > > /tmp/b/odroid-c2/u-boot.dtb
> > > > > > > > > > > >
> > > > > > > > > > > > but where are the rest? Also, is it possible to put=
 the output .dtb
> > > > > > > > > > > > files into the same directory? Otherwise we may hav=
e some pain with
> > > > > > > > > > > > binman.
> > > > > > > > > > >
> > > > > > > > > > > What do you mean by same directory? But maybe also, w=
hat's an example of
> > > > > > > > > > > a board you think might end up having problems? Conve=
rting that in a
> > > > > > > > > > > follow-up series is likely a good idea, to highlight =
and address these
> > > > > > > > > > > issues sooner rather than later.#
> > > > > > > > > >
> > > > > > > > > > Today the .dtb files go into arch/arm/dts - so it would=
 be easier if
> > > > > > > > > > this series could do the same.
> > > > > > > > >
> > > > > > > > > The kbuild infrastructure keeps the dtb alongside dts fil=
es which is
> > > > > > > > > the preferred way too as otherwise it would be complicate=
d to locate
> > > > > > > > > DT files for the users. Also, we have to move towards Lin=
ux DT
> > > > > > > > > directory structure and thereby the tools like binman hav=
e to be
> > > > > > > > > adjusted. I will do that when I get to migrating SoCs sup=
porting
> > > > > > > > > binman.
> > > > > > > >
> > > > > > > > OK, I want to stop here and rethink this. This is the path =
taken so
> > > > > > > > far, I believe:
> > > > > > > >
> > > > > > > > 1. We want to use devicetree files taken from Linux and
> > > > > > > > devicetree-rebasing provides these
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > > 2. We want to use 'git subtree' to avoid needing a script t=
o do the
> > > > > > > > sync / create a commit
> > > > > > >
> > > > > > > No. We want to use 'git subtree' to avoid having to use git s=
ubmodules.
> > > > >
> > > > > Well that is what I understood from Sumit, when I asked about a
> > > > > script. I imagine a 100-line Python script could do the same as:
> > > > >
> > > > >    git subtree pull --prefix devicetree-rebasing
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetr=
ee-rebasing.git
> > > > > <release-tag> --squash
> > > > >
> > > > > and it could also put the files in the right place for U-Boot.
> > > >
> > > > I've been saying in various places for years that I want to move aw=
ay
> > > > from arch/*/dts being where we have the "just a copy" dts files and=
 have
> > > > them somewhere else so they are easier to manage and differentiate =
our
> > > > changes / additions. So arch/*/dts cannot be some hard-coded "right=
"
> > > > path.
> > >
> > > OK
> > >
> > > >
> > > > > > > > 3. But this leaves us with a directory structure which does=
n't match
> > > > > > > > U-Boot (no script to fix it up)
> > > > > > >
> > > > > > > No. We intentionally abandon arch/*/dts because it's so full =
of
> > > > > > > out of date files and never fully re-synced, only re-synced a=
d-hoc.
> > > > >
> > > > > I mean that the dir structure doesn't match. I am not worried abo=
ut
> > > > > keeping arch/*/dts but I want the same structure somewhere else, =
e.g.
> > > > > dtr/arch/*/dts
> > > >
> > > > And what I want here is to match the same structure everyone that's=
 not
> > > > U-Boot uses. For better or worse no one else seems to have gone wit=
h
> > > > "treat aarch64 as just another ARM", and then the vendor directory
> > > > structure only makes that more obviously a mismatch. We need to fol=
low
> > > > what everyone else uses, and developers familiar with other project=
s
> > > > will expect to see.
> > >
> > > So you are saying that U-Boot should move to what Linux uses. I agree
> > > that seems like the best approach, so let's do it.
> > >
> > > >
> > > > > > > > 4. So we deal with that by skipping the build rules and usi=
ng CONFIG
> > > > > > > > options to select what is built
> > > > > > > > 5. So now we cannot build all the files for an SoC, just th=
e ones that
> > > > > > > > are in the CONFIG options
> > > > > > > > 6. Linux doesn't actually use devicetree-rebasing itself, s=
o doesn't
> > > > > > > > have this problem
> > > > > > >
> > > > > > > No. devicetree-rebasing skips the Makefiles because they're p=
art of the
> > > > > > > kernel. We couldn't re-use them ourselves because we don't ha=
ve the same
> > > > > > > CONFIG names the kernel does. And Sumit has not replicated th=
e logic we
> > > > > > > have under arch/*/dts/Makefile today because I've asked him n=
ot to, and
> > > > > > > we'll figure out what subsets of that logic make sense to add=
 back in as
> > > > > > > a second step not a first step.
> > > > >
> > > > > Again, you are missing my point. I am not suggesting using Linux'=
s
> > > > > build rules, just explaining why Linux doesn't have the problem w=
e
> > > > > would be creating here.
> > > > >
> > > > > > > > So this is heading in the wrong direction. Nor is it clear =
that this
> > > > > > > > would just be a temporary problem.
> > > > > > >
> > > > > > > A previous iteration of this series built all of the dtb file=
s for the
> > > > > > > SoC that Sumit has migrated with this series, but then droppe=
d it.
> > > > >
> > > > > Oh.
> > > > >
> > > > > > >
> > > > > > > [snip]
> > > > > > > > I would like to do this series properly, maintaining the So=
C-specific
> > > > > > > > build rules, not removing what I see as an important featur=
e. It
> > > > > > > > should not be that difficult to figure out and I am happy t=
o help with
> > > > > > > > it.
> > > > > > >
> > > > > > > The problem is that the rest of us do not understand the use =
case you're
> > > > > > > describing where a dtb file that would be useful in a build i=
s not
> > > > > > > already in the list to build. The only one of those use cases=
 I
> > > > > > > understand thus far is the exynos4 (iirc) case you mentioned =
previously
> > > > > > > where yes, really, one defconfig + appending board.dtb is fin=
e, or fine
> > > > > > > enough. It's not that far off of the SPL_LOAD_FIT case, but t=
here we
> > > > > > > know what to build already.
> > > > >
> > > > > Perhaps the problem is that the rest of you think of the build as=
 all
> > > > > happening in U-Boot, similar to the proposed 'make image.fit' tha=
t I
> > > > > am trying to add to Linux.
> > > > >
> > > > > But packaging can be (and often is) a separate step from building=
.
> > > > > Linux has no packaging mechanism today...it just builds everythin=
g
> > > > > (including all DTs) and stops.
> > > > >
> > > > > We should be able to pick up whatever .dtb files we want and use =
them
> > > > > in an image.
> > > > >
> > > > > > > And I guess trying to tie things up, that's my puzzle. SPL_LO=
AD_FIT is
> > > > > > > how I see the use case you talk about being solved, if a full=
 U-Boot is
> > > > > > > generic enough for N boards, SPL_LOAD_FIT does the right thin=
g (in this
> > > > > > > non-bloblist DTB, non-reusing-OS-inntended DTB world). I real=
ly don't
> > > > > > > knnow how many modern SoCs can take a literal concatenated DT=
B and even
> > > > > > > in those cases I don't get why that's the win we want now? 1 =
build to N
> > > > > > > binaries?
> > > > >
> > > > > Yes SPL_LOAD_FIT is fine although in practice we will likely need=
 SPL
> > > > > to use the correct DT as well, so the DT will need to be determin=
ed in
> > > > > TPL, perhaps.
> > > >
> > > > I mean, SPL_LOAD_FIT still can handle this case, with a call to the
> > > > function to re-parse the tree, when needed. I thought we did this t=
oday
> > > > even, but perhaps I'm confusing my options here.
> > > >
> > > > > But anyway, this works OK with rk3399, for example. We need to su=
pport
> > > > > this use case.
> > > > >
> > > > > Also, it is pretty easy. We just need to stick with the dir struc=
ture
> > > > > we have today and copy our existing Makefiles into that dir. Or c=
hange
> > > > > to the kernel dir structure and use that. Or do one, then the oth=
er.
> > > >
> > > > I'm sorry, I don't understand what directory structure has to do wi=
th
> > > > "build more dtbs". For the cases where it makes sense to, yes, we c=
an
> > > > build more dtbs, based on the SoC. I'm setting aside entirely the
> > > > discussion on what SoCs that works for, for another thread.
> > >
> > > Well you said above that we should switch to the kernel dir structure=
,
> > > so I believe that issue is resolved.
> > >
> > > 'build more dtbs' means build all the DTBs for an SoC, not just a
> > > selection that a particular board vendor decided on.
> >
> > Yes, what other dtbs to build is the sticking point, in a number of
> > threads now.
>=20
> All of the ones for the SoC.

Yes, that's your position, and it's not anyone elses position.

> > > > Perhaps an issue here is that much like the kernel "install" target=
, we
> > > > need an "install" target too, so that whatever dtbs we build can be
> > > > more easily found for external packaging, but whatever tooling it i=
s
> > > > that wants it? And perhaps this is part of the problem, tooling tha=
t
> > > > expects to pull things out of the object directory rather than an
> > > > "installed" directory?
> > >
> > > This is where binman comes in. It can run as part of U-Boot build, to
> > > build a few default firmware images. Then it can be run *later*,
> > > outside the U-Boot build, with an augmented or more targeted image
> > > definition, with mostly the same input files, to pull together images
> > > for specific uses. As you say, the input files need to be in a define=
d
> > > location, which they are today, for the most part.
> > >
> > > So even if a particular board only uses one DT, all the DTs for that
> > > SoC are built and so can be used in that final-packaging step. Withou=
t
> > > that build, there is no way to get the required .dtb files, other tha=
n
> > > building every board one by one and then pulling out the .dtb files o=
r
> > > something weird like that.
> > >
> > > Note that this works independently of whether OF_LIST is used, etc.
> >
> > How about this. When you introduce generic-rk3399_defconfig is when we
> > can also have dts-$(CONFIG_ROCKCHIP_RK3399) list everything, and insist
> > it be kept up to date. That to me feels like the right order to go in.
> > And we can have all of the implementation details be hashed out
> > elsewhere, not in the thread about fixing our nightmare about dts file
> > resync.
>=20
> So long as Sumit can put it back so we can use build rules, that's
> fine. But removing the build rules is the sticking point for me.

But it's not a sticking point for anyone else for the series. Because
no one else gets the point you're trying to make.

> > > > > > > But even then, I don't object to adding those rules to the Ma=
kefiles. If
> > > > > > > it works it works. I object to adding them when they don't wo=
rk.
> > > > >
> > > > > What do you mean by 'work'? With this series as is, it simply isn=
't
> > > > > possible to add Makefile rules, as they are ignored. Am I missing
> > > > > something?
> > > >
> > > > Yes, I think you're missing something. Perhaps you need to publish =
a WIP
> > > > tree somewhere so someone can see what you're doing as it sounds li=
ke
> > > > you're not able to add another SoC of any type on top of Sumit's tr=
ee
> > > > and have it work.
> > >
> > > The current -next source builds dtb files based on the SoC, for the
> > > most part. I sent a series to clean that up a bit[1], but it is mostl=
y
> > > there.
> >
> > Yes, and that relied on Rasmus' series having been merged ages ago whic=
h
> > fixed up a number of "people just copypasta'd something here,
> > incorrectly".  Keep that in mind as part of why I have objections here.
>=20
> OK.

And since I think you're missing the point I was raising, because no one
else has the "any dtb from the SoC with this binary", we'll just be
getting back to re-introducing those kind of problems with what you're
demanding.

> > > From the above it seems like the plan could be:
> > > 1. Move arm64 .dts files to arch/arm64/dts/<vendor>/... and adjust
> > > Makefiles accordingly
> >
> > Since we're going to move everyone to being from the upstream kernel,
> > that seems like unneeded churn.
>=20
> What is the timeline for that move?

It could probably, largely, be done in 2024, for the platforms that
actively sync. For the ones that aren't behaving well right now? I don't
know, it'll depend on when someone shows up being active about them
again.

> We are talking about 1700 lines of Makefies and I already made a good
> start on part of it. So if we are going to be a few months with two
> different paths, fine, but this is going to drag on for a year, I
> would rather clean it up now and have a unified path for both sets of
> DTs.

The sticking point for migration is going to be the testing of the
platforms that are not well in sync at all.

> > > 2. Choose a directory target for devicetree-rebasing. I see that
> > > 'barebox' uses 'dts' which seems better to me than
> > > 'devicetree-rebasing/src/'. Actually barebox even seems to have
> > > scripts for handling all of this [2]??
> >
> > They've been doing this since longer than git subtree has existed I
> > believe. I suspect that much like how Rob would like to move the
> > in-kernel devicetree compiler sync from a script to git subtree, barebo=
x
> > will too.
>=20
> Maybe, although the first barebox dts/ commit was 2014 and subtree is
> claimed to come out in 2012...but then devicetree-rebasing might be
> newer, which would explain why they have 'git filter-branch' stuff in
> the script.

Well, it was just a guess on my part. It took a while for subtree to
catch on, and yes, it's taken a while for everything to reach the state
it's in today, for dts sources outside of the linux kernel itself.

> I thought devicetree-rebasing came from Linux. Is it its own repo? So
> what is the DT upstream these days??

I'll let Rob chime in again here if he likes. In short,
devicetree-rebasing is the kernel dts files/bindings copied out and
tagged, matching upstream kernel tags, and with assorted useful bits of
git history available.

> If subtree does what we want without making U-Boot look like
> Franekstein's monster, that's fine. But I don't mind having a script.

Yes, everyone else thus far seems fine with what we get via this series.

> > > 3. Adjust the build system to use the dts/ directory for .dts files
> > > when OF_UPSTREAM is enabled
> > >
> > > Then it will be easy. People can enable OF_UPSTREAM for an SoC
> > > (without changing DEFAULT_DEVICE_TREE) and will get the same behaviou=
r
> > > as now, just with upstream .dts files. All the .dts files for an SoC
> > > are built, as now, just as Linux does. We can continue cleaning up th=
e
> > > DT build rules as time permits.
> >
> > Maybe the unasked / unanswered question here is, why don't we put the
> > subtree in to dts/ ? Just because it would make us more likely to make
> > changes rather than treat it as read only?
>=20
> It is an easy checkpatch check, if that is your only concern.

Yeah, checkpatch isn't great for catching and stopping things. I don't
know how many other custodians check their PRs before I get to them. So
if it's not a fatal CI thing, it's not going to always be caught before
I see it, and I don't always catch "ERROR" things in checkpatch in a PR
either. But it might still be more annoying than not to have subtree be
shoved in to "dts". I'm hoping for some feedback from Sumit on this
point since I think he's played around.

--=20
Tom

--Groupsio=nDFB7Q3FtCAMuejGDx0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUrT8ACgkQFHw5/5Y0
tyzSrwwAsgKjRqRl+7ds/eM3YNfu6t+3wZkBdrIDRaxtygry1JBadkeG3UYzSfaK
82VXwiMhSiSIavvphtG9t+yFTVzepbsHBDbVZBpPZbnrNmyFHBpfIYe/MnIASVYc
l3ParyJlpnY+NIOJkRVOk3MF7Usmx5ftwUf3cSZHkPhYJ/D8Yjqh3JaAqycNVuvt
fnTWQE+JodUAtG3ftMM2LoEjmNfmGgrRZlmTLi+XZn0WNYLQwPQLtm9iuq47vAZL
oALW0e3cW6FVJ9Ki32BZXXGh94wtZ8OigmlDrbI2X1er+8KlrI2HkPxrXTiW7izW
WF4v0OaOUo95mA3/j8PFXn7lb5N153PJ4PByNYQ29h67CnCkKUspb8Y/JDJAweEu
JlvmGQohJSEObJkOX+CA1i6gVSs4pCZ8F3yNSPWiJATX2MWM+mj3dtgp7OlDDCtF
aSvdCh6uMKc1HmmuvLiVqOuDU32kAJMRp8Hj0UUMG18i6pbjSx2iYAEU6HvsysCa
Hhu7VnWa
=HESv
-----END PGP SIGNATURE-----

--Groupsio=nDFB7Q3FtCAMuejGDx0Q--

