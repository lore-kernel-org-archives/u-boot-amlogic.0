Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1224109319F
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:26 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6362.1773953943410453834
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 13:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=rlPHlinX;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b40003d13so893464f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773953942; x=1774558742; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xvrXcpZ8i0ywOmDf+Q4Z8hYkutdUIK0fivHIy7piVE=;
        b=rlPHlinXE8NIBsfTBtYB5LQqYQDF+WGtBT0wRMwzVOaD91rcF7TEAK16+fibOYB2ZV
         C/1KB3VN9pjkGm+iKVWKP/kVTssg7ZsYVGm0GKKmG4FgsUuMSfCiwlbbe4JiycZsgvLY
         TEB3FRvFQET4xzL/RucdpNB2XxXg8Mbn37oh0Ho10YubRsoSliLMABgClXgEVNbborZl
         4rdpqovV7P2Y/e2Qty1M5zXbU6aQVchyas/o/IdrFwqi30zChSOVmjSzopsX468gvau/
         2s+q8kSd+VgCiUYLyZQJucEQbHKeeESTJ4xiti9Wck3WedQ9vX0F7qy28eRjXMGBWHQw
         UKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953942; x=1774558742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9xvrXcpZ8i0ywOmDf+Q4Z8hYkutdUIK0fivHIy7piVE=;
        b=QNbRXtpo2EYQauyB53Amyh6v/SyFzgh5MlyVjrNgPihm/FWLuB4tmnCaatLAwvw2XQ
         v82tocc0SpxLaQ9K/VmfbzUR0itZtN/BArhI6sHwp38Sif79Aany0eG8ZOQze7x+Q7vP
         57etPFlHc93lCxPG7tWD7ViRGCP0VGtJQrTHMGqbGlQGI37OBtVahbbsLyqeZl3giKxu
         tf3EtUUT0RbuslnTyE2H75mpRC/ZOi2tkDGqCm4us4oGSH/6tWGrtPFCr4l4wjwCzvvA
         T+MBcPKQu0ksKoauAbA5OkwJGbfreiRRp54WPUiAPBe3aCo5iAXQbwQxVAd4y776sfqT
         nadw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Zts6hdOxRsrGnVANwy/n7/WIJFpNbRZhhIejWhMOF8Z2uOE0AU1/p3EPqDjbu1VIbYPvLtJYrhbAixitzQ==@groups.io
X-Gm-Message-State: AOJu0Yzc1aT/uI4M2VIdGfC0K8xm64rthyp1sLsA/FPUdaLYPCk1AC2k
	ozETTu3u3p0LgGGp1/selc7bIQazFSezA80I9Db5oaKWtG+Y/YMN1WWc+ZduaWPBaG8=
X-Gm-Gg: ATEYQzzt+5ibzW0oUyPEzOXEIxaEqOxZC2zoNdSULFTwdpZ9lhtMp/nEG8eO2rT630h
	jHeuffxOUZpkfZLzCBntxowi5TkUOB6ZW1bVch00w/qHiyqP+xnUZzUa002G5YTLj2uN+K0GYcu
	4lDUwsN/3Al2BgL095+JztFZwRIzStYvAbHKBlaL7U7dP8K6IHSr0KXARlZQvlc4VPzoXIiZenD
	Wr6/ULQJrbmL0/F92ucJEdzHHL9luc9/TSAPdtM0wINcY9Z4l59KkHLqaiSPIqdK/rb19T1H+z/
	ZpMFOHGjtwO9IW+dACM1UOYZ/KkibuYn+UjiewJ2ysbYXWnMaBWijV5iZZQEJYM8eKjqiz6eORh
	YKKOoSUxqQq7xuIJmQIQffcrOSPyso0Cd9SzV3Muyvs1WK/xGkgBC5IujXY1T6sD6eppf3yycDn
	wAbYb1wrOpdVochtD4r7Wn2Jsm8IrXfq/a6tXwpIz2jVnPIr1CgHOaHkEPbCe1M9CrMOA=
X-Received: by 2002:a05:6000:40c7:b0:435:e3bd:5838 with SMTP id ffacd0b85a97d-43b64277ea7mr1269355f8f.25.1773953941616;
        Thu, 19 Mar 2026 13:59:01 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:59:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:54 +0100
Subject: [PATCH RFC 32/40] clk/qcom: move existing clock drivers to clk/qcom/basic
MIME-Version: 1.0
Message-Id: <20260319-casey-ccf-upstream-v1-32-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8763;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Qy527/8RecTsJ5eEbcqcHYJgzU6oqp8gpAtbhRyAq54=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yYIhip9/X98V8vZ6gt/M1bsMkljmKO/dFPHY9YP+s
 zLP6tU+HSUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAixx8wMuyW06wRcnqc4OMQ
 9vBu7bK6g1sYm3acWGV6lvGTze6vHu4M3/NSl8krzBOX63k8uyRW9MCUgnL3WNac6z3PzvyP/3n
 8BwA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2924

