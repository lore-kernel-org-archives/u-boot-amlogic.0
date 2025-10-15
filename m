Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2835CCD1B9
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.18600.1760539159305328651
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yQyC++vu;
 spf=pass (domain: linaro.org, ip: 209.85.218.43, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1201506266b.2
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539158; x=1761143958; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DlBlKpxAI+PPChFoLT58sI+sD4cz43gntE98De/JHE=;
        b=yQyC++vuCcyVsgbzholtVVqLBulSOLI44K4tjr4zFemUJ65kj76S4AJr75clR6Eh8B
         Cfi+zyS+EMUt682BEzHXaXtCf0TmgdQraoWd2CrPED/VlJZsY6gRVNsfcFuZBbnRSo0a
         /Bmn2mirxQOi+a0QggGnYtP1xagRMDPROB/ic9GhjomdV0/BK3NHDIJmlZwDt+gaVqgm
         IPYp49COpNUHHL08kqiUJGIm4gpYe60BTBBOfcpaKrtCqOHxxpA3FnBIIwbDX4yRH6KO
         mr9YhIvTVD2vW/M7BYlKPhytKGq7bxHKLN1O6nENHstvl1DiJma4JxJTHfmi/M8Rxe+e
         aWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539158; x=1761143958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DlBlKpxAI+PPChFoLT58sI+sD4cz43gntE98De/JHE=;
        b=ar/Em5nPpSDe4zgZcaARTV1JryBglWsxkRXK6gt0le/kNDNvb9Lr+ljB9+HApsKKM+
         3oXvQ4KY7vGX3OfJ/Eb3q5kFdvOXUP5nYVHmaT05T6n9ql3pk/l+JyPDrPWAjpOj2TWg
         XgHlCpieN5F1pWUvXs2S22pifXqfUHoiGLsligxWFqeyyOyhqWDjJmlb1hddpSkylb03
         HdrgZrTaB8Y5CYsxs2GCJdz4q39CiBLwZoXancqzt4EOM4MHMvbthO1hpyBKFUJJ0+WA
         oXwqWoZh8Fg/m4B2TfvXipwsmTzidzmbUq5N1cteSK5od3HgydvFNN9zZZKzTT9dcCdd
         ywBA==
X-Gm-Message-State: AOJu0YyccahZLWIZShQDQkNt5Ri4Pd5fLRxTPSUOF/4EZikhCGYDb93y
	vSNgfuHHRYaZDB2/wbEr8N7oxy2QUwCD3WcjXvk/zOR2ZsAUiWw84DkNDqPVHEDSw1CC5ICAuEb
	fo9C/zOY=
X-Gm-Gg: ASbGncu/B64dNLUqLz1KfJ5aS0y6f5I+M9BnP5X06xn3toImbUD5bdSTEZpO+BxpHiD
	O104Hl8GAnDnqtpv5R4k2ZxBsYAs/WCB3Gbo/oHyWK8G2e8z/k3T8n0ZQXXIkKqF389VvUSuEkW
	tAgYiS9barWfascl8X3kCPqcmYepuNe7opu61pdxQCfTma3P/89N9QelkxJcOz08UYJYQf+Hcwp
	W2vyG9Okf/NpHxZfUfuVk4d6YgrtMJdm+xqQ3xDmvB60IujJLo2D5iJs/UUxk8uVz7ArUm7opaG
	OGV1O7XWy981Gi/UmIi1OL4E15jH40GpvIslEYhTRzRy7PTJRoxVezV6+2mXWdoEqpG3N1bipo5
	EimzAHgShTd1y4uTp1nYxcZk6UMBhbd5IbErALySUxOkMt6jPhKdZbaieZ6ZdidPPrgeXHwo0ig
	==
X-Google-Smtp-Source: AGHT+IGGoNhcuuBnqzdOS8d1serI7LBP8ZtrY43uHHsw2cJDzVWs6n2CpX0JLNFJQ7Pf6GLL4B2fyg==
X-Received: by 2002:a05:600d:42a4:b0:46f:b327:31ef with SMTP id 5b1f17b1804b1-46fb327388emr111447735e9.12.1760538788353;
        Wed, 15 Oct 2025 07:33:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:33:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:29 +0100
Subject: [PATCH 24/24] clk: x86: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-24-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2834

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/intel/clk_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/intel/clk_intel.c b/drivers/clk/intel/clk_intel.c
index a677a7caac7c84e5576a8b228e8ce4493a2e92b3..b5f3e800431314f4c2617133c1afad99dac35787 100644
--- a/drivers/clk/intel/clk_intel.c
+++ b/drivers/clk/intel/clk_intel.c
@@ -15,7 +15,7 @@ static ulong intel_clk_get_rate(struct clk *clk)
 		/* Hard-coded to 133MHz on current platforms */
 		return 133333333;
 	default:
-		return -ENODEV;
+		return 0;
 	}
 }
 

-- 
2.47.3


