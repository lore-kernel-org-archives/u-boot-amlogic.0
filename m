Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D3C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 08:32:22 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.20098.1753288647162604281
 for <u-boot-amlogic@groups.io>;
 Wed, 23 Jul 2025 09:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=hJd+pLTK;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54700a46eso28704f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 23 Jul 2025 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753288645; x=1753893445; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpZ6EeYs+LGWNt5MketzLyae4vHBD6BLVZAXkb6Gzpk=;
        b=hJd+pLTKkxfhqvZMp6Tl01OwYTVaz2BltzTKbFhDqqy3+rc1FNiuf04wNhTv7AO4tp
         oLKlutRzKFzUtf388+BmmZ3woLvUbicanya+qLatZKyBUEqNhWb1iuuyy6+mcoQXelJR
         OT+4h20lZluenFSJLtC5PtCKXtfjqhDoX+PmGP9pG3F8B2jWwjuqUpcNVykQohgwyfog
         SHyMjY00qn/LPM6Sv/lSnU/IYM6SX227oFHCmL9hnKnDwwRnL9NwIcNBlSzyQdNtXWXK
         pLUE/dTvQJYmyv7MfDoWl2LreJYyippAqd9UOMr2wQdreHYrLoIrQj0opvN3paSM7fpQ
         +SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288645; x=1753893445;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpZ6EeYs+LGWNt5MketzLyae4vHBD6BLVZAXkb6Gzpk=;
        b=gFuhhd2Tv2C1usCWiiOtfVBT92n+XjN1xaE/C67eOTM7t39NfU0w6C69fidu7DY8PN
         hPLJ5bLpz1ZT/OFeqZS2OH2HspmEYFqlrreoCgTJA9sidkjHS3nyLQywAvd6DiZ7lq+W
         rP6IXD0Zf7sDggeQUwotB/CaCuqshJUA3Z87gIa1qZV1qzYukENKyAB0Xi/ePxm5r/Et
         dutgxyASN/9wCdCf2GY2DEcm1HQguiXxupZ013clnkhvCrtseSkwf0jhkU13pN2FqE2D
         SnY9nC3SVgTjzbQ/j+wlxhfG46uBh+06CD0zzcwyYbZY5eR/hdKx6SyM0I+arjZjXi2l
         9vkw==
X-Gm-Message-State: AOJu0YzcuT5AMt5QaIUbw2NzQwL2JGWayh/NVWqp2O8buuHmIZKOv4ba
	dAJMqWhB9vUI9MF4SGkCjjIdl0y/cTVn4E9EFUk/7orSGaOaRxpA0XmDxawjrh0ubpBc2FEt4tZ
	hBml3
X-Gm-Gg: ASbGncsc9+kmmQTZX6kgUGf+vg9Z3LT7U7NKHR010emTnlFUxidCCqxw0JrRfBjZVeq
	yqtjWyhQQ55GSoRsVSorBnpZqB7Q6Dk8xYj8aM86ZE7lbQ/8yGy/BzYYIDt8WKMd1IgnmieulKY
	TLpsH2723VILBzLW8LFduNbVGqP6JBKPgZNRcZ6CxT1T+LbS5dxuit33KBuolK4dMwWzVT1GdQl
	2FdPhhn1aV66Cr27jjMXXxdufXYu0rr7RIExDS46upl3jLfrkrHXFACSNjqdfXD81kq/U07mMNG
	irx+D9JixIbXSmW6OvnKOGOm9qio2SsU0nyv/Kio1PmJQZ6uiIpV7Hv3TOv28ddd0tnwbxla57s
	4Uxq9yzBrW2E62NoOgCk+WYfEYkXQXV/jYrdXJe5NahqtUsiLxsU=
X-Google-Smtp-Source: AGHT+IFD1QG5/tPpr7t1LFGKsn1FDEr7VExg5+sqDAjwyE1HY9kcu/ZwXgtvxKINttXpJlPX4VYY9g==
X-Received: by 2002:a05:6000:208a:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b768eb077emr3485130f8f.7.1753288645430;
        Wed, 23 Jul 2025 09:37:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm16855166f8f.59.2025.07.23.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:37:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 17:37:24 +0100
Subject: [PATCH] clk: meson: Remove unreachable code
MIME-Version: 1.0
Message-Id: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMMPgWgC/x2NUQqDMBAFryL73UAaEbVXKaUkm1UXNZbdIoJ4d
 6Ofw5vH7KAkTAqvYgehlZWXlOH5KAAHn3oyHDODs66ytSsNTuN3Jl2SKWNrA7q2ayJC9oNXMkF
 8wuF6zF7/JNfwE+p4uyPvz3GcPO1M3HQAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 08:32:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2731

A second return following the first return is unreachable code so remove
it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/meson/g12a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 5d7faaa3eab..a7a42b2edb6 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 			return -EINVAL;
 	case CLKID_PCIE_PLL:
 		return meson_pcie_pll_set_rate(clk, rate);
-
-		return 0;
 	case CLKID_VPU:
 		return meson_clk_set_rate_by_id(clk,
 				meson_mux_get_parent(clk, CLKID_VPU), rate,

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-clk_meson-3d90bc29f8dc

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


