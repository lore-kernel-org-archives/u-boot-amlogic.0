Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D906BC3ABA9
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 14:56:02 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web11.1774.1746061514481749839
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Apr 2025 18:05:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=kyHvKK1v;
 spf=pass (domain: chromium.org, ip: 209.85.166.181, mailfrom: sjg@chromium.org)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d57143ee39so4021445ab.1
        for <u-boot-amlogic@groups.io>; Wed, 30 Apr 2025 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746061514; x=1746666314; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mXzvpxBoe0hJTZFZci+DBKVEXx/PiFiiDGA+OsJDLI=;
        b=kyHvKK1vQJdd+NQh4KP6nV9nEKmJQ8GaXpgdOCVfHVNtrM5yAiJqAskdRARUPwafLY
         MxpWVYpjzKsSrkjENuxQp/mxi16msFHzlaDzqn46r1EaAzDhCu3k2wMOEbX3kZIuY4E9
         TYrIe3cgifVAegrCq4OYsdCmhBvVdbF7zTVmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746061514; x=1746666314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mXzvpxBoe0hJTZFZci+DBKVEXx/PiFiiDGA+OsJDLI=;
        b=HVblyJSNHj+I8qO7+mZxLt6o1cImyidF7R+1qXDKhIusawfn9GRjfQS31Cg2/sdQUf
         +g5z0zCS84AaxMzs+fzD4vvDzV3Uh77tlzNEj3wLxRjdRmp8cqumFN5mY0BDheOGbaeC
         BLjIEiWi24x4VBcx0s6XAd4jyr6j7bxGsxPDpVCiUrzg12585yNyYUQOOsc9ZFunLwNI
         Q7OxxuWKrDf9EpjA9DDhaE3eomewAhkNNJtyKnNyVmybOSbmif2X6J76Bjz+UsoxcIAF
         0qYgk8+7l3hI9LjxzoAMza1KyDSVw8ai3BRpu9JwJ/kwmZ5xgbyZl/8DLRZGEIB3gzxf
         8xKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvoygTUAzgMdRV0WyEl1C6DNJWR1zQO7T51n3rksFIPdGhdTjR8jLccS22HDRAd1UAUlY8WMiZGZw1VKMS/Q==@groups.io
X-Gm-Message-State: AOJu0YzC9wnYwIXE6N/nT9ivBHtZWJJ7eHJpjtdvnHETgpmh3J53i7ZB
	+SXpu2XoE1NHYoRWRwBPUquozrReMt3UQGVm9hSPN1LSsIQ21ZmtXQtePgCpvw==
X-Gm-Gg: ASbGnct/DeJAYDFadFJxClpdA5EtwVxX5kxsXtKvHzMZw2PxcXW5URVSYPXP1p49B5W
	6L1Ni9yxOEsPJsIV0qcIPbKfJsAu9QueL+X6ey0SmtpOA6q4dDmkm/yMERsRMKlWhEP8Kz6gUyT
	ZHmy5AF3EGjSdZu7Lbm5bG8j7xMxpiVCtLY56MzjXV6J5m99CkJteS2I4XI9HCjKExzuvvWFoxb
	ePfffdYp9W2xlvJHzI3HMkccDQ/HjLmW7pv/oMBMfok/mcPB0xa+nQ+2kYNdpUQWSzrQUQlS/iM
	qFrGORG92z+GzN1PRNy3lrzmlCaLqJPz2lcJRigBSgCgSUheZcRxPtr8PvNo5MjFIA5Xm/d7LBF
	Ieg==
