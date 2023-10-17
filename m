Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A6CDB482
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 18:57:31 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.239290.1697569048013545691
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 11:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=HCpEA1WM;
 spf=pass (domain: baylibre.com, ip: 209.85.208.178, mailfrom: glaroque@baylibre.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c5210a1515so39372371fa.0
        for <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569046; x=1698173846; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Onq5Ei9HhL/jY+JPRrJ/vO8LYK4BUfmy7FZQoeAmEfc=;
        b=HCpEA1WMlE97EZ32734kHA/glDkMV7vAUSSQMmInecceuV8Iu/53h/JUE366IlTYBV
         /14lPqQ8gpu0Ho2Dh9RDu/AUO68HkUKJGdWuQ2mRkxRsmb4qwlUGY2jMkLbENSWgjiFu
         J96acdOJwYjBC0pdcbO4nBeUrEm0dMmfoiAiqaANZvpMyCQPjUBqWPxgncNenQ4cg313
         ab1vdFBbV4naQXt2TA8jg/ilUw4Y9SYJ1EhvmC9ns/0XL74v5J4vBJrLe2lelT3fUwmZ
         T5tbPfHIo2p/1PfbqmenKYgTyqkNWcArUZVXTAKBYHO4ZqY1YohhVhnrPc7zTpWe/T+x
         xPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569046; x=1698173846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Onq5Ei9HhL/jY+JPRrJ/vO8LYK4BUfmy7FZQoeAmEfc=;
        b=bbMaiazNh0r8r+0C+wQ+H4jO+5jONK6sE1GdHC+5ak7tAR+qC5D9h2G7EVtu861mhY
         OPInakYu2w6ymLifMTu7oJ1CU3UM2Lfl/jBYiiFk6AW8cYerkqpvtCqDRxcp+feb7eFT
         /pYHVR+rjLFKvUjAp4cjpxe82fwncwqPpi7KcvOZBq3LFV3C4g05QuZE5OHklFqhbzTD
         oqTer0xDJwAiDHjG1dRMvKeErTuMqPOFDII52FtCgQuG7Fj6uXltZCMqbAKVrFEbLCfH
         0uLSktI0rmqCYKa4iJp9iZn1upecXP9HxxO1huz3zjfalDVszdJf5YImAhYuitaT0r85
         6PZg==
X-Gm-Message-State: AOJu0YwtCUfUuhLBBUQJPUX7jMQBLyK1EEkSirc9u6XqkBnNsee09ppg
	BVqV1BIX/wG2sVH3T2/q05hOYbaEnK+/spcHpTpWlQ==
X-Google-Smtp-Source: AGHT+IHdMiN7anAX9QOx7OWWEnUmsThrgZGMF5RQpxq34B6mMx91q2+zdej7S6jlDhpYb9hKQ9AWUg==
X-Received: by 2002:a2e:b531:0:b0:2c5:3261:615e with SMTP id z17-20020a2eb531000000b002c53261615emr2082372ljm.35.1697569045855;
        Tue, 17 Oct 2023 11:57:25 -0700 (PDT)
Received: from glaroque-desktop.box.freepro.com ([2a05:6e02:10a5:e010:ece4:111a:47e2:bab0])
        by smtp.gmail.com with ESMTPSA id fl17-20020a05600c0b9100b0040776008abdsm2579530wmb.40.2023.10.17.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:57:25 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	avromanov@salutedevices.com
Subject: [PATCH] phy: meson-g12a-usb2: fix ret check on power_domain_get
Date: Tue, 17 Oct 2023 20:57:25 +0200
Message-Id: <20231017185725.809524-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 18:57:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1773

Patch which add A1 SoC support create a regression on khadas vim3/vim3l
boards when we try to use fastboot command:

  => fastboot usb 0
  failed to get power domain
  failed to get power domain
  No USB device found
  USB init failed: -19

Add ENOENT check on ret in probe function.

Fixes: 5533c883ce10 ("phy: support Amlogic A1 family")

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/phy/meson-g12a-usb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 4ba3992bda70..3958d2404b85 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -328,12 +328,12 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
 	ret = power_domain_get(dev, &priv->pwrdm);
-	if (ret < 0 && ret != -ENODEV) {
-		pr_err("failed to get power domain\n");
+	if (ret < 0 && ret != -ENODEV && ret != -ENOENT) {
+		pr_err("failed to get power domain : %d\n", ret);
 		return ret;
 	}
 
-	if (ret != -ENODEV) {
+	if (ret != -ENODEV && ret != -ENOENT) {
 		ret = power_domain_on(&priv->pwrdm);
 		if (ret < 0) {
 			pr_err("failed to enable power domain\n");
-- 
2.34.1


