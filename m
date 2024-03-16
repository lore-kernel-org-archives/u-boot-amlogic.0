Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388EC54E6A
	for <webhook@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:49 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.7039.1710597276734808465
 for <u-boot-amlogic@groups.io>;
 Sat, 16 Mar 2024 06:54:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LO2CqYfG;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: christianshewitt@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41409c98fd4so882205e9.0
        for <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597275; x=1711202075; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kt/YjxGxxxRTEXNRaujnbBUr5TtFYZAAACdznTR67QE=;
        b=LO2CqYfGfsPfe/RfEJdacV5E07NbuQfyEBOCyMuoUfYu50xYnrAlahjEevR41mJzgT
         NJG4banXIUsFmuHeNbBCnDW6Gf+PdzEAyso9LM+eHEQKQddFnl7GHmuPBPoAUF7LVwoN
         Ss4PvqmltTnlpcxp7lizbz6fdeV+x6bi06Z/2U3QkN+lYdyU+muHHXwZa/P8B0T/6I2G
         G3VPmco9y7sp1ZNMbgBFbxN+yHlKUtK+DVMTXodz4Rj9p08zxc0IxFhgYti6RGySfp/U
         FOqB8zOWoyqVjDAu1W88nTZSLhB4kMyD5tXM7Qpkp2TbaVhnKAX0tobRAQdNhf7gk/cW
         yT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597275; x=1711202075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kt/YjxGxxxRTEXNRaujnbBUr5TtFYZAAACdznTR67QE=;
        b=l6UC1J5IG3+4se7JUoM/qVYLr/pgZEW3yEGl8JkbByCi9sAQR+Ln0byzQdw66LmE7E
         0GKFnoyZz33Czy0RCweUUg1Mjsm8FZBZ/7ZnHtGPs3zOuJbkbAGhQKjvp3L3gY8SY7fQ
         2ZtLEfsZNZ34FjE1eB7nF/xfR1pA/RlDlXPkvF6iTqIhDcQnugqeQ/7wrb6EE4p39VSm
         njZUrKHJagAkEzy5YZp2zYFIbfw5imbhY3rZEThvYmgZ49QOu5kqAsmeyf8fpIQDZl/f
         hxljPU35x2I2SQvHjnVTGV3NdI97YjvWlhJH50/j2jyQ1oPHVmDOlWvCp7QJ4FgOxNrk
         SaSg==
X-Forwarded-Encrypted: i=1; AJvYcCXRR7kF67xMmCUWryLTBihO5K+Ax+dMAQdju7us0b8/cN1A2rIdQUF6YYB9pyLhVxgHZ2Y4fVKvU6hzWCEledyi6V3lFEyBlDY=
X-Gm-Message-State: AOJu0Yy96zmCjz7auuc0na0LFewyX84aSBKJVYcJsXozaSHZLInDMxBc
	/T2n0dKEX60UnTedOBjslkAbiRjpEtjbglCOr6DhGgPiEoCPQefZ
X-Google-Smtp-Source: AGHT+IGYxko7SOhWbl0XhbZC2hlDbIu9Uyg0oBzjsgz5cMhOL4IYHGlOEO0cArEepQ4PLNvpMrDW5w==
X-Received: by 2002:a05:600c:3505:b0:414:630:26ba with SMTP id h5-20020a05600c350500b00414063026bamr1928214wmq.15.1710597274911;
        Sat, 16 Mar 2024 06:54:34 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:54:33 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] ARM: dts: fix Ethernet and random MAC's on WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:27 +0000
Message-Id: <20240316135430.826898-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 13:54:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2192

In submitting the original patches for WeTek Hub/Play2 I appear to have
squashed an experimental change to place the u-boot.dtsi file on the common
board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
creates per-board u-boot.dtsi files to fix that. However, while the NIC is
now probed correctly this results in random MAC addresses. Setting the p200
family in board configs also does not work, so patch 2 revises (overwrites)
the board init function using the same code as VIM3 which reads the factory
MAC from efuse correctly, and patch 3 sets board family to ensure boards
have a static MAC. The alternative would be to create a dedicated board
definition for wetek boards. If that would be preferred, let me know and I
can rework the changes to do that. And apologies for the mistake on the
original submission.

Christian Hewitt (3):
  ARM: dts: fix Ethernet on WeTek Hub/Play2
  ARM: board: meson: update efuse MAC reading code
  configs: amlogic: set board family to avoid random MAC on WeTek
    Hub/Play2

 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi | 14 ++++++++
 ...tsi => meson-gxbb-wetek-play2-u-boot.dtsi} |  0
 board/amlogic/p200/p200.c                     | 35 +++++++++++--------
 configs/wetek-hub_defconfig                   |  1 +
 configs/wetek-play2_defconfig                 |  1 +
 5 files changed, 37 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-play2-u-boot.dtsi} (100%)

-- 
2.34.1


