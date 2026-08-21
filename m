Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B13C61DC5
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3451.1787302367831372289
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Aug 2026 01:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: tanurelinux@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so9017921fa.1
        for <u-boot-amlogic@groups.io>; Fri, 21 Aug 2026 01:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302366; x=1787907166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RL/69i8TbXeToJ/clC/EM1MXP2QwwjK6LtZb5BIvTZw=;
        b=kUqCj9YRRYiOaWsPj1Lh/1wOeUrdmvbccjWegPO4OlucDetNlzo5XBcJZxaQrN0QmN
         3ccw4+OrQ4qC9Ai9++NN3uaIxcd5zB0sZyS7NkBh33EDS09Z9P4ZmUJLmGS+JtT9j/i9
         VvXbOwg7oS0JHx8NIiDcUxNlSEVNVv0EHE77/tMnX8WFK8+/cD0NSkg4dvX9pfOKTQBl
         0BfT8ZPQe60980bJGSWmuq3B4QFom9aMl0+lThPOP0V8qoE9OCDZSIXTLZieKjXme+yu
         nGmiLZ9Ye54QztbpLF3Q5SBxotUmJBItbbdoNImzCS0+YNBrnTnNELRY3I478ShVi9Qe
         beHA==
X-Forwarded-Encrypted: i=1; AHgh+RrWP6n9YBdvbkKst/54ja7WJ9wGWl8cGh2eRTrEm79gqxDpCorykRfx7TXu5XWNyb8mSyjDZx5VQdpJIjChog==@groups.io
X-Gm-Message-State: AFuF++m4X3dq8MlvB1SskYpFq3vk6hcWbwaK/7ydO0LtpQtVbOmmoxI6
	IVE7QJvh17XXSNfuwby0QAse6JNszJgklISKT7rHGb/n/ECcwtPgTh336Us2GQ==
X-Gm-Gg: AR+sD106iMU/fCFcoIN1avqbLAmAi7nSCoOV40XsL4zCNxdAKFtuep0qVzhi4j72x3x
	Kd00DLc3AGu5Y0HYOnSGDZbXk1s9/BxGHbsqiaQegtsJA3JEME9dHA9CSw1gHQ/wGO1klizkNvl
	IFrRW/DM61jG7ZQ1XBZ4+Je7cqWqRbwIKqEj7us8r4c7olHVChBjCC2dl2yJdrpBWNdUZ9Xzyqd
	0yHMc36Kf5KDfUQr4R+vetZ8LhJ1whVJnQzJAn+dmOU1mz3G+JuiqdNnoiGGKsJeG8tCr0hUgLM
	fjk7Dx5BVVaK/VzB3RX7qkw25tp2SOwLrA23fgF4SgIPZ6tUnJQ04yf8qeTk8ByQ+0RWW1vISGS
	N5lyPjUmf9RO5l5l3IjR62zUP1I8YRJlEpqhnZcDM42rc+1IcaXRCOooALRM7JQDAH3v06v50yY
	77WhYURw70fUvbYWWmY0cvhgVQD4FXulyBUm1BIpCpqtwweafBaJWzmkTymroU6pB9DrV4Iyepc
	F8i0RWLPUEJHiiAM6AxUcMfEuA=
X-Received: by 2002:a05:600c:3107:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-499b82b4bdbmr60131615e9.7.1787301967403;
        Fri, 21 Aug 2026 01:46:07 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:46:06 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
Date: Fri, 21 Aug 2026 09:45:59 +0100
Message-ID: <20260821084603.25974-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3045

This series adds initial mainline support for the Amlogic T7 SoC
family and the Khadas VIM4 board (A311D2):
 - S4-generation UART support
 - the T7 platform code
 - VIM4 board and defconfig
 - VIM4 documentation

Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
(tftpboot) and cold-booted from an SD card.

Changes in v2:
 - move the T7 register and reserved memory defines to a new
   asm/arch-meson/t7.h header
 - shorten the MESON_T7 Kconfig help text to match the other SoCs
 - drop __maybe_unused from meson_init_reserved_memory(), the
   parameter is used
 - move the SoC-level bootph-all properties to a common
   amlogic-t7-u-boot.dtsi
 - drop CONFIG_SYS_PROMPT from the defconfig

Lucas Tanure (4):
  serial: meson: add Amlogic S4 UART support
  arm: meson: add Amlogic T7 SoC family support
  board: amlogic: add Khadas VIM4 support
  doc: board: amlogic: add Khadas VIM4 documentation

 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  16 +++
 arch/arm/dts/amlogic-t7-u-boot.dtsi           |  14 ++
 arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
 arch/arm/include/asm/arch-meson/t7.h          |  25 ++++
 arch/arm/mach-meson/Kconfig                   |   9 ++
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-t7.c                |  82 ++++++++++++
 board/amlogic/vim4/MAINTAINERS                |   8 ++
 board/amlogic/vim4/Makefile                   |   4 +
 board/amlogic/vim4/vim4.c                     |  14 ++
 configs/khadas-vim4_defconfig                 |  26 ++++
 doc/board/amlogic/index.rst                   | 119 ++++++++---------
 doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
 drivers/serial/serial_meson.c                 |  51 ++++++--
 14 files changed, 437 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/dts/amlogic-t7-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/include/asm/arch-meson/t7.h
 create mode 100644 arch/arm/mach-meson/board-t7.c
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

-- 
2.55.0


