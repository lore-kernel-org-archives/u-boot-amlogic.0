Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C8CCF9E2
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:35:45 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.18558.1760539076771740551
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 07:37:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=lrdkUukQ;
 spf=pass (domain: linaro.org, ip: 209.85.167.47, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1341601e87.0
        for <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539075; x=1761143875; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tWf4K5nfITc9L+EnRjgeRkZmPVpS7I4ycWja9HuwN4=;
        b=lrdkUukQ6v2G+NpfmLrZam7GgGe7K1HSbydztuzKasA692+UYHE1pGqO22z6OPGgHU
         4pGhRi+TkW4zrHVmqeTFmBO1tWVibMcQcgfsVjhYW5nyzTMBPAi4u6IH4WvIE3sHLklt
         Ylo00JyA6BqCgJTvAOBm8uPbHgR0p+rjDYq7yY9KrbAtcZ3/zMglKxWCQFGt9j8wZCvw
         GngrgxClUanSE850SFwTufvaMw72dok82NBAQ2+57uQ+QadHsIlS/T4pNcKUWE4qCKCv
         iim0e3wYwCwY6nCLN+RMH8+RO9W7s190e4ZOgGoNmx7h+LSVtChXl2QXyISEy5wMk4aT
         2PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539075; x=1761143875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tWf4K5nfITc9L+EnRjgeRkZmPVpS7I4ycWja9HuwN4=;
        b=kAB5iVn4c4ReB1PBGxSKEKOWzfkE3fOu0bhYTK+OyjfNxX9G2I9P5+DxnhH48Oz2pe
         qlig4Qczzb4YNBdIU80R6556OSgq9Un8NYjvsdQZXXsPJsyj2mOOTuw7f1YW9u+IPYFw
         GYlbDUVWTutWnsgrTFqLDbP/No2GRR+EeGirLbRVFUWU+6nwYh+w59Td/ipipprDgiGh
         lptns+cMKxV+TnMKDycCRG48k3yHjxsN4ZQcVUPqmYYpAjbsdV6xI+gy4x6E0+ECEOZd
         ORM0uP8QVm7cM46CJ6WyXWOy5FqtC4vcs2lQ3jTnqC2XDdz1xqSIZ+1U95JvI1YlwUgj
         Diqw==
X-Gm-Message-State: AOJu0YydcIlLnQ5vD55Ys1aNSjasOk4e4O46xDAWpqfHV4fiajGw05dt
	lWPDmw5jl9T2pKDucFUO5LhWTnxKLNOdPmn6+D05WM4ndqXYBKcMYJ0HPxxcBBCpASnvEy78CKK
	6JyiiwXs=
X-Gm-Gg: ASbGncuKWCyzwzIH4+EvFIFUEZJoGkkXP8lsEnmWSENRV6ErxoY/4Uay+Ob1xxPKPs4
	FG3Xix0226CffXFgSUd4XN6pa40lEDd4ZlxR+PvNgxkMSqFmQpqNZoxmPm1FwXHRl7ZclUczbCn
	2dC3FWBJAG044udgiXr+KhwWIT7bw5YVv5q9K6aulekGyb+0uVNsKT52cNP06InIOphL4z7fr9l
	59fV/CFe6nIGmCU8Gsu16gc5d90Qj6oextmkOmYtetyktlD7ainyEQoWEtLl4HwUbk9LosPOLJ7
	Gu/vb547bcJEsO9xU9Fs2ws8E4O19h7xHBM6MG3hmn8Mum0XHV0czcpsBf5H+fRdXNLzoDoiNpN
	xgB12BIALWd00FAtMtKSGaOY86WHpXNWhLLQCaUjCFc7sU99L9QcfneUp/O4cI99W8TOyeyuIwk
	5tGmqoai+Z
X-Google-Smtp-Source: AGHT+IHBJVSDbhob8EQTtHJBQyTHlnrM8iU3P6RVY/IQeZmYdOCBqElQiuRq2B0zOuFibLaJVHxdQQ==
X-Received: by 2002:a05:600c:4e89:b0:46f:a8fd:c0dc with SMTP id 5b1f17b1804b1-471099212bbmr3743235e9.3.1760538756090;
        Wed, 15 Oct 2025 07:32:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:32:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:12 +0100
Subject: [PATCH 07/24] clk: renesas: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Message-Id: <20251015-clk_ops-v1-7-5f80f827407e@linaro.org>
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
 <u-boot-amlogic@groups.io>; Mon, 20 Oct 2025 07:35:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2830

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/renesas/clk-rcar-gen2.c | 8 ++++----
 drivers/clk/renesas/rzg2l-cpg.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 9b6fce4675c018ad72eeefe3939bacbf65ffc428..4cdcc0fe71946d3055caae3ac7eb8e36c0b9b507 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -82,7 +82,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 	ret = renesas_clk_get_parent(clk, info, &parent);
 	if (ret) {
 		printf("%s[%i] parent fail, ret=%i\n", __func__, __LINE__, ret);
-		return ret;
+		return 0;
 	}
 
 	if (renesas_clk_is_mod(clk)) {
@@ -94,7 +94,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 
 	ret = renesas_clk_get_core(clk, info, &core);
 	if (ret)
-		return ret;
+		return 0;
 
 	switch (core->type) {
 	case CLK_TYPE_IN:
@@ -112,7 +112,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 			return rate;
 		}
 
-		return -EINVAL;
+		return 0;
 
 	case CLK_TYPE_FF:
 		rate = (gen2_clk_get_rate(&parent) * core->mult) / core->div;
@@ -198,7 +198,7 @@ static ulong gen2_clk_get_rate(struct clk *clk)
 
 	printf("%s[%i] unknown fail\n", __func__, __LINE__);
 
-	return -ENOENT;
+	return 0;
 }
 
 static int gen2_clk_setup_mmcif_div(struct clk *clk, ulong rate)
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 7fce1f70d13805fff452b60ce6ec16e4439e28d0..ecdd6c6e52695658d032b805425480cf60a1be59 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -225,7 +225,7 @@ static ulong rzg2l_core_clk_get_rate(struct udevice *dev, const struct cpg_core_
 		return rzg2l_div_clk_get_rate(dev, cc);
 	default:
 		dev_err(dev, "get_rate needed for clock %u, type %d\n", cc->id, cc->type);
-		return -ENOSYS;
+		return 0;
 	}
 }
 
@@ -244,7 +244,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id)
 		}
 
 		dev_err(dev, "Module clock ID %u not found\n", cpg_clk_id);
-		return -ENODEV;
+		return 0;
 	}
 
 	for (i = 0; i < data->info->num_core_clks; i++) {
@@ -253,7 +253,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id)
 	}
 
 	dev_err(dev, "Core clock ID %u not found\n", cpg_clk_id);
-	return -ENODEV;
+	return 0;
 }
 
 static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *name)
@@ -272,7 +272,7 @@ static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *nam
 	}
 
 	dev_err(dev, "Clock name %s not found\n", name);
-	return -EINVAL;
+	return 0;
 }
 
 static ulong rzg2l_cpg_clk_get_rate(struct clk *clk)

-- 
2.47.3


