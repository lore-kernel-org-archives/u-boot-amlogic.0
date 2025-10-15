Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7B1CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.18651.1760539186463488905
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qVuZ85pP;
 spf=pass (domain: linaro.org, ip: 209.85.208.47, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63b6dfd85d4so8693627a12.1
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539185; x=1761143985; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft6YpEUUyQpMIMjtQb4mzXXMGUrMiVllGY4iEuw5Oyk=;
        b=qVuZ85pPlwrdZeAJjY7KOHwt9ZkU26Frh6ATW9ws+31gXinboCu6ngWytOb/JZxfOu
         YIcd8o/5lkp12z1MlTZrT45Nnutx70QnnJj0bGsTG2OC7Blf3SymZLurabrdjmRW3Uoy
         lfdnXsxxTU6RYw1YU/x9IW+orvLlZPsUFdiXbKnV6cNmfX2vwrhigb5xGn6bnH9xHiLR
         +uMhNsgIMGEYDsiRafzA7OW7oWbyPCm1/Pb2AynfjlnLdUxaGt5baMUy6Sd/yCyIzIpN
         HBBIZZ05KVrEIOfJY+y7LFm58mEaYh2eQ0uNJlT4s9AiyzJvutiV2RGaC/iGceiATD/e
         wDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539185; x=1761143985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft6YpEUUyQpMIMjtQb4mzXXMGUrMiVllGY4iEuw5Oyk=;
        b=f98cswr9Tf3A0QS93WWc/x3l8HKBgBcVYVUNe4NGRnOFEt87E4/g31H28oI/U0OTwa
         Y2Ay8A9hSxah6o3MkUqhb837wYq0azcltKWUviucqjvqSZbf7P3AaSzNP9bBLURlfAyu
         Jmv8goY7/Bv9/EyzB0ylsk3OSkoIaTJsglH1y4daCHba8Nx1E5ZT03TeanMS78Vc695R
         ZDDkR4cko/f5TPVjNIacX7UICFWT060N9kX1M+xSxdig7HCD9U1ZT/IaEv6C+y1rNyqJ
         Bc+EY6MoX2Cf39hSRMPYCnD7L2QIz4sR9RttLpPbYbGIS7ZasZV/QY6ZYWrmKEtlQzsQ
         x4yw==
X-Gm-Message-State: AOJu0YxvvxThZPaJ8gD4VHH7mGCvt+S+Jl+bEKURnRAY4oUE64jVFSIL
	rCC4Kmf/mRIRkN64xjpyOtcDO2i15oF3OXazVNPAYKE450vdwXU18CneZ6Cq08EoqyYWWnWmKwQ
	fe9+2QzM=
X-Gm-Gg: ASbGncsrasxomTXjxYY1m5Bt2ev3pu2n3mILHhAtOo++IKq8Ja+RjAyoqVQ52kDIopT
	EXkdpYR8TGa9GRgdk6DTiPD0a41y8bRgOS0qYMDn6R0DFT5MYTkFI4F6lcEd9sT5XpwE0hrPntf
	IgKg9IiE/7Z1hK4iIXNX4MbM4W8MfFeQb4yzIJxFaj/54NLlgxdCBJ4KBu7DYF9+Mjq9XMYwgVs
	0bclaVu0pbtON7uX0cSFblLDe6ZlZ7wuRr5Wy6VGs4ZUjeMp+/AfPT2G/7sbzHAfARSVmRZN12+
	1hzaVoZj4D5p8uDbAvsIYhaG/XXcOvbUBQnZ9/fzoUYY6fsO3LkRSNC4FIlBP3WTO3rZPVlx3uX
	HYj/JS9xOcbp0i5VCbeAxRrnTR8pIQbI0J1SChVY2XQXrPAMxH24FxIGv4tHryX9rI7z4gFkI7V
	sE6lqSHPV/
X-Google-Smtp-Source: AGHT+IGhjWYd2CQ0DhgHukvBFVnRXpKUvzKiYOh/QAsK00PN3zJO6feyK57Jo0s8/4iLtrm/BWvvOw==
X-Received: by 2002:a05:600c:358a:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-47109da54admr1640155e9.26.1760538754211;
        Wed, 15 Oct 2025 07:32:34 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:33 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:11 +0100
Subject: [PATCH 06/24] clk: at91: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-6-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2824

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/at91/compat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index 1d738f160b6e0881ac6ca6730e54f016e9899b27..ffc3168400b276a57f7dbe6f80f813571118cead 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -291,7 +291,7 @@ static ulong at91_plladiv_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(clk->dev, 0, &source);
 	if (ret)
-		return -EINVAL;
+		return 0;
 
 	clk_rate = clk_get_rate(&source);
 	if (readl(&pmc->mckr) & AT91_PMC_MCKR_PLLADIV_2)
@@ -387,7 +387,7 @@ static ulong system_clk_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(clk->dev, 0, &clk_dev);
 	if (ret)
-		return -EINVAL;
+		return 0;
 
 	return clk_get_rate(&clk_dev);
 }
@@ -522,7 +522,7 @@ static ulong periph_get_rate(struct clk *clk)
 
 	ret = clk_get_by_index(dev, 0, &clk_dev);
 	if (ret)
-		return ret;
+		return 0;
 
 	return clk_get_rate(&clk_dev);
 }

-- 
2.47.3


