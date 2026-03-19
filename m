Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B21093199
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:26 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6359.1773953939515842502
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 13:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IFA/5L6E;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1032547f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773953938; x=1774558738; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNVimY15oqCrAYHxDzYtB5OTchEi1mxLeVPqbmrztJA=;
        b=IFA/5L6Ef7WCrNUMGAdLr8YHUFNCDD1dqzMgPeVynLYbI1frbU611yYndYTLqqbTjJ
         ogsgegoD8bO06hewK3SEJRYt93lBmxVUsQorOXfkekMxZVuwdBT4Uu6KCZQQHidKTbMS
         a0zQLe3oZXU6z4SR8Wl/xz/kXaa5SJFNgk6+GF5mjbCIwjHCbRN0dQuIfewpOmjGV2XD
         ZhsLszHCWxFyv1uhUb1qs3Xf4grhwlnrIxSkZtcCqQ1qDSXV3w/glWM8iSwtBosrIqlE
         /Cp8APDhlMDp4EnIqtFgr9a+aqs2/Fp3h7BMU50Q+vrp5iSld7ThnV+8yc2IYOHXp+Hx
         2DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953938; x=1774558738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pNVimY15oqCrAYHxDzYtB5OTchEi1mxLeVPqbmrztJA=;
        b=llgT+ddwF9r67i74iHrsmL9DXxAykmb/rU6MK7OC0QIyCD7z/wT5u64Bsmk/VUpazS
         oNRyaRWNHvsQYhhXjoc/5x5EDcO0vFoRYOMaAuB4RK5RngLFX4HOt8yZYhwZQDOveLOC
         6To2ZTujvnZWJ/wck4CywAERSsNgiYE94M6Ye7B81PGOAylUpbGG+T9rG6JPLL7xy+Ny
         D6C3QtVG1xEWtv6lsqcUU+kSGn9m9pUgD/eeYmo/lkYjTVDXS2s9tU3RswCsu/t9O1rP
         hvplU8JgK7p2BUveOEt9J4/CICAarYWEicHa6VNKPPVCTJBiuzonLoq/IcXyuNzvdhDb
         5s4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoilX+bK7SJ7GedEYaY9IerRCd0/6YVmS1mSLKFl5RgZBI07Jkl+BlA7vM+vM+ACTfQ5BFHbMVU+umQEu9rQ==@groups.io
X-Gm-Message-State: AOJu0Yzq7ZS2AObDHxu5ZjV3OvUvlW9FLJQklwEQa+j5l+dNbsLiYUNE
	ugMdigdtWftjm6PqbVuueUoykMjHx0W2hXq2PiA6AO90PnWFXXz4V7iUDUcjvdMOq58=
X-Gm-Gg: ATEYQzxyyfuDBD8Ca/R3OZ2u0Y7+93EaWtkfEfm0/wW8ENZ/nuesTETQd+vFuyxHCi7
	HgzQ4Oc800D/Cm2rI/cI//S7h5XMC8/UKjUrj+EHAphfjyL8W6iKG+tx+nvdMmJDvqUvXwCpmJt
	pu1hH+2HC2hqgJpbO7Endj3OSyqkhN82G/ccgR1hgRz4AnaUL0ykH9rOBhGJK5Cim39/6jcYqco
	P987d97PhGTphqH1Dg6Q+CawcZKxYOdBTYgefWocyubGH584qsI7A/f+fZmEnxz1VZ8Wvv8mUE+
	aQI8dCsVTXFgqgEFpcz0c+9I4ILzdq+lOeg/vcPimBTZkL2+hKPEkd1vqdgjot3T8yCzWgHhaJc
	ddTDi8lPUvX/tuc8+gQRC5NPIbqNPSI+upy0v3AsUDf0582vH4CruD9SD4YZT7vogZXtxmNB6iu
	xBRKQbZ1CvHdcZTSRLHM8SuVE3xLPzrmAdPYvkqurWH/mv83PLNrNS6pGITPB6RbIKcWg=
X-Received: by 2002:a05:6000:2f84:b0:43b:4469:d31b with SMTP id ffacd0b85a97d-43b6424e354mr1215926f8f.15.1773953937711;
        Thu, 19 Mar 2026 13:58:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:58:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:53 +0100
Subject: [PATCH RFC 31/40] cmd/clk: add CCF_FULL support
MIME-Version: 1.0
Message-Id: <20260319-casey-ccf-upstream-v1-31-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=wSWRPGBCtLo+xli0XQv87b9CkhsJCfTj3P+Ywiou4TY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQJ//4v/L9Cs6X99tvWc/vyw1UJ60+QPOB5RW7R2h
 7DfJhHLjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjAR3gUM//0jpJw8Y4pmnJtd
 pmR88OtPr/07V881THkZpJr0rGHzvGOMDDP6wksmXWT4ecF41ZkNPu/vfEqVtk6/srp2QanTz9d
 mh3cBAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2928

This functionality can be expanded later, for now just support calling
clk_summary_show() to dump CCF state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 cmd/clk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/clk.c b/cmd/clk.c
index 1210a84ca2aa..1f1888b8fd94 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -9,8 +9,9 @@
 #include <dm/root.h>
 #include <dm/device-internal.h>
 #include <linux/clk-provider.h>
 
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
 static void show_clks(struct udevice *dev, int depth, int last_flag)
 {
 	int i, is_last;
 	struct udevice *child;
@@ -119,8 +120,26 @@ static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	printf("set_rate returns %u\n", freq);
 	return 0;
 }
+#else
+
+void clk_summary_show(void);
+
+static int do_clk_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	clk_summary_show();
+	return 0;
+}
+
+static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return 0;
+}
+
+#endif
 
 static struct cmd_tbl cmd_clk_sub[] = {
 	U_BOOT_CMD_MKENT(dump, 1, 1, do_clk_dump, "", ""),
 	U_BOOT_CMD_MKENT(setfreq, 3, 1, do_clk_setfreq, "", ""),

-- 
2.51.0


