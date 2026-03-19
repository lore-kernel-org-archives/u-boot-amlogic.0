Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6ED1088E6F
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:26 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6411.1773954223011002194
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:03:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IN4N2Fay;
 spf=pass (domain: linaro.org, ip: 209.85.167.48, mailfrom: casey.connolly@linaro.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so1483876e87.2
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773954221; x=1774559021; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P535AG/2k8ItRv7CW2LNXmHzd331bBJoGHddWlJiKB0=;
        b=IN4N2Fayo2QAA6zJm0riULlVgvlCCYkgbil62j1VETMDBD7dHEKWGpm7Q6cPJ0AAAV
         CARsGCjaklyFJ/IC+cA26qtcF2oS5bstQWrAzL6DoGEHRXWhwxjrSrdYG+9kZlANqorD
         /GxbIriAXV1zyzUG0GBS8UL3yp0ZsjGiMIuaccRXD//y3AK8KyhY3I4Odn1WorG6ZE3v
         iTIXL7xDPyCWUaE43sQAJ8bRbEZR876tFCgO7qKG8nxVvavXfzruIQ5bwO/XDbs/ScT4
         mHz+AaySldcB9UPL29TcJDHMPGXa6X15X7Zp0NfhiN9W6v1KdFjbkv/isY6IEa7PoCsJ
         BD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954221; x=1774559021;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P535AG/2k8ItRv7CW2LNXmHzd331bBJoGHddWlJiKB0=;
        b=I84XD40+Ne3hYFnQtJUS3XSyrqgLTvccB3/1ZiaEbypeBjJPmfzf8YHsNaR4AZgy0a
         e0/HPIv0XvaVZ69bPF7/NEvJz6F3wo85rTFgCny4vbDhXehVFu43rGXFlhgSi6iHtj0k
         ChndyQVGiXMsVm+3He2bRb8zwpDlXBwH16qJpHx3US5VVbuDlKcjbQb2LW3bkdHcLZr5
         D5+ioVKmZjwShD512Mn0Z+jclXqXNSsxC5jXLam3fNHPOmaD8rdjZ427REdT9cDeCTS5
         22OtD8+WoyCpFYlhxV5adaurfM0jmEYCBFQtpu4d1/SNPMTmNmIq59pJfJxRxfZIqKyN
         uI0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/KWvlNbz56Ava3dLWxhTwg1sxEXBYgXAWCRrMlOw3xVUSP9O7jkmIMHmuUUKB5cNo592Kezjg91/sNY46Bw==@groups.io
X-Gm-Message-State: AOJu0Yy9m4y3Ueq6ZZdTlJqq+6Z9OO+KAAwq4pp9wqDpPMqKFQVwWg4T
	2h+lXzpZT8id7+9JGJYKFnlSHyV8wuAVqoSMmiCcJVtpQ6dNQPSADEB9OH3JUjnZKQCTjnFC63D
	A3qzz7B0=
X-Gm-Gg: ATEYQzwjbCR29zV9Sv4YBPy7iAHuvFOPba167NChpWzTHtrF8bcndOd09V1UNyVG87r
	NUqiIspYQx+DcqA76F+i3zgtE8XZo+xBxBB+Mshv9s55BOinlKQ9D+ezy0uBJUoPd+kDw/COybI
	f1nH4AgXlEzkj71ltt4LiejbYlol6Y8ctwJdMLu4vyp0HZFK3ZfuObSehd65E9qJnMMLuPBjXdA
	+ctFwx8AXHUkbmAFfL8exDtrE8IJLUGBxfhrMOXf43DM6nJ/6UpWl/ssbDTgvVVKp8aWjwZAjmO
	vQkJN2Z9Apf8Qm0mJNNWhJ0VvCZdF9FB8kokkKptmRwScKy04R9a5LctxUi2GPLPRqUi1LBsFuS
	bFZ3BpSvFw0jOIVAkIfHflj0sjZpy/pAM/ix86/8owWtDGBBnljXvmvFvnsA1DX6Pa68g0pLB2r
	/+/72yq5QD5ejdoUyWxmaQ/S6NXblpk1u6Ensv1xsFvr4iA4V6Ptsd3EcIGHDbM/U0FME=
X-Received: by 2002:a05:6000:1886:b0:43b:3cdc:941f with SMTP id ffacd0b85a97d-43b6424a832mr1292002f8f.17.1773953813877;
        Thu, 19 Mar 2026 13:56:53 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:56:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to U-Boot
Date: Thu, 19 Mar 2026 21:56:22 +0100
Message-Id: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPdivGkC/yWMwQrCQAwFf6XkbCC7gqhXwQ/wWjxs01eNYC2bV
 pTSf3fV4wzMzOTIBqd9NVPG09wefYGwqkivqb+ArS1MUeJG1mHHmhxvVu14GnzMSHdGktBKIxp
 lSyUcMjp7/aY1nY4HOv+lT80NOn53tCwfGs8/EXsAAAA=
X-Change-ID: 20260319-casey-ccf-upstream-ea01d0b0c208
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
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
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
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
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=26382;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=tjnK4RoAZ/HTyna9IlTHnXHrkoe2WzZCvGkqj2ScAbw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybzPT9jdWX94uunfkx7PlN9X5s3VaNXbvKFAsKame
 6/R1rrlHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiTkcZ/gpc0E3ecaonLe+q
 1IzpiyOibl4LCznOxKj19aJ22fO/d0KAKrq8fybrLpu4prhF+PHB9b5MxUVbWPO/PU37+nP75Mk
 e/wE=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2931

This RFC provides a proof of concept for using the full Linux CCF in
U-Boot and consequently porting full Linux clock drivers with extremely
minimal changes.

== Overview ==

This RFC is pretty long but can be separated into a few chunks. The
first patches relate to Linux API compatibility and just contain small
self contained changes, these can go upstream regardless of CCF.

The next group of changes prepare for importing CCF from Linux, the
standalone fixed clock drivers are moved to clk/basic, the existing
U-Boot CCF drivers are moved to clk/uccf, and struct clk_ops is renamed
to clk_ops_uboot.

Additionally, clk_set_rate() is changed so that it returns a signed
long, since it can return negative values. This is also done to align
with CCF but it's a standalone improvement nonetheless.

The next changes import CCF from Linux 6.19 and then adjust it to
compile and work with U-Boot. These commits are split up mostly to
try and reduce the size. Finally clk-uclass is adjusted for CCF, this
definitely will need some additional passes to be a bit cleaner.

With CCF done, sandbox clk-ccf driver gets a CCF_FULL port, the clk_ccf
tests are adjusted to pass.

Lastly, a PoC port of Qualcomms Linux clock drivers is done, this
only has sm8650 clocks but they serve the desired purpose. The changes
necessary to the Linux drivers are mostly to deal with U-Boots driver
model, the actual platform specific clock drivers require essentially
zero changes!

=== Feedback ===

I'd like to get feedback on the overall architecture and ideas, feel
free to point out any dead code or printf's I forgot about, but I'll for
sure do a more detailed cleanup before the next revision.

I would definitely like to input on how to deal with clk-uclass, since
it's now supporting 3 different clock frameworks, but I'm now sure how
best to separate the code out without duplicating code.

In terms of overall architecture, CCF is a departure from the uclass
model that U-Boot has stuck too for so long. If this is a success then
I think it could make a lot of sense to make similar changes for power
domains and resets. I think this change offers a lot of additional
flexibility which has been sorely missed.

== Motivation ==

There were quite a few motivating factors behind this effort which I
think provide useful context for this series:

1. Existing UCLASS_CLK support in U-Boot (even with U-Boots minimal CCF)
   doesn't provide a fully cohesive API nor implement the necessary
   functionality to support complex modern platforms without a lot of
   additional effort.

2. While trying to enable display support on Qualcomm, it became clear
   that U-Boots clock framework was a severe limiting factor,
   particularly for more complicated setups like "bonded" dual-DSI.

3. The current state of Qualcomm clock drivers in U-Boot is pretty poor,
   as the old very basic driver code is being expected to support more
   and more complicated usecases. Clock support is generally the most
   complicated part of bringing up any new Qualcomm platform, so being
   able to properly reuse Linux drivers with the familiar API greatly
   reduces the amount of friction when working on U-Boot support for
   complicated peripherals like the display.

Consequently, My aim with this effort was primarily to provide API
compatibility with Linux as much as possible, minimising the changes
that have to be made to clock drivers to port them from Linux, and
reducing the chance of introducing U-Boot specific bugs.

=== clk_ops/UCLASS_CLK ===

CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
independent clock API. If the clocks are provided by another device like
a phy, they can simply be registered with the clk core the same way they
are in Linux. Standalone clock drivers should use UCLASS_NOP.

Clocks must all be registered during driver probe, the CCF will ensure
that a given clock provider is probed (via a global ofnode -> device
lookup) before checking the of_providers, thus making sure the clocks
are registered so that the consumer can use them. There is currently no
special handling for cyclical dependencies.

=== struct clk ===

It's definitely debatable if it makes sense to have 3 different structs
for each clk (clk_hw, clk_core and clk). I do think clk_hw and clk_core
are justified, since clk_hw is more tied to the hardware description and
typically nested in a clk-specific descriptor while clk_core contains
the internal runtime state of the clk which should remain private to
CCF core.

It could make sense to merge clk and clk_core, but since struct clk is
public in U-Boot, where it's an opaque pointer in Linux this would be
a substantial effort. In Linux struct clk objects are allocated inside
CCF, but in U-Boot they're allocated by the driver, this would need to
be resolved before we investigate combining these structs.

=== Memory/perf overhead ===

The memory and size overhead of CCF is undoubtably bigger than uCCF,
although I suspect the difference is less than it might seem at
first glance. In particular: clk_core is only ~50 bytes larger than
struct udevice on ARM64, and an additional 120 bytes is saved for each
U_BOOT_DRIVER used by uCCF.

On the other hand, the CPU overhead is probably more significant,
but not an unreasonable cost to ensure correctness and propagate rate
changes across the clock tree.

Just comparing the binary size of sandbox64_defconfig with uCCF vs
CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
haven't done any more detailed analysis here (still haven't got buildman
to play nice...).

