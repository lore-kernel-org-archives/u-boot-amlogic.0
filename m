Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942EFC72CA
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 07:41:04 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17990.1774025924070854016
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Mar 2026 09:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=VqE2P/Ro;
 spf=pass (domain: chromium.org, ip: 209.85.167.44, mailfrom: sjg@chromium.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso1395446e87.0
        for <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774025922; cv=none;
        d=google.com; s=arc-20240605;
        b=GmLjSfbxEc8zUVHEhaeMC2DVsT82apxhuSLqfRJYr9jpwK76tQxdGhNhvTRhzYfnHv
         T5xnWPVpPCY0l4z6/cWxbTqy9u6JZT3mitOR5Z6+G8q+WX1ar0A0+VKdmjx5nsSoMCCz
         75FuPux903/6YnpXBRxK7KnS69F8jq1VKII4UilZD8+wiqj9bfSXWSrtpzPFGmkhK7Lm
         EYVBinKhlBk+LnTR9Xi5WdGSdbqVNFF5cu2SKRON6tshVSMWzn+2zj833tpelC0YUcnR
         a3niBnlfY6ol+3QBjPKpXi9j66UEEeKcxSnNfoTRrK8u7cAQBMNGEqn2HlT0bvDWQYfr
         dqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
        fh=i1thyyPuWW5g2304DXQ5TKivMzmvaqVORj5N51w0Plo=;
        b=hzTYn3eIIRHzrhfuYbQEykZbGwl+vZmUx3kDtRo1TaY4l1Mu4gUC+NQY3t6c2cUZH3
         4j7UhW02KYkgAgKpDL1wBt0/TxZV3y0p8+YB1QqUt62dPJOx3qUTN1Cqb3zqWZVmsThl
         fAVxVAWcNQnNH+W/nJfq+ERgSyaLv6ItLinDZ0KHtXYKULN4S0e8srB/diyC2OVkK7CX
         +RqW6ghjLeQ/xKQuf769mZHGYfIbh/aswWNDM6wuLJ8eQsH+ZaQmz5yN9qD8ZggtQ9f/
         RX+7Tnv/GxkWQjeKr6G/bUIYLbvGHaJ6sZ2H83mMTLhB/AMcU1o/Sn4rNmuvKCtExGWL
         tYLg==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774025922; x=1774630722; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
        b=VqE2P/Row8qJ1phsy3CnVThiK79S2IVTTpgSvn5BEEbrxJU0s12/XexP/W5FBjqSL1
         bj9mv720SsimX0ckeqUDgQpUJ6oL36RF3MpshK6YNkPF8O1Pjt6HL/PyxYOsurMaNeeJ
         BMK54U0/FpcRt0/emsAwUkffT44mT+bPTH70s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025922; x=1774630722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogAQHzvDO6Z2mtpWF4WWMAnj55zQVH/abZq6g+QI030=;
        b=pfWJ7BNiRdVbx2PLuc0YX++1EqrGZbZCPuRAiAwGIJups4adWsrB8OjHZovdgYLS31
         I0qQRtCf1FpYBxKYIArMbOpHXZk/RdSFs2KxRSXflU7kjtNsY1VddieYNl/i8IF18rYZ
         izocjGwQq5Jx3U5zc6qaedcNXmZS+h/ZZSj4eC/iBjpFGKIGRLiGterpCmp23rpV9SEC
         U5y/KN+HNniAgSYt2BOeXft+wtzQzZRFfu03NoJx4NzSq+4l7wifjPxAp516Ixn/IrYg
         kTAawxa2lgmBvSWou18gW9qbxprFKpJBhoLhoycV2H1dsrWORrOGc5j6T+px9PkVZlRa
         Nl6w==
X-Forwarded-Encrypted: i=1; AJvYcCX1DZf5Lhq+X/3otplKi5LVqx2s9uUetWPmmJajCVxHivxY4ii/0cLC4O55nDPuOHzfuaoKeAitzVsIQOLjHg==@groups.io
X-Gm-Message-State: AOJu0Yy25YdzbcHIecDwX/ry+CYPfoyREp26B2QuClWPKRzcgmdlSn6k
	HJmtxWK2gcfgwIkQvEvne8N8BpkSUPGMa7nXq+KcJS+yg3BcZHYa9B+ac8jpjhPiLkiaJYBkuTe
	oTqxmHLYJeKiaAqCOmaAOgHRgrcPDEto3lz+QjCKWpdAYVeRxMRaa3j4i
X-Gm-Gg: ATEYQzw4RhXSCAlBX2Wymob00XmXtaizdKoojF0YrZXkT+74TjLL0G25Bq8kOaTNdct
	QiW9R0OucSRuHSzSm6cxbPXWFmOhVy/VruFRDeVrPVMam7A0P5k1vLBzJxVCRFnnQb5938OY9Up
	rWvV+MboCqWQwl9V5lnOxyVhzH1YcBuvJUoxGR42FoqyvX3oJif0Dem3Hy3rlkz/vXJRKcYg8xB
	DhUe3hdO/QQuY2VDlND8HW7sT0AXGaG9CjHmZ4e91NNUIe4sK2Rfxduf3Zp7+OUMdRhpLdqso8A
	esVEdPL3
X-Received: by 2002:a17:906:f0d8:b0:b98:4b8:1046 with SMTP id
 a640c23a62f3a-b982f2edce8mr188687866b.31.1774025544622; Fri, 20 Mar 2026
 09:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Mar 2026 10:52:12 -0600
X-Gm-Features: AaiRm52WedrmCbbdHbA3EK3NH8g7GEWpMQQboV0WG4VAi5OVQf0TPWMTfopz5AU
Message-ID: <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to U-Boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, u-boot-qcom@groups.io, 
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Paul Barker <paul@pbarker.dev>, 
	Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, uboot-snps-arc@synopsys.com, 
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
	Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Stephen Boyd <swboyd@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Raymond Mao <raymondmaoca@gmail.com>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
	Leo Yu-Chi Liang <ycliang@andestech.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
	Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
	Arturs Artamonovs <arturs.artamonovs@analog.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Sean Anderson <seanga2@gmail.com>, 
	Liviu Dudau <liviu.dudau@foss.arm.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
	Stefan Roese <stefan.roese@mailbox.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Philip Molloy <philip.molloy@analog.com>, 
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Ryan Wanner <Ryan.Wanner@microchip.com>, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, 
	Manikandan Muralidharan <manikandan.m@microchip.com>, 
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	Jens Reidel <adrian@mainlining.org>, David Wronek <david.wronek@mainlining.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, 
	Nishanth Menon <nm@ti.com>, Alice Guo <alice.guo@nxp.com>, 
	Valentin Caron <valentin.caron@foss.st.com>, 
	Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
	Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Padmarao Begari <padmarao.begari@amd.com>, 
	Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Sam Day <me@samcday.com>, Rui Miguel Silva <rui.silva@linaro.org>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, Shmuel Leib Melamud <smelamud@redhat.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Heiko Schocher <hs@nabladev.com>, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
	Dinesh Maniyam <dinesh.maniyam@altera.com>, Paul Sajna <sajattack@postmarketos.org>, 
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Mar 2026 07:41:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2935

Hi Casey,

On Thu, 19 Mar 2026 at 14:56, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> This RFC provides a proof of concept for using the full Linux CCF in
> U-Boot and consequently porting full Linux clock drivers with extremely
> minimal changes.

As a general question, what is the boot flow for the Qualcomm devices
you are are targeting, i.e. where does U-Boot come in the chain from
reset? Does it use xPL?

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

Agreed.

>
> The next changes import CCF from Linux 6.19 and then adjust it to
> compile and work with U-Boot. These commits are split up mostly to
> try and reduce the size. Finally clk-uclass is adjusted for CCF, this
> definitely will need some additional passes to be a bit cleaner.
>
> With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
> tests are adjusted to pass.

Minor point - perhaps CLK_LINUX ? CCF_FULL seems cryptic to me and
some would argue that the existing CLK_CCF is already full..

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

Perhaps a justification can be expressed in terms of code size / capabilities:

Small - can boot in xPL from limited SRAM, only simple clocks
Medium - smaller code size but still provides good access to clocks
Large - Linux compatible, full capability but lots of code

>
> In terms of overall architecture, CCF is a departure from the uclass
> model that U-Boot has stuck too for so long. If this is a success then
> I think it could make a lot of sense to make similar changes for power
> domains and resets. I think this change offers a lot of additional
> flexibility which has been sorely missed.

While those are separate, does this mean that there will be a
significant delta from Linux's clock drivers on Qualcomm, or will it
be minor?
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

It seems that 1 and 2 could be merged? The question here is how much
effort would someone want to put in. Providing an easy way to pull in
the Linux clock driver makes sense. Some people may wish to put in
effort to at least support the basic clocks for xPL, etc.

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

Bypassing UCLASS_CLK entirely is a big departure. It means DM can't
track these clock devices properly - no uclass_find_device(), no
sequence numbers, no standard device iteration.

The suggestion to do the same for power domains and resets would
fragment driver model further.

How about having a single UCLASS_CLK_LINUX device?

>
> Clocks must all be registered during driver probe, the CCF will ensure
> that a given clock provider is probed (via a global ofnode -> device
> lookup) before checking the of_providers, thus making sure the clocks
> are registered so that the consumer can use them. There is currently no
> special handling for cyclical dependencies.

Driver model normally registers devices during a bind step, which
helps to remove the problem of cyclic dependencies. Is there any need
to wait until probe()? Also, can we statically declare it, to save
code size? Most of the definitions are static

The global ofnode -> device lookup to force probe ordering is
reinventing what DM already does with uclass probing. This feels like
it should integrate with DM rather than work around it.

>
> === struct clk ===
>
> It's definitely debatable if it makes sense to have 3 different structs
> for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
> are justified, since clk_hw is more tied to the hardware description and
> typically nested in a clk-specific descriptor while clk_core contains
> the internal runtime state of the clk which should remain private to
> CCF core.

Probably we should follow Linux, since we would start to lose the
benefit of your series if we merged two structs.

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

We already struggle with slow pre-relocation performance, something I
have never really dug into.

>
> Just comparing the binary size of sandbox64_defconfig with uCCF vs
> CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
> haven't done any more detailed analysis here (still haven't got buildman
> to play nice...).

