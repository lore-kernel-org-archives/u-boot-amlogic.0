Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC9DC636D3
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.11796.1700511371591287718
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Nov 2023 12:16:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XL4y/O5y;
 spf=pass (domain: konsulko.com, ip: 209.85.167.180, mailfrom: trini@konsulko.com)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b566ee5f1dso3100188b6e.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Nov 2023 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700511371; x=1701116171; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foHonOICjYjIcac7Qw2x/CJwCGCuQbhK9ujt81YaTFE=;
        b=XL4y/O5yJs6BfVfDITk/kBAILteBusYhim/tnUOUrmoEZmk9oUh5Ai/rPxj7C5Wto0
         f7MvpIQ68xspgBaMQFcIZ3YQ/w3xfAQxRePe/I9JGbH1E884uKb66qmQppx84XWl8ZsQ
         KsDFMawZXFs8mdloHYdsvq4i69o/v8t/F/HkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511371; x=1701116171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foHonOICjYjIcac7Qw2x/CJwCGCuQbhK9ujt81YaTFE=;
        b=gUHkDVhUktZbAjUvtpj8gRVPAEN/+5srZDl94MQ9ENXA84tzFeia08I3ezxE85UNyC
         IluTzj9sFYJMc+MPYjOi9ejaWIS1zNSw7HJ9UJsw1RFQfKzASXNzY+bH4QVr83rmIFYe
         bmt5xlgnrkTIvQEAsmINTk3sV5R3s3Of6XjjR5h8LtFVeSF6I2ZRfr14pYrJDJlqZD0M
         IDctUbPD+PkN/406W5mKNm68SD3sYlKDiO+hUByTVabktcP1zLON+GY+iIlUkFDuKjCR
         XGmkLJanaBDzu5tYAM2SV3aH4vUmyqX8Wh8ju3PUCwJMUb0NZbHo2l/1HIVPbErxQYBv
         zONg==
X-Gm-Message-State: AOJu0Yx4o6IhvLsaCcZ2PMitTaoeK+jkqaWXbJhQlTZMMhGYNUsZFSks
	VneJliXNDOe3pSYxtw0ECZP3Ww==
X-Google-Smtp-Source: AGHT+IFywLHlPAU2dDWnzg/WTwN0foFy7KCrvqBOagrb/Oyq+hCpiRXzZyjzK+lU1S5ytoOZ4nzUQQ==
X-Received: by 2002:a05:6808:1201:b0:3ae:1351:d0f with SMTP id a1-20020a056808120100b003ae13510d0fmr3712587oil.22.1700511370902;
        Mon, 20 Nov 2023 12:16:10 -0800 (PST)
Received: from bill-the-cat.lan (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com. [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b00777611164c5sm2899840qkb.106.2023.11.20.12.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:16:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH] libretech-cc: Populate SMBIOS information
Date: Mon, 20 Nov 2023 15:16:09 -0500
Message-Id: <20231120201609.619598-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1883

Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
eventually display this information

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Posting this as this was the easiest platform for me to test some SMBIOS
related patches on and I needed to populate the nodes so I could check
things in dmidecode once Linux was up.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io
---
 .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
 configs/libretech-cc_defconfig                |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
index 39270ea71c8b..e56cd67a9d91 100644
--- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
@@ -5,3 +5,26 @@
  */
 
 #include "meson-gxl-u-boot.dtsi"
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+
+			baseboard {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+
+			chassis {
+				manufacturer = "libre.computer";
+				product = "Le Potato";
+			};
+		};
+	};
+};
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index baa9b1b3dbc5..24a46f50d0d9 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -55,6 +55,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.34.1


