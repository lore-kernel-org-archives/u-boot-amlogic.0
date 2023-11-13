Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56EC41535
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 10:07:48 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web10.29651.1699844408087902343
 for <u-boot-amlogic@groups.io>;
 Sun, 12 Nov 2023 19:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=JhF1emRj;
 spf=pass (domain: chromium.org, ip: 209.85.166.47, mailfrom: sjg@chromium.org)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7a689bd4928so119982139f.0
        for <u-boot-amlogic@groups.io>; Sun, 12 Nov 2023 19:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699844407; x=1700449207; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=comWTCV1XaRZU1sd0HPXl/reLdTUpm3Fb3i9aFP3E54=;
        b=JhF1emRjWTQqKqFQOYLhCP3nQ+st48Z3eMKR3ZPbjdQQAqwVmG+EaJoWl8HxUUqRcB
         Mcp75F1zEEiKcVQpD7/nYfJ+AmcV50rU/MQDCtfOz5PTe+Km0tklrDShlPDGXX4bMxB8
         9x6Dn7DdMMq65BiSScZzpIndiAYBLUT0Km3hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699844407; x=1700449207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=comWTCV1XaRZU1sd0HPXl/reLdTUpm3Fb3i9aFP3E54=;
        b=nhGo9w7zxBmqZI45mh/K0llo5eAuBJfFIq1W50CVTWiXdxJUgCpACXh3NScG7VrTEl
         wAfQcsaPqqjGwRjxfGHXBX9dAOSpVwWpCJlnRirZXl4AuSpDCg+wr3f74BptjjSXPoIT
         1OMCLERt8V2Ro/SRsUuJ/YKJlbT++woNAeeSTY8d4jeoP/SU6PSOnkpyrdUC6BjwIJNX
         mpYBlFVC/fGb6Z4OUHK4OVtK1orG9c36IBv9yLbn6cPvM4O8UZGZbWzbw5wCTCkSnt0g
         sbmIFiXGFlYFlU/AK1xbAiDwcUoV7vD3BsGefU/3rNOkQYBbpE2sfyMGBSOBDawBtK38
         WivA==
X-Gm-Message-State: AOJu0Yz1K/VARkVnNlHHykHu3mDt1seDNznP2VHDZ81ks/uB6AvLeMOp
	Y5U1/LpnKesrJ0Gir3u1x1DUqOdaBLH149B3lZhgVg==
X-Google-Smtp-Source: AGHT+IF9mAs5Si6VV7CrmuLBE4lQYBf39MxgiIKwOKnX+RF2nswg3ClueJ11nepdZHLvPSXCuSi94A==
X-Received: by 2002:a05:6e02:20ca:b0:359:33dd:f470 with SMTP id 10-20020a056e0220ca00b0035933ddf470mr4573229ilq.3.1699844407381;
        Sun, 12 Nov 2023 19:00:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 19:00:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH 2/9] meson: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:22 -0700
Message-ID: <20231113030001.240020-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 13 Nov 2023 10:07:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1871

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-meson/board-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 2421acd817e4..95a29da07229 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -168,7 +168,7 @@ static unsigned int get_socinfo(void)
 	return socinfo;
 }
 
-int show_board_info(void)
+int checkboard(void)
 {
 	unsigned int socinfo;
 
-- 
2.42.0.869.gea05f2083d-goog


