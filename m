Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994E8CCD1A7
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:44 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.18627.1760539146714728983
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:39:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=csdNiAlp;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee1381b835so4444525f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539145; x=1761143945; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5G/pzUDmAWP39RNeIkhwHh1OMLzLKAP5G+xfsbBMiU=;
        b=csdNiAlphOEjbJIHAicmxj3F8KET+uVBubyakDRZpXoXw6Fj0vu6zDUXAY3ydwBE38
         QBcnaHx13sd5ZcWr1c455jJZ8FHji8BsiAqm3ds9NuajqZG8qsI/Vzd2uPDmhBYRF+0N
         dpk3vP/TPNtr1a5LM+1tdHSUuj6nEUr29HvhJ3wfo0vEoPdGHBPtTFhEI+DC2kdkcRI8
         uNsOv+QsMVjknh0pXNqUdv6Db6jIwSRsA7lrOph3zxBVfCuD7tFc3F0ZrEKMaUbJOT9u
         wMkk0wtbGD6mB/Yx+EGwGXgtpFW88dBKMGUkfBmpnCuSbxKzudNKxz0L2IWte6oGYIr+
         c3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539145; x=1761143945;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5G/pzUDmAWP39RNeIkhwHh1OMLzLKAP5G+xfsbBMiU=;
        b=HH92uh6niYCDXE9jDa9scs8D4oS/3Ezc06L2b2a6IorV5gZilNpXZd0S/2EY/KPrco
         NJwgdx9pHgTbdOkK8L+nZSbBeNUhFFdAPEWiZE5qUO5mD5zkn3IdHB/vevw7pR4xic+y
         aa3LnBT4Qgb2x2KpYbxrt6rY1ip8WC5pc/qVNdSmGCdBRzUS5dpHMzakOdL7IT9ITXsi
         3oF4q/yKVtyLyez5Rz9uakJinTqgTxgVQYy54zzfCV+L/Mfkbv7x+KIpjR2KvOfcFymn
         UkYCsp8pkDv4VaPtduncMOwuuxBmhpZ+XgRVt9NXJVJWvtcPHuKNDRQZFh7Nt874PGEn
         O5Mg==
X-Gm-Message-State: AOJu0YwKd2RebWunbEB84b/8hTxYfC76S5h8fz+nTAG6JfOGYoKUW0FW
	uyg+9Nr48UGBqmzzSk61eLTOhrgopAZgHWMOFeFTSHZm+1UfLZNNphCfQNniUtwyGvUA/uqCv3Q
	p/n6xCyo=
X-Gm-Gg: ASbGncuSOllD7I5xkFCf29KHQiDhFJBZeRr+/9y7Ky5SrNClFBWrgp4ZZCNmvLASRj0
	60PpPu88uQeoTE0LUNlPEgOO6QiQkGUtvXVH3G8OJeAhpx1pjkNz9Yhk7W8L1VBismFwSus95m7
	5pDrguynOT+1IHpTSybw7gKtq3XMTJi9lh+j8WguM7wPKZIPZLC6RjUJe6YIGRiY1kZOSPTYymD
	kvUKwW7/hz4nNKQ3nO50hk5lLc70dCZSP12lLIj34Q0GcytrdViTCrp3C91OwheOTJnMTQFvKlT
	2SmAKBjL7TCoxCVYFYBPA3pdsdH81sc5hyXxtVN7NK2squNgVnuXvyxR6S51jQwCauAWPgZEfPt
	LKLzOekldR+mcAPKu6PsGrYTV6KJrzi7qzhnZ/r8FaO6lfFydCeoiqWst+ji2kJMueaD5YgIZVJ
	7fDNB+sdbg
X-Google-Smtp-Source: AGHT+IGpoVfGLE6ayqDBinGSA8T0Qgz6rCdE95D3/d6SX1NXBSxgZaQBiBLkHjt9eoMpy6vxWPuThg==
X-Received: by 2002:a05:600c:5490:b0:46e:4744:add7 with SMTP id 5b1f17b1804b1-46fae33db7amr213440255e9.7.1760538741374;
        Wed, 15 Oct 2025 07:32:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 00/24] clk: Remove passing of negative errors through unsigned return
Date: Wed, 15 Oct 2025 15:32:05 +0100
Message-Id: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGWw72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MD3eSc7Pj8gmJd4yTz5GTL5OQUA3MDJaDqgqLUtMwKsEnRsbW1AEt
 mhXtZAAAA
X-Change-ID: 20251010-clk_ops-3b7cc9ccd070
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2839

