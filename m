Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA44CCD1AF
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:41:45 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.1644.1760898547778475235
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Oct 2025 11:29:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=PE6drlys;
 spf=pass (domain: chromium.org, ip: 209.85.208.49, mailfrom: sjg@chromium.org)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso6592787a12.0
        for <u-boot-amlogic@groups.io>; Sun, 19 Oct 2025 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760898546; x=1761503346; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slG1a2FV7BYhmLZLPqMhyiEapBPBgsoexHX4DXzGNoM=;
        b=PE6drlys2XXWxfI/8YsPNbCb6d6HYQKaf2CCWJJ5bRrEGtNDWVpR0zasHwsLM4fZEr
         sasnkQbgE02RExbGiMo67GGkX7iISf1uuIxJStdGVy0ZStZRP1joV14GZqKlKEKMh0Xb
         SybGZIK50HA1QJQwLlVkQNayzsKDSeh/Q+d7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898546; x=1761503346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slG1a2FV7BYhmLZLPqMhyiEapBPBgsoexHX4DXzGNoM=;
        b=oSbyR3U58/uyC0eoYlX71z/i/cJNCZaqPnOe3cc1G7ew+Hh1+52wYJIgV8uBIkqkrN
         rRoLoeNcFipYvMuZ4X50NIx+Q6PAZfQkNmJ+W2bGcZttNWWkPXd0SE5BJKoxdVa3NKmS
         zOzHARHdLAB5bGR07Dm7Kt6AZUMTZADHXGfYFRGAz6s7d+G9Yu+LD5CvgBX90JrPSlzf
         +F4bssT9UElYz+FIAIWpPXl0keJ5WQ6iGmXzzXZLl7Dym20Gt9yPxRSl4eFJjVKqTmde
         witcvPBIun4Yxj48DEFHrNbCw5zwjA4tg8wZwGn0kdmBk5NTgXqQWFIJX+EdpmbEnL37
         LNoA==
X-Forwarded-Encrypted: i=1; AJvYcCWro8fbTIVVyJaYTx/aFyLxa2cJMRpElrHjZwFnlEk5a59wbVh6VSDlpNSJjOEUpg2iZ94e6diWD2EHncrFzg==@groups.io
X-Gm-Message-State: AOJu0YxZPrDSlnGgnx0R42CUEbyeZBYsD6OXMO01CmCIepiiAcNXI3CA
	eey+RHl+ofmVNUtdRHUdgRqZlWQExM1K9KgQELZpjynh78gzRB36e8OVu+cGMnMQOPqTFlXvcvs
	8mcaXWdUYZcmi5EInqBaDBXyHt0FeWNJBvasnhVzC2ZSB3exjkHAJ9Uy9orA=
X-Gm-Gg: ASbGncsuVUY1me21MrMY+Qs8YSwWGjEWpiAeGtDgH8rWcKmUsT1nydM5o16wwOy0MF8
	AQ8ibAFzKcDLkZHUygW4r0qQZUWJfLa8MtwuoKJEiLH+QUdhPFfhd2WKWTUqm1YSoPlBSmaZGfD
	QealwhEyM7KukwuIyYb5R/yEsA743kiO32HIOD5vVbEgDmgARXf2CoRHV6pNswVShSY/oSA+mPf
	Q7KN28tWs+MoL+2PHvbf/7Io9FoDQjOk8v195rny9hxpSt9oK94KKATNw==
X-Google-Smtp-Source: AGHT+IFwL+//y3KSYPT+eT5k0kOcjAQZT1Hk1Mwgsus+5H5K7X814GhlRwTuAkf+HvS1/+Np8q0MREP/Lany+i72QC0=
X-Received: by 2002:a05:6402:3552:b0:63c:683c:f9d2 with SMTP id
 4fb4d7f45d1cf-63c683d021cmr2881961a12.12.1760898545906; Sun, 19 Oct 2025
 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
 <20251018140414.GN6688@bill-the-cat> <CAFLszTjE5Gi8-UEjzAciasnWrBwanqDdDW2xX57ykrsYqAGFyQ@mail.gmail.com>
 <CAPVz0n2seuNyeJzhYgintpj0OR9qzutYER8LxxLDkssPtQbevg@mail.gmail.com> <20251019162104.GP6688@bill-the-cat>