=== SPL ===

This RFC doesn't have any SPL specific support, I think this role is
better fulfilled by UCLASS_CLK.

=== U-Boot's old CCF port ===

The original CCF port done for IMX platforms is vastly different in API,
scope, and function to CCF_FULL, to differentiate I refer to it
as "uCCF".

I have kept support for this in and made it mutually exclusive with
CCF_FULL. uCCF drivers have been moved to drivers/clk/uccf, with the new
CCF port in drivers/clk/ccf.

Included near the end of this series is a port of Sandbox's clk-ccf
driver from uCCF over to CCF_FULL, this might be a useful reference for
other drivers (although it's probably better to just adapt the Linux
drivers).

=== Compat shim ===

Lastly, this series includes a compat shim which allows UCLASS_CLK
drivers to somewhat work with CCF, I would imagine this being useful
if some generic peripheral device provides a clock for example, but in
almost all cases I think it's better to implement a proper CCF clock
device. Unless there is a particular usecase for this I would probably
not include it in the next revision.

== TODO/Outstanding issues ==

* Clean up clk-uclass.c, does it make sense to somewhow split it in two?
* Assess test coverage, have basic sandbox tests, would like to mostly
  use integration tests (i.e. diff the clk summary) once more platforms
  are supported.
* pre-relocation support is currently missing, on Qualcomm at least I
  would prefer to completely skip FDT scanning pre-reloc, there is a
  patch in this series which does that. It is very non-trivial to try
  and handle clocks pre-reloc.

