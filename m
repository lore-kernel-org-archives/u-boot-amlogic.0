Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7BCCD1AB
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:41:45 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web10.6498.1760796590029049355
 for <u-boot-amlogic@groups.io>;
 Sat, 18 Oct 2025 07:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gyrB//Lc;
 spf=pass (domain: konsulko.com, ip: 209.85.166.173, mailfrom: trini@konsulko.com)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430cadec5deso14099125ab.1
        for <u-boot-amlogic@groups.io>; Sat, 18 Oct 2025 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760796589; x=1761401389; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuAbPfZKcdHeCJ+R2lg8Vyr8AvZf5RRjqFEw3QtM6Hs=;
        b=gyrB//LcnTiANGoH4mvGJSEDThocXLsj9wDT/lgeTz7YcUJrwKeseqyFMc1t0HQAcV
         /BK/NyHNSyBjIPDIxeD9GjdU3VHnT1jbvOLHGuIL1NLRWcpgfeVz+BbiUr+NSb0Rtmdl
         JqiI22KiO0WhC7PFPdWCitBd6bvqX3Me4DPA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760796589; x=1761401389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuAbPfZKcdHeCJ+R2lg8Vyr8AvZf5RRjqFEw3QtM6Hs=;
        b=ccMO0nosPtEwi3HW/+8dEBTZfnxWPlFBEJyteq+nSbXyV+12dKg6pPry8XHAkLa5gF
         wwG93DpEYP4zuvk7fn+ui+rSeYpN8gkgvDLfn3s/Mv/hosrMX+ZvArkuQQN1dK277SqV
         S8mXvDaWPuKg0R5X3Azn1FilBpL2x6sGK/y2Ch9LOYnIrBI2nxhup3d/QRsoHfhdXW3S
         cjSR58ummU3qx2oyYNoWCQqAyoJb79upIqB57pmt8jn+1xhc04Jc3Z1HvFXfCEjQiVH6
         bv2VpQ5RlJY2pNd40+CNADf01zg0ziqHlu5wOXQTQVJDAnOJN2hyDJt3h7kT6UwRgHSX
         LTXg==
X-Forwarded-Encrypted: i=1; AJvYcCVstbwpBrMxdJn4XZOMyPCyzWu0Zjzp0RNCuMduOUh59bVSlu+ztWIt4YwWvRBqD120IT+jcrYMZponPd0GmQ==@groups.io
X-Gm-Message-State: AOJu0Yz6Ofb4oakX3C43JW2AIc6LSnxdtmhqsbU46FLzRoQVirJb13a6
	4bGhyEo4Hps8oY5TXZn/5IYtldFBPHQRkZKx3VMmdJqAWWMlYp1dhe2yUafRqk7Ai94Ka2WNJ+0
	3dLsyXK4=
X-Gm-Gg: ASbGncuYIrnKV72Jt5Vhm+sLCfHgz3SeyiAMQLUAKN9/y4vEzQkpHoNao1Si7YmNUFm
	Ab7GXoefj2xZzYX3YIaNg6dmE/dNGB9yCa6oVtPDZkiHDCoTonGKSGGwLkbS03/IPwwzNOqGsud
	JKUYG+pVGh3bLMPDDQ2IgBTsh94cOqd9LRxfgq6bmQ5xiYbZxcFfJ+X7o0aWqyWEfUszMUV7lnE
	q6FA12ktxcfmBAux9nu6Igh97+O4gN+4v4rqvHmZTgtMBlyVJ+uh7b7wV2+r8vBunN9DOhEJMQw
	Av2g3I8NGcmZAdaIjR3cVOiwGJpNzyvb8RPtZEztsudIdHKVp/tmyO3ZAGVL313j24H5xkGGnMX
	O5XtMT+yC3CwhaDSCZCIVzcPvTcQFe+YBjGqzB5KiOzdsc/mJFcbtaZSfApCAWalRkV/dHB9Zwi
	3JxfcI8X1YIaAQ3rEadJDXPgm46SO0pA/tuHVqUdk=
