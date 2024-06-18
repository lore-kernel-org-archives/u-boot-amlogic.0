Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63AC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:41 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.80798.1718697335545723443
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iHGc9JKN;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421a1b834acso43915165e9.3
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697334; x=1719302134; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
        b=iHGc9JKNtlNpMHajBqHrAeXIfAGtF7uPTEI+OfCRGAcMFn6DZAJegb1+kZCb6aqq6I
         eV3EWzfp1d2b7O2es2WeuiFssDjqNmwRqfO43AyFFXcNDbGWxvn07AhkIZFRRL4ONwur
         nlbiJidLj9y4Pju43SOfPRGBdF4NvLXaJGICN51vl6MuQZ05ivaf8dlQ5fw21+tPUM03
         e1isYW/TgpdJVQqjXZzCqIy88K/0KtyRB7xgYqBfq9Yeu5R7kZTBv/LtYr090vsZWvnW
         US/vNdG+SQoeeuI+oht7tHb6omwWpVwLZBjD+UZL0rMArod85L7iCL1ssmEtXN0UrEBE
         Y1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697334; x=1719302134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQPN6Jt2rsPTvACxaljaQFZ6kE1AmkZWw/yLHFwcX74=;
        b=XNi9f0Gf+VBLljLmFxunwqd5O36/Er3wJN02gx5MxISPbVvxFLJ5qySPZBxisndKrE
         nwkzW024rvzIfc7eGDlw9bLc3mGxe+fTzSjCJYmLPIl7QoqQGVk6DzQq2IIsYfI7muRm
         hiOZX/Relri3SinOGMdsK8W+pEZJ4okATT9TOe+sSwU8fuwGMQmygjkJR3L6SS7/OR7o
         rb7CbkZyFBYsd8o82Ohd46QzIGnC8+CfyovIsxyc8ywsjA965pNzcWJHvzwosbuo4usW
         AbFDWIGhKvZp4Bkwk79Tx0/KOmmW1yMhrb4xD5rN0oxe7+z7bdftwN5uwIXpwvHfBqM+
         1Mew==
X-Forwarded-Encrypted: i=1; AJvYcCW36pft91gvnd8cvSZHuSspLUEPLhvPHE2eBZNdLTUk5HFTDloH8wLv4HAKchH2ZKgB0+N1zFroZVyLOzEOjVyclgkfbT+CYak=
X-Gm-Message-State: AOJu0YxLVoOlHZKL8anXxBumqJN5Ll0RXC5KNiHJMIAVGHc7zo7EZzWf
	qRZwRUpL+P8dmH5pVwQ1LYwut/L+AMcsg8QyzatuLnpBkPR09S4V6zDnRF8UF+8=
X-Google-Smtp-Source: AGHT+IEPDN6PjtSLqP42iWo+gUwiVk87IO2cKo2eOVXodr9s5Ut0Z72WFXpjZRcoJSvMvMQoAoHlEg==
X-Received: by 2002:a5d:58d3:0:b0:362:6cb3:c428 with SMTP id ffacd0b85a97d-3626cb3c4cdmr288295f8f.68.1718697334004;
        Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:28 +0200
Subject: [PATCH 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make
 dwc3_meson_gxl_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-4-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DpgZRKTgku+ys6NjVBIfERJR/6XmLyfT3EDY9DcHj8U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xoNuGVCdBygwOmAF3sQEiV3hiSjCtFJyNz7hp
 gQabkZqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0SaHEA
 CnPOY27LW8x/hL8/uPEsdYxaLJB5WcD8JkrAVNWR6/RiI6djALcfx51kRwyHMlWFVPslA6Yl0M6WKY
 mZQuOUX84uBbV5kTw9qhXd/FxApnvblZTawlmwl1gEQslSRYF9gexakvFDEPzsFpEheL1fqJhzL7Lg
 q5euNrgfd96JTLoHX5TXR6vWnmIjIKSm7KvKfjD6TJMDdMb/aNs1lrAeasldhJtwahBU39atx6i2d4
 7JU6Q+TpgTQDvhjhHh2wKsDG7HhKB3vbFmSJ/78h+HaQ3op6eC4RQTF1pyEgTDfhaGaxGcMN7JwzGh
 kzZS7M5i6WdikOe+PQ6Gq9/a0ze5a5DJrubNLtDId8uxWHv/NzWPnLQhxoRYHUjqO3ZV3FrA5ZOHdC
 03PW1in3jXDksmuZvyeE5lFkXDwKusL8Hpky/cDTFaXdBy4Byt00VkLIi7Msun4SLBW/xNT1bN4moW
 x/PP9FQ4XR36t88ZLDSHQgISbLuZsw7vTfAV1Tfqey09m6WHWd08rnRVe5B3eIQcotQ9dDXsO+oNPS
 fHNCPMBHK3xwrqZ0fnPBpbbCS2lh0Q2RC40TLQ8LMM2gAM0wQbM1h6p884NZKdFuuNRJNxq1sa689B
 b6xTAqXKRk4ijoQYalNEH7uIzQQUXhm9qaocINWg6g1NCjIQXSB+BdxLbgkA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2302

Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
static since only used in the dwc3-meson-gxl.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h | 14 --------------
 drivers/usb/dwc3/dwc3-meson-gxl.c        |  3 +--
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
deleted file mode 100644
index 966d401730..0000000000
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 BayLibre SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-#ifndef _ARCH_MESON_USB_GX_H_
-#define _ARCH_MESON_USB_GX_H_
-
-#include <generic-phy.h>
-#include <linux/usb/otg.h>
-
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 290ac03a37..5fb9b477ad 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -26,7 +26,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
-#include <asm/arch/usb-gx.h>
 
 /* USB Glue Control Registers */
 
@@ -193,7 +192,7 @@ static int dwc3_meson_gxl_usb_init(struct dwc3_meson_gxl *priv)
 	return 0;
 }
 
-int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_gxl *priv = dev_get_plat(dev);
 

-- 
2.34.1


