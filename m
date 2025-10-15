Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE5CCD1AA
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.18620.1760539199504517122
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=OzoOnYb2;
 spf=pass (domain: linaro.org, ip: 209.85.167.48, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58b025fce96so5874628e87.1
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539198; x=1761143998; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV/e8/t/Q2+spodtqDGG7TeDuDfPmijfIksYHrPyn9U=;
        b=OzoOnYb2XZt3vjjqy/IHi1J1kLuJuh7+eER4z7Sk+HOZQIJYJf9IiEYscn6rqOr3aP
         +TlJ1blr0Tc2x5Z9iwrWKzXcy+UTV4URMvrwhZXj/sZEzafsrkajpG98Xybo2jNmuVBC
         SuQgrT1KjK7ZCJIaVNUL7b784k2hA49xTuaD8U4RmemBkklVrUNDIoNADHyELxuBCEc+
         FEURBMSPtt+Td9yb+qOFkTO7PVwxD3OsjUAL9EVamcz2BpUcifAE7d2g0r+MIzvgn54U
         8FNABinfiPEfeukwuShMKyhoRowsvp+r5kY9Mjd5ngBHgdcVNwvmR8GoSsfWjK6B6C2y
         NaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539198; x=1761143998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV/e8/t/Q2+spodtqDGG7TeDuDfPmijfIksYHrPyn9U=;
        b=oCKFdzdgozqesAmp6NKGhM8UX2k/7hULh1+UE7HWIX9f15BdyDe/kJPqn1Rvx32n3j
         A/qNbTdQEq23uFDRJYflXCrItdHyRRgQlV2DEt6sqiFd2r9DP27Z/gRQfaLdQftfQu0I
         d2xzQfpJr+B96PKL4dB1/BnGJn3DIfVW6qiOMLI0Rg0LcTBpfJCAbW+HrCk83ZI/y7vP
         xRhMQ9ouNhouhWTBOKddojMqwOY1aF/Zt5EjFbbhQub0l/5ivgrfc/UtUTDv9S3Zy3gX
         pHWOxokkhIzaqvPvNnf0p5ZE3jG2oztwc84BtPr95mSHwbq2s+ft1E8HQ3Thk/CRD4Wh
         wNWQ==
X-Gm-Message-State: AOJu0Yz+2kG/9o94TyHGEmVOyH6ufqBX56SL86fnOEqWbaPPaoyw9GSa
	XqnFTWO/4jJBGqq8cPrPYRfS81nk1hsc+CFslrkAQO2OioBVtW6n4+CweGu6o2ecvXZxjuDxVm/
	uwAr3Drc=
X-Gm-Gg: ASbGncvMdzQ7j8JuKLUt34ro/6cl9c91ZLVX6lPN6wOL9JkSelPnupojqFmVGI0Ou5U
	AhaRg01rKsJVFdVXoF6BJDMb+HcQ6b/4Y1E7YVm6EwnpAiKEDgBF/mrOhj6utxZNDDvGoQnBtV/
	szoe7d3clE0iu4hvcigGkLmPQJ9nBI7alFs/widaAfvLknDunFkHPzGMCrA3odiTfhdQgbxhKI0
	VftEknHUJuywnKBMBmr3XXGBE/VqwM6WChA4F4W3lQCpxenwC07NRDj+qCFrSgtkIXAnfYjNYrC
	upZWPjYHHQ5pfy6iOSUCqUI0nUy9MeH7dXgRkxlQ08Kot6f4FQ3haFrF66VgiP0mrEo3aYG2Q8N
	8YdmzcX+24cDFnNTVkGm/sb+taC9gffJ8+IDg7XKW5jBqjAQGIkPn7teZ93a7hp0+AdD0O5i4EU
	TURJGQvRFs
X-Google-Smtp-Source: AGHT+IEdXqJ0ecDo7rFbfmDvnja6s23sdrsv131WYpUK2dXyZgikEBrPhQmktvo9H2vA2YUew3DXSg==
X-Received: by 2002:a05:600c:c110:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-46fb42ee4d2mr116739385e9.41.1760538769348;
        Wed, 15 Oct 2025 07:32:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:48 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:19 +0100
Subject: [PATCH 14/24] clk: nuvoton: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-14-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2837

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/nuvoton/clk_npcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
index 18cb9cddbf38f4f68f9d035079ff147a4409878e..304c5f2ca07ba3c3e285494ca07330e572b4cac7 100644
--- a/drivers/clk/nuvoton/clk_npcm.c
+++ b/drivers/clk/nuvoton/clk_npcm.c
@@ -177,11 +177,11 @@ static ulong npcm_clk_get_fout(struct clk *clk)
 
 	parent_rate = npcm_clk_get_fin(clk);
 	if (!parent_rate)
-		return -EINVAL;
+		return 0;
 
 	div = npcm_clk_get_div(clk);
 	if (!div)
-		return -EINVAL;
+		return 0;
 
 	debug("fout of clk%lu = (%lu / %u)\n", clk->id, parent_rate, div);
 	return (parent_rate / div);
@@ -199,12 +199,12 @@ static ulong npcm_clk_get_pll_fout(struct clk *clk)
 
 	pll = npcm_clk_pll_get(priv->clk_data, clk->id);
 	if (!pll)
-		return -ENODEV;
+		return 0;
 
 	parent.id = pll->parent_id;
 	ret = clk_request(clk->dev, &parent);
 	if (ret)
-		return ret;
+		return 0;
 
 	parent_rate = clk_get_rate(&parent);
 
@@ -236,7 +236,7 @@ static ulong npcm_clk_get_rate(struct clk *clk)
 		if (!ret)
 			return clk_get_rate(&refclk);
 		else
-			return ret;
+			return 0;
 	}
 
 	if (clk->id >= clk_data->pll0_id &&

-- 
2.47.3


