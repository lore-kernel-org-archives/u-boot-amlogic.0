Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEFCCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.8209.1760674307284398935
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Oct 2025 21:11:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cwd0VPQT;
 spf=pass (domain: gmail.com, ip: 209.85.210.175, mailfrom: malysagreg@gmail.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782023ca359so1529835b3a.2
        for <u-boot-amlogic@groups.io>; Thu, 16 Oct 2025 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760674307; x=1761279107; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3IDJ+vLRLRjQM/X27foHFqyNmEo5T95YhlhbnJkmvE=;
        b=cwd0VPQTfUBYeWGfw+u+qBsXIpqaN/W7Eg6Hoq+Esck4ySQ9RPXuPXxtSU1w7CTjwO
         fWoPUx67J11jO8MxDImPsYW0ehtJWSr+xDdvMcR5pf+v9J5bNPbMI/rHmGrNY5jFBtRN
         eWRyJrDRPjMNSwsll8n7Tnz9opQn0NwjpQ/xO3tou6RuNY8dvt6z7LH2JWx4N6XuDTvk
         JBGdy28Hy5Q7F7QVpD3b1J4e1AGFktzFpmJ/X3gfrGPftaFL5ocaqz7curGLpB7mR3oo
         0uZx9AWnzkHmb3Pu+xMzvqSeZ0Tt7K5e2iCLveaMHNcRlB0DZ9Otjyr0t10PxnKLFT2z
         6Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674307; x=1761279107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3IDJ+vLRLRjQM/X27foHFqyNmEo5T95YhlhbnJkmvE=;
        b=epobZDit05iPBT1igW8Jg8bxq6RuOA9A4dyYwFfk1UmfhUtW+ImAStcT6CTWtsfImv
         drBaURmXL4h1O5MStOBTUpMsc7Z5kJF1Ac6SfSJm+pqRjtCGjePMYCRFCcQVI1m0N134
         lRGnCYfIEMdZp7Uxo5RKRzae1GJvj45nsfqFZ5nwzOlrJhpp6/DX3GxgXPykCJ4QacFR
         DLEW9txb6tdoPaNCALpGDReoEFVn/JnJ6teudPbCRN439oKP/+++CIuSDjW15oWQM+Zc
         6bIfiYljfHXtPCCnkcy1ZtWDWxbdtNqIfm9QPHS1kuIenrQlM5MMqL1jOGC49wYfPM5/
         UrNw==
X-Gm-Message-State: AOJu0YzaPMqhqmEP2HNkli4b5umNu59mDQ1rGqJuz6JygVONl57p2Im0
	o21GIsWd/jbon/XrHwoAYrmGhHEBahwcVa0RdVUDODcMaMBYwOnnXaRGTfeys2PuzWvTR9I7EJZ
	Uvq3QZdoa7YpsjxHBVP9zUBTx03AtJU9KvYMG7g==
X-Gm-Gg: ASbGncs0+lNT4qOER6VTeXeAMSCgaw1QhhpYEW9KaPc/9lHtqzcik6HhUe4o0JobCaE
	ZSsVG8Y7jQ+TfpFnZKOYJ3Kj83ffeGhshxzgHz4E9Wqs4CXNiGjoMdUhclo0XF7nK7OLCIgyyM7
	VpzjzTju6OV8v24s/xOSDPnmmNtJCIDubAJAEJeWxMw2889N62uI3zNLSw4wD2tpStPp8woAA8t
	prBfeB8RZl3z/SL3H0B0pTQq/RfKxexKfrjhFIC5nI28DDf2PNwT3Vll2NMxAu/cAchQcXSEpco
	1Q4WQt/ExBYO0q9w7QgmwCutsRc=
X-Google-Smtp-Source: AGHT+IHmzB317oQkQHpHZys/FCDRniELEzvLa5cBeIzNljKywnu98WHQOROmEkt1+b0K86qlXFzZhCreAxtHUKqwOEE=
X-Received: by 2002:a17:902:f541:b0:28d:1939:f9c8 with SMTP id
 d9443c01a7336-290cb0803d5mr30672475ad.26.1760673863365; Thu, 16 Oct 2025
 21:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org> <20251015-clk_ops-v1-21-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-21-5f80f827407e@linaro.org>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 17 Oct 2025 00:02:55 -0400
X-Gm-Features: AS18NWDw-WCq3s6Td5-JQy4J-j4STU-cSY6siJRlDbWGdZZhreSlSr0RoZPk1VQ
Message-ID: <CABdDSeVJnZfp86yDXw6sh4cioKTsYj3NcGy_sgVMdja0K_pApg@mail.gmail.com>
Subject: Re: [PATCH 21/24] clk: adi: Remove negative error returns from clk_get_rate
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
	Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
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
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2822

On Wed, Oct 15, 2025 at 10:33=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> clk_get_rate() returns a ulong so do not attempt to pass negative error
> codes through it.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/adi/clk-shared.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
> index dcadcafa9d236882af8c7b397eeeeb44461a23cb..600e22940e8cb60b1e510a74e=
e8068ccf0c7848a 100644
> --- a/drivers/clk/adi/clk-shared.c
> +++ b/drivers/clk/adi/clk-shared.c
> @@ -16,7 +16,7 @@ static ulong adi_get_rate(struct clk *clk)
>
>         ret =3D clk_get_by_id(clk->id, &c);
>         if (ret)
> -               return ret;
> +               return 0;
>
>         return clk_get_rate(c);
>  }
>
> --
> 2.47.3
>

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Tested on my sc573 and sc598 boards, looks good.

Thanks,
Greg

