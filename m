Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E55C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:03:42 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.8673.1746774212231310872
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=agcROecN;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30828fc17adso1856690a91.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774212; x=1747379012; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7ltAtejEdAV9MZhiUQDNqnwnzqsCUJMvK6vihAk1oc=;
        b=agcROecNbNeTJI7wdDv2zAtvx6ncjAxJserPPW7SWfS7FnGqNBDuF8G8cx0TpvGwhB
         9rXZ+RwJWJYA5Og4NNYqyG6tWcxBonZEMlqdtQd9S7IA8pfYfAylaBlm4BFe2PmIiXXc
         I8Ac1t2Kv81i7ZSA8u1MqBG7M+oJeWDMpbsF6l3AhYQtyepcdkYxfXdEC3QLXBS/bedo
         Jff6Iie1ozisapXSwG+eaXjqGe6dxebjDljNPeHl/m78YK5FeDP8+FuGwQpEay1ZoXAS
         HZ2xDdtvINGBp7/W4bo8arDeV+rRGuh2aQQXQ57VxdvOkwVlgbu9655tLXnR1Q8FiBe8
         OB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774212; x=1747379012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7ltAtejEdAV9MZhiUQDNqnwnzqsCUJMvK6vihAk1oc=;
        b=I4b/iV2dXcTdE4ksFcQ3+8gMRkO98/i0rDCu28OZW5U8I0ZOzKLrJaJaI7Z7w4yxXg
         g+VA5uLrQdCaHh27nDI3tzeYVi4R3Lm1+GCiLBFBRggM7LrWZkzJTcGGI4dRX1JnL/7Y
         hXUSa1zas8dWRnXQG7ql6MAkRv7zEKfVLt8gCG8FAcX2SIh/Hv/PcDFodBVLNGCs4Xka
         Cha2mRK0+2TgovMCbAPbCmBglcKkq/mppaGDJwJMLGJbs2bqQHXJyoN/0Pf7jB5XCUVY
         TnKlVOjOomDS3YBRvaTGaRdqq5JdYVVNTyCZ7cNLwwNpoOe+Fbg3Ql4VpjcuZY1FXNRk
         iU6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkbFjluuzyXt0S84CDKys1i1utkCFPf4zJaD2NJ2rzJzmugw6toI2Oz7zG1GGJOnsoffVPXfIGfzF9OmLC1A==@groups.io
X-Gm-Message-State: AOJu0YzZjWUn6hRabku5HCUQG++f3lKgOXrPq2L8zAt5xf9BKsuUI32w
	e+g4vTqfkX5Lxc4tMJdkF3YC/QCDsL6Yh4zF7e93wVC2p2kgzFST
X-Gm-Gg: ASbGncu+yIyTZ2Wkt4/ImiBS5xGvVggjI+70K7wGprhoHG/TIx+jzMpd57nfHKKVKLs
	7aOjB3WXbj0Rp1rCxWTESnBsXvgAne7u2BjF14F/C6mSSBajFW1sNsN42Vv+iPhYsAGST/4Db1H
	oVnGW+8iRS1NLqhYSniDrIIqHO1TMemtH0IZgm9TL9JdrwLKo84l1wLYBRnOwQGtjTqcsR4Z6hP
	aYBhFBB5BF20pRh8QCuT4063BxMJJpz6NDVSDhWE64DoCyhixb6zEVauQnvrHuCmgZGdMcFaa2g
	SBhPABtRpYeTSYtkZN7v+ckfzRPf8PfvwDRxMe7FGsVLr0M5IWj4
X-Google-Smtp-Source: AGHT+IG/sjj7nZqG5DQYQuTkBLUYQ/gToIH94TtNAsYnyGMVlxfrHWVaZFTOl8AZqVkWpD+BNFR3xA==
X-Received: by 2002:a17:90b:2d8d:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-30c3d0ea49bmr4254116a91.11.1746774211358;
        Fri, 09 May 2025 00:03:31 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:30 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	u-boot@lists.denx.de (open list),
	u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
Date: Fri,  9 May 2025 12:32:07 +0530
Message-ID: <20250509070258.5077-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:03:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2677

Enable the onboard USB HUB driver to power the
USB_HUB_GL852G-OHG on the Odroid C2.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-c2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index bcaab46f8bc..f8a66a923c9 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 # CONFIG_VIDEO_BPP16 is not set
-- 
2.49.0


