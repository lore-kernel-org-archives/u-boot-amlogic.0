Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF892C61CE3
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:24 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34716.1786984624262308419
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 09:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=arHjewB/;
 spf=pass (domain: brivo.com, ip: 209.85.160.177, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c16ac21acso22181351cf.0
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786984623; x=1787589423; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbh3UhD9Jun5V7H7NQy9EsrhNmLnzjp5ZYGAMDpVKmQ=;
        b=arHjewB/tLzs+lSrkGh4i3nsT/0Hb8riECw2D04W98MsCUbt3yFb5gfD7UAMil+8j1
         OTZgqw7oh+ye5xyHGychGRSphcLQx+YmmRRF0MDwEgAm6T9cJW9AZyerLFYg490hn428
         Mfq6l+i8K/QkZyLYhpwK14UwiNbJdlb8rD8o2EvHACR0WHyAaQswC0ughgCHhuIKab1A
         0tdAg2QHcOR4CW6tbNQXOf3gTraOpRb+z70MGbSm91iBmif0N9FV3Hx75dA7qrOWcnVA
         cYosSOjAfUVV4MStAFk1vOhTcPU6QCWkAoqdUBinpgIC5DNzf6w0XgadMfN7y7xtVwK3
         uKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984623; x=1787589423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbh3UhD9Jun5V7H7NQy9EsrhNmLnzjp5ZYGAMDpVKmQ=;
        b=dG+MdwrlNTdu7x4dRIYilcICGp/wq1vK8G3UmErYu9P21SmEVBp98hrPzlDshppEDp
         EyPxY4gGG3Fxe5UX3oADSaqjkER/1oReqlz5HlihGYgnBzebqZHa4IvYEzzg29+wCr+2
         yGlL+fbUfJ5ciGgaw/13fDO7ylBzhRMRNE7sWjvtZpsyApGTP/pTQ5RiKoWQTIwcRwq2
         /N5so5V1pcVHbjSMQGm7CgsxQRh2EtKYo+eKN5RWEqD7XSt1cW3RszjUcUI8nm8t6wjF
         +VFnGW4JOufnmCm8FgPErENnKN0Hq9ckxaNmDsvIPm9TPmyhJvFixM5vNWu2j3dL6/2h
         INBA==
X-Gm-Message-State: AOJu0Yw4L+t6JO+aE0eTDFD96uLRlRHcDpTXaHEhwbQnDn19mm3gkwIp
	p1FZOXXCTTMb+PNg4DGaQkZ6nzEU4LzqOwBHfeinp0Mby1q3PpSx/+Y6y81//kU8vfy6cuwIwd6
	jKEGAVdrOekweC6gmiPl5tx0n0EvyqnrjJnUtFrWSDuzK9g+dlXnZIw==
X-Gm-Gg: AR+sD12kJACfn79i8C1iWOxoZgMH1ZuLx/z5HfAnFG+cDITRrZ2/3nTk+ctuBnNcuhO
	JnqQ8ooKRx6uJn8g03WK59J22fZAAiQOYy9LmaerPbI26/jaICC6k+IdxDqraI9Wbe5Is2b7Nne
	/fExRk0NwISY50dgOfvdxuqlzdpI9P119XAMRzCo+2RKvUjnr4GhVYrFdcfJLfO2LbDpPkosnrB
	1Kh4/dd1wmknocw/bxm28NOS7vchBiRrmjBZtxPaNhHpl4df42veA4t5PAROOp9odHqT9hpbcna
	Hk9XgtIJcb7vyqZUt9JKQIG2xIE/vA16ccSss/IgrPK/0OcJWeTjgg95lkS0Cbbq9LiQz1GpwyL
	pazMU2wBoQilMKlCFCdWSLESKK9CZG9TsapF1f/OoVvuIue/sfXUbA+VC4MAx0zXl2NwDdzd8zU
	2fqtsIAjbm1Co5bCob8uBdDMGXv+qhL8euhMbojES/AXL/dvnGZecbSfzFQas5eCEG07xHHDV2Q
	DUEdTTdASdwiEaIvVZaCkD4jFLsUHQ5irMitw==
X-Received: by 2002:a05:622a:342:b0:519:8998:661b with SMTP id d75a77b69052e-52d85433854mr270381511cf.20.1786984622846;
        Mon, 17 Aug 2026 09:37:02 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db623bfb0sm17882451cf.24.2026.08.17.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:37:02 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: meson: Parse devicetree properties
Date: Mon, 17 Aug 2026 12:36:50 -0400
Message-ID: <20260817163652.1893650-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3025

Parse devicetree properties so things like max-frequency are respected.

Upstream-Status: Pending
Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/mmc/meson_gx_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 76af3873e15..b5b4e60d8ec 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -351,6 +351,9 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->f_max = 40000000; /* 40 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
+	ret = mmc_of_parse(dev, cfg);
+	if (ret)
+		return ret;
 
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
 		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: meson_mmc_dt

-- 
2.53.0


