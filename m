Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD0C6FD1F
	for <webhook@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:16 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.31251.1711293554484846028
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Mar 2024 08:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XrxRYhG5;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: christianshewitt@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so4174212a12.0
        for <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711293553; x=1711898353; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orAznLnWy0CEitEVvnSeuGQAseklMB0s/6SFzX1+Rno=;
        b=XrxRYhG5gE07dqDungt2sBzMgqYGf/vp6+wT1vo7gvr87hMck5Gn+9ryMmP6gByXyf
         3KiQ45a8syJEf9ZAEBQn+dMIKDJ+KvNNYhaMstIL5l+RTn6BHPMhIcHHFEBH0+Gh0JgM
         U5K3RGvjBZt3qeBzbo7ldAHKnv3xdz3qjo3ZuzkRKtyLmX48+hs7aWB95BZlUIDar7wT
         gMbUVcSLGPexVqTY7auXO90yADWHfgV8XaUqjZRtY2O3hyAr0RFZ+87JGInPxtco85po
         jfRyAPO2NNCy1G/aBsJM3kFI+R7jWz0wgcIv8a7EPHnCXiF6y0LcZFeFM8HYFi9PHC+g
         iDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711293553; x=1711898353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orAznLnWy0CEitEVvnSeuGQAseklMB0s/6SFzX1+Rno=;
        b=ROzz2Gdre3BE0zVYLDeHZ5s64gbid/y+z0u6AeuSXFZaVtGUnNyfp2bbctyg8sMmVD
         GIzal+MB/GShEWAbUr+riWJa4FGtx4VI8VDKOi9w0B/5HbSBpnzBRFBTt+Cyy00QEVPd
         i3U+V+TIIT/5M0ULECdWSU9jypJZbqc+CXa805kQXH7clKK26InvZa9R+uQojehgCP/F
         nRSxerFqzpz/aV5rfQE7gbIzt0AlCcwDg5j3I8uHDfPwj325SqNReAxWRSopDuaL8hzv
         MjlvX8Szh1GyBWkaf5cUOq57eNUiVH8l/dl0l1xTx+/abfF+5WK4mUskWr/fc8NrY1Ug
         O/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXB1UezPijOEayQff9ggFEYaTZ2k4QeHW1k3ZTK7UmH7aNUqrQ86c4jP0x7RxJIgcSied6YB1nnNbY12SJyyPWx6+nhjH0zVBI=
X-Gm-Message-State: AOJu0Yw5YAg3tZguwPfZRNRISB6lHzmlBK7Xk063iOdZhE02/6JJLutE
	e6OsJYlG0H7/jpHecD84c4KgKpbS+i3YogmZRqXsBz+Y5cN8hm4bwGgz/CCmBO8=
X-Google-Smtp-Source: AGHT+IFhRJgpiqLGFCc44rQRz5LPiyxEJY5CVYn69exzGloG9UHUmJzBBQMw9KF+UW7QUds+qK+B2A==
X-Received: by 2002:a50:bae7:0:b0:56b:d15b:6dc1 with SMTP id x94-20020a50bae7000000b0056bd15b6dc1mr540362ede.23.1711293552801;
        Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] board: amlogic: add meson_generate_serial_ethaddr fallback to p200
Date: Sun, 24 Mar 2024 15:19:05 +0000
Message-Id: <20240324151905.3817732-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 15:19:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2241

Add a fall-back method to generate ethaddr from CPU serial on p200 boards
if the MAC cannot be read from efuse. This prevents random MAC addresses
on the WeTek Hub/Play2 boards.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/p200/p200.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d281..3061f7a6b3c 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -30,6 +30,8 @@ int misc_init_r(void)
 					  mac_addr, EFUSE_MAC_SIZE);
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
 	}
 
 	if (!env_get("serial#")) {
-- 
2.34.1


