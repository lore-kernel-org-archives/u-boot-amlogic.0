Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE86AC47DD9
	for <webhook@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:15 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.31155.1711293552096177239
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Mar 2024 08:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CqgMHhuZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: christianshewitt@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so49324331fa.0
        for <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711293550; x=1711898350; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovYQFvlq3mePJe6rO637zUtVNkzpO6QrO028yw8E5bM=;
        b=CqgMHhuZgXb0z98CFdGDl1ZoDd9XDUB0Dek06QEk0Ag9aikRN8LO6f0lwLhXBr4m9X
         KCIjqn1LUoInVPLjwQgbRwRi7L0QeUtYr16trK+oEEpyl8hobsFZYp9IqLkPSgoNQoin
         KV+A8d5ie7J8EKF7yJDCOyGThcbG0IdlVI20SPl5lwonNjnwJdAvlQCXoysWLly65qHR
         6K4dcjjhmzoYL0Q2YbaRDXHUB76yErnxAg3ozcvlV/DRrIHQ1awv2rgtX3lb+A2Cm+aB
         LXP0use90zK6VrEsOUUZxw181doB4TAOnlga9rSj0UwgmKitJl5rNQLxNK1B1Z61UrRW
         rWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711293550; x=1711898350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovYQFvlq3mePJe6rO637zUtVNkzpO6QrO028yw8E5bM=;
        b=sMwy2YOz1rFQ/4ynPZa+KKnS6QCjVLXLsU/MMmouzyUrZb8nFN740D6vzHyfUihdE7
         azr6N1oMqkYF5xJxXM6qqAwzG2p2ZmtTSDaAbqSLOhY5Uar94ao1hkhQiI8/4aZPGhJF
         YbqN5g31uKJIbEehyj6ERZZypeyFrxpEkbjZjWJ42VzjRjQdHhpfO3vvMCoqb35lKTCU
         ZeS29Dcopi0VOTw4MMCCw3nwrcEH3nYhDIZA7U+V6FZik3pmkrBqmk+l24k2VNxOIWyp
         G+3fqLqRm8SXzcqHjrrMkd1E8N5kJ4vzocCDFXFyBOxIqrqwqqp7+MniRWlGRiov6vCP
         LoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm/GoWjPNoP+I32S/ZGpkVcq9aw5fatoojAkz1q8Bs5hXzwxdM/gI5dB06+kz/HUaTSMc5iOahyoSdlEShqxmL8VT2RZcn9qE=
X-Gm-Message-State: AOJu0YzjYrGwxfFbd3sosV5l9XALKPkc2PHtFx2DqKB8JX4EF+mcn8eP
	lW5ArxO0adurY+xzB1YIZUpVjWyOaX5fFvSIUwfO5N6bpmexlqOh
X-Google-Smtp-Source: AGHT+IHvxG9SMUjnncSUNvSs9rktVG4jV639ZxavzgSpTs/MknCviYzx9CPubScE1BGDThkrdOLmYA==
X-Received: by 2002:a2e:bc1e:0:b0:2d2:eeda:c019 with SMTP id b30-20020a2ebc1e000000b002d2eedac019mr3566205ljf.28.1711293549955;
        Sun, 24 Mar 2024 08:19:09 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 08:19:09 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: fix Ethernet and random MAC's on WeTek Hub/Play2
Date: Sun, 24 Mar 2024 15:19:03 +0000
Message-Id: <20240324151905.3817732-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 24 Mar 2024 15:19:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2239

In submitting the original patches for WeTek Hub/Play2 I appear to have
squashed an experimental change to place the u-boot.dtsi file on the common
board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
creates per-board u-boot.dtsi files to fix that. However, while the NIC is
now probed correctly the current p200.c board file doesn't find the MAC in
efuse and we get random MAC addresses. Patch 2 adds a fallback method for
generating a MAC from the CPU serial.

Changes from v1:
- Simplified p200.c changes
- Drop patch 3

Christian Hewitt (2):
  ARM: dts: fix Ethernet on WeTek Hub/Play2
  board: amlogic: add meson_generate_serial_ethaddr fallback to p200

 ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
 board/amlogic/p200/p200.c                           |  2 ++
 3 files changed, 15 insertions(+)
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

-- 
2.34.1


