Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677EBC3601E
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.36872.1743989731153366206
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 18:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=PYinsRfd;
 spf=pass (domain: chromium.org, ip: 209.85.214.172, mailfrom: sjg@chromium.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so41929525ad.1
        for <u-boot-amlogic@groups.io>; Sun, 06 Apr 2025 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743989730; x=1744594530; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/8ynHvWh7awCBJB5kkCN7bc7IfKpF8BL7z/gPfes9w=;
        b=PYinsRfd017cUbWpChMSoa8gdOtuA1xYJytZ04UBQMQsgp4Oqkqn73zepux2reyccV
         HTekJ2sJXcoUI4AulvDtjD+MirJWHHjdhhfUIxnvE9b31DzjdQK7PSqPDP2kN/on9H8Y
         nSLY7jLY7TUQypq/9Y2zwdg7e/Xf2nu9Bn+ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743989730; x=1744594530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/8ynHvWh7awCBJB5kkCN7bc7IfKpF8BL7z/gPfes9w=;
        b=Zd6bF2Tmi7a4epSZghKv2aHXNfqCbPbmlIUqc9q3/LiYRc+vyaKb0GLEE3JpVaCm6J
         uGb13BefB5tukJ/029h1sOP4A1hvm8RxAan9nkCfHuRSrV1Tqv/QZXgSm1/BUmer2oAs
         8BszPpY2F65E0O7CAblmxdoPOUz9F8PVmzm3+WWBKvJM2Dnw2tHBTTBfgCOwSRyPT5Yk
         cL7pWShmvI1QjfhEZQ02UvFiHd+0VXX6E9D2RUWGZjyz/P3KNq3vhZaNJcr+ZkNrS7HN
         NrP7w1m8mM9myxQnLS7mVN4mqot+vn2bKzKdcSLrnI7LonTI+icKBFWlTeAoglPnqo6K
         hsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzD3tw2HB2iMuK+7cKsdcBc99p7xMUmPHKdHXuIScmlsQ/eRYxJokOUKoHhAvZox9teSyPTYXHuZsAH2fPbA==@groups.io
X-Gm-Message-State: AOJu0Ywt37CU1FP2/eZeRSZnZJ2ON7HFvHx125OBSNU4NvXoEPKb3SGn
	5T8iB5RSjleEsrKBPzeoEqc+CrQyr8dNFvn+aj7Y8EpsV8cTJWMfBT+VBZgFEQ==
X-Gm-Gg: ASbGncuk3RYV26sj64cGmG3LNr8MSH5P4tgqrjdvLPIqdA3QjneM3SroruBXpEw05/6
	TidL3mB9CdDMbO2n1DA7cykpd7HEPgnTWh89lg3pR8sAmgTMrwnfQTSuONhDztncxTsZ999Pogj
	w9GTA6CvsltlXQ8+BBHtttTImJk/XjiHMJKt6gi1/mKUC5K6sechLgq3GaCQgIK4h9HyzcHBXGp
	sFEyMkUmRdz/7evHqT7C3iwCFBI70gXB6vC5cwroyZaZju8eKE2E1yccRF6q9SaWnYFgV0jjPC8
	zmnh1fRzEmvw8ymRZ46ocje1Ml7Wv3zYokQgdg2DYpVxLiKMFVf19/i+2yI=
X-Google-Smtp-Source: AGHT+IF6qfpZtGvUt2BOjU2x+PXSxSfxqKyca35jL9bX7uvtHVtZkeQUBv/dQAn+QcCXewrIfsPRiQ==
X-Received: by 2002:a17:902:e5c4:b0:225:adf8:8634 with SMTP id d9443c01a7336-22a8a0b3f58mr136658615ad.51.1743989730618;
        Sun, 06 Apr 2025 18:35:30 -0700 (PDT)
Received: from chromium.org ([161.29.84.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 18:35:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	neil.armstrong@linaro.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Janne Grunau <j@jannau.net>,
	Jim Liu <jim.t90615@gmail.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Kongyang Liu <seashell11234455@gmail.com>,
	Leo <ycliang@andestech.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marex@denx.de>,
	Matthew Garrett <mgarrett@aurora.tech>,
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
	Pavel Herrmann <morpheus.ibis@gmail.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Ramon Fried <rfried.dev@gmail.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Rick Chen <rick@andestech.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 0/4] dm: net: Assorted patches related to networking and DMA
Date: Mon,  7 Apr 2025 13:35:06 +1200
Message-ID: <20250407013513.638110-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2653

This series collects together a few patches related to U-Boot leaving
DMA running when booting.

Changes in v2:
- Use the designware_eth_remove() method directly
- Add gmac_rockchip too
- Reword the commit message to mention the uclass' actions
- Add a new patch to mark drivers as having active DMA

Simon Glass (4):
  designware: Use the remove() method with related drivers
  net: designware: Mark drivers as having active DMA
  efi_loader: Move device-removal later in exit-boot-services
  dm: core: Rename dm_remove_devices_active()

 arch/arm/lib/bootm.c          |  4 ++--
 arch/riscv/lib/bootm.c        |  2 +-
 arch/x86/lib/bootm.c          |  2 +-
 drivers/core/root.c           |  2 +-
 drivers/net/designware.c      |  4 ++--
 drivers/net/designware.h      | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c   |  3 ++-
 drivers/net/dwmac_s700.c      |  3 ++-
 drivers/net/dwmac_socfpga.c   |  3 ++-
 drivers/net/gmac_rockchip.c   |  3 ++-
 include/dm/root.h             |  6 +++---
 lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
 test/dm/core.c                |  2 +-
 13 files changed, 44 insertions(+), 23 deletions(-)

-- 
2.43.0

base-commit: d47b5693e21f78d8cd8caa8fcd9e64fd6ae85759
branch: eth2