These drivers will be deprecated and removed in favour of CCF.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/Makefile                     | 28 ++++++---------------------
 drivers/clk/qcom/basic/Makefile               | 25 ++++++++++++++++++++++++
 drivers/clk/qcom/{ => basic}/clock-apq8016.c  |  0
 drivers/clk/qcom/{ => basic}/clock-apq8096.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq4019.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq5424.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq9574.c  |  0
 drivers/clk/qcom/{ => basic}/clock-qcm2290.c  |  0
 drivers/clk/qcom/{ => basic}/clock-qcom.c     |  0
 drivers/clk/qcom/{ => basic}/clock-qcom.h     |  0
 drivers/clk/qcom/{ => basic}/clock-qcs404.c   |  0
 drivers/clk/qcom/{ => basic}/clock-qcs615.c   |  0
 drivers/clk/qcom/{ => basic}/clock-qcs8300.c  |  0
 drivers/clk/qcom/{ => basic}/clock-sa8775p.c  |  0
 drivers/clk/qcom/{ => basic}/clock-sc7280.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sdm845.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm6115.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm6350.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm7150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8250.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8550.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8650.c   |  0
 drivers/clk/qcom/{ => basic}/clock-x1e80100.c |  0
 24 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82a5b166196c..71b0bf7f44a7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -1,25 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# (C) Copyright 2023 Linaro
+# (C) Copyright 2026 Linaro
 
-obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+else
+obj-y += ccf/
+endif
diff --git a/drivers/clk/qcom/basic/Makefile b/drivers/clk/qcom/basic/Makefile
new file mode 100644
index 000000000000..82a5b166196c
--- /dev/null
+++ b/drivers/clk/qcom/basic/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += clock-qcom.o
+obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/basic/clock-apq8016.c
similarity index 100%
rename from drivers/clk/qcom/clock-apq8016.c
rename to drivers/clk/qcom/basic/clock-apq8016.c
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/basic/clock-apq8096.c
similarity index 100%
rename from drivers/clk/qcom/clock-apq8096.c
rename to drivers/clk/qcom/basic/clock-apq8096.c
diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/basic/clock-ipq4019.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq4019.c
rename to drivers/clk/qcom/basic/clock-ipq4019.c
diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/basic/clock-ipq5424.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq5424.c
rename to drivers/clk/qcom/basic/clock-ipq5424.c
diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/basic/clock-ipq9574.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq9574.c
rename to drivers/clk/qcom/basic/clock-ipq9574.c
diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/basic/clock-qcm2290.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcm2290.c
rename to drivers/clk/qcom/basic/clock-qcm2290.c
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/basic/clock-qcom.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcom.c
rename to drivers/clk/qcom/basic/clock-qcom.c
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/basic/clock-qcom.h
similarity index 100%
rename from drivers/clk/qcom/clock-qcom.h
rename to drivers/clk/qcom/basic/clock-qcom.h
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/basic/clock-qcs404.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs404.c
rename to drivers/clk/qcom/basic/clock-qcs404.c
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/basic/clock-qcs615.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs615.c
rename to drivers/clk/qcom/basic/clock-qcs615.c
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/basic/clock-qcs8300.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs8300.c
rename to drivers/clk/qcom/basic/clock-qcs8300.c
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/basic/clock-sa8775p.c
similarity index 100%
rename from drivers/clk/qcom/clock-sa8775p.c
rename to drivers/clk/qcom/basic/clock-sa8775p.c
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/basic/clock-sc7280.c
similarity index 100%
rename from drivers/clk/qcom/clock-sc7280.c
rename to drivers/clk/qcom/basic/clock-sc7280.c
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/basic/clock-sdm845.c
similarity index 100%
rename from drivers/clk/qcom/clock-sdm845.c
rename to drivers/clk/qcom/basic/clock-sdm845.c
diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/basic/clock-sm6115.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm6115.c
rename to drivers/clk/qcom/basic/clock-sm6115.c
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/basic/clock-sm6350.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm6350.c
rename to drivers/clk/qcom/basic/clock-sm6350.c
diff --git a/drivers/clk/qcom/clock-sm7150.c b/drivers/clk/qcom/basic/clock-sm7150.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm7150.c
rename to drivers/clk/qcom/basic/clock-sm7150.c
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/basic/clock-sm8150.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8150.c
rename to drivers/clk/qcom/basic/clock-sm8150.c
diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/basic/clock-sm8250.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8250.c
rename to drivers/clk/qcom/basic/clock-sm8250.c
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/basic/clock-sm8550.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8550.c
rename to drivers/clk/qcom/basic/clock-sm8550.c
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/basic/clock-sm8650.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8650.c
rename to drivers/clk/qcom/basic/clock-sm8650.c
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/basic/clock-x1e80100.c
similarity index 100%
rename from drivers/clk/qcom/clock-x1e80100.c
rename to drivers/clk/qcom/basic/clock-x1e80100.c

-- 
2.51.0