Sandbox may overestimate the size here, not sure. Ping on irc if you
need update with the buildman setup.

>
> === SPL ===
>
> This RFC doesn't have any SPL specific support, I think this role is
> better fulfilled by UCLASS_CLK.
>
> === U-Boot's old CCF port ===
>
> The original CCF port done for IMX platforms is vastly different in API,
> scope, and function to CCF_FULL, to differentiate I refer to it
> as "uCCF".
>
> I have kept support for this in and made it mutually exclusive with
> CCF_FULL. uCCF drivers have been moved to drivers/clk/uccf, with the new
> CCF port in drivers/clk/ccf.
>
> Included near the end of this series is a port of Sandbox's clk-ccf
> driver from uCCF over to CCF_FULL, this might be a useful reference for
> other drivers (although it's probably better to just adapt the Linux
> drivers).
>
> === Compat shim ===
>
> Lastly, this series includes a compat shim which allows UCLASS_CLK
> drivers to somewhat work with CCF, I would imagine this being useful
> if some generic peripheral device provides a clock for example, but in
> almost all cases I think it's better to implement a proper CCF clock
> device. Unless there is a particular usecase for this I would probably
> not include it in the next revision.
>
> == TODO/Outstanding issues ==
>
> * Clean up clk-uclass.c, does it make sense to somewhow split it in two?
> * Assess test coverage, have basic sandbox tests, would like to mostly
>   use integration tests (i.e. diff the clk summary) once more platforms
>   are supported.
> * pre-relocation support is currently missing, on Qualcomm at least I
>   would prefer to completely skip FDT scanning pre-reloc, there is a
>   patch in this series which does that. It is very non-trivial to try
>   and handle clocks pre-reloc.

Does this mean that only serial is needed and the clock for it is
already set up by some pre-U-Boot phase?

Regards,
SImon

