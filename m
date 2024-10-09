Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9FCED25D
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:29 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.11911.1728465327222325785
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 02:15:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=bxbfz6qj;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cdac05af9so6066532f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728465325; x=1729070125; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZLum84mjuCXiydoHw4h8lxl3O2fj6xHhIlf9mM3a+c=;
        b=bxbfz6qjPVQ0dgsGDP3XYDuBMA/EDkrJt1xN9dSQ6GuKbze2VPZa5QoQLKhwp20EMg
         lc2PTyDhZHp7ergl2tRGIcy+kK2hF0NAr0qalK8YzXA8CBJ/8DNXwbu5esbbG/9fp5L9
         QlubtuqTQ+H5xJVJDnKf488RGmM9pPOsm5cL5WWaUcfXsMTWFYLxpeNpZQ8ytu9JW3oI
         1eNhd/7IMkG9UpY/YORiPBZ/oUvjtyb/BdmXKjBR0BEbMUSrYq0SeiW5l/+AXopR0EWt
         svvW62PAav/h5zT+MmRpIIDoqc+kbkojMoJuJbxOl/BoX24RezvgzJDv+Js3PwwWPJZD
         KdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465325; x=1729070125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZLum84mjuCXiydoHw4h8lxl3O2fj6xHhIlf9mM3a+c=;
        b=TaJpMySsPNyIYtFF6Ze0RL/yLUwHS4UV98T/OeDs9gEuITxnJpO3sWKfxtJMR67nps
         kRVdjeCb54zmzxfL0hmebD2bWQpf6O9OuRR2EMhuAtoFcNPGgMDwJ0rZN0Tup9Uzh8hr
         gOi82aq7bBYSke29y91VPpG0UU6IwdjPWzBkPE1mN28qi0L14lPUZ3etHWZ/8SrP1a3b
         gU6pWR4hI8bQEYduBVcDfhBGha7F+vgq6iBWMw7HxclMqGuM7CbdgBnZS7yjOCjsxQZl
         5TlylY1DE2yBF6Kwo2unJi86tbk7tz6peGGnu2dlJhJmeT0eEKCqRSuv/10baQiyPjfy
         BtsA==
X-Gm-Message-State: AOJu0YyacPg9pepebFJNFAfc0/2JaaJgVuqNo8J3XMmYaNfMzz1Acfb+
	TiAWrG4hCnGS785J5hhJrpPxpk4tGTSajwuQcCGy0te3RxqWSBWBafsIceKvSq8=
X-Google-Smtp-Source: AGHT+IE4V/4yjBMx5z2FThtsn7aA0j5mGIoFWUo1FjKofaB7IKi1yNybj2lcHnybg4Ct2AiruhiWEA==
X-Received: by 2002:a5d:4ed0:0:b0:37c:c4c0:9b78 with SMTP id ffacd0b85a97d-37d3ab01196mr1380824f8f.48.1728465325498;
        Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f270sm9865471f8f.21.2024.10.09.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 11:15:21 +0200
Subject: [PATCH 2/2] power/domain: meson-ee-pwrc: make sure to not enable a
 domain twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-u-boot-topic-fix-hdmi-v1-2-2479cd90c4ea@linaro.org>
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QqKlaNG2u18NoqfXoFDLKgPkKwXjhg4sGwQNKuvTmI4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBkmqWfTejNYWz+pX3trg035RyATW0CdSse5185t8
 lgwI8BGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwZJqgAKCRB33NvayMhJ0SAMD/
 9k6AAs9pzV5z+ZTr4itQbqcsERUNbvCPdpaSUZ+JfBxDbj7liKjs0EGKqxwmTf3RAgeRGX244ONbnA
 hNarb56pOAolU/68NNNnVwDWF3J8u7MaybglY+YsRIbq1CvJ3Y2Pir9uHRN6bcPBvUOb5NPlTCgp6v
 qT8M3tc3+eiWZbR18y7EiurGcPVWkuurIUASRzW/Hwuc7nmcvklHykP2vyXpzFvFWf2VfMl/olLAzJ
 d34CDA/m2nKUVRCiHTP3y2kOOHZN7k7zjBX81/mkv/wkmtcgddcCPWkvylvOPU4wMB37FGINvsOeMc
 isGSl70+qWAFRARRMXcd/rP0+cRGQSHdOI0/nX9yH/PFjXciNVzA7IlbOXmzjC5TEoWUAtysE596FN
 Nibd1PkRX1hY3kmbSHjHzSFV86CfhWJa/bbdrofY7UJ1KRje9tUWsQRLguXxjBO9lgRpSxARzG9Pc9
 HkMdhIBUpwGuIFNBjrL9ou1x9uLwWDTvzVguS8bsfztGlByZEsi6/QavhpgoEuFzGA4Klr9a2VAvSv
 nvOwc+C1ynFZB92eRV0/hzUPt8GAwFfFXjAxaNoU0StIm42i3mjyfFVQrWGzY45tqALSH9gxjLCWry
 xAzYx3gInkjbgP3ovEHGQ8VBNBHKzrUvf58hEr0C+lfJM9LiE/TQWpVKfnIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 09:15:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2436

The upstream Device Tree for GXBB/GXL/G12A was updated with VPU domain
shared between the VPU and HDMI node, causing a double enable.

Simply store the enable state and avoid enabling twice, fixing
HDMI output on all platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/domain/meson-ee-pwrc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 20e9f32b381..4d9f3bba644 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -60,6 +60,7 @@ struct meson_ee_pwrc_domain_desc {
 	unsigned int mem_pd_count;
 	struct meson_ee_pwrc_mem_domain *mem_pd;
 	bool (*get_power)(struct power_domain *power_domain);
+	bool enabled;
 };
 
 struct meson_ee_pwrc_domain_data {
@@ -306,6 +307,8 @@ static int meson_ee_pwrc_off(struct power_domain *power_domain)
 		clk_disable_bulk(&priv->clks);
 	}
 
+	pwrc_domain->enabled = false;
+
 	return 0;
 }
 
@@ -317,6 +320,9 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
 
 	pwrc_domain = &priv->data->domains[power_domain->id];
 
+	if (pwrc_domain->enabled)
+		return 0;
+
 	if (pwrc_domain->top_pd)
 		regmap_update_bits(priv->regmap_ao,
 				   pwrc_domain->top_pd->sleep_reg,
@@ -347,8 +353,13 @@ static int meson_ee_pwrc_on(struct power_domain *power_domain)
 			return ret;
 	}
 
-	if (pwrc_domain->clk_names_count)
-		return clk_enable_bulk(&priv->clks);
+	if (pwrc_domain->clk_names_count) {
+		ret = clk_enable_bulk(&priv->clks);
+		if (ret)
+			return ret;
+	}
+
+	pwrc_domain->enabled = true;
 
 	return 0;
 }

-- 
2.34.1