X-Google-Smtp-Source: AGHT+IFPmrXMeW9+cuf3yW9byCqlHgsKs/WwOrUEw8MXqrC8BPDhwkMk+ao8hsRB6Sxdwwh05YLQhw==
X-Received: by 2002:a05:6e02:1689:b0:3d9:2aa3:fe2e with SMTP id e9e14a558f8ab-3d967fb0b20mr51876945ab.10.1746061513606;
        Wed, 30 Apr 2025 18:05:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net. [73.203.119.151])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 18:05:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Simon Glass <sjg@chromium.org>,
	Adrian Alonso <adrian.alonso@nxp.com>,
	Adriano Cordova <adrianox@gmail.com>,
	Daniel Palmer <daniel@0x0f.com>,
	Daniel Schultz <d.schultz@phytec.de>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Hanyuan Zhao <hanyuan-z@qq.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilko Iliev <iliev@ronetix.at>,
	Jason Liu <jason.hui.liu@nxp.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Lukasz Majewski <lukma@denx.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Maxim Moskalets <maximmosk4@gmail.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Otavio Salvador <otavio@ossystems.com.br>,
	=?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
	Peng Fan <peng.fan@nxp.com>,
	Phil Sutter <phil@nwl.cc>,
	Ramon Fried <rfried.dev@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Stefano Babic <sbabic@denx.de>,
	Stephen Warren <swarren@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Tom Warren <twarren@nvidia.com>,
	Tony Dinh <mibodhi@gmail.com>,
	Viacheslav Bocharov <adeep@lexina.in>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 00/22] Deal with exfat versus byteorder
Date: Wed, 30 Apr 2025 19:04:25 -0600
Message-ID: <20250501010456.3930701-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 01 May 2025 14:56:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2665

Since exfat has its own byteorder functions we need to be careful about
including the normal U-Boot byteorder headers in code included by exfat.

One chain for include/linux/byteorder/little_endian.h is like this:

In file included from arch/sandbox/include/asm/byteorder.h:19,
                 from arch/sandbox/include/asm/byteorder.h:19,
                 from include/compiler.h:132,
                 from include/env.h:12,
                 from include/command.h:13,
                 from include/net-common.h:7,
                 from include/net.h:6,
                 from include/efi.h:23,
                 from include/blk.h:12,
                 from include/part.h:9,
                 from include/fs_internal.h:11,
                 from fs/exfat/io.c:52:

This series tidies things up so that efi.h can include net.h as
required.

Changes in v2:
- Add patches for other files exposed by this change

Simon Glass (22):
  net: Use a forward declaration for cmd_tbl in net-common.h
  congatec: Include env.h to permit reading the environment
  dhelectronics: Include env.h to permit reading the environment
  imx8ulp_evk: Include env.h to permit reading the environment
  venice: Include env.h to permit reading the environment
  phytec: Include env.h to permit reading the environment
  ronetix: Include env.h to permit reading the environment
  toradex: Include env.h to permit reading the environment
  advantech: Include env.h in imx8qm_dmsse20_a1
  tegra: Include env.h to permit reading the environment
  synology: Include env.h to permit reading the environment
  amlogic: Include env.h to permit reading the environment
  freescale: Include env.h to permit reading the environment
  google: Include env.h to permit reading the environment
  liebherr: Include env.h to permit reading the environment
  technexion: Include env.h to permit reading the environment
  elf: Only use network environment-variables if net enabled
  net: Include byteorder in net6.h
  net: Include string.h in net-legacy.h
  net: Include env.h in pcap.c
  net: dc2114x: Include env.h to permit reading the environment
  net: Move env_get_ip() out of the header file

 arch/arm/mach-tegra/dt-setup.c                |  1 +
 board/Synology/ds414/ds414.c                  |  1 +
 .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
 board/amlogic/jethub-j100/jethub-j100.c       |  1 +
 board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
 board/dhelectronics/common/dh_common.c        |  1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
 board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
 board/gateworks/venice/venice.c               |  1 +
 board/google/chameleonv3/board.c              |  2 +
 board/liebherr/xea/xea.c                      |  1 +
 .../common/phytec_som_detection_blocks.c      |  1 +
 board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
 board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
 board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
 cmd/elf.c                                     | 41 ++++++++++---------
 drivers/net/dc2114x.c                         |  1 +
 include/net-common.h                          |  9 ++--
 include/net-legacy.h                          |  1 +
 include/net6.h                                |  1 +
 net/net-common.c                              |  6 +++
 net/pcap.c                                    |  1 +
 23 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: fix-net2

