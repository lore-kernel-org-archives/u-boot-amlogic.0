Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE532C3065B
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.125720.1719174637305499342
 for <u-boot-amlogic@groups.io>;
 Sun, 23 Jun 2024 13:30:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=O4D3oA0c;
 spf=pass (domain: chromium.org, ip: 209.85.166.44, mailfrom: sjg@chromium.org)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f38f5584ebso120397739f.3
        for <u-boot-amlogic@groups.io>; Sun, 23 Jun 2024 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719174636; x=1719779436; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02kH5fbssxZPV+CMxhJUpCxJVlosxneGWxXtZ+1mYNE=;
        b=O4D3oA0cwDyTTeOnWw3eW7p8KuFvEz/dZfvZs7NjywJ4Kk1qbsLKVtlifC3SxzdiWB
         7zfIhWWCHgB9+OjTkas5y4+rrdccLQo4dmJRQQUV8RREl3c6oQJKvPMFjRKY0+dU8KRc
         5IqkXkIKe/MwgO3EAZGQR5XqptohC8dRxclqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719174636; x=1719779436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02kH5fbssxZPV+CMxhJUpCxJVlosxneGWxXtZ+1mYNE=;
        b=tDGCArdp+LohuDZANYxyfVVj7fkktDt5YsQqYxRFFoe2jKLmF8ML+8iF7YZXMDOl2K
         WvMIKQcx78coQzXBt/UBSHUWY/IPdwJQRvWiKMUkXPhLZ/nzQcCA28oLltn1GleYrf3R
         gSbT/naEb9ma9JlHw/0SSYKRTxCBl6NjQkYOF5GigbpjzkfaOWFgLcjomkhHuDqYqmMs
         c0kuOj1OK0paxlLFc2FJEMhN+q3cOwv8rx2taBkMXlLk0f2YkT8WD326iNC0CeMCKI6y
         lPwIAapeMHLj4aa1qiYhowekkH7GvF5u5asLLyVy0ehq351xux4/f5yj+aRYih3Kvflm
         GRgg==
X-Forwarded-Encrypted: i=1; AJvYcCXdiQp0415dRUFx+U/Du11qrzl2UanEq7r0jODwnfXJEW9YvTExaTYicwj3HlQupW42QgkI5nDSIgZSifu5rGRza0V8+sLXQY0=
X-Gm-Message-State: AOJu0Yz2wUbI+NFERdRjNFLAmmeF3DN0N3ZX4+Q59Pr9njba2x8HDM/+
	cp50pkXRknYJLJOhxxRZaUIYthrz1xHmnzmFCyNihUCgLUAe1rmIGG5ECI9ISQ==
X-Google-Smtp-Source: AGHT+IFG2O45FRONHY8f336gydDkuy0V2P8Aq9sfdDlBRoz1u1ZhNkAo047RJqHqFyf0LOcJ0zPitw==
X-Received: by 2002:a05:6602:1688:b0:7eb:7bc9:7fc2 with SMTP id ca18e2360f4ac-7f3a4e59c7emr321165339f.20.1719174636443;
        Sun, 23 Jun 2024 13:30:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 13:30:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Alexander Gendin <agendin@matrox.com>,
	Allen Martin <amartin@nvidia.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Bin Meng <bmeng.cn@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Francis Laniel <francis.laniel@amarulasolutions.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Pavel Herrmann <morpheus.ibis@gmail.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Trevor Woerner <twoerner@gmail.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 00/14] testb: Various tweaks and fixes for Labgrid
Date: Sun, 23 Jun 2024 14:30:19 -0600
Message-Id: <20240623203033.1566505-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2321

This series includes a number of mostly unrelated changes which are in
service of running U-Boot on a lab using Labgrid.

Changes in v2:
- Add new patch to update u-boot.cfg with CFG_... options

Simon Glass (14):
  trace: Update test to tolerate different trace-cmd version
  dm: core: Enhance comments on bind_drivers_pass()
  initcall: Correct use of relocation offset
  am33xx: Provide a function to set up the debug UART
  sunxi: Mark scp as optional
  google: Disable TPMv2 on most Chromebooks
  meson: Correct driver declaration for meson_axg_gpio
  test: Make bootstd init run only on sandbox
  log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
  test: dm: Show failing driver name
  test: Decode exceptions only with sandbox
  test: Check help output
  Update u-boot.cfg to include CFG also
  smbios: Correct error handling when writing tables

 arch/arm/dts/sunxi-u-boot.dtsi                |  1 +
 arch/arm/mach-omap2/am33xx/board.c            | 18 +++++++++++++++---
 configs/chromebook_link64_defconfig           |  1 +
 configs/chromebook_link_defconfig             |  1 +
 configs/chromebook_samus_defconfig            |  1 +
 configs/chromebook_samus_tpl_defconfig        |  1 +
 configs/nyan-big_defconfig                    |  4 +---
 configs/snow_defconfig                        |  1 +
 drivers/core/lists.c                          | 16 ++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     |  4 ++--
 drivers/pinctrl/meson/pinctrl-meson-axg.h     |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  4 ++--
 lib/initcall.c                                |  6 ++++--
 lib/smbios.c                                  | 10 ++++++++--
 scripts/Makefile.autoconf                     |  2 +-
 test/py/tests/test_dm.py                      |  5 ++++-
 test/py/tests/test_help.py                    |  6 +++++-
 test/py/tests/test_log.py                     | 11 +++++++----
 test/py/tests/test_trace.py                   |  6 +++---
 test/py/tests/test_ut.py                      |  1 +
 test/py/u_boot_console_sandbox.py             |  2 +-
 test/py/u_boot_spawn.py                       | 10 ++++++----
 23 files changed, 84 insertions(+), 31 deletions(-)

-- 
2.34.1


