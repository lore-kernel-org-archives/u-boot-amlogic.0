Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E09CC2BD09
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.42409.1718869392567007803
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=mgdB0JVI;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42172ed3597so3327285e9.0
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869391; x=1719474191; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
        b=mgdB0JVI5FJf+e/8EmZ5KV0RT3JEmXu1owgoTSiixi0ulokBer9fcglVPJszVdRxwj
         OqjWNYxvclHuUfAwvBlkcV1LJ992D4nmnyPOE9JHYeNjYyLQUosWAJHiSJVgiLPI+0YX
         V4kiyOAQl+B2+CiUTZofv8/kim9GrP+TXFAzmuhLcDG1zrGitCjYV6Px2+HFUOitpfUl
         nYapSD0G6SXp2uSw0KdrJ6Xvx5US4++xRIQUytxujhjGdHBJamR+jDf6YF5x1tB48dMh
         gT/aO4tuF7PG2eLwRW11dQOatPOPrOsbmRGDcVUm3pRj9AsGWElbLw/NNsGtk/8fKaxZ
         w36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869391; x=1719474191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
        b=qw8d8GYGwEgUAeVU/hHYNTtDwwumw6f4aKLu+nZLxmxLQ3G1+qQw580V0BoSaA+iW3
         P7z1rn5gHVHyUDl8Icrb+LU7BH1WQV0ev3YcVLUxm0h1l6e4pP+ubpPj9EC+Q1JRzcr1
         G9lh/a6V3GXNDOGbziM2+TvqPFGMa/6hyjNGEivxvz6119gBvqchAdjD7gJEkrtVfOHR
         DzaYp9ZaIsI5FL6sFXzDWE7g1sv+obFSVQ6PkiSsZtwVt/WmPuqV5Q72D9SNUAEd/5dA
         f4htLTzmCPntudC+pzPO6R1IozicYyOcs3DTY2Z7hYaz6yy4boKUPTjBGZy2ZVAhMl7r
         kkxA==
X-Forwarded-Encrypted: i=1; AJvYcCXVVMlC1vyx8Oz6dcE6ORyF/h+R1dgJ5QdGdD1TwM45w2xYISS7YZmyV7nl47+H0yZ/U5B280eIPjaCYEbjV+3T2vXKZu/EYwc=
X-Gm-Message-State: AOJu0YwjpYUUSvbqeI/xPoZSX+WNgf2ViY4ksRNoFcrWSziFP/JD19iR
	Cx4k06GmYyWSWpSkV1ndghli4Vhs47ZsqiDmU/GHKtI8A1mp235/rXteRPbidfUUH9eoOj/IyFC
	RSoo=
X-Google-Smtp-Source: AGHT+IEGmXXCLRE0wIeqVva/PbicdFdi0ND5xfg35chbg/wgKI7N8ynPFgYgL7TPSbKqEyzWkiIOtw==
X-Received: by 2002:a05:600c:3b28:b0:424:74e1:bc8a with SMTP id 5b1f17b1804b1-42474e1bd31mr44712415e9.4.1718869390492;
        Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:54 +0200
Subject: [PATCH v2 5/5] usb: dwc3: meson-g12a: drop usb.h and make
 dwc3_meson_g12a_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PPsS7D8TEBBrAwE0wIAH2nzaqsk2E8ByOhmeHE8CZe0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92HfNlRi7QBrHfVN9m40l8RHlSxj7RxPLBLHp+k
 nYMdQTOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhwAKCRB33NvayMhJ0dmXD/
 0VL4Y54gWzklgeBI4nP32u4eiXofOvQbtxpwI0eo0xQyh4bP4kr5wQi1hACNqGGyz/pwHAXEs50xoy
 kt62JnEQP9taPwJq5VIxsUqc+wMspggjlUNcIpFayuPXxOn2vrxCVtq/+rj4Xng3tN28B+siOxHUmE
 82vf3+9CPXmIWMURcyCa0uwsYmPAcPAMr15y248FF0aFmE9b5bYNVmyT8ufMAEFh9l0mINN4p7Sdot
 XE+uZVjNWcKd3D7DPABAq2v2WQ78AlGq+1/qFzG0Mo8Zvfe1MnImQHvHbQ/OYBQpATRggcVktjbZZT
 dB+qeXq/mJuymPXYk+lCa5R6yBC598I17JfUNbgla1ngvN3XqHs7gzIVnAtC+a1iZAo59psHOApenb
 zWbKOOMkoLLTfrh8sbOP0vfcjnEsoKAJQAZV0jjV3MTkXJg8IAio571Pi5q8EljfpYaaHBwT6riZXW
 A646hu2KTGltgwDDbKWw4i/5htS03/CjhZJ99mzRWu6MRj00nhW3AfK1p+pYn/Ly+8ZOzOD2TKjEHb
 eIrMbGZKsV0gmeRDj6IWf+r0V5C1v/Z5b4Df+4bnaxh61X5tT6H3fqSOkgJrIFbIyxKyOWYhFdq2OB
 yEONSFEmGSUqgsU48bCiJrqNwUQQSAto8Rm4o6fpcCWY765TrJ+CPhNnZQbw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2312

Drop this useless usb.h and now make dwc3_meson_g12a_force_mode
static since only used in the dwc3-meson-g12a.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb.h | 12 ------------
 drivers/usb/dwc3/dwc3-meson-g12a.c    |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb.h b/arch/arm/include/asm/arch-meson/usb.h
deleted file mode 100644
index b794b5ce77..0000000000
--- a/arch/arm/include/asm/arch-meson/usb.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2019 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef __MESON_USB_H__
-#define __MESON_USB_H__
-
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif /* __MESON_USB_H__ */
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 21e4f637bb..41d15996e5 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -270,7 +270,7 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
 	return 0;
 }
 
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
 

-- 
2.34.1