---
Casey Connolly (40):
      vsprintf: add %pOF
      common: add an option to skip DM pre-relocation
      serial: msm-geni: allow invalid clock
      qcom: rpmh: don't error for SLEEP requests
      string: add strdup_const and kstrdup_const
      ofnode: add read_u64_array and count_elems_of_size
      linux/compat: add PTR_ERR_OR_ZERO
      compat: add kref implementation
      compat: add dev_name()
      compat: add linux/regmap.h symlink
      devres: add devm_krealloc
      regmap: add regmap_assign_bits
      compat: regulator: add enable/disable macros
      compat: math64: add abs_diff()
      clk: restrict clk/imx to MACH_IMX
      clk: move U-Boot CCF to clk/uccf
      clk: rename clk_ops to clk_ops_uboot
      clk: move fixed clocks to clk/basic
      clk: make clk_set_rate() return signed long
      clk: make clk_get_parent_rate return signed long
      clk: import full CCF from Linux
      clk: move clock flags to common clk-provider.h
      clk/ccf: adapt clk-conf for U-Boot
      clk/ccf: adapt CCF core for U-Boot
      clk/ccf: adapt CCF generic clocks for U-Boot
      clk/clk-uclass: adapt for CCF_FULL
      RFC: clk/ccf: add UCLASS_CLK compat shim
      clk/sandbox: add a CCF_FULL port of clk_sandbox
      WIP: test: adjust tests for CCF_FULL
      configs: add sandbox CCF_FULL defconfig
      cmd/clk: add CCF_FULL support
      clk/qcom: move existing clock drivers to clk/qcom/basic
      clk/qcom: drop in Linux Qualcomm CCF drivers
      clk/qcom/ccf: drop in Linux rpmh clock driver
      clk/qcom/ccf: add sm8650 GCC, dispcc and tcsrcc.
      clk/qcom/ccf: add uboot common code
      clk/qcom/ccf: adapt common, gdsc, and reset code for U-Boot
      clk/qcom/ccf: adapt clocks for U-Boot
      clk/qcom/ccf: adjust sm8650 clock drivers for U-Boot
      TEST: configs: qcom_sm8650_ccf_defconfig: add a CCF sm8650 defconfig

 Kconfig                                            |   12 +
 arch/arm/cpu/armv7/bcm281xx/clk-core.c             |    8 +-
 arch/arm/cpu/armv7/bcm281xx/clk-core.h             |   14 +-
 arch/arm/dts/sm8650-hdk-u-boot.dtsi                |   26 +
 arch/sandbox/dts/test.dts                          |    4 +-
 arch/sandbox/include/asm/clk.h                     |    2 +-
 cmd/clk.c                                          |   21 +-
 common/board_f.c                                   |   11 +-
 configs/qcom_sm8650_ccf_defconfig                  |   24 +
 configs/sandbox64_ccf_full_defconfig               |    5 +
 drivers/clk/Kconfig                                |   52 +-
 drivers/clk/Makefile                               |   20 +-
 drivers/clk/adi/clk-adi-pll.c                      |    2 +-
 drivers/clk/adi/clk-shared.c                       |    4 +-
 drivers/clk/adi/clk.h                              |    2 +-
 drivers/clk/airoha/clk-airoha.c                    |    4 +-
 drivers/clk/altera/clk-agilex.c                    |    2 +-
 drivers/clk/altera/clk-agilex5.c                   |    2 +-
 drivers/clk/altera/clk-arria10.c                   |    2 +-
 drivers/clk/altera/clk-mem-n5x.c                   |    2 +-
 drivers/clk/altera/clk-n5x.c                       |    2 +-
 drivers/clk/aspeed/clk_ast2500.c                   |    4 +-
 drivers/clk/aspeed/clk_ast2600.c                   |    4 +-
 drivers/clk/at91/clk-generic.c                     |    4 +-
 drivers/clk/at91/clk-main.c                        |    8 +-
 drivers/clk/at91/clk-master.c                      |    8 +-
 drivers/clk/at91/clk-peripheral.c                  |    6 +-
 drivers/clk/at91/clk-programmable.c                |    4 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |   10 +-
 drivers/clk/at91/clk-sam9x60-usb.c                 |    4 +-
 drivers/clk/at91/clk-system.c                      |    2 +-
 drivers/clk/at91/clk-utmi.c                        |    4 +-
 drivers/clk/at91/compat.c                          |   30 +-
 drivers/clk/at91/pmc.c                             |    2 +-
 drivers/clk/at91/pmc.h                             |    2 +-
 drivers/clk/at91/sckc.c                            |    4 +-
 drivers/clk/basic/Makefile                         |    7 +
 drivers/clk/{ => basic}/clk_fixed_factor.c         |    2 +-
 drivers/clk/{ => basic}/clk_fixed_rate.c           |    4 +-
 drivers/clk/ccf/Kconfig                            |   15 +
 drivers/clk/ccf/Makefile                           |   19 +
 drivers/clk/ccf/clk-composite.c                    |  495 +++
 drivers/clk/ccf/clk-conf.c                         |  189 +
 drivers/clk/ccf/clk-divider.c                      |  663 ++++
 drivers/clk/ccf/clk-fixed-factor.c                 |  409 +++
 drivers/clk/ccf/clk-fixed-rate.c                   |  217 ++
 drivers/clk/ccf/clk-gate.c                         |  260 ++
 drivers/clk/ccf/clk-mux.c                          |  282 ++
 drivers/clk/ccf/clk.c                              | 3208 ++++++++++++++++
 drivers/clk/ccf/clk.h                              |   59 +
 drivers/clk/ccf/clk_sandbox_ccf_full.c             |  220 ++
 drivers/clk/ccf/compat.c                           |  227 ++
 drivers/clk/clk-cdce9xx.c                          |    4 +-
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-hsdk-cgu.c                         |    4 +-
 drivers/clk/clk-stub.c                             |    4 +-
 drivers/clk/clk-uclass.c                           |  326 +-
 drivers/clk/clk-xlnx-clock-wizard.c                |    4 +-
 drivers/clk/clk_bcm6345.c                          |    2 +-
 drivers/clk/clk_boston.c                           |    2 +-
 drivers/clk/clk_k210.c                             |    8 +-
 drivers/clk/clk_octeon.c                           |    2 +-
 drivers/clk/clk_pic32.c                            |    4 +-
 drivers/clk/clk_sandbox.c                          |   47 +-
 drivers/clk/clk_sandbox_test.c                     |    2 +-
 drivers/clk/clk_scmi.c                             |    6 +-
 drivers/clk/clk_versaclock.c                       |   22 +-
 drivers/clk/clk_versal.c                           |    4 +-
 drivers/clk/clk_vexpress_osc.c                     |    4 +-
 drivers/clk/clk_zynq.c                             |    8 +-
 drivers/clk/clk_zynqmp.c                           |    6 +-
 drivers/clk/exynos/clk-exynos7420.c                |    6 +-
 drivers/clk/exynos/clk-pll.c                       |    4 +-
 drivers/clk/exynos/clk.h                           |    2 +-
 drivers/clk/ics8n3qv01.c                           |    4 +-
 drivers/clk/imx/clk-composite-8m.c                 |    6 +-
 drivers/clk/imx/clk-composite-93.c                 |    2 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |    4 +-
 drivers/clk/imx/clk-gate-93.c                      |    4 +-
 drivers/clk/imx/clk-gate2.c                        |    4 +-
 drivers/clk/imx/clk-imx6q.c                        |    2 +-
 drivers/clk/imx/clk-imx6ul.c                       |    2 +-
 drivers/clk/imx/clk-imx8.c                         |    4 +-
 drivers/clk/imx/clk-imx8.h                         |    2 +-
 drivers/clk/imx/clk-imx8qm.c                       |    2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |    2 +-
 drivers/clk/imx/clk-imxrt1020.c                    |    2 +-
 drivers/clk/imx/clk-imxrt1170.c                    |    4 +-
 drivers/clk/imx/clk-pfd.c                          |    4 +-
 drivers/clk/imx/clk-pll14xx.c                      |    8 +-
 drivers/clk/imx/clk-pllv3.c                        |   18 +-
 drivers/clk/intel/clk_intel.c                      |    2 +-
 drivers/clk/mediatek/clk-mtk.c                     |   14 +-
 drivers/clk/mediatek/clk-mtk.h                     |   10 +-
 drivers/clk/meson/a1.c                             |    8 +-
 drivers/clk/meson/axg-ao.c                         |    2 +-
 drivers/clk/meson/axg.c                            |    2 +-
 drivers/clk/meson/clk-measure.c                    |    2 +-
 drivers/clk/meson/g12a-ao.c                        |    2 +-
 drivers/clk/meson/g12a.c                           |   10 +-
 drivers/clk/meson/gxbb.c                           |    8 +-
 drivers/clk/microchip/mpfs_clk_cfg.c               |    4 +-
 drivers/clk/microchip/mpfs_clk_msspll.c            |    2 +-
 drivers/clk/microchip/mpfs_clk_periph.c            |    2 +-
 drivers/clk/mpc83xx_clk.c                          |    2 +-
 drivers/clk/mtmips/clk-mt7620.c                    |    2 +-
 drivers/clk/mtmips/clk-mt7621.c                    |    2 +-
 drivers/clk/mtmips/clk-mt7628.c                    |    2 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |    4 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    2 +-
 drivers/clk/nuvoton/clk_npcm.c                     |    4 +-
 drivers/clk/nuvoton/clk_npcm.h                     |    2 +-
 drivers/clk/owl/clk_owl.c                          |    6 +-
 drivers/clk/qcom/Kconfig                           |    1 +
 drivers/clk/qcom/Makefile                          |   28 +-
 drivers/clk/qcom/basic/Makefile                    |   25 +
 drivers/clk/qcom/{ => basic}/clock-apq8016.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-apq8096.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq4019.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq5424.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq9574.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcm2290.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcom.c          |    4 +-
 drivers/clk/qcom/{ => basic}/clock-qcom.h          |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs404.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs615.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs8300.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sa8775p.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sc7280.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sdm845.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-sm6115.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm6350.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm7150.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8150.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8250.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8550.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-sm8650.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-x1e80100.c      |    4 +-
 drivers/clk/qcom/ccf/Makefile                      |   21 +
 drivers/clk/qcom/ccf/clk-alpha-pll.c               | 3196 ++++++++++++++++
 drivers/clk/qcom/ccf/clk-alpha-pll.h               |  251 ++
 drivers/clk/qcom/ccf/clk-branch.c                  |  203 ++
 drivers/clk/qcom/ccf/clk-branch.h                  |  125 +
 drivers/clk/qcom/ccf/clk-rcg.h                     |  217 ++
 drivers/clk/qcom/ccf/clk-rcg2.c                    | 1765 +++++++++
 drivers/clk/qcom/ccf/clk-regmap-divider.c          |   90 +
 drivers/clk/qcom/ccf/clk-regmap-divider.h          |   22 +
 drivers/clk/qcom/ccf/clk-regmap-mux-div.c          |  232 ++
 drivers/clk/qcom/ccf/clk-regmap-mux-div.h          |   44 +
 drivers/clk/qcom/ccf/clk-regmap-mux.c              |   57 +
 drivers/clk/qcom/ccf/clk-regmap-mux.h              |   23 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.c          |   62 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.h          |   33 +
 drivers/clk/qcom/ccf/clk-regmap.c                  |  104 +
 drivers/clk/qcom/ccf/clk-regmap.h                  |   38 +
 drivers/clk/qcom/ccf/clk-rpmh.c                    | 1030 ++++++
 drivers/clk/qcom/ccf/common-uboot.c                |  188 +
 drivers/clk/qcom/ccf/common-uboot.h                |   38 +
 drivers/clk/qcom/ccf/common.c                      |  252 ++
 drivers/clk/qcom/ccf/common.h                      |  106 +
 drivers/clk/qcom/ccf/dispcc-sm8550.c               | 1825 ++++++++++
 drivers/clk/qcom/ccf/gcc-sm8650.c                  | 3846 ++++++++++++++++++++
 drivers/clk/qcom/ccf/gdsc.c                        |  545 +++
 drivers/clk/qcom/ccf/gdsc.h                        |  103 +
 drivers/clk/qcom/ccf/reset.c                       |  112 +
 drivers/clk/qcom/ccf/reset.h                       |   29 +
 drivers/clk/qcom/ccf/tcsrcc-sm8650.c               |  174 +
 drivers/clk/renesas/clk-rcar-gen2.c                |    4 +-
 drivers/clk/renesas/clk-rcar-gen3.c                |    4 +-
 drivers/clk/renesas/compound-clock.c               |    4 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    6 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                |    2 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    2 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |    8 +-
 drivers/clk/rockchip/clk_px30.c                    |   12 +-
 drivers/clk/rockchip/clk_rk3036.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3066.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3128.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3188.c                  |    4 +-
 drivers/clk/rockchip/clk_rk322x.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3288.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3308.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3328.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3368.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3399.c                  |    8 +-
 drivers/clk/rockchip/clk_rk3528.c                  |   10 +-
 drivers/clk/rockchip/clk_rk3568.c                  |   14 +-
 drivers/clk/rockchip/clk_rk3576.c                  |    8 +-
 drivers/clk/rockchip/clk_rk3588.c                  |   12 +-
 drivers/clk/rockchip/clk_rv1108.c                  |    4 +-
 drivers/clk/rockchip/clk_rv1126.c                  |   12 +-
 drivers/clk/sifive/sifive-prci.c                   |    4 +-
 drivers/clk/sophgo/clk-cv1800b.c                   |    4 +-
 drivers/clk/sophgo/clk-ip.c                        |   30 +-
 drivers/clk/sophgo/clk-ip.h                        |   18 +-
 drivers/clk/sophgo/clk-pll.c                       |    8 +-
 drivers/clk/sophgo/clk-pll.h                       |    4 +-
 drivers/clk/starfive/clk-jh7110-pll.c              |    4 +-
 drivers/clk/starfive/clk.h                         |    2 +-
 drivers/clk/stm32/clk-stm32-core.c                 |   22 +-
 drivers/clk/stm32/clk-stm32-core.h                 |    2 +-
 drivers/clk/stm32/clk-stm32f.c                     |    4 +-
 drivers/clk/stm32/clk-stm32h7.c                    |    2 +-
 drivers/clk/stm32/clk-stm32mp1.c                   |    4 +-
 drivers/clk/sunxi/clk_sun6i_rtc.c                  |    2 +-
 drivers/clk/sunxi/clk_sunxi.c                      |    2 +-
 drivers/clk/tegra/tegra-car-clk.c                  |    4 +-
 drivers/clk/tegra/tegra186-clk.c                   |    4 +-
 drivers/clk/thead/clk-th1520-ap.c                  |    8 +-
 drivers/clk/ti/clk-am3-dpll-x2.c                   |    2 +-
 drivers/clk/ti/clk-am3-dpll.c                      |    4 +-
 drivers/clk/ti/clk-ctrl.c                          |    2 +-
 drivers/clk/ti/clk-divider.c                       |    4 +-
 drivers/clk/ti/clk-gate.c                          |    2 +-
 drivers/clk/ti/clk-k3-pll.c                        |    4 +-
 drivers/clk/ti/clk-k3.c                            |    6 +-
 drivers/clk/ti/clk-mux.c                           |    4 +-
 drivers/clk/ti/clk-sci.c                           |    4 +-
 drivers/clk/uccf/Kconfig                           |   22 +
 drivers/clk/uccf/Makefile                          |   11 +
 drivers/clk/{ => uccf}/clk-composite.c             |   20 +-
 drivers/clk/{ => uccf}/clk-divider.c               |    4 +-
 drivers/clk/{ => uccf}/clk-fixed-factor.c          |    2 +-
 drivers/clk/{ => uccf}/clk-gate.c                  |    2 +-
 drivers/clk/{ => uccf}/clk-mux.c                   |    2 +-
 drivers/clk/{ => uccf}/clk.c                       |    4 +-
 .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |    8 +-
 drivers/clk/uniphier/clk-uniphier-core.c           |    6 +-
 drivers/core/devres.c                              |   83 +-
 drivers/core/of_access.c                           |   52 +
 drivers/core/ofnode.c                              |   48 +
 drivers/phy/cadence/phy-cadence-sierra.c           |    2 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |    2 +-
 drivers/phy/phy-stm32-usbphyc.c                    |    2 +-
 drivers/phy/phy-ti-am654.c                         |    2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |    6 +-
 drivers/power/domain/imx8mp-hsiomix.c              |    2 +-
 drivers/serial/serial_msm_geni.c                   |   15 +-
 drivers/soc/qcom/rpmh-rsc.c                        |    8 +-
 drivers/soc/qcom/rpmh.c                            |    4 +-
 include/asm-generic/sections.h                     |   19 +
 include/clk-uclass.h                               |    6 +-
 include/clk.h                                      |   34 +-
 include/clk/sunxi.h                                |    2 +-
 include/dm/devres.h                                |   10 +
 include/dm/of_access.h                             |   20 +
 include/dm/ofnode.h                                |   50 +
 include/fdtdec.h                                   |   16 +
 include/linux/clk-provider-ccf_full.h              | 1461 ++++++++
 include/linux/clk-provider-uccf.h                  |  251 ++
 include/linux/clk-provider.h                       |  247 +-
 include/linux/clk/clk-conf.h                       |   22 +
 include/linux/compat.h                             |   13 +
 include/linux/device.h                             |   29 +
 include/linux/err.h                                |   25 +
 include/linux/kref.h                               |  124 +
 include/linux/math64.h                             |   19 +
 include/linux/regmap.h                             |    1 +
 include/linux/string.h                             |    2 +
 include/power/regulator.h                          |    3 +
 include/regmap.h                                   |    9 +
 include/sandbox-clk.h                              |    5 +-
 lib/fdtdec.c                                       |   18 +
 lib/string.c                                       |   31 +
 lib/vsprintf.c                                     |   37 +
 test/dm/Makefile                                   |    5 +-
 test/dm/clk_ccf.c                                  |  117 +-
 test/test-main.c                                   |    6 +
 269 files changed, 24338 insertions(+), 932 deletions(-)
---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da

// Casey (she/they)


