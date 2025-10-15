Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F4CCD1AD
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.18612.1760539189221378174
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=JUUOVcqX;
 spf=pass (domain: linaro.org, ip: 209.85.167.41, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1344433e87.0
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539187; x=1761143987; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4USdmUWRoBxa2auUBl/bOqEZus6FVT4B5gwKLaCSZQ=;
        b=JUUOVcqXbFUyhPJOtM2iQ7PWE48tNNgeCeORNvBRmNtVXPMmsRcFWYvr8Qf4zWfsXl
         Rxqz3NH4e3gaI7/YuV04XawFgRbjiNpSmS7koI+RQ6SKn0UtkOX5ueUeNphTIlTKayGs
         4cM36Sv/TpaPdx6gQvFV5f3mUZVbvLl5qlU398H1qCV4P8tGPXLN+AF9nLlMaIH54h9W
         C4yKxPVR6mm2fzVwH26Fu6VwCGZwgrdNgvPiL9/9bPImeJ0tWA0RP/uXp8nfHUpAkgDr
         fo43zn2D6bDwt9Q+hfohz9RwULequY2yzzwTi0zWOgDO11U3d2/AKVXBWACVA4FsXTK4
         Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539187; x=1761143987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4USdmUWRoBxa2auUBl/bOqEZus6FVT4B5gwKLaCSZQ=;
        b=IDbqClIA1zzfFp0Dx2wcwPtuBS+Zr5IvpfpwJbUA6T4FJ9UeXvpyEylf7e34GlxYLy
         QxPPeK7rOcNe678e8xqJUf+E0HXzfYVZVyHG4Wbwk/M4rUbCm3sS9KcdO3s5UgOgtXd7
         7eTt0Jd3/GRPdzrw90W12hUJnsya1L/jPi4RGA50vHPCoMas6BV81tb3LJDCzmZbdCCe
         REICo9qlLeUOI8k9m/03Ia7zIbt5aZGGu3sV6GEitF+UOmRYHRS/Yi0fw8PfHCzyWXNz
         ueoXJPfbIz5FpnE1YpjC66iX4qeg9c7uUG8BdrcqI+g3UrANphOr+YC/QNcYZ5io3IMn
         m27Q==
X-Gm-Message-State: AOJu0YwesMeFKS6WQ/gAS9mldGTzCEehTX7ztvj17RD/p+dgMADDQcME
	FsbUwJ9Me/bZ7jS8Ds+aJHvZBY8JozHXGow2XiPBlGpn5GfV0taxIwZTGv8g4uuPHyAy1KqPhKL
	fsbLm25w=
X-Gm-Gg: ASbGncu/jUGfE2/7ayQ634XySicpEBoz8Fjdhs/TLMxti2raDySzWbXuwKpRa+wTECa
	RUfC55ylh1ZK9bh7dPFwn0yzouUpgDnybl7W7nP2w9QdB/gvI052Ll7IboxvyxvK0q9Wt9QKyOX
	Ivthqya0tSPBdAjZODvJPj5sFzLJVliSCLEbluLm29KPFNrbD/9QQ0DyoealI9wpWyE2223ILSo
	rrglAsawwKF/sOYtLNoKb1QHYZZ0SbCRHQWY49VrjZaKiboF58MSpFqISpHM6OF+GlVcygz376W
	N+of2Uffp5TxPz6YHZe8adsIf8ylXka29fp7oFKVHv4h6OfLOTRFagsFEmPBIauN6j2kuTMXNvS
	+8qSuFpuScTjADviLlt/mO0YC1o4VQkUc46k3wXoImKZHlT0f6fjbu70Tm6Itk3qDLh9YS3j/mL
	zI8oY/r+W4
X-Google-Smtp-Source: AGHT+IGukt19G/PYZOSW4vD1zMsgMCtooeLi8q7LKqiyW8/UWAJG648gEKOHzHmpGSlcRpHmeIFn2w==
X-Received: by 2002:a05:600c:d2:b0:46d:83e7:45ec with SMTP id 5b1f17b1804b1-47109b4ff60mr1887255e9.11.1760538748490;
        Wed, 15 Oct 2025 07:32:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:08 +0100
Subject: [PATCH 03/24] clk: armada-37xx: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-3-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2825

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 2 +-
 drivers/clk/mvebu/armada-37xx-tbg.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 30330393f760fe34b3c78f23b617309b18903477..938881056d373e9978ff34376edc76527ebe4c0f 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -325,7 +325,7 @@ static ulong armada_37xx_periph_clk_get_rate(struct clk *clk)
 	struct a37xx_periphclk *priv = dev_get_priv(clk->dev);
 
 	if (clk->id >= priv->count)
-		return -EINVAL;
+		return 0;
 
 	return periph_clk_get_rate(priv, clk->id);
 }
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index c1bab84c070e35f3ce739cfce2e1468157ebe71b..d61b1d34fc64cfff473ead2bf8b0e929d4957994 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -88,7 +88,7 @@ static ulong armada_37xx_tbg_clk_get_rate(struct clk *clk)
 	struct a37xx_tbgclk *priv = dev_get_priv(clk->dev);
 
 	if (clk->id >= NUM_TBG)
-		return -ENODEV;
+		return 0;
 
 	return priv->rates[clk->id];
 }

-- 
2.47.3


