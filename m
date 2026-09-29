Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F04CCA5FA5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:25 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2885.1790705244752530913
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=GrqQD44B;
 spf=pass (domain: brivo.com, ip: 74.125.230.204, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2dea320fso453300685a.2
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705244; x=1791310044; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
        b=GrqQD44BAqT8NFFksPzUTPOfYcU/qQnvSQIkqMvlawyyZzGNbdQO9CEsZ+WiLtgTfl
         Jwlkh9c7pJqafCgpg2eNsgljDydwfE52xvNg5cSpv3o6dIbqqa7EgZkXOu2popriCKKy
         2uu5frOw3eM7bgSC19TTTB3/rBKLiyX0toGxNXZ0K0QrBTm4nYG2OCWgGhIxh7e6oC8g
         ObYeX5fZA/tebph+WYukxkeCZPyblqRr5sJmzekhzMMM782Gt4AhQ9NNY9CpJMXe7sCN
         HY3pr2RlNdu5era2DkqwaePudqdRcN0hklKTg9BeFzRrzubnqaSOHWm2chD5ylpkPjIy
         HMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705244; x=1791310044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBZmtfpV5NapNTjQVYNLYgTNXg38/j+JDNHjnLI5C6Q=;
        b=FhrIWeYQUZDlYyea6lwV3v4oSilbGUPdboI+hMdK0aUAloKz7l53wyPSyVzoYTckoK
         qqzdq4yYVlaTDHMZUdOkdUB0UpCk+lAqGKooR7B2jmQ627AGTgYZn2ByQonNfo3oNXAl
         huVibU1rShl8hA+XRY7vv715vRepxpR9P54Ojd5NPSpDN+HD6hBdUAAD9eqDORaxAYnV
         9/+JxNud3pkcToM0Po0z+Whil9EU7YMZC4NYk5hzobIMaHIMRnXkDU8occo4MHpKphyd
         lpSFohxZNu0Amt3bjvqT0jcul3aTp0NxzpINpWggrRYiKK18H3f7Wi4+ii0qMR8BLpct
         x+Ug==
X-Gm-Message-State: AFuF++lD5w3X2/ZPSArBM/vpSdSachyIOSrPNrAOPpH2xiSepGSkkXyT
	5Ap7eZCb0IgqSAjRfe8S0sX/wk587p/2/sJp5GK/ynv9gTkrMnVXVYjCSuf7G/rTMq98AN7DFXm
	a0siAg2Hp9AZptTKE9u/UO93EwaY/U4Gg2Z3jnlG6gxUWB2Rx+un+IQ==
X-Gm-Gg: AYBFou1LxgiRHtdqkZcUQN4YVxPse2q1QgvqG1balutXWHIJuAj1t1JJemT3P5Lgc8r
	4ps8uMrPCWyhONyS0CkxIcgh8o1A+7aExjYdn0lk1H26ag7sh5nZapSN/enCRm2y8JWNHk/NhWq
	UhcHRtt0VRsL/42IcrCX8ubDsXZtTK0qw9VYu/bjEQkNknVQAVPydlGHHbP2Y/Vy01v2G1KDKeY
	7nz+E4f6j6I/FolJua5iVXT8Bs/T22nZQaRmV/ifK/Afq+rtlMUaIZHDijUirqPp7mXKfB3RkrR
	iULtOtPo7p2pWriBL30jAs2lJ5vBqawv8j2aX86S/0xfbhVg5rTWURBAW5KLBs/7W/+YmsTVAJM
	E8eMNE6BuVmx/G0tb6lcUGiybx5Ix6trfdQndPAvtuzgn/Sf2qcDpQk0yji9KkJVF+F81PBXgqw
	T3IQNBR61ed6YYs4bzOi9RdHppb0dmABjxACoZfQTOjpJ1auBcdHOcAY5N6iddwhJ1rg==
X-Received: by 2002:a05:620a:370d:b0:93c:17db:d91f with SMTP id af79cd13be357-93c9fb59e46mr57265385a.39.1790705243208;
        Tue, 29 Sep 2026 11:07:23 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:22 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lukasz Majewski <lukma@denx.de>,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v2 0/9] arm64: meson: Add s4 support
Date: Tue, 29 Sep 2026 14:06:22 -0400
Message-ID: <20260929180721.3440839-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3103

This series (along with several patches submitted separately) adds basic
support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
patches on it is at [1].

I developed this for a custom board, but I believe a better candidate
for a defconfig is the publically-available Khadas VIM1S [2]. Khadas
has kindly sent me a VIM1S so I was able to add some more features and
fix a few bugs.

Creating a bootable image currently requires modifying AMLogic's
FIP [3]. Unfortunately, that software has a proprietary license and I
have already reviewed it in order to make the necessary modifications.
Therefore, I am wary about submitting patches to [4] (or binman). If
anyone would like to do so, I can try writing up a specification for you
to implement so we can avoid any copyright issues.

Linux boots but can't read either the eMMC or SD card (mmc0/mmc1):