X-Google-Smtp-Source: AGHT+IGDFAnvW7ZjRMItT+YnltVJd/d4c1KbPS9EnXXz00WLnmPEfQ4m59x5GEtaMfHLyzXx7cfQKw==
X-Received: by 2002:a05:6808:4f50:b0:441:d679:efa1 with SMTP id 5614622812f47-443a2fecd71mr2701484b6e.32.1760796261212;
        Sat, 18 Oct 2025 07:04:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net. [187.190.202.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443dc4d5460sm554862b6e.4.2025.10.18.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:04:19 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:04:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot-amlogic@groups.io,
	u-boot@lists.denx.de, Paul Barker <paul@pbarker.dev>,
	uboot-snps-arc@synopsys.com,
	Dai Okamura <okamura.dai@socionext.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com,
	Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Joseph Chen <chenjh@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Peng Fan <peng.fan@nxp.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
	Michal Simek <michal.simek@amd.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Ye Li <ye.li@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
	Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Padmarao Begari <padmarao.begari@amd.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Tien Fong Chee <tien.fong.chee@altera.com>,
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
	Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
	Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
	Tingting Meng <tingting.meng@altera.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Minkyu Kang <mk7.kang@samsung.com>,
	Heiko Schocher <hs@nabladev.com>,
	Jonathan Currier <dullfire@yahoo.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Weijie Gao <weijie.gao@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
	Greg Malysa <malysagreg@gmail.com>,
	Ian Roberts <ian.roberts@timesys.com>,
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
	Utsav Agarwal <utsav.agarwal@analog.com>,
	Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 00/24] clk: Remove passing of negative errors through unsigned return
Message-ID: <20251018140414.GN6688@bill-the-cat>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=m0Krh4ohwtdHwp4LwogB"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:41:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2848

--Groupsio=m0Krh4ohwtdHwp4LwogB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 09:34:42AM +0100, Simon Glass wrote:
> Hi Andrew,
>=20
> On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
> >
> > This series removes the passing of negative errors through the .get_rat=
e
> > function in the clk_ops struct. This function returns an unsigned long.
> > The only value guaranteed to not be a valid clock rate is 0. This will
> > also bring the drivers more in sync with Linux to allow for easier code
> > porting and other maintenance in the future.
> > Another series will address the calling of clk_get_rate and associated
> > error handling.
>=20
> Some indication of the problem you ran into would be useful here.

The problem statement is in the paragraph you're quoting. The numerical
value of -ENOENT is a valid clock rate.

> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> > Andrew Goodbody (24):
> >       clk: meson: Remove negative error returns from clk_get_rate
> >       clk: sifive: Remove negative error returns from clk_get_rate
> >       clk: armada-37xx: Remove negative error returns from clk_get_rate
> >       clk: thead: th1520-ap: Remove negative error returns from clk_get=
_rate
> >       clk: ccf: Remove negative error returns from clk_get_rate
> >       clk: at91: Remove negative error returns from clk_get_rate
> >       clk: renesas: Remove negative error returns from clk_get_rate
> >       clk: rockchip: Remove negative error returns from clk_get_rate
> >       clk: Remove negative error returns from clk_get_rate
> >       clk: starfive: Remove negative error returns from clk_get_rate
> >       clk: altera: Remove negative error returns from clk_get_rate
> >       clk: uniphier: Remove negative error returns from clk_get_rate
> >       clk: aspeed: Remove negative error returns from clk_get_rate
> >       clk: nuvoton: Remove negative error returns from clk_get_rate
> >       clk: exynos: Remove negative error returns from clk_get_rate
> >       clk: imx: Remove negative error returns from clk_get_rate
> >       clk: ti: Remove negative error returns from clk_get_rate
> >       clk: mediatek: Remove negative error returns from clk_get_rate
> >       clk: owl: Remove negative error returns from clk_get_rate
> >       clk: tegra: Remove negative error returns from clk_get_rate
> >       clk: adi: Remove negative error returns from clk_get_rate
> >       clk: sophgo: Remove negative error returns from clk_get_rate
> >       clk: stm32: Remove negative error returns from clk_get_rate
> >       clk: x86: Remove negative error returns from clk_get_rate
> >
> >  drivers/clk/adi/clk-shared.c             |  2 +-
> >  drivers/clk/altera/clk-agilex.c          |  2 +-
> >  drivers/clk/altera/clk-agilex5.c         |  2 +-
> >  drivers/clk/altera/clk-n5x.c             |  2 +-
> >  drivers/clk/aspeed/clk_ast2500.c         |  2 +-
> >  drivers/clk/aspeed/clk_ast2600.c         |  2 +-
> >  drivers/clk/at91/compat.c                |  6 ++--
> >  drivers/clk/clk-hsdk-cgu.c               |  2 +-
> >  drivers/clk/clk-uclass.c                 |  4 +--
> >  drivers/clk/clk.c                        |  2 +-
> >  drivers/clk/clk_fixed_factor.c           |  4 +--
> >  drivers/clk/clk_k210.c                   |  6 ++--
> >  drivers/clk/clk_sandbox.c                |  4 +--
> >  drivers/clk/clk_scmi.c                   |  4 +--
> >  drivers/clk/clk_vexpress_osc.c           |  2 +-
> >  drivers/clk/clk_zynq.c                   |  4 +--
> >  drivers/clk/clk_zynqmp.c                 | 40 ++++++++++-----------
> >  drivers/clk/exynos/clk-exynos7420.c      |  2 +-
> >  drivers/clk/imx/clk-imx8qm.c             |  6 ++--
> >  drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
> >  drivers/clk/imx/clk-imxrt1170.c          |  2 +-
> >  drivers/clk/imx/clk-pllv3.c              |  2 +-
> >  drivers/clk/intel/clk_intel.c            |  2 +-
> >  drivers/clk/mediatek/clk-mtk.c           |  2 +-
> >  drivers/clk/meson/a1.c                   | 10 +++---
> >  drivers/clk/meson/axg.c                  | 10 +++---
> >  drivers/clk/meson/g12a.c                 | 36 +++++++++----------
> >  drivers/clk/meson/gxbb.c                 | 20 +++++------
> >  drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
> >  drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
> >  drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
> >  drivers/clk/owl/clk_owl.c                |  2 +-
> >  drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
> >  drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
> >  drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
> >  drivers/clk/rockchip/clk_rk3036.c        |  2 +-
> >  drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
> >  drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk322x.c        |  4 +--
> >  drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
> >  drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
> >  drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
> >  drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
> >  drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++--------=
--------
> >  drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++----------
> >  drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++---------
> >  drivers/clk/rockchip/clk_rv1108.c        |  4 +--
> >  drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++-----------=
---
> >  drivers/clk/sifive/sifive-prci.c         |  8 ++---
> >  drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
> >  drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
> >  drivers/clk/stm32/clk-stm32-core.c       |  4 +--
> >  drivers/clk/stm32/clk-stm32f.c           |  6 ++--
> >  drivers/clk/stm32/clk-stm32h7.c          |  4 +--
> >  drivers/clk/tegra/tegra-car-clk.c        |  2 +-
> >  drivers/clk/tegra/tegra186-clk.c         |  2 +-
> >  drivers/clk/thead/clk-th1520-ap.c        |  2 +-
> >  drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
> >  drivers/clk/ti/clk-divider.c             |  4 +--
> >  drivers/clk/ti/clk-mux.c                 |  2 +-
> >  drivers/clk/ti/clk-sci.c                 |  2 +-
> >  drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
> >  65 files changed, 290 insertions(+), 290 deletions(-)
> > ---
> > base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
> > change-id: 20251010-clk_ops-3b7cc9ccd070
> >
> > Best regards,
> > --
> > Andrew Goodbody <andrew.goodbody@linaro.org>
> >
>=20
> If you don't return an error, we cannot tell if the operation
> succeeded, or not. U-Boot needs to be deterministic and we need to be
> able to debug errors and detect them at runtime.
>=20
> We use ulong for the return value as a bit of a compromise, since it
> is inefficient to use 64-bit on a 32-bit machine. Ideally it would be
> long, but some clock rates are 3GHz and it would be confusing to cast
> to ulong before using the value.
>=20
> An alternative we discussed was to return an integer error with the
> clock rate returned in a parameter, but that seemed less efficient.
>=20
> With 64-bit machines, there really isn't a problem. Just checking for
> a negative value is good enough, since the clock rate isn't going to
> be 9 exahertz(?). Values between -CONFIG_ERR_PTR_OFFSET and 0 are
> errors and are defined to be so.
>=20
> If you want clk_get_rate() to work like Linux (suppress / ignore
> errors?), that's fine, but please create a clk_get_rate_err() (or
> similar) which actually returns the correct error, and keep the error
> return on the uclass interface. It is not uncommon to have the uclass
> do some processing on values passed to/from driver. This allows people
> who care to obtain the error.

This is moving things in the right direction of having the error
reporting and handling done where it can be done correctly. If there's
further parts of the Linux kernel-like API we need, we can take those
next.

--=20
Tom

--Groupsio=m0Krh4ohwtdHwp4LwogB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPOeWgAKCRAr4qD1Cr/k
ChTiAP9bd9AcnF9YQPEbhXRUDcVTsqeEjIS15V3Bf0DUt+edXgEAxdcXEmTx0HeV
5KJkZx1hXeGto6NJRTJUtcv/Yan48A0=
=I5dp
-----END PGP SIGNATURE-----

--Groupsio=m0Krh4ohwtdHwp4LwogB--

