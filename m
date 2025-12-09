Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2DFD3B7EA
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 09:26:30 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1013.1765260188272251883
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Dec 2025 22:03:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d55vNQEE;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: xieqinick@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29808a9a96aso56597215ad.1
        for <u-boot-amlogic@groups.io>; Mon, 08 Dec 2025 22:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765260188; x=1765864988; darn=groups.io;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipWTaBkO9NRhYB73xbdcKlhmMD4pf98Ty0k/P5ljLEI=;
        b=d55vNQEEvhZ5NSqaHn2Xt8oqq4sPkoE5MGZ3TivBElII/cYuiAqiBHmP3Zf5x6jVes
         MRWEtX9j/Iffj4yIVq+pkmYkyKFQfVaUgjFieM1y0Ivk9QXUjd9mxx8vtf0Izyj7LQZ3
         GSSxFWb0qwNK14OBJ24aniuMVxXE0ABJVL1elcgZ1N6ZypRyocYCKrwZQ6T09manvMuz
         Z29sFQEDdO3b8FE4dFXfzsW2CMMVp9RJO5TZ2O4QRexRseSPWD7U2DdQFRaHbOTyygm2
         M3TwMr5dTPZt9Op0UbN8iASiFFNYXlUaFCcZ0VSE92Jk7EGVRCFMUiFISyN9gq85YtFQ
         UqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765260188; x=1765864988;
        h=message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipWTaBkO9NRhYB73xbdcKlhmMD4pf98Ty0k/P5ljLEI=;
        b=kf2iOljbk5AG+4GIOSGA5BYzzD5uYmxIyGQ26RGo6JIPBAoV/JED8xQuCE3qAwiVyK
         mg+WHr6P/UZdwWlbpZM5GYsIUHKymtah+gQ9MI96tfi5XaE9Etwm+LOnf0p2APMNC+ww
         Jcp+ZYX+P273ZoiTIPfcUyaJpbxLNzvx4JlCF//L6//5Qv4YZy4++WTebl08UMgPm1Jk
         1UYAE0P3E/iCSACamsrQmA6+VCGB29S6kHquG9YHD0/w4IVO99gQy9b8h2DJv7inLK97
         jSpgWPxN0rWn+w5cpTILtwC08FcbXW1OEXdQTpe8F8/6Lefp906ew8fsG3YiKkSZlftX
         QGrA==
X-Forwarded-Encrypted: i=1; AJvYcCVRER9DHrmlZiDjeILaM+WFv3mXONYIRJcwd9+OsyNYpupzeIzqrKazFGRJ0XXPvcN3O4ItP3gaH5sc8MYDpQ==@groups.io
X-Gm-Message-State: AOJu0Ywqu28KSOIEvQHQIj1U2irjGy7X83kMMcdhdhvTJzaJtY5zGMbN
	w4U1vIlRn0canhAF0yE9RNMEIv9PCeIFWqMLukel9hmV9FQYdLdNlDsc+mfQKyV+ghU=
X-Gm-Gg: ASbGncumWxd4sraahs7z7xM8tn9Nov8elRsI6bTWC1iRaWw4ukyrh9kXOLidBR1B+OX
	Jz/p9BOg7LRjjwMxffmWW/+HGYHddHd87IlzTeDkQ0LyYJxe3hYB8dkxmxb0fPWHdby7P051Zs3
	Juax6Fpe0Kgh9zU2YQIHIoUaPnFg/7BBWXUJReum6xqV2TADET0PcWH6/w9tELq6cQCCnI7FVnJ
	l1r/rqgoaGvpWY+O131kK5ivGWsdr2wo7DzkQ5D0hY7e/c/tW8iaS3eCFABXJC6LbPwWWbbvJGL
	z+kHPvaZyRI8FQhm9XpTuFj3OLuU3qWKLmnULruOdp2evpPgAzPEb8ftFKgCHIKTpy3dgfJBVhU
	VSUQh+wmtxngaI02oSJM+74onyjvwAOnsjBxxqHai0jbqM/MCBTlSeMJS1tnaQd/2S0oYh1Z7DU
	GI2w3+91xviHc=
X-Google-Smtp-Source: AGHT+IE/lqap8UwMWERcs2fpnkS2PSs5SUmVJWPpsA3Tjw9p6waFsQQNR548elxCHuT5vN3qoe6z7g==
X-Received: by 2002:a17:90b:2fc3:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-349a2518c46mr7733097a91.13.1765259885775;
        Mon, 08 Dec 2025 21:58:05 -0800 (PST)
Received: from localhost.localdomain ([124.156.134.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a4a7f55dcsm555593a91.4.2025.12.08.21.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 21:58:05 -0800 (PST)
From: Nick Xie <xieqinick@gmail.com>
X-Google-Original-From: Nick Xie <nick@khadas.com>
To: nick@khadas.com,
	neil.armstrong@linaro.org,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] mmc: meson_gx_mmc: reduce maximum frequency
Date: Tue,  9 Dec 2025 13:57:50 +0800
Message-Id: <20251209055750.43594-1-nick@khadas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 09 Dec 2025 09:26:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2865

Reduce the maximum frequency to 40MHz to be compatible with
more eMMC. And the Amlogic vendor U-Boot also use the maximum
frequency of 40MHz.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 drivers/mmc/meson_gx_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 5852b24c6d2..87c5f04da0f 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -278,7 +278,7 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
 			MMC_MODE_HS_52MHz | MMC_MODE_HS;
 	cfg->f_min = DIV_ROUND_UP(SD_EMMC_CLKSRC_24M, CLK_MAX_DIV);
-	cfg->f_max = 100000000; /* 100 MHz */
+	cfg->f_max = 40000000; /* 40 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
 
-- 
2.17.1