In-Reply-To: <20251019162104.GP6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 19:28:52 +0100
X-Gm-Features: AS18NWCMtdV3U__YT7N6Ejrf3zn6ZLGYSzEP5MCZ-f2c5ypFlhCc1wFDqjOK60U
Message-ID: <CAFLszTi1Zx1i+5U-cGZ78t5vsDsuJX8acDNb6EemgT-L32CpBg@mail.gmail.com>
Subject: Re: [PATCH 00/24] clk: Remove passing of negative errors through unsigned return
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
	Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
	Dai Okamura <okamura.dai@socionext.com>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
	Joel Stanley <joel@jms.id.au>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, adsp-linux@analog.com, 
	uboot-stm32@st-md-mailman.stormreply.com, Lukasz Majewski <lukma@denx.de>, 
	Sean Anderson <seanga2@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
	Leo Yu-Chi Liang <ycliang@andestech.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, 
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
	Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
	Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
	Padmarao Begari <padmarao.begari@amd.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, 
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
	Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
	Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
	Tingting Meng <tingting.meng@altera.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Minkyu Kang <mk7.kang@samsung.com>, 
	Heiko Schocher <hs@nabladev.com>, Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Sam Shih <sam.shih@mediatek.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa <malysagreg@gmail.com>, 
	Ian Roberts <ian.roberts@timesys.com>, 
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
	Arturs Artamonovs <arturs.artamonovs@analog.com>, 
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:41:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2850

Hi Tom,

On Sun, 19 Oct 2025 at 17:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 19, 2025 at 04:45:24PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BD=D0=B4, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE =
16:05 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Tom, Andrew,
> > >
> > > On Sat, 18 Oct 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 18, 2025 at 09:34:42AM +0100, Simon Glass wrote:
> > > > > Hi Andrew,
> > > > >
> > > > > On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
> > > > > <andrew.goodbody@linaro.org> wrote:
> > > > > >
> > > > > > This series removes the passing of negative errors through the =
.get_rate
> > > > > > function in the clk_ops struct. This function returns an unsign=
ed long.
> > > > > > The only value guaranteed to not be a valid clock rate is 0. Th=
is will
> > > > > > also bring the drivers more in sync with Linux to allow for eas=
ier code
> > > > > > porting and other maintenance in the future.
> > > > > > Another series will address the calling of clk_get_rate and ass=
ociated
> > > > > > error handling.
> > > > >
> > > > > Some indication of the problem you ran into would be useful here.
> > > >
> > > > The problem statement is in the paragraph you're quoting. The numer=
ical
> > > > value of -ENOENT is a valid clock rate.
> > >
> > > No, I mean a problem with a board, or something like that. We are
> > > talking here about not being able to return a valid clock rate betwee=
n
> > > 4294967040 and 4294967295, which is only even a theoretical problem o=
n
> > > 32-bit machines. So I think it is reasonable to include a motivation.
> > >
> > >
> > > >
> > > > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > > ---
> > > > > > Andrew Goodbody (24):
> > > > > >       clk: meson: Remove negative error returns from clk_get_ra=
te
> > > > > >       clk: sifive: Remove negative error returns from clk_get_r=
ate
> > > > > >       clk: armada-37xx: Remove negative error returns from clk_=
get_rate
> > > > > >       clk: thead: th1520-ap: Remove negative error returns from=
 clk_get_rate
