Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A31091936
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:27 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6470.1773954221287264519
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:03:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kAHfl34i;
 spf=pass (domain: linaro.org, ip: 209.85.208.171, mailfrom: casey.connolly@linaro.org)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a32d36396so12264911fa.0
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773954219; x=1774559019; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
        b=kAHfl34iM9RORjdZI2V5R3tL/DaL/vjLyARNHNSk5iNoCogt+405sYbk3RFTVfEd9T
         f8K8oJ7Z1LQpPpYydB3tVyX1qve5iT3CNRfyvI6IYclD15tnDYH4iRhnx8BguwTsk1ms
         DgyZXdm+RcUxVTsWZDWq5XvuCnkv1Qu/UVTlgem3boxwmJE29/W8h2whVk6Ui9z+5UBx
         sRL5voThFVLbYGBZiVLLmM+fZPhTYC5pzcSMKXzOfbwfOUu0lZosZo9HZiv0IzuFXxL1
         BCGbHHkn4KTkoHEQRyLR5qkeunr5m22ve6lBP3xRKzORC8Zyqgz0w/uqqVfJ1wy0izjL
         msUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954219; x=1774559019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
        b=Y0X/T3F/duRZn43PXfODwI+2E0saxMRRwMqkFnSXYmcl5HIGD9aSaFaq4pvzP10vRd
         op1pUexFH3exVIZBrdiaJkD1MpAAaSh9gZFiguhj4yuVqiI26Jvm8eFqfYBkNqoJkEBJ
         q0Kwm/4vCQWE6c0GutCeAwABOWN3NyY8/oAaipZ+vBFVOgAz2IXwu00c3K8IVHEemhQE
         9lQrdE/WrnFherbI4WkDqlAofg55PUCnW9eR9h9xiQ2QFVsg/PvIKo127YZKdcfDxAGQ
         Zj0tGuBq8yff5VR4cAj0R05bFyBIlp+JoonQYuB+b69r7ngD6SmuQwMATt6rlYanfinC
         xfKw==
X-Forwarded-Encrypted: i=1; AJvYcCUy73NgQdWBqqTSlpHV0t7wsOYLvlEgx9RTus6HOS/kEru+UPUy8+U98Fu/IMxw2kN94wwUHsDfYce2Ni/nNA==@groups.io
X-Gm-Message-State: AOJu0Yz/sZFtOIYcJG0miLkzJvc8yTvsjEtVvPPe51eAVLei8EtIFWE8
	emNP68piy6VICvKWDufxT6IotwPIupHBOK67AG/6+e/SraTfuv2EeGfoOqjXgHhlY3ZlcPK84fI
	HVQrb8Hg=
X-Gm-Gg: ATEYQzxZFOKHy19uatJMPu/PR6+EokNZV684SioeVeXDrJx+tmtDAnJJyVcwhazcngq
	gNY9ou+l25Ts9mrIciPgSKpOoCIheeMFnO+jr+nrFd/k7CtdEx/pUZeZSbZUmK+eF54lir9R/+M
	r+5CPQ/4X2o6rrjImtkfD4TwG62oew+vcgTtoTAPLwwJu1jbz/AY8EF895/fHu270kj+VYNRXQB
	IqWJCWAs7PXHmuJe1jiYXCDdv1EDVWp1x4NDLKg+/OWyzi3zr/Uo48I/K2bkJ2XDIUoS+iPo4dr
	CwoewQScA0aojsKlo/LnPS7g/9tixGiJqpoBqCFLVhCqpMk6wsCH8HorYlia1izh5TMPSpx7Zm2
	EOSDusC7LvFFc3KliNecsh6sjC/98tOnqnpEZgeO4yUTmwPHQSdcB4t3xyz/0WburvDul/AL4ZM
	28v+MEF+Fl0nwVnn9Xanb0YqzEvcrjZzifI/92Gg6Gg+OvYE6xzXEw7ybntxrJirUdR0E=
X-Received: by 2002:a05:600c:56d5:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-486f8b921f0mr66772275e9.18.1773953885922;
        Thu, 19 Mar 2026 13:58:05 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:58:05 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:40 +0100
Subject: [PATCH RFC 18/40] clk: move fixed clocks to clk/basic
MIME-Version: 1.0
Message-Id: <20260319-casey-ccf-upstream-v1-18-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=715igzV4HS4mUxyYAOfpPGBwwmJ9nlDFxPe0UC3c4oY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfxbI19eVM/kmzujILX13YeWAh2hX37bWyQWzKoSX
 M3JMVuoo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk6QlGhpkKjm6571IXnBE3
 S58U/ojZ9nmm92n5QPcmM84tElHHZzH8ZPS9p7lpE1PBv98Nnw/2WWvfL/Fqd57q816Iu1FieWD
 8TAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2925

Linux CCF has incompatible implementations of fixed-rate/fixed-factor
clocks, move the U-Boot versions of these drivers to clk/basic and only
build them if CCF_FULL is not enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                       | 8 ++++++--
 drivers/clk/basic/Makefile                 | 7 +++++++
 drivers/clk/{ => basic}/clk_fixed_factor.c | 0
 drivers/clk/{ => basic}/clk_fixed_rate.c   | 0
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 30991e9f55d7..23f381eb0d9f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,16 +4,20 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 
+# U-Boot basic fixed clocks, full CCF has a
+# different and incompatible implementation
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+endif
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
new file mode 100644
index 000000000000..4cf9469d2312
--- /dev/null
+++ b/drivers/clk/basic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Linaro Ltd.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/basic/clk_fixed_factor.c
similarity index 100%
rename from drivers/clk/clk_fixed_factor.c
rename to drivers/clk/basic/clk_fixed_factor.c
diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/basic/clk_fixed_rate.c
similarity index 100%
rename from drivers/clk/clk_fixed_rate.c
rename to drivers/clk/basic/clk_fixed_rate.c

-- 
2.51.0


