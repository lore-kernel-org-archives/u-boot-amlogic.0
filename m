Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8653FFEEF4D
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 14:02:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53784.1775478363030069488
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2026 05:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=UZcVqbZl;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: sumit.garg@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 746C544136;
	Mon,  6 Apr 2026 12:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074EBC4CEF7;
	Mon,  6 Apr 2026 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775477927;
	bh=4fzMSwoM0psHeMrlVWfL2XZhNC091UNSM0mAXfoA0O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZcVqbZlCrihf+d1BCWzH+VbTRSvsPIzjl0SBeMMva7NEe3zJHy1Qi3kw3nGHGmMI
	 z66F8fdVfv5jwqhO5iF5SptjteMtWBWmUgCVt1aXXZSYItYH2BWhNFcgYhdZpEcYWi
	 dJRok01gavINi8tGxMna0eEz/3kxCuHr/sma+zZbIYA9Ra+ZuynMrR+sNFmP2HIwTF
	 2Tzv/Puxn5zTs1W95lD5ddOeDrJc9iYAt+fwYT+Oe4xBi78doSPlv+KTT4HXybI6B9
	 PVnm2ei1C38oF/IDHntzVxYTVm2snHvnv5JtU8SqbDdM3tzA0Hc4NcBErmgSsLpEJ2
	 g0BxHfaMRhiBw==
Date: Mon, 6 Apr 2026 17:48:15 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
	u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	Paul Barker <paul@pbarker.dev>,
	Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
	uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	Tom Rini <trini@konsulko.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Glass <sjg@chromium.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Raymond Mao <raymondmaoca@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
	Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Michal Simek <michal.simek@amd.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Peter Korsgaard <peter@korsgaard.com>,
	Greg Malysa <malysagreg@gmail.com>,
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
	Arturs Artamonovs <arturs.artamonovs@analog.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Sean Anderson <seanga2@gmail.com>,
	Liviu Dudau <liviu.dudau@foss.arm.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Weijie Gao <weijie.gao@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>,
	Stefan Roese <stefan.roese@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Thierry Reding <treding@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Philip Molloy <philip.molloy@analog.com>,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Ryan Wanner <Ryan.Wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jens Reidel <adrian@mainlining.org>,
	David Wronek <david.wronek@mainlining.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>,
	Alice Guo <alice.guo@nxp.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
	Naman Trivedi <naman.trivedimanojbhai@amd.com>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Padmarao Begari <padmarao.begari@amd.com>,
	Jonathan Currier <dullfire@yahoo.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sam Day <me@samcday.com>, Rui Miguel Silva <rui.silva@linaro.org>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Shmuel Leib Melamud <smelamud@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Joseph Chen <chenjh@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>,
	"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
	Dinesh Maniyam <dinesh.maniyam@altera.com>,
	Paul Sajna <sajattack@postmarketos.org>,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to U-Boot
Message-ID: <adOkh0qBBLfVWB87@sumit-xelite>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 07 Apr 2026 14:02:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2950

