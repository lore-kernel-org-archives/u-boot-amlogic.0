Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D6C54E5D
	for <webhook@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:49 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.7041.1710597281093306471
 for <u-boot-amlogic@groups.io>;
 Sat, 16 Mar 2024 06:54:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SL/HZmIO;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: christianshewitt@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4140993c4a2so1404225e9.3
        for <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597279; x=1711202079; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWhWcKIn0pGCEzwEvQhFIBa9a12cgD1Rhhcfr7musaI=;
        b=SL/HZmIOLjZpoKjEvLzlNKXv6rhTaVgbW1KxnT1Ce9agshfgVlDVxp194/m70c3rPj
         zd/B/QVbZE8KxmgFKzTVqyZSI+/vrchpbUeMkGU8F5lJw29p4jZLSKqsyF0kQHcyFqQU
         2E0Jfb6mYbdRTC+pCo2CUlj8bU9SC7PJMfFW2HnucjzjAzHM3e8MPHKUVgF69IHSzcFf
         Bkv97J9923JYSGkgi1ce0j1Oww3oCVK30z0gQNOGe6AR6tkFuOhSvcJ+sM3vOtaa5Ax0
         7J1M9JJCldqhMOiP6RgOC9f0+O+wTwh7qoUZtgSLgYfK3mBWEwSOdLsOblzTlXsK1O6g
         lY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597279; x=1711202079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWhWcKIn0pGCEzwEvQhFIBa9a12cgD1Rhhcfr7musaI=;
        b=WT+AHNniwdz25NCv9UnDlGZX70fRk3YMLBxkoNmXI32JBI9ETyU7+VVsMHaoAOWPuW
         ql70sQmDzgdgD/gMq2VRKaghpjO3GKKroyjqNHIrXCMsOYDggxzV7LNcauBVJSmF9xmj
         JT7dQ5iXsookhNhlJutWS3H42W++5KvMqpnMdSHbS5HjFqkjXrd7ArvMTMi8Rg9ZnYr+
         n1Xn/aQa3/rd9aJQUrRxGR6RN+PkVKRa9rbctl9+B72LbIyAnOfJ3DRZvjvPiuIsF6pW
         ClzELRBf5VRYS88Bx9xdMknqw//3NKesD7EHzDvM9z9+ITnV2gdgjk3sWHYU3siUy2uU
         BrIA==
X-Forwarded-Encrypted: i=1; AJvYcCUM252XyNwPWzgSW9ghw2ekjcNd8bpcFrBTZC9k1IOmNpXXBmd8uQ9WV+JK52lXOVCtYfTB5nLC7RWgKQJxijaJYQmgCWl3Qps=
X-Gm-Message-State: AOJu0Yw1bAbnIgvhHLFJ1Q7v6h8Dpw7YFwmgkSvAK05Kou55FSg1MHbR
	s+b6Op/b+OcAADWII3zHi0zj8UoFL/YOt4cpOdn6/hxGOh6almGx
X-Google-Smtp-Source: AGHT+IGzRMqMtu4v9w5YQ8+ov6mybC3kz1cjjQ/1+F4ZvcVqewhFcpXSu7Iz69nZ890Fbbr22AshFw==
X-Received: by 2002:a05:600c:1d18:b0:413:f0d1:5ee2 with SMTP id l24-20020a05600c1d1800b00413f0d15ee2mr5842748wms.12.1710597279625;
        Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] configs: amlogic: set board family to avoid random MAC on WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:30 +0000
Message-Id: <20240316135430.826898-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 13:54:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2195

Add CONFIG_SYS_BOARD="p200" to the Hub/Play2 board configs to ensure the
factory programmed MAC is correctly read from efuse.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/wetek-hub_defconfig   | 1 +
 configs/wetek-play2_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e73..413bbfe9ab7 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MESON=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6ba..dd98929444c 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MESON=y
+CONFIG_SYS_BOARD="p200"
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.34.1


