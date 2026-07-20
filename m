Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB8C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 07:30:19 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1998.1784566018773391990
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Jul 2026 09:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Oj8jS0st;
 spf=pass (domain: linaro.org, ip: 209.85.218.46, mailfrom: casey.connolly@linaro.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1670dad7a8so1051936866b.3
        for <u-boot-amlogic@groups.io>; Mon, 20 Jul 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784566017; x=1785170817; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y25x447Guht5ADrFC/WcBLjjXlhddC1R3nrVIl22w6o=;
        b=Oj8jS0st79MVsmqHN6BjGO38TZR7kRGk6r4OV8w/4u3fqF7Z/HJ8+Somy4mzFu6I9X
         7iJdACGlLViKFSPeuVfIJTDFfofLXUAdtH2wSkq7CHccz5+ik+11AZRF1DW6wZaiJHZR
         vSkDf3NdHz+DS7XEjiB/jKZZT1ppj3Hy/WjUyu4gAD4bVpI8U7r78LlURmvGhfq/aX1z
         WgI8qCUnQHrFoDUBYwX9+Gaq/vPgo9lbTQJEu7vMdRzGkVQwulg6+qTqJ4giiHnyJBhc
         S6V6BdLYMLIlOhn4A8Ho1zfNtknq77IKRCYfqzRYzNF4Gg06/KWCtOj8Pmas0sszFub2
         tbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566017; x=1785170817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y25x447Guht5ADrFC/WcBLjjXlhddC1R3nrVIl22w6o=;
        b=IQzByacc4BP/BK/yjcoi9p2kkDuoOowAPk2cesC8XHj5npy713sJaLjZ8eX7GSHCP7
         ZipQIzWLSwxpGBR6ZxfF+d+3JOEuWVisprRh9ieqkE4jOOhvK96A9M/olE/vkh+/wZHS
         XwXC49A34irC+obyVQ90A+vLObtpg5uxwST8rqUp/ZdOT/ypqOhvuOZuON2UCzmwQVXv
         7YFZxnxzs91OJyZrZr5rlGhKRuoidk7+W8h5TgzWkuxFAqfH+89TSKZGzolKSfyiw2ap
         +ammctNh1EPeI8G33bUP07eEgxCzubSnTgfFQLjGiNJYpoTHq0STeYfdi2d5JUbT8ClC
         GsEw==
X-Forwarded-Encrypted: i=1; AHgh+RqRAlwGw5FYSBM8cqsYHh5eViD421y+rfd5AC+hP530r2iy2ObQtXSdnaK8YJr1vIEPILurp7yR5F2uy9O5KQ==@groups.io
X-Gm-Message-State: AOJu0Yzow8XULLuV2KbPXZcBbfuWv7qYQDIQVkR2HtkO3825guYZcKSS
	WhieK287l1wjpfJx2c+OKWbgaRviS5DmiO0L18b8a/lJP0V8+wiAUzsKlNR+6fqP5BFqjwoLlOr
	YN4A7ROo=
X-Gm-Gg: AfdE7ckslROjq41gaBh8PU6DF95P7i44GEkF4peJmr8bRsCPq8eNMIzGxRzdeg0KPK2
	pnukpRf5CeKgpIJgkmeSpXEDTLpAckAZiZ5ukOY4US9uhc8d4ut7FcP5WUvukLJt46JSzLQlwiz
	28gKv8pq66yYdfilX3vjj0ghWtTwP8UrIzlWPnGPz9YXCEg15GIBNLvligrUEvPK3CGjROXDgaR
	AqmitQ353Y3SUhKerB67yaqWIOpuRdyiKIdsvGm3cTelA9r5LMew7swGhi2zbeVtqJj6qua5pC1
	MVZjdvTfjZrHvAsHEJFPTA1vcq03zh9duNyUgzF6Cz8Gu6a64np+eyhluanEFNkruYn0QWAR7P3
	cHEJ3XC8xw0HzwAtp/S7bG8IWZW2xPNmWxnRUPcYpbuFhT8+cBn1nLoPhvF9Ao9uXc9a3ImoB1t
	P74dxI+qp0aW4CBvazj1Wuu/mT5YZOZA==
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4954a3dc7bcmr184999985e9.16.1784565660734;
        Mon, 20 Jul 2026 09:41:00 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:41:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 20 Jul 2026 17:40:34 +0100
Subject: [PATCH 07/36] dm: ofnode: fix parse_phandle_with_args API
MIME-Version: 1.0
Message-Id: <20260720-casey-ccf-upstream-july-v1-7-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VkqFoCA+I49phw4ZN9BG/jLRlqnUHdmYjTVV5RWV5c0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AmUZ+xt+bfbv5CNqttCYh3sbJcI+HehBYo
 v2Xw9jvYqmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 trg4D/9rZG2bvRA1/1gdHsB6lSgv2RMGnFZd7U/oc37uNL0dZWPVEZ5fu/XHzsNOF8gHeDqhRcl
 kDE/Zx6tStNoBnilbUHplEkWTcCtbGRrtBThTkgkyY2Q6+6pqAklGiRVlZEsNeQAmb4jIvcBp7x
 RZitkeh6Lm/qmO/SAhKUlHHHnaysrbIARGJv3TZSUNaL2zr/hFbkAeeFxerRCx/cSmRlAcg20HX
 FD2BeLpDv5pdJWhUdSOHeglRA6iUF9oEkLz8IVbM3xkzE/y0NJcj4Ii2u71xxVT/9auINkWO1d9
 DN8+LLeFct4j5P22Wo0MizCoSjFgwjtmtdB7G3nAorLhuJxTbEVxLen0X8HuYdgCRvTHbtFoZPD
 jvkPjMutNgkdT4gfLexWUWrabHT1d7f0SDpVT1HddTFGT/x4mauCAuRxk3S/AQZXfx5TGLz+yb3
 QVqz4KEoj2DEtD1qN3MIK01xGMVhCKHXo2xYu0iDzcMTGcorUScTsOtcOnebQxHot/wcqK3OUYr
 Xwxl6wgQakbxDNf+w/hB+0Bi9TxEuuMpaRzpzuqH1/0M7L+dA7Dp2KB1UYmMl68r/iTZP2rR3xI
 dY6O1yFMzQU98FbOI4O8kTzd3/TUyAGFrH4QgCV5DSLquCskJLQDkXsWh+GSIccPKBFtQRZx2dw
 YV2ZIwChQ8d9IlQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 21 Jul 2026 07:30:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3012

When not using livetree, fdtdec_parse_phandle_with_args() is used both
to parse as well as to count the number of arguments. This means it
returns a positive integer in some cased (based on the index) which is
NOT valid for ofnode_parse_phandle_with_args().

Fix this by ignoring positive return value since it still indicates that
the phandle was parsed correctly.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/core/ofnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 1388b4810317..b82d48232ec3 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1069,9 +1069,9 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 		ret = fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
 						     ofnode_to_offset(node),
 						     list_name, cells_name,
 						     cell_count, index, &args);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
 	}
 
@@ -1102,9 +1102,9 @@ int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_na
 		ret = fdtdec_parse_phandle_with_args(tree.fdt,
 						     ofnode_to_offset(node),
 						     list_name, cells_name,
 						     cell_count, index, &args);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
 	}
 

-- 
2.55.0


