Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7186CCD1B3
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.18641.1760539158526903128
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=s86F6pem;
 spf=pass (domain: linaro.org, ip: 209.85.208.44, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so13832305a12.3
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539157; x=1761143957; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2Ex94fmhlLv2i2Yx1QhQ917Ez/zRaZdOvJOV/zm02o=;
        b=s86F6pemKj0Btp3yQG3W/LPq1X82zMjirsAbcaq3AXFAHUrCya5xCsB12XSKYr57PX
         dLDI5mZ60UaXWHhZY1LRRs8Dvi2w/LCcQlDzU0S2NZoKq292sTiT6CsAbzgLE/OSiLV9
         NuQnxbsHv3cUlqtnY4iNdjV0WPl+YnHnwCV9w0oH50NZfJEu+UYY/c24EIizw1F+374p
         tlv+pIXWBRIBkK0+lvo93Oh4Ch0w4uQA69pvHE1P1CCdjbQ0wsTCzDjFNu9Gg1JCmLRU
         zQiLjTOxcDSclnO7sjIGP6sq2CPAB6jF7RcszhBX7MSjfWSQGHWPS4dACxEg+qlDgnvP
         1JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539157; x=1761143957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2Ex94fmhlLv2i2Yx1QhQ917Ez/zRaZdOvJOV/zm02o=;
        b=WuqCgJ0DVf8g2h6jxBcv29X5JCUDhVWqWTAaRuW3DiaBO8EQjyoaox/c9vfXOnegGu
         sa1VKfYkgWOf49HqqiAPnILCXpdGzD/hvQCiz7bRM92EnWhXJlwYr93qCrC6n70Aass2
         zF9ei2MleJ3c4vcUD+WxWVytIUub0hNYN3qHQ9RvXupEv1duR/qTN78DJ0vpGiKYJiEl
         rVOKYSJH+b9dGZQWi6BsmpJbmLWBOKj+cuXDhAohGmHyvDdfUMBboI4kAkT6b9fBkLzj
         fM3JFNlYtl9+Gv+ebX9uuGmwGLSrbHBMUksSOpHoQYQ3xZJuhvzbqV189ul0HePVgrw9
         W5KQ==
X-Gm-Message-State: AOJu0Yx9g/6V3mRDo1Ijuq91KPkzDi22Vxrfay81RsbGp+jOPkxBt9YA
	YjGccXpS1H82OuzZaMZV5az6JeoXSq41o2VYQ3uDcLxUR7SvE83UdAIcuIFwlOqBvGsKt/YRtlc
	fCJ3AbHI=
X-Gm-Gg: ASbGncuzI0PJ0pe/t/8RTgy7ZN8QYyRAfrcAbuxQ/b/qLIv9sHSe8xqfBh1jYsz4GOT
	6kQTLYRR7Kn2+405s6pNRsHBFv6u1rJGVfnIAOD+K/x4Zoir3AzrNBl1yMXixdY3JtQvfXaQ4C+
	IDJYJ/4h+Z6+u3erU7mAA10MrX3pBdWw1gNdVS/d1k9psoTE2l5Rm12Lra+NBr7tfGmDlaKbD41
	dm3bl4R1cyVa7eKykR/Jue3aGTvNJNlEvxdXQLUJpeLZNpyuWxTBsXjRAg1nMROiMWp8EpcUjOZ
	WRZqV4Qt01kwd8Cc7h1Zq+JuFnQ7601BbjOh5wRN9OMHhL2ruiKB5J8xWdO5Mhq1fpIDfI/PrsL
	W5EZ0IrpCiEJbhAyrO5AJO7cbVDexxNh+Xg414VxGqNKItVbDNC/KDyC0eIWKH8s+KXSijhmP+9
	Ym6bZkBk8V
X-Google-Smtp-Source: AGHT+IFntIZgc8kpwywcm6Ac1YodmDRVT9uEaIFSPv2xMkytU2MPV98wALWC7FxueiIlE7bJN1OwyA==
X-Received: by 2002:a5d:5d88:0:b0:425:7e38:419f with SMTP id ffacd0b85a97d-42666ab867amr19302858f8f.16.1760538771388;
        Wed, 15 Oct 2025 07:32:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:20 +0100
Subject: [PATCH 15/24] clk: exynos: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-15-5f80f827407e@linaro.org>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2832

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/exynos/clk-exynos7420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
index 7de4e688f036d47adfa22c841400770b1b1ed3b3..494f5623259945376475c53dcd8d5b5fbf635b0f 100644
--- a/drivers/clk/exynos/clk-exynos7420.c
+++ b/drivers/clk/exynos/clk-exynos7420.c
@@ -199,7 +199,7 @@ static ulong exynos7420_peric1_get_rate(struct clk *clk)
 	case SCLK_UART2:
 		ret = clk_get_by_index(clk->dev, 3, &in_clk);
 		if (ret < 0)
-			return ret;
+			return 0;
 		freq = clk_get_rate(&in_clk);
 		break;
 	}

-- 
2.47.3


