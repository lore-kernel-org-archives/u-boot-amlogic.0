Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8852BC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 09:04:36 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.27521.1701853467089570589
 for <u-boot-amlogic@groups.io>;
 Wed, 06 Dec 2023 01:04:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AZZqx6fz;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so266936f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 06 Dec 2023 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701853465; x=1702458265; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+1/0oUjz5rluJhR9RmqMC8xOdhAin3fsn5Iyog2y8c=;
        b=AZZqx6fz25BL2XvqDF/p4T+ywBznu8tiFUp5frArORTCZjJql62YFn6l+wn3DCqGQV
         WM4uRIfLMSswIcYB5NDK8tjW3BEKjhZjI5sFURjq2NBvJV6nD6nDmXN4+Y5U8A5e6Hti
         e9N8Pp8Lxv6L1xHVQJP4esC2EkkK+C+NGu7JZFOriFoAUQwJj2yKRC3zVqVxRFCIAOOn
         ed2yF7vy47u+pIexT08x7nAcZk3ZQrszTIBcnCVUOAAeztwRpzWHZv+lRC9Bi4c5vSWx
         FS5mUoMHXZSKlqswKjqsIxmLOLq32GDRAAskkMrOVAabuYPaQlQQABZNWfHek+rccayq
         0X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853465; x=1702458265;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+1/0oUjz5rluJhR9RmqMC8xOdhAin3fsn5Iyog2y8c=;
        b=Q4+iEtf/XjjFTsqOgU9qAuXaSkyli/INL3ynF1nG148dUG+iSo99zVPjg0S9R7mH7+
         h3xqe1SbKU4SV8Tt9zYD6P/o6/erklc03nfIKcQGmp2XFG33C82qip3HsJ1s4vkzyv38
         PTp+50yw3tHGVmdcyWpPvNLaGvGJK/JKlkr6HYwSukmyddLa5gdlBZcR7H27mSW6HoHV
         df9Z9D83XOIskAmMzpiUUMEdH9MFnwwLI40aNAsZ821Yq4KZz8gxomvrzXcCB/YHiJfu
         o69ReLVtxOce5osaDw7tJ0h0TEkbm8PTGpsC6sO8scLYbQ0JzHOJErLiwBvmJHlEsGZS
         q3mA==
X-Gm-Message-State: AOJu0YwIDOKt+105Rxny3+DiubY3cFX59OXFvwQzn11NFNkXJOQ/7fGI
	z6RwKnUH/enn5w+/hggQcom1KsOKrK3jwv8Yj4R6bzWV
X-Google-Smtp-Source: AGHT+IH6UZ6fmBx3WT/fEHQpSNnffMtr8r3z85mCMC6cjF8XVc2xQiy24DScww8nDJycO89IPZ4CFQ==
X-Received: by 2002:adf:f250:0:b0:333:2fd7:9602 with SMTP id b16-20020adff250000000b003332fd79602mr279648wrp.61.1701853465615;
        Wed, 06 Dec 2023 01:04:25 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:f855:6075:9365:8b70])
        by smtp.gmail.com with ESMTPSA id f9-20020adff8c9000000b003333d2c6420sm10682031wrq.74.2023.12.06.01.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:04:25 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 06 Dec 2023 10:04:21 +0100
Subject: [PATCH] configs: meson: enable missing DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
X-B4-Tracking: v=1; b=H4sIABQ5cGUC/x2MQQqAMAzAviI9W9g6EPEr4mFqnT3oZFURhn93e
 AwkyaCchBW6KkPiW1TiXsDWFUyr3wOjzIWBDDlLpsELxxhP3EhxkQcvHTH4OfCJk3emZWsdUQu
 lPxIX43/3w/t+SBi3VGsAAAA=
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ORIDsnMm4F8KEoPrXWijjF8CkW7NnOxxAsMmhYyoUOg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlcDkWvt2bDJou8o/2uAP9JbfYjo5d3c0S+5XkO
 LvNxOG9RV6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXA5FgAKCRB33NvayMhJ
 0XTxD/0WoDTtAoX4kn7qcPmi7W9kx7jG6rAeC95VtfZASss1si1XEIUegPmzFbteHl5RznWbbiD
 62pRHYJnf+rIcNVPP0F9M5KiVWENJgUazjkjhVuqs4soAIa254IKf+In5htnrscHywkGGB/bLLj
 q3PCCLI97N6HYfqvJBhG16kmJVE21/zg/FOFB4AWAA4lqxs65aCKN/JygCZn1o0Eph0O8yH3mqd
 yei2/NVxGkmDWvkq9QQ/O7CBzWmFd6/2CLU154LxMIOJqfqM1OnR6MaCdhFAtExZsOv+1hYN2HF
 ahAuZClCuQ9znLX7++wohTaNiv19pfH/rWdFGhGjs8yEOyd8Fzy5LrrQavIfhFxJgVpmvp5Hbn8
 eveoHcNI5VD5oIyg+OsKs73ockza/XiKY+q3gGR0OHZi4ZFNzUUq8iw80NKeFYtGQ1dcdoEdsbq
 bXZvdtINFZJTDu6hdcUv5FZznX1CK9ChYUGGE285WtsxbmMYeaYoMhFVwqENLtizLURrfr5mRLh
 Rzr3oHl6wZEepQIwIwqLSyIlt3ROtySIAPIbaMWzDTPF33aMfuYQgLLrgRDFwvLTriyeXVRsFDT
 WzuDtGRSUCzkoZlEzslCxwyoajbO30u+tcGqMviDPLute7MdLZ6FsGix0eruh24DYYYdEOvKPSs
 iFFZiTEpdF3W1VA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 06 Dec 2023 09:04:36 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1898

Since commit b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
and commit e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
Amlogic boards now requires DM_USB_GADGET to have USB Gadget to work.

Add it to the boards configs as returned by:
$ grep -L DM_USB_GADGET $(grep -l CONFIG_USB_GADGET $(grep -l MESON configs/*))

Fixes: b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
Fixes: e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/bananapi-m2-pro_defconfig | 1 +
 configs/bananapi-m2s_defconfig    | 1 +
 configs/libretech-cc_v2_defconfig | 1 +
 configs/odroid-go-ultra_defconfig | 1 +
 configs/radxa-zero2_defconfig     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 2a3958b0fd..755bccb4a7 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -56,6 +56,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index 405ce3a93a..af8daced62 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -61,6 +61,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index ba74b241ab..b1c267a791 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -66,6 +66,7 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index bc0bf9b896..49d628b76a 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -63,6 +63,7 @@ CONFIG_MESON_SERIAL=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index e9415762ff..b795681b3f 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -52,6 +52,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y

---
base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
change-id: 20231206-u-boot-m2s-fix-usb-gadget-ca308e113228

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


