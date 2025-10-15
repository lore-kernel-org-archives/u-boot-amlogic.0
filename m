Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF10CCD1B7
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.18642.1760539158531457235
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=EKinzBUi;
 spf=pass (domain: linaro.org, ip: 209.85.208.46, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so4682247a12.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539157; x=1761143957; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTbXf2v+6DOITANdOMYtay+m9aD8F7IEVVIpnQ+2pPc=;
        b=EKinzBUinvO7n6hV37Z0lDltYdzV1X3htvfj1x+nccfW2TsyoPaLYGx+0miV3cTd6Y
         +Mtt7CAvdAel+f+mtQY23sfUDnExzch5zgBFIee0gKFj6gYIYPvCnXolh/57HI1BBU5c
         qSLMb8zJZzDXcacOH0HnuXV+i8piZY3pheGPMyiFF8GN9Zvpx8bV9zgKUL6SXQDIQ0et
         d5fIOgYQyPuAtrlo3tF3vWIQ27OwpQO08F2Rt/bJPdUVJudlOfF24jcOyVvX6jCWRFw1
         E1IzOeji8KlVR+2lEN5KYWwqhF+Ee4uht0SxVIPw76kKHTOHGVNTxpENkTLeWD8mMsUU
         ia9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539157; x=1761143957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTbXf2v+6DOITANdOMYtay+m9aD8F7IEVVIpnQ+2pPc=;
        b=vGNHOYACQPFgkph3Zv9JLkI1g01LpmMIW7WINYE+qx3zbGXMqxvM2OgVRW1195Jqxj
         5pA8pV5OcHpZoAlWOGSiBX/YKzlGtOFq3Ss3Z1/FDpiX772ABTpbusS7KBe9RsB7Uc8X
         xTIe659fujP54z/pJmb4gxsBFXvdnBwuTn2VlUF5q7BEfLUHN7y8GjrIgXPsMaKvDaR2
         PNMHqsf6fH6fugrs0AEpO3CszB1vrv6ze+190udAEisWSShwYg2oVTgLbJqP8Ibve95+
         Vg08h4WVanxsuJY+fUI6oYKFrLcSWhmSrLecEUOYVuLhhN+gkcM6mI9fOHBqOLdtiE8N
         oLUg==
X-Gm-Message-State: AOJu0Yz+AmW/coUQ8g3J3Q9TkyhYQiuTQSKDQ8AglAVaRnsAsmDEt50d
	XAHhg71/o5sfKLBIiSvdwORSdn93/DCXZ9lPbdeNfnFZkg0822siU/m8k3kNQThIwncQsVzS9EW
	n87SuYI8=
X-Gm-Gg: ASbGnctrDZ9f9cuFrbpjrNqQDOQrhZndQtlGvMrmwreGd+J7GUqx6CX+IF58xAjNIYJ
	5PG8zEyz+iXScHeCFPuy8OnAERqKh0zpEvPxXywdqDAjg94ywrCrsTivw4vkvKWP5e1ncIZjp8g
	g+SoIepRSNtB23WfpKAFLu2zxu0Ka7yn+5ZqFAEs4O6tqcB1T78fA22B54koHkWRGs1Ln/Kk82/
	yWOMGiy5UTPJeYcS3cO05XPTk0jMRfvqXTGalIFEo5G6jyOaaWbE8wiISt74u5nDcSAqGIyg7si
	94I6aaS79e2eD0UpFS2mm/ML5BSuh5qAj6WhOeWiB6cNniFLf4Ffd47oXKwyGzT52P2XE7jEBDX
	AERCE2RTuD9e2esej1QJvsLfRH4a6wRr5s/2OHHnKpSjLulE+DObCl+wFHX6o+KNHKO+l2DOiog
	==
X-Google-Smtp-Source: AGHT+IH+rwZaZc5p0en/wUvb43r51I+4D/Ojes6xOI2/lEb1mRkkPQW7ty8WKdlM7v8kZME/V1yKwg==
X-Received: by 2002:a05:600c:35cb:b0:471:9da:524c with SMTP id 5b1f17b1804b1-47109da5403mr1337285e9.12.1760538780882;
        Wed, 15 Oct 2025 07:33:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:33:00 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:25 +0100
Subject: [PATCH 20/24] clk: tegra: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-20-5f80f827407e@linaro.org>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2833

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/tegra/tegra-car-clk.c | 2 +-
 drivers/clk/tegra/tegra186-clk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 880dd4f6ece9fde3ef3dd9d457e717ce4c237e29..19ca5583a53427d05936cf65b6a32237d91df4ae 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -57,7 +57,7 @@ static ulong tegra_car_clk_get_rate(struct clk *clk)
 		return clock_get_periph_rate(clk->id, parent);
 	}
 
-	return -1U;
+	return 0;
 }
 
 static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra186-clk.c
index ec52326c3b365eac9845e2fb98531ae0da2f486a..8c364e2dd3412d1298bd39178f19b3cb609aba5a 100644
--- a/drivers/clk/tegra/tegra186-clk.c
+++ b/drivers/clk/tegra/tegra186-clk.c
@@ -23,7 +23,7 @@ static ulong tegra186_clk_get_rate(struct clk *clk)
 	ret = misc_call(clk->dev->parent, MRQ_CLK, &req, sizeof(req), &resp,
 			sizeof(resp));
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	return resp.clk_get_rate.rate;
 }

-- 
2.47.3


