Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48981EC1E87
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 09:49:00 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19091.1770207373365575185
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Feb 2026 04:16:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@dolcini.it header.s=default header.b=to4PK8Vo;
 spf=pass (domain: dolcini.it, ip: 217.194.8.81, mailfrom: francesco@dolcini.it)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E330B20200;
	Wed,  4 Feb 2026 13:08:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1770206946;
	bh=rV8MugSWJElUnNJsq7kkw6TNF2UDbsneM9RTfewRwN4=; h=From:To:Subject;
	b=to4PK8VovRxkk4HB3VrCibnTpWSWGzhQbGd4ORVcP57KdqtI0qRD0zzbFovs2X4Q0
	 6KZu3W912iZZ8/mxZk0q9kb+UTXOQu6JfaioZP6ebtdVmsNjPY3t0e3TIQefpATbw6
	 rTvIZ6rKf5IyplVUs7HTfJ8YxgxuucqYdKBJpx8FeDpgvaa4rpw3Bpq5vaY8ARDc82
	 +8j56kzaId6Ji+iIzNkUQuV1NbQX/CI6YmFqy1zoI4VeymMCNSG0JZjZcMItpo3HPn
	 7bj1eqAnVkr8zwEGT4mVYVRbJZisT8AbyhvrYlp5dVZaTh6HZR0JojXICbdxqNb37j
	 pQ5uU8Ik++fyA==
Date: Wed, 4 Feb 2026 13:08:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Christoph Stoidner <c.stoidner@phytec.de>, kernel@puri.sm,
	Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
	u-boot@dh-electronics.com, upstream@lists.phytec.de,
	u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com,
	adsp-linux@analog.com, Adam Ford <aford173@gmail.com>,
	Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Weijie Gao <weijie.gao@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>,
	Anton Moryakov <ant.v.moryakov@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Rasmus Villemoes <ravi@prevas.dk>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Jerome Forissier <jerome@forissier.org>,
	Simon Glass <sjg@chromium.org>, Max Filippov <jcmvbkbc@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Stefano Babic <sbabic@nabladev.com>,
	Alexey Brodkin <alexey.brodkin@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Stefan Bosch <stefan_b@posteo.net>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Vasut <marex@denx.de>,
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
	Tien Fong Chee <tien.fong.chee@altera.com>,
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Aaron Williams <awilliams@marvell.com>,
	Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Bin Meng <bmeng.cn@gmail.com>,
	Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
	"Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Randolph <randolph@andestech.com>,
	David Feng <fenghua@phytium.com.cn>,
	Linus Walleij <linusw@kernel.org>,
	Peter Hoyes <Peter.Hoyes@arm.com>,
	Liviu Dudau <liviu.dudau@foss.arm.com>, Nishanth Menon <nm@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gilles Talis <gilles.talis@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
	Mario Six <mario.six@gdsys.cc>, Marco Franchi <marcofrk@gmail.com>,
	Alifer Moraes <alifer.wsdm@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Thiery <heiko.thiery@gmail.com>,
	"Lukas F. Hartmann" <lukas@mntre.com>,
	Patrick Wildt <patrick@blueri.se>,
	Martyn Welch <martyn.welch@collabora.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Teresa Remmet <t.remmet@phytec.de>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Angus Ainslie <angus@akkea.ca>,
	Stephan Gerhold <stephan@gerhold.net>,
	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
	Ilko Iliev <iliev@ronetix.at>, Kamil Lulko <kamil.lulko@gmail.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Dillon Min <dillon.minfei@gmail.com>, Bryan Brattlof <bb@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lukasz Majewski <lukma@denx.de>,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	Heiko Schocher <hs@nabladev.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Ramon Fried <rfried.dev@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
	Greg Malysa <malysagreg@gmail.com>,
	Ian Roberts <ian.roberts@timesys.com>,
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
	Utsav Agarwal <utsav.agarwal@analog.com>,
	Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Anastasiia Lukianenko <vicooodin@gmail.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Anatolij Gustschin <ag.dev.uboot@gmail.com>,
	Brian Sune <briansune@gmail.com>,
	Tingting Meng <tingting.meng@altera.com>,
	Mahesh Rao <mahesh.rao@altera.com>, Ye Li <ye.li@nxp.com>,
	Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
	Jeremy Compostella <jeremy.compostella@intel.com>,
	Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
	Debbie Horsfall <debbie.horsfall@arm.com>,
	Harrison Mutai <harrison.mutai@arm.com>,
	Jonathan Humphreys <j-humphreys@ti.com>,
	Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>,
	Francesco Valla <francesco@valla.it>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	"Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
	Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole <d-gole@ti.com>,
	Neha Malcom Francis <n-francis@ti.com>, Keerthy <j-keerthy@ti.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Maxim Moskalets <maximmosk4@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Adriano Cordova <adrianox@gmail.com>,
	Mark Kettenis <kettenis@openbsd.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Joseph Chen <chenjh@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Viorel Suman <viorel.suman@nxp.com>,
	Sky Huang <SkyLake.Huang@mediatek.com>,
	"Lucien.Jheng" <lucienzx159@gmail.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Alexander Feilke <alexander.feilke@ew.tq-group.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>,
	E Shattow <e@freeshell.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Paul Geurts <paul.geurts@prodrive-technologies.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
	Eoin Dickson <eoin.dickson@microchip.com>,
	David Zang <davidzangcs@gmail.com>,
	Brian Ruley <brian.ruley@gehealthcare.com>,
	Swamil Jain <s-jain1@ti.com>, Zixun LI <admin@hifiphile.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
	Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
	Alexander Graf <agraf@csgraf.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
	Leonard Anderweit <l.anderweit@phytec.de>,
	Dinesh Maniyam <dinesh.maniyam@altera.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 07/14] toradex: common: Add missing headers
Message-ID: <20260204120855.GA30917@francesco-nb>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 05 Feb 2026 09:49:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2920

On Tue, Feb 03, 2026 at 06:41:38PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Include linux/types.h and asm-generic/u-boot.h. Missing the two header
> files will cause building error after cleaning up usage of
> asm/global_data.h.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  board/toradex/common/tdx-cfg-block.h | 2 ++
>  board/toradex/common/tdx-common.h    | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
> index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
> --- a/board/toradex/common/tdx-cfg-block.h
> +++ b/board/toradex/common/tdx-cfg-block.h
> @@ -6,6 +6,8 @@
>  #ifndef _TDX_CFG_BLOCK_H
>  #define _TDX_CFG_BLOCK_H
>  
> +#include <linux/types.h>
> +
>  #include "tdx-common.h"
>  
>  struct toradex_hw {
> diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
> index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
> --- a/board/toradex/common/tdx-common.h
> +++ b/board/toradex/common/tdx-common.h
> @@ -6,6 +6,8 @@
>  #ifndef _TDX_COMMON_H
>  #define _TDX_COMMON_H
>  
> +#include <asm-generic/u-boot.h>
> +

maybe just have the forward declaration?

  struct bd_info;

and that's it?