[    1.537445] Run /init as init process
[    1.573054] mmc1: new SDHC card at address 0001
[    1.573722] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    1.578302]  mmcblk1: p1 p2
[    1.594234] mmc0: new HS200 MMC card at address 0001
[    1.595881] mmcblk0: mmc0:0001 AJTD4R 14.6 GiB
[    1.598333] mmcblk0boot0: mmc0:0001 AJTD4R 4.00 MiB
[    1.600596] mmcblk0boot1: mmc0:0001 AJTD4R 4.00 MiB
[    1.602689] mmcblk0rpmb: mmc0:0001 AJTD4R 4.00 MiB, chardev (239:0)
Starting systemd-udevd version 255.21^
[    1.681013] mmc2: new UHS-I speed SDR104 SDIO card at address 0001
[    1.758610] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    1.884396] mmc1: card 0001 removed
[    1.902656] hub 1-1:1.0: USB hub found
[    1.902829] hub 1-1:1.0: 4 ports detected
Waiting for /dev/mmcblk0p2 to show up...
[    2.083595] mmc1: new SDHC card at address 0001
[    2.084253] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    2.086749]  mmcblk1: p1 p2
[    3.102764] mmc1: card 0001 removed
[    3.247600] mmc1: new SDHC card at address 0001
[    3.248274] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    3.250416]  mmcblk1: p1 p2
[    4.254738] mmc1: card 0001 removed
[    4.399589] mmc1: new SDHC card at address 0001
[    4.400230] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    4.402721]  mmcblk1: p1 p2
[    5.406737] mmc1: card 0001 removed
[    6.604775] mmc1: new SDHC card at address 0001
[    6.605518] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    6.607752]  mmcblk1: p1 p2
[    6.774076] mmc1: tried to HW reset card, got error -95
[    6.774133] mmcblk1: recovery failed!
[    6.774594] I/O error, dev mmcblk1, sector 61066752 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 2
[    6.780963] I/O error, dev mmcblk1, sector 61067016 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 2
[    6.781018] mmc1: card 0001 removed
[    6.927580] mmc1: new SDHC card at address 0001
[    6.928252] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    6.930422]  mmcblk1: p1 p2
[    7.934738] mmc1: card 0001 removed
[    8.003206] meson-gx-mmc fe08a000.mmc: card claims to support voltages below defined range
[    8.003576] meson-gx-mmc fe08a000.mmc: no support for card's volts
[    8.004334] mmc1: error -22 whilst initialising SDIO card
[    8.032146] mmc1: error -95 whilst initialising SD card
[    9.163594] mmc1: new SDHC card at address 0001
[    9.164282] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    9.166825]  mmcblk1: p1 p2
[    9.334084] mmc1: tried to HW reset card, got error -95
[    9.334140] mmcblk1: recovery failed!
[    9.334605] I/O error, dev mmcblk1, sector 61067016 op 0x0:(READ) flags 0x80700 phys_seg 14 prio class 2
[    9.340984] I/O error, dev mmcblk1, sector 61067208 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 2
[    9.341040] mmc1: card 0001 removed
[    9.491572] mmc1: new SDHC card at address 0001
[    9.492239] mmcblk1: mmc1:0001 032GB 29.1 GiB
[    9.494407]  mmcblk1: p1 p2
[   10.526746] mmc1: card 0001 removed

Not sure what's going on. Maybe the drive strength needs to be adjusted?

[1] https://github.com/brivolabs/u-boot/tree/meson_s4
[2] https://www.khadas.com/vim1s
[3] https://github.com/khadas/u-boot-fip-yocto
[4] https://github.com/LibreELEC/amlogic-boot-fip

Changes in v2:
- Add S4 to meson board info
- Add DEBUG_UART defaults
- Extend initial padding to 4096 to match what Amlogic does
- Add ADC clocks
- Use our own board instead of reusing q200
- Enable more peripherals (buttons, LEDs, etc.)
- Use defaults where possible (commands, distro boot, etc.)
- Set mac address the same way Khadas does
- Set config/stdout-path so we can find the serial

Sean Anderson (9):
  arm64: meson: Add s4 SoC support
  clk: meson: a1: Eliminate separate id parameter
  clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
  clk: meson: Use soc-specific naming for common functions
  clk: meson: Export a1 functions to common file
  clk: meson: Support fractional fixed-factor clocks
  clk: meson: Support power-of-two dividers
  clk: meson: Add s4 clock driver
  meson: Add Khadas VIM1S support

 .../meson-s4-s905y4-khadas-vim1s-u-boot.dtsi  |   5 +
 arch/arm/include/asm/arch-meson/boot0.h       |  12 +
 arch/arm/mach-meson/Kconfig                   |   7 +
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-info.c              |   2 +
 arch/arm/mach-meson/board-s4.c                |  50 ++
 board/amlogic/vim1s/MAINTAINERS               |   7 +
 board/amlogic/vim1s/Makefile                  |   1 +
 board/amlogic/vim1s/vim1s.c                   |  26 +
 configs/khadas-vim1s_defconfig                |  66 ++
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   2 +
 drivers/clk/meson/a1.c                        | 495 +--------------
 drivers/clk/meson/axg-ao.c                    |  12 +-
 drivers/clk/meson/axg.c                       |  16 +-
 drivers/clk/meson/clk_meson.c                 | 376 +++++++++++
 drivers/clk/meson/clk_meson.h                 | 149 +++++
 drivers/clk/meson/g12a-ao.c                   |  12 +-
 drivers/clk/meson/g12a.c                      |  24 +-
 drivers/clk/meson/gxbb.c                      |  24 +-
 drivers/clk/meson/s4.c                        | 601 ++++++++++++++++++
 drivers/serial/Kconfig                        |   2 +
 22 files changed, 1358 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c
 create mode 100644 board/amlogic/vim1s/MAINTAINERS
 create mode 100644 board/amlogic/vim1s/Makefile
 create mode 100644 board/amlogic/vim1s/vim1s.c
 create mode 100644 configs/khadas-vim1s_defconfig
 create mode 100644 drivers/clk/meson/clk_meson.c
 create mode 100644 drivers/clk/meson/s4.c

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: s4_clk

-- 
2.53.0


