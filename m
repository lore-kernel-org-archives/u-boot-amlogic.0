Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D236C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 13:50:08 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.31633.1698933004451578170
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Nov 2023 06:50:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=d64+6btP;
 spf=pass (domain: linaro.org, ip: 209.85.167.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507b96095abso1104395e87.3
        for <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698933002; x=1699537802; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bve3ilxgivvp/liLMwyWo9dPFQSnNNhOES9b0SRCTto=;
        b=d64+6btPwehDgZGoLT05fEuvB8j3N8HMmmhy6clAUOS7XMnzT10F6nXVNfXF1swf4H
         0IP3j0hng/QXGgX1aw3qkfzQTDf8blzA2xnw47q9J8kTydXX7CeO4lV+lQFYbRuuMVN0
         XFHK8hiNIulwGOlCDlzbfH6RYkMGxqe53kqNcxuCHrh7rBAk1zsSSL6XJ7LWKQ3lQp7E
         2N5MeiY5y6efVc3i21tImkZLMiy+gKJipuJLlhpnd/ExRuCeY73F1VgpQ4mC0z+Wk2qv
         DhUvhdWYc6AbdEd+KPBv0Quee2nqbocAA6goVvgB3IPbnZKbuy5pdvQSUBDibs6jH5VC
         5ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933002; x=1699537802;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bve3ilxgivvp/liLMwyWo9dPFQSnNNhOES9b0SRCTto=;
        b=CB9iuMO/aNv6GR1KtxjZRq77P6YEh3vhDjz0xrStrD8N5xId/xMnbEKY3g50rApXUc
         oNQcE66LCNLLagKVNrlmHYK3XWFvrBWnUxatMy2C8TBZLuNOQ7naA5eAlOUP3292pGo2
         hGRL3pX2srVPT7mxxH9bZPxhctUJv7ry5dEubpJgdyI44fH7k1lvSpE8DHRiFrA8XxAl
         gkQKXXpKnEHmdnb5HeA+T6wmq+BnN43Dkry3omYqT9fxijX1FQkfbHieV7dqHhbcg4zA
         3cV/kdHqxG3GcFxRl9lwkaM/vmibfWwvUru90wugtXiNFCvWv80aS1ZaB9rPKRTtPf65
         TeOw==
X-Gm-Message-State: AOJu0YwVrkqtcrdYcoP+LzvgT6ZvGifNwhaPEx2TALh6RTtO4sbP+g/4
	KP6s5ZN+PGqD8MUnowe6qWznAA==
X-Google-Smtp-Source: AGHT+IHbiS+DQRWd5u1hPP6jEPfTOmtwD3OzDZGoh1C3oNmeK26CmPOar8xPdUEaHQyoUi/oPYhD7w==
X-Received: by 2002:ac2:5928:0:b0:504:3499:7c37 with SMTP id v8-20020ac25928000000b0050434997c37mr13737824lfi.60.1698933002543;
        Thu, 02 Nov 2023 06:50:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c079300b003fe23b10fdfsm2952913wmo.36.2023.11.02.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:50:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 Nov 2023 14:49:58 +0100
Subject: [PATCH] ARM: configs: libretech-ac: enable USB_DFU like in
 meson64.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAWpQ2UC/x2MQQqAIBAAvxJ7bkENofpKdDB3q4Ww0Iog/HvSc
 RhmXkgchRP01QuRb0myhwK6rsCvLiyMQoXBKNNorQxuMkU+2a/oPM7yIM0X0kStVh1ZawhKekQ
 u6t8OY84f7GhPd2YAAAA=
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mspt5Mz3KjcfMXyYuluNmxzIZK8UcxqMxfjBtNJeHOE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlQ6kGxcwzwFMHWAAPP2cCMby9s11ShzivKke8B
 5bOeHx7c0iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUOpBgAKCRB33NvayMhJ
 0fjEEACnPdku66thkBuf1OPxUhBIBfN8Y3eBvK05KM2GRgmKw6h4EpXHh+Jkh/j7NS2sfXZ1qMq
 48lU06yFbLNwrye8iTKGWY/Srgryuc8VQKgvUAOP3v5Wv7SfkFYB69pu1NZ722pjKsGIv3pTzhg
 ac8EpV8337KmwX7mPsSHYiIlp9ef1FqFZIhS6/O6AGS0sNHYFt/ULVAWH5paRvpR8RIyia6dC+h
 o/A0tm+IJg+ZjYqtrjCdyaZ2jvWZtRkuwoUZaIUts0bnr2n25lVA5lt9tmc0TMe12FSM0vZ5R/W
 adzHOmshLMHtG/M3CH21udoTxv9R+L5sfT73fMgf4NkxPawEZKR0wC3wjVXxEh7SunlSc78cyOU
 K50Wp7d2qAGzBvfvDvndMV6idmyaUPu+27753qZ0dX5bDVG9Qpq3UvVTOvarsirnRU+u+oGaJs4
 htYUZTCOzRHB/tJVvXNRm84SZfYdozICIYQW/rFeqYSZNoWBGEPVW4EBDgCGWP5FAH7TjKTd3pk
 16e96t6xK9rMqxQ23EbFqUrX4YeswSSGej4KpLnEi6fnbiKyaaFk4fPLCnSmFzq2lVC7s2Cu1Zk
 T1n2Vnd1S9MAb0KidhqRt5bCL0EepEuTvhc/mXgEKoaaV7m3DbBFVfosNV468Y8DZESV+i8qq+C
 jvGKDVVO2qkK62w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 13:50:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1819

USB_DFU was added in meson64.h but is missing in libretech-ac.h,
fix this to enable DFU RAM boot for libretech-ac.

Fixes 4aa027b3f8 ("configs: meson64: add alternate USB DFU boot target")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/libretech-ac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/libretech-ac.h b/include/configs/libretech-ac.h
index bf20d31543..16239f2520 100644
--- a/include/configs/libretech-ac.h
+++ b/include/configs/libretech-ac.h
@@ -11,6 +11,7 @@
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
+	func(USB_DFU, usbdfu, na)  \
 	func(MMC, mmc, 0) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	func(PXE, pxe, na) \

---
base-commit: a803f87202aa48974bdff4d8100464a8288931e4
change-id: 20231102-libretech-ac-fix-dfu-dbd8109d552d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