On Thu, Mar 19, 2026 at 09:56:22PM +0100, Casey Connolly wrote:
> This RFC provides a proof of concept for using the full Linux CCF in
> U-Boot and consequently porting full Linux clock drivers with extremely
> minimal changes.
> 
> == Overview ==
> 
> This RFC is pretty long but can be separated into a few chunks. The
> first patches relate to Linux API compatibility and just contain small
> self contained changes, these can go upstream regardless of CCF.
> 
> The next group of changes prepare for importing CCF from Linux, the
> standalone fixed clock drivers are moved to clk/basic, the existing
> U-Boot CCF drivers are moved to clk/uccf, and struct clk_ops is renamed
> to clk_ops_uboot.
> 
> Additionally, clk_set_rate() is changed so that it returns a signed
> long, since it can return negative values. This is also done to align
> with CCF but it's a standalone improvement nonetheless.
> 
> The next changes import CCF from Linux 6.19 and then adjust it to
> compile and work with U-Boot. These commits are split up mostly to
> try and reduce the size. Finally clk-uclass is adjusted for CCF, this
> definitely will need some additional passes to be a bit cleaner.
> 
> With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
> tests are adjusted to pass.
> 
> Lastly, a PoC port of Qualcomms Linux clock drivers is done, this
> only has sm8650 clocks but they serve the desired purpose. The changes
> necessary to the Linux drivers are mostly to deal with U-Boots driver
> model, the actual platform specific clock drivers require essentially
> zero changes!
> 
> === Feedback ===
> 
> I'd like to get feedback on the overall architecture and ideas, feel
> free to point out any dead code or printf's I forgot about, but I'll for
> sure do a more detailed cleanup before the next revision.
> 
> I would definitely like to input on how to deal with clk-uclass, since
> it's now supporting 3 different clock frameworks, but I'm now sure how
> best to separate the code out without duplicating code.
> 
> In terms of overall architecture, CCF is a departure from the uclass
> model that U-Boot has stuck too for so long. If this is a success then
> I think it could make a lot of sense to make similar changes for power
> domains and resets. I think this change offers a lot of additional
> flexibility which has been sorely missed.
> 
> == Motivation ==
> 
> There were quite a few motivating factors behind this effort which I
> think provide useful context for this series:
> 
> 1. Existing UCLASS_CLK support in U-Boot (even with U-Boots minimal CCF)
>    doesn't provide a fully cohesive API nor implement the necessary
>    functionality to support complex modern platforms without a lot of
>    additional effort.
> 
> 2. While trying to enable display support on Qualcomm, it became clear
>    that U-Boots clock framework was a severe limiting factor,
>    particularly for more complicated setups like "bonded" dual-DSI.
> 
> 3. The current state of Qualcomm clock drivers in U-Boot is pretty poor,
>    as the old very basic driver code is being expected to support more
>    and more complicated usecases. Clock support is generally the most
>    complicated part of bringing up any new Qualcomm platform, so being
>    able to properly reuse Linux drivers with the familiar API greatly
>    reduces the amount of friction when working on U-Boot support for
>    complicated peripherals like the display.
> 
> Consequently, My aim with this effort was primarily to provide API
> compatibility with Linux as much as possible, minimising the changes
> that have to be made to clock drivers to port them from Linux, and
> reducing the chance of introducing U-Boot specific bugs.
> 
> === clk_ops/UCLASS_CLK ===
> 
> CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
> independent clock API. If the clocks are provided by another device like
> a phy, they can simply be registered with the clk core the same way they
> are in Linux. Standalone clock drivers should use UCLASS_NOP.
> 
> Clocks must all be registered during driver probe, the CCF will ensure
> that a given clock provider is probed (via a global ofnode -> device
> lookup) before checking the of_providers, thus making sure the clocks
> are registered so that the consumer can use them. There is currently no
> special handling for cyclical dependencies.
> 
> === struct clk ===
> 
> It's definitely debatable if it makes sense to have 3 different structs
> for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
> are justified, since clk_hw is more tied to the hardware description and
> typically nested in a clk-specific descriptor while clk_core contains
> the internal runtime state of the clk which should remain private to
> CCF core.
> 
> It could make sense to merge clk and clk_core, but since struct clk is
> public in U-Boot, where it's an opaque pointer in Linux this would be
> a substantial effort. In Linux struct clk objects are allocated inside
> CCF, but in U-Boot they're allocated by the driver, this would need to
> be resolved before we investigate combining these structs.
> 
> === Memory/perf overhead ===
> 
> The memory and size overhead of CCF is undoubtably bigger than uCCF,
> although I suspect the difference is less than it might seem at
> first glance. In particular: clk_core is only ~50 bytes larger than
> struct udevice on ARM64, and an additional 120 bytes is saved for each
> U_BOOT_DRIVER used by uCCF.
> 
> On the other hand, the CPU overhead is probably more significant,
> but not an unreasonable cost to ensure correctness and propagate rate
> changes across the clock tree.
> 
> Just comparing the binary size of sandbox64_defconfig with uCCF vs
> CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
> haven't done any more detailed analysis here (still haven't got buildman
> to play nice...).
> 
> === SPL ===
> 
> This RFC doesn't have any SPL specific support, I think this role is
> better fulfilled by UCLASS_CLK.
>

SPL support on Qualcomm platforms is coming for real. I see a patch-set
already posted and more to come. So we really need to see how Linux CCF
can be reused to support SPL limitations on Qcom SoCs while executing
from on-chip RAM.

If it turns out to be separate clock drivers, Linux CCF for U-Boot
proper and UCLASS_CLK for U-Boot SPL for the same SoC then it's much
more maintainence overhead as compared to just pulling in clk driver
from Linux.

It would be better if somehow Linux CCF can be stripped down to meet SPL
needs too.

-Sumit

