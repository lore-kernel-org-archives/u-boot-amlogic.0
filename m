Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308FC4332F
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 10:07:48 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.29722.1699844407121851284
 for <u-boot-amlogic@groups.io>;
 Sun, 12 Nov 2023 19:00:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=VLtML/wL;
 spf=pass (domain: chromium.org, ip: 209.85.166.174, mailfrom: sjg@chromium.org)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35749078a59so15132955ab.3
        for <u-boot-amlogic@groups.io>; Sun, 12 Nov 2023 19:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699844406; x=1700449206; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGGAhuv1ao7PDHIsXFlwhrpH6JEyYjCaG2p5iKBld00=;
        b=VLtML/wLMbGMq4yvOm8XP45BDhsgtGA319cJs3XZNwgn4OYD/bxKu0KkIY2QdUSIlR
         zAJe6XODYocEsmoAgFJJFFRS1XguwYdcLMyukJ+k3VHsCoZKlZZrAEJcaObdClsNStjf
         cWJe5UxAwy6L6VeRtoxKpfBuOobs7VdchAJrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699844406; x=1700449206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGGAhuv1ao7PDHIsXFlwhrpH6JEyYjCaG2p5iKBld00=;
        b=ItGxPBYcRuAWUU12MT1jhU6Si8B+L8FsvHlRmDB2SWiHoDhCnnvjzxJ7cCQgO4J7Q0
         PSHqTqTok6tI/dfyeq86xX1QATQn/xmUkdO63ail3U+ZbWeesJZJXNMRy0CFEeKKr+tz
         +Qib2w9Q9TmoNlfNUd0prZ6UT+MGuMneNMcnLVH+R16Yn+fAsY9Bn2PfXhIOj3J83sRw
         /d7AE4hpLaDLdu+4mzoKsXsaqzgrcdrT26k2gMIqGYEAJ7ps8SZLnP+Hmo5J5miTcnlG
         7b7d1fYtQTchb27qAzTG1sjTZ0UcPs5tMKNLV2n3r/6EKVsjIpCGAEww0/EL/lPdJPHn
         TOMg==
X-Gm-Message-State: AOJu0YwTq5UlvOkfyZO0lEFMuF8dy6gW5zHlHaPAgcXgRMtMu3O50XlG
	L3KGs0eZnBn73qQS3Is23gX9Pw==
X-Google-Smtp-Source: AGHT+IHU1QE61o46WmxygpOuB4smHvqEh/+H/Pz7/cZT6qjO9fp990CastmB1/8L4r/tGZyvbgafDg==
X-Received: by 2002:a05:6e02:1d13:b0:359:3d9a:2837 with SMTP id i19-20020a056e021d1300b003593d9a2837mr9768065ila.2.1699844405827;
        Sun, 12 Nov 2023 19:00:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 19:00:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Artur Rojek <artur@conclusive.pl>,
	Baruch Siach <baruch@tkos.co.il>,
	Bin Meng <bmeng.cn@gmail.com>,
	Breno Lima <breno.lima@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Montefoschi <francesco.montefoschi@udoo.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Mike Frysinger <vapier@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: [PATCH 0/9] sysinfo: Expand sysinfo with some more banner information
Date: Sun, 12 Nov 2023 19:58:20 -0700
Message-ID: <20231113030001.240020-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 13 Nov 2023 10:07:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1870

The show_board_info() function was adjusted to weak so that it could be
entirely replaced with a board-specific implementation.

The intended way for boards to provide their own information is via a
sysinfo driver. But currently there is no way to show anything other
than the model name.

This series adds support for showing a few more items, in a way that is
easy for boards to extend.

Since there is already a weak checkboard() function, we don't need to
have two levels of weak function here. So this series drops the weak
attribute from show_board_info()

Existing boards will see a slight change in output, in that the model
name will appear first, before any custom output. If that is a problem,
then the solution is to implement a sysinfo driver for the board.


Simon Glass (9):
  board: Move show_board_info() comment to header file
  meson: Use checkboard() instead of show_board_info()
  turris: Use checkboard() instead of show_board_info()
  solidrun: Use checkboard() instead of show_board_info()
  toradex: Use checkboard() instead of show_board_info()
  udoo: Use checkboard() instead of show_board_info()
  Revert "generic-board: make show_board_info a weak function"
  sysinfo: Allow displaying more info on startup
  x86: coreboot: Add a sysinfo driver

 arch/arm/mach-meson/board-info.c              |  2 +-
 arch/x86/cpu/coreboot/Kconfig                 |  2 +
 arch/x86/dts/coreboot.dts                     |  4 +
 board/CZ.NIC/turris_mox/turris_mox.c          |  2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
 board/coreboot/coreboot/Makefile              |  1 +
 board/coreboot/coreboot/coreboot.c            | 44 ---------
 board/coreboot/coreboot/sysinfo.c             | 89 +++++++++++++++++++
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |  7 +-
 board/toradex/apalis-imx8/apalis-imx8.c       |  2 +-
 board/toradex/apalis-tk1/apalis-tk1.c         |  2 +-
 board/toradex/apalis_imx6/apalis_imx6.c       |  3 +-
 board/toradex/apalis_t30/apalis_t30.c         |  2 +-
 .../toradex/colibri-imx6ull/colibri-imx6ull.c |  2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c   |  2 +-
 board/toradex/colibri_imx6/colibri_imx6.c     |  3 +-
 board/toradex/colibri_imx7/colibri_imx7.c     |  2 +-
 board/toradex/colibri_t20/colibri_t20.c       |  2 +-
 board/toradex/colibri_t30/colibri_t30.c       |  2 +-
 board/toradex/colibri_vf/colibri_vf.c         |  2 +-
 board/toradex/common/tdx-common.c             |  2 +-
 board/toradex/common/tdx-common.h             |  1 +
 board/udoo/neo/neo.c                          |  2 +-
 common/board_info.c                           | 80 +++++++++++------
 drivers/sysinfo/Kconfig                       |  7 ++
 include/init.h                                | 11 +++
 include/sysinfo.h                             |  3 +
 27 files changed, 189 insertions(+), 94 deletions(-)
 create mode 100644 board/coreboot/coreboot/sysinfo.c

-- 
2.42.0.869.gea05f2083d-goog