> > > > > >       clk: ccf: Remove negative error returns from clk_get_rate
> > > > > >       clk: at91: Remove negative error returns from clk_get_rat=
e
> > > > > >       clk: renesas: Remove negative error returns from clk_get_=
rate
> > > > > >       clk: rockchip: Remove negative error returns from clk_get=
_rate
> > > > > >       clk: Remove negative error returns from clk_get_rate
> > > > > >       clk: starfive: Remove negative error returns from clk_get=
_rate
> > > > > >       clk: altera: Remove negative error returns from clk_get_r=
ate
> > > > > >       clk: uniphier: Remove negative error returns from clk_get=
_rate
> > > > > >       clk: aspeed: Remove negative error returns from clk_get_r=
ate
> > > > > >       clk: nuvoton: Remove negative error returns from clk_get_=
rate
> > > > > >       clk: exynos: Remove negative error returns from clk_get_r=
ate
> > > > > >       clk: imx: Remove negative error returns from clk_get_rate
> > > > > >       clk: ti: Remove negative error returns from clk_get_rate
> > > > > >       clk: mediatek: Remove negative error returns from clk_get=
_rate
> > > > > >       clk: owl: Remove negative error returns from clk_get_rate
> > > > > >       clk: tegra: Remove negative error returns from clk_get_ra=
te
> > > > > >       clk: adi: Remove negative error returns from clk_get_rate
> > > > > >       clk: sophgo: Remove negative error returns from clk_get_r=
ate
> > > > > >       clk: stm32: Remove negative error returns from clk_get_ra=
te
> > > > > >       clk: x86: Remove negative error returns from clk_get_rate
> > > > > >
> > > > > >  drivers/clk/adi/clk-shared.c             |  2 +-
> > > > > >  drivers/clk/altera/clk-agilex.c          |  2 +-
> > > > > >  drivers/clk/altera/clk-agilex5.c         |  2 +-
> > > > > >  drivers/clk/altera/clk-n5x.c             |  2 +-
> > > > > >  drivers/clk/aspeed/clk_ast2500.c         |  2 +-
> > > > > >  drivers/clk/aspeed/clk_ast2600.c         |  2 +-
> > > > > >  drivers/clk/at91/compat.c                |  6 ++--
> > > > > >  drivers/clk/clk-hsdk-cgu.c               |  2 +-
> > > > > >  drivers/clk/clk-uclass.c                 |  4 +--
> > > > > >  drivers/clk/clk.c                        |  2 +-
> > > > > >  drivers/clk/clk_fixed_factor.c           |  4 +--
> > > > > >  drivers/clk/clk_k210.c                   |  6 ++--
> > > > > >  drivers/clk/clk_sandbox.c                |  4 +--
> > > > > >  drivers/clk/clk_scmi.c                   |  4 +--
> > > > > >  drivers/clk/clk_vexpress_osc.c           |  2 +-
> > > > > >  drivers/clk/clk_zynq.c                   |  4 +--
> > > > > >  drivers/clk/clk_zynqmp.c                 | 40 ++++++++++------=
-----
> > > > > >  drivers/clk/exynos/clk-exynos7420.c      |  2 +-
> > > > > >  drivers/clk/imx/clk-imx8qm.c             |  6 ++--
> > > > > >  drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
> > > > > >  drivers/clk/imx/clk-imxrt1170.c          |  2 +-
> > > > > >  drivers/clk/imx/clk-pllv3.c              |  2 +-
> > > > > >  drivers/clk/intel/clk_intel.c            |  2 +-
> > > > > >  drivers/clk/mediatek/clk-mtk.c           |  2 +-
> > > > > >  drivers/clk/meson/a1.c                   | 10 +++---
> > > > > >  drivers/clk/meson/axg.c                  | 10 +++---
> > > > > >  drivers/clk/meson/g12a.c                 | 36 +++++++++-------=
---
> > > > > >  drivers/clk/meson/gxbb.c                 | 20 +++++------
> > > > > >  drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
> > > > > >  drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
> > > > > >  drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
> > > > > >  drivers/clk/owl/clk_owl.c                |  2 +-
> > > > > >  drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
> > > > > >  drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
> > > > > >  drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
> > > > > >  drivers/clk/rockchip/clk_rk3036.c        |  2 +-
> > > > > >  drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
> > > > > >  drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
> > > > > >  drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
> > > > > >  drivers/clk/rockchip/clk_rk322x.c        |  4 +--
> > > > > >  drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
> > > > > >  drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
> > > > > >  drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
> > > > > >  drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
> > > > > >  drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
> > > > > >  drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
> > > > > >  drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++=
----------------
> > > > > >  drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++-------=
---
> > > > > >  drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++--------=
-
> > > > > >  drivers/clk/rockchip/clk_rv1108.c        |  4 +--
> > > > > >  drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++---=
-----------
> > > > > >  drivers/clk/sifive/sifive-prci.c         |  8 ++---
> > > > > >  drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
> > > > > >  drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
> > > > > >  drivers/clk/stm32/clk-stm32-core.c       |  4 +--
> > > > > >  drivers/clk/stm32/clk-stm32f.c           |  6 ++--
> > > > > >  drivers/clk/stm32/clk-stm32h7.c          |  4 +--
> > > > > >  drivers/clk/tegra/tegra-car-clk.c        |  2 +-
> > > > > >  drivers/clk/tegra/tegra186-clk.c         |  2 +-
> > > > > >  drivers/clk/thead/clk-th1520-ap.c        |  2 +-
> > > > > >  drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
> > > > > >  drivers/clk/ti/clk-divider.c             |  4 +--
> > > > > >  drivers/clk/ti/clk-mux.c                 |  2 +-
> > > > > >  drivers/clk/ti/clk-sci.c                 |  2 +-
> > > > > >  drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
> > > > > >  65 files changed, 290 insertions(+), 290 deletions(-)
> > > > > > ---
> > > > > > base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
> > > > > > change-id: 20251010-clk_ops-3b7cc9ccd070
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > >
> > > > >
> > > > > If you don't return an error, we cannot tell if the operation
> > > > > succeeded, or not. U-Boot needs to be deterministic and we need t=
o be
> > > > > able to debug errors and detect them at runtime.
> > > > >
> > > > > We use ulong for the return value as a bit of a compromise, since=
 it
