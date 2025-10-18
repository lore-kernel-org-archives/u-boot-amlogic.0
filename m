Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA96CCD1B3
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:41:45 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.2318.1760776849251742992
 for <u-boot-amlogic@groups.io>;
 Sat, 18 Oct 2025 01:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=DV0aAfcz;
 spf=pass (domain: chromium.org, ip: 209.85.218.46, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b457d93c155so389492066b.1
        for <u-boot-amlogic@groups.io>; Sat, 18 Oct 2025 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760776848; x=1761381648; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GyQWOulrh/Eer1xNnW7Kyg8KGv0rCXH9pL1ZkY7eaSU=;
        b=DV0aAfcz5rFtP5rjO7XJsvXpV+KaKh6F2zlni+6md+iP+o68TbfjUsKsocYLuU60Jw
         4972+8ACkBcvtMd0dasHugFchF1xEyG504i2trw5qUoXUS8tMoBC8OMS53tUOzHJ2TQl
         ZZXGgxpfUKr2OqevjiRud1/4VhrM1Cab5h1QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760776848; x=1761381648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyQWOulrh/Eer1xNnW7Kyg8KGv0rCXH9pL1ZkY7eaSU=;
        b=OPkn358279CotKmAzOtTJvA59IyZcyX9wsxPg5iHSAXC6jwAcM5dQIHBSTym9A9Gbr
         vNju4oPjfwwUEoA4X89wnnpUXkwfgiC7s+udn7hEZYjVjMxeLTlj/+meU1t+eRtwq4Jo
         wv8aeENxPAKdgMVtG5e8ofeN/rpchfPCchC3ZIauMrj/mtFj6xuL9ds+q3uu5KZePboz
         Q+yJyPkkPldm1Cw/O/Wfs0vh6ZRw+lZE5l8rXU+r5kLALcOQ4Kw/OtLmcfeFU+T1thWy
         SOPf1AzvLUvnoyCw1y6Xgq2O1H0dnXgmd6CjUvcz14+ODviMvga24ZXXw2ZGBFy+7WS8
         WKTg==
X-Gm-Message-State: AOJu0YyMdLRylEp3uIiCWaON5+3JM+Ghx9f3rVPWjHz3hm05757Cj9YN
	OqxCu4mYoVjUAYqQ1BwpWMnIlgtFzaqp+utjNFJOVVWu7mmB4A7Mki6TLvE3cBiq1hnkI9GBoIK
	hf5NU6YCWyGcuIZrjpNqJlclDUE0oWRboeefzJ4yDKQ7yyTBWFpa2OFZ8
X-Gm-Gg: ASbGncs5XjTdql9R1edyg9EBBWHa/oUrku/7ZMrQ+Wsq9GMZevyYzJyObmCGlAcncP1
	b7J+ROLry04mRmPYNMRQuoTMe+Mnw9TrK7k+7SLSgw1qUOiTEPeN+FIkFNkGR5c4HLbkIlX5J/L
	heNGpf5VyWl1h5W//ZEpoSI9h0B7HRq69QsUtz8k1e8tX2U/VoOVnzJTDizlTIiAtdgfoX4aOAq
	9wxJh2Dbq0wcdj/5Oluu9DsEHGuASQ7APs3nBXosJwqUt3XSpBIkU14cIaS
X-Google-Smtp-Source: AGHT+IGWGGbVkCD3XOXmUZtpd0mvxQ85Bf+KNTpUMy0MxPwXGTLHNb9i04xYr36/ycvqCIxLVPMPa77V3aHPjtVYa5s=
X-Received: by 2002:a05:6402:286:b0:637:c0c3:fbc1 with SMTP id
 4fb4d7f45d1cf-63c1f6d3244mr4188243a12.30.1760776501460; Sat, 18 Oct 2025
 01:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org> <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-1-5f80f827407e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Oct 2025 09:34:48 +0100
X-Gm-Features: AS18NWBnLaAN6fZ9FkElI-GXJyJ7IwNjlDP4wjDRZycZoPdxyTeUW7J3w9JNY2U
Message-ID: <CAFLszTiPBOmz88HXUAM6Qdrth9xm5sgeyRxVO=GV_1GVAFucSA@mail.gmail.com>
Subject: Re: [PATCH 01/24] clk: meson: Remove negative error returns from clk_get_rate
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
	Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
	Dai Okamura <okamura.dai@socionext.com>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
	Joel Stanley <joel@jms.id.au>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, adsp-linux@analog.com, 
	uboot-stm32@st-md-mailman.stormreply.com, Lukasz Majewski <lukma@denx.de>, 
	Sean Anderson <seanga2@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
	Yao Zi <ziyao@disroot.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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
	Svyatoslav Ryhel <clamor95@gmail.com>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
	Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
	Arturs Artamonovs <arturs.artamonovs@analog.com>, 
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:41:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2846

Hi Andrew,

On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/meson/a1.c   | 10 +++++-----
>  drivers/clk/meson/axg.c  | 10 +++++-----
>  drivers/clk/meson/g12a.c | 36 ++++++++++++++++++------------------
>  drivers/clk/meson/gxbb.c | 20 ++++++++++----------
>  4 files changed, 38 insertions(+), 38 deletions(-)
>

Don't change the driver interface...just update the uclass.

Regards,
Simon

