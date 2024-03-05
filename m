Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A62C54E68
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.21942.1709642576734455700
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Mar 2024 04:42:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mz/rlJRT;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f5cdca7a3so48802456d6.1
        for <u-boot-amlogic@groups.io>; Tue, 05 Mar 2024 04:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1709642576; x=1710247376; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wk69115rxQ7gj5iSGgTkNwUAZw6Ry8B22GrBL+mokpY=;
        b=mz/rlJRTtwUbqVKhP37BEpuTWU1FRVIPi7jBAFJttddlfZfbLf9wwVmqwGaMVA0UfT
         Afvxk3+fcUhI3cvZuJc8SRl2MqnJDij03HgR7dcKZ/8iveVTTV7/nDQcrTMHDcsYg2Cd
         h5mFTAZpwrRbp6nxzVPowm32mfgsCKGFOIzr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642576; x=1710247376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk69115rxQ7gj5iSGgTkNwUAZw6Ry8B22GrBL+mokpY=;
        b=hFrPEvhfiVUn5TJW4Eve40VXmUlkB8Ax7XBhVa1NnBa2Vx28CL0IdbFruBKReRSooB
         rbS2oCOxAddbW51FGJ3PY44fSnHDsm/pmuTDutJk9s69d3WZwdcR3xj8sHZ8ssbVUoen
         otm09Pz8lUFTXV5ImmpkxiA0TSEQvizKsot0otv1+xfJYeDMAIEsPd0uTEJ68QRN0zBz
         gqciaNfQmqSTq1hxkhnSZunxOQ4mLs6hPqE5nCD2fCmKi2iuzVQAVR2r6EDGLGHdF1So
         e1P+lNIBvhWRUtFoOL4YeCKu0nKaJ3f7NsbpknNAWFKnxBxOt9w7ipQh8y+DRzHvtynG
         F1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWMH4CHBDYPT0vl6jt8YnCCwZe5KVLnAJb4iAwuAIolO26xPenOIJKtBuhVl65320VM91PZIfPP6VGgvoH1AIano8AfKQNMXQ0=
X-Gm-Message-State: AOJu0YwnQF3M7nj+NbEMDD+bsv0rKxzIxqs9dNNjGm2XAMPnZGWfr8Dn
	RWDoAO2IlBnhQawq53ruNNoX1guj1KmfniEzzNCW3+HcyFGWogOcVSpgnjDhAvk=
X-Google-Smtp-Source: AGHT+IFLNemNWxb6qjPWkXHj6fl0HhKSexUpwLRPqamXkhTxAKI2ZSemBXE9u8kgXTgwrXjDU6fpLg==
X-Received: by 2002:a05:6214:1255:b0:68f:5d7f:6a8d with SMTP id r21-20020a056214125500b0068f5d7f6a8dmr3197673qvv.3.1709642575818;
        Tue, 05 Mar 2024 04:42:55 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com. [2603:6081:7b00:7f::1000])
        by smtp.gmail.com with ESMTPSA id ol14-20020a0562143d0e00b0068ffdb8fb59sm6208452qvb.112.2024.03.05.04.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:42:53 -0800 (PST)
Date: Tue, 5 Mar 2024 07:42:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Simon Glass <sjg@chromium.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Matthias Brugger <mbrugger@suse.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Ramon Fried <rfried.dev@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Weijie Gao <weijie.gao@mediatek.com>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Dai Okamura <okamura.dai@socionext.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	uboot-snps-arc@synopsys.com
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a specific vendor
Message-ID: <20240305124250.GZ1523872@bill-the-cat>
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=SIIgpSrKQEjMne8Ooj0C"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2187

--Groupsio=SIIgpSrKQEjMne8Ooj0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 06:05:52PM +0530, Sumit Garg wrote:
> Hi Caleb,
>=20
> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> w=
rote:
> >
> > This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> > all the devicetree files for a given vendor to be compiled. This is
> > useful for Qualcomm in particular as most boards are supported by a
> > single U-Boot build just provided with a different DT.
> >
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> >  dts/Kconfig          | 24 ++++++++++++++++++++++++
> >  scripts/Makefile.dts | 17 ++++++++++++++++-
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index b9b6367154ef..67d9dc489856 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -100,8 +100,32 @@ config OF_UPSTREAM
> >           However, newer boards whose devicetree source files haven't l=
anded in
> >           the dts/upstream subtree, they can override this option to ha=
ve the
> >           DT build from existing U-Boot tree location instead.
> >
> > +config OF_UPSTREAM_BUILD_VENDOR
> > +       bool "Build all devicetree files for a particular vendor"
> > +       depends on OF_UPSTREAM
> > +       help
> > +         Enable building all devicetree files for a particular vendor.=
 This
>=20
> Do we really want to build all the DTBs even if many of those aren't
> supported by U-Boot at all? I would have rather added Makefile targets
> for boards which really supports a single defconfig eg.
> qcom_defconfig.

Yes, I think this target is useful as it addresses some of Simon's
earlier concerns with the feature.

--=20
Tom

--Groupsio=SIIgpSrKQEjMne8Ooj0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnE0cACgkQFHw5/5Y0
tyxtGQv/Wod2EBmX5FhenEgBCfdTBzSxdGJ5+X+907CEYEwKHQ2EKUD/rLyaYBWh
YoLu0e5mas2+3PSBBWdmvapYqusnc6vXxr53UYOSXkMzWuL1FeMvirhrelb1jdfC
S3bB3gnPMXZukz8q6DpsjfOpeAJiWPtYmSYJPZBq7aXgWusAFIb1aGEww+Zp2R+4
AZqwEuT0g4IBCJvjVg/B+QcaH8LivpTGBATr0kTMvRHRKuuu6qD0VqOKgiUVqQnW
Ls4aIfSm9ul0rUBEgkeatEVprJVO5wXxye6l1DXLCtsURyBmKpP9trV/ZLnzTDZN
sakhwNI+y1A36CFSM8EVFUcXqulgFD/OV0prY4nYZswhezgT/MOg4lWisSa1xJ/d
c2h1BWzsYIgNULElLCiStIZwpHI4hD09XL4T5whAEYYmX3NK4pK9gSq4M/JXhRCH
aJrCz952CoPnp/t3S8LJyW34GwdbOo1XfxlUPnoLv2EGMIAZKzEl5tX3wAyu3xNn
6Hcdp7my
=UZMy
-----END PGP SIGNATURE-----

--Groupsio=SIIgpSrKQEjMne8Ooj0C--

