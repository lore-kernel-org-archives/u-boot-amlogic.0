Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3FFC2BC81
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.81277.1718697336320904511
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CAYVDo5T;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4218008c613so39065735e9.2
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697335; x=1719302135; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
        b=CAYVDo5TJPTJxouZe6laWKu1vUGCctHIAwjNSqRNChvshhz9MH2lbY6G2Q7Ybsbidf
         fCCaWpyCxqbScbzEys+pyjJAi4KdKlheOPuFiGpRy4NdhpHlmIW0R3JJPYCI/32jyLFS
         Cq+d3dQqou0/dpCDVhwjqq+DxTb0B0YS9jnca5n3vBhSe0iEOe49tiy7XRs1uBNOZDt9
         gGcJVKNj+3O88Y6bje19dknUPoqkeztrwah9PRYk8YKraokwRw1V05tuDbg+Xyq+NC/i
         XfgPCpjZJJq3pMJncLZNtIdUVXTU9xqeyTyKzv9CsUn4RdtzJ0ssSy7LA1CVJXoIiU8O
         4r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697335; x=1719302135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
        b=T0yvvP4tcrpfmX6CCDt4TLcgMyM5S7/TDWv4jJc3s6DhZRLP4OcqiksgmMm0/deVkB
         frogLUQRcPo6vkyKJnDrNuVPjm/qRjxMicN3szVpBgV89Dj/E22yJj1wAefY0/KHcXvm
         wmo1mYOEmDlafV9UrP+a1AgfQrEFL+Kstc/xa2mzWu2BE60MwHdVCZUI+27LSB0wl0ww
         I+TpMbugoFO2an9adwO9UnY55UZN9fWF/5tASyMU138b4lmCdzq7kNMfXUd5dgnPq50I
         JPtaOcikb2h+dV1kf2pzpjv0tirVLUI80cHhJWwflUV/ZO5ttfVgRR/lmjjGBMnBg8+Z
         b4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUU8FZKdvkx3MV+q9vR+6gqN7E7pgSB6RR+oZGck9xq7dQ6K6BM3a605uRLSEfCCL1gtSxtyb1XXxouNtsOYEC3bGmkYYS0zGo=
X-Gm-Message-State: AOJu0YzfgBeDA6izwASgwcMWPqET3H7P2FXx6cUTL7yZjyKyDlF+FHWy
	1bP4X99Liif/5eu1+ev1LlnGIuaxZQ/odGJvdCLPtE04LXQp/zeEEpTnZMcGibo=
X-Google-Smtp-Source: AGHT+IGgqUG7sP8eLlYehvCK2UFjvdy2yFdExOWAWaCfWihj+2/4ZTMOcaZyEEwA9G6aPHlCx9ySPw==
X-Received: by 2002:a05:600c:4213:b0:421:8188:d394 with SMTP id 5b1f17b1804b1-42304827504mr96861035e9.12.1718697334722;
        Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:29 +0200
Subject: [PATCH 5/5] usb: dwc3: meson-g12a: drop usb.h and make
 dwc3_meson_g12a_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-5-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PPsS7D8TEBBrAwE0wIAH2nzaqsk2E8ByOhmeHE8CZe0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xcC3qXrhLwUmGIga3U/hl9c9wRXnwaefc1Gv3
 uhiBmLSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0aLAD/
 9Fpl0hd9IOOyEtmNP8iTqTKddD3QniFiZsTNQt+83sj+OZgAZfb21yaiydD357FC5Dd+Sr7TrWyChC
 mG3bQG/Nn4quioVjmmAANjV6pTv4yRavTt8UhXxLCB8WsKFqIy2D+BR7+lT4amYOc/fiYsvppBcN/L
 pYQUk/roMFEEuHC5aEDuai9icGOPxXxEcfhRUcu0UpiLWlpLbaT2GcYGz/rPEV6dP6SYFZAZpcojTX
 QTUhaAC/Ew4L/ENGaqeVhK7W4JISrrd4rK07C5pJicfxYLGnhGRCsz4GzDh3DD6GApgghgGhDgWUxz
 0/MIrtqqTXbyXQimKuLKIPiJn6frbNIYoTlCANJ9fvEi2tadBMQI4tTbH+X1sSgJQiLRYoJ1aXTN2q
 y1Pi4eps694P2DFWLNA/GwPaHJ57rldoj5s1vmT+53lamXXea9H3OR6ucXDnQjID8nNxylYeUbqaZt
 CtAAq1HDdF4+yMWpkUDL0YGBKEHAQlwZD9fouQiOmifEAm/B6w1AFMRWJZhRWd+rA4TQdMRNXEQpsv
 iRRq9Cugnnibtr22jNacJuOR/J4qqZyhrD+4zZErWgeCx5oHdsM8pd2cA7l6fJhFJAzES5NCfGxiuD
 Mg/w+rmSpTa2uJtooHjDs4axd/oKnFFpqmUFVkuh6yh3IZ7L6t/4dWF1PzVw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2303

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