> > > > > is inefficient to use 64-bit on a 32-bit machine. Ideally it woul=
d be
> > > > > long, but some clock rates are 3GHz and it would be confusing to =
cast
> > > > > to ulong before using the value.
> > > > >
> > > > > An alternative we discussed was to return an integer error with t=
he
> > > > > clock rate returned in a parameter, but that seemed less efficien=
t.
> > > > >
> > > > > With 64-bit machines, there really isn't a problem. Just checking=
 for
> > > > > a negative value is good enough, since the clock rate isn't going=
 to
> > > > > be 9 exahertz(?). Values between -CONFIG_ERR_PTR_OFFSET and 0 are
> > > > > errors and are defined to be so.
> > > > >
> > > > > If you want clk_get_rate() to work like Linux (suppress / ignore
> > > > > errors?), that's fine, but please create a clk_get_rate_err() (or
> > > > > similar) which actually returns the correct error, and keep the e=
rror
> > > > > return on the uclass interface. It is not uncommon to have the uc=
lass
> > > > > do some processing on values passed to/from driver. This allows p=
eople
> > > > > who care to obtain the error.
> > > >
> > > > This is moving things in the right direction of having the error
> > > > reporting and handling done where it can be done correctly. If ther=
e's
> > > > further parts of the Linux kernel-like API we need, we can take tho=
se
> > > > next.
> > >
> > > Here is part of the patch:
> > >
> > > --- a/drivers/clk/meson/a1.c
> > > +++ b/drivers/clk/meson/a1.c
> > > @@ -359,7 +359,7 @@ static ulong meson_div_get_rate(struct clk *clk,
> > > unsigned long id)
> > >
> > >         info =3D meson_clk_get_info(clk, id, MESON_CLK_DIV);
> > >         if (IS_ERR(info))
> > > -               return PTR_ERR(info);
> > > +               return 0;
> > >
> > > I don't see anything in that fragment other than just ignoring errors=
.
> > >
> >
> > I agree with Simon. This patchset may cause a lot of problems for all
> > boards it changes in case clk ops fail, since it silences all error
> > returns. Any clock error will be untrackable unless you know where and
> > what to look specifically.
>
> I think it's worth going back to the original thread:
> https://lore.kernel.org/u-boot/f5c94319-8ef8-459d-88b2-836702779cfb@linar=
o.org/

Specifically Heinrich's response which seems to make sense to me -
i.e. IS_ERR_VALUE(). A series that introduced that everywhere would
get my vote :-)

>
> As part of the problem is that what we have today does not work. This is
> why I'm think it's OK to first return 0, always, as the invalid clock
> rate and then re-introduce error checking that can work.

OK, but actually what doesn't work today? Which board is broken? Is
the problem that no one checks the errors?

- Simon