This series removes the passing of negative errors through the .get_rate
function in the clk_ops struct. This function returns an unsigned long.
The only value guaranteed to not be a valid clock rate is 0. This will
also bring the drivers more in sync with Linux to allow for easier code
porting and other maintenance in the future.
Another series will address the calling of clk_get_rate and associated
error handling.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (24):
      clk: meson: Remove negative error returns from clk_get_rate
      clk: sifive: Remove negative error returns from clk_get_rate
      clk: armada-37xx: Remove negative error returns from clk_get_rate
      clk: thead: th1520-ap: Remove negative error returns from clk_get_rate
      clk: ccf: Remove negative error returns from clk_get_rate
      clk: at91: Remove negative error returns from clk_get_rate
      clk: renesas: Remove negative error returns from clk_get_rate
      clk: rockchip: Remove negative error returns from clk_get_rate
      clk: Remove negative error returns from clk_get_rate
      clk: starfive: Remove negative error returns from clk_get_rate
      clk: altera: Remove negative error returns from clk_get_rate
      clk: uniphier: Remove negative error returns from clk_get_rate
      clk: aspeed: Remove negative error returns from clk_get_rate
      clk: nuvoton: Remove negative error returns from clk_get_rate
      clk: exynos: Remove negative error returns from clk_get_rate
      clk: imx: Remove negative error returns from clk_get_rate
      clk: ti: Remove negative error returns from clk_get_rate
      clk: mediatek: Remove negative error returns from clk_get_rate
      clk: owl: Remove negative error returns from clk_get_rate
      clk: tegra: Remove negative error returns from clk_get_rate
      clk: adi: Remove negative error returns from clk_get_rate
      clk: sophgo: Remove negative error returns from clk_get_rate
      clk: stm32: Remove negative error returns from clk_get_rate
      clk: x86: Remove negative error returns from clk_get_rate

 drivers/clk/adi/clk-shared.c             |  2 +-
 drivers/clk/altera/clk-agilex.c          |  2 +-
 drivers/clk/altera/clk-agilex5.c         |  2 +-
 drivers/clk/altera/clk-n5x.c             |  2 +-
 drivers/clk/aspeed/clk_ast2500.c         |  2 +-
 drivers/clk/aspeed/clk_ast2600.c         |  2 +-
 drivers/clk/at91/compat.c                |  6 ++--
 drivers/clk/clk-hsdk-cgu.c               |  2 +-
 drivers/clk/clk-uclass.c                 |  4 +--
 drivers/clk/clk.c                        |  2 +-
 drivers/clk/clk_fixed_factor.c           |  4 +--
 drivers/clk/clk_k210.c                   |  6 ++--
 drivers/clk/clk_sandbox.c                |  4 +--
 drivers/clk/clk_scmi.c                   |  4 +--
 drivers/clk/clk_vexpress_osc.c           |  2 +-
 drivers/clk/clk_zynq.c                   |  4 +--
 drivers/clk/clk_zynqmp.c                 | 40 ++++++++++-----------
 drivers/clk/exynos/clk-exynos7420.c      |  2 +-
 drivers/clk/imx/clk-imx8qm.c             |  6 ++--
 drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
 drivers/clk/imx/clk-imxrt1170.c          |  2 +-
 drivers/clk/imx/clk-pllv3.c              |  2 +-
 drivers/clk/intel/clk_intel.c            |  2 +-
 drivers/clk/mediatek/clk-mtk.c           |  2 +-
 drivers/clk/meson/a1.c                   | 10 +++---
 drivers/clk/meson/axg.c                  | 10 +++---
 drivers/clk/meson/g12a.c                 | 36 +++++++++----------
 drivers/clk/meson/gxbb.c                 | 20 +++++------
 drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
 drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
 drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
 drivers/clk/owl/clk_owl.c                |  2 +-
 drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
 drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
 drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
 drivers/clk/rockchip/clk_rk3036.c        |  2 +-
 drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
 drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
 drivers/clk/rockchip/clk_rk322x.c        |  4 +--
 drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
 drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
 drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
 drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
 drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++----------------
 drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++----------
 drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++---------
 drivers/clk/rockchip/clk_rv1108.c        |  4 +--
 drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++--------------
 drivers/clk/sifive/sifive-prci.c         |  8 ++---
 drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
 drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
 drivers/clk/stm32/clk-stm32-core.c       |  4 +--
 drivers/clk/stm32/clk-stm32f.c           |  6 ++--
 drivers/clk/stm32/clk-stm32h7.c          |  4 +--
 drivers/clk/tegra/tegra-car-clk.c        |  2 +-
 drivers/clk/tegra/tegra186-clk.c         |  2 +-
 drivers/clk/thead/clk-th1520-ap.c        |  2 +-
 drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
 drivers/clk/ti/clk-divider.c             |  4 +--
 drivers/clk/ti/clk-mux.c                 |  2 +-
 drivers/clk/ti/clk-sci.c                 |  2 +-
 drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
 65 files changed, 290 insertions(+), 290 deletions(-)
---
base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
change-id: 20251010-clk_ops-3b7cc9ccd070

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


