Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5EC5AC82
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 08:11:19 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16726.1786011909017118697
 for <u-boot-amlogic@groups.io>;
 Thu, 06 Aug 2026 03:25:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: tanurelinux@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1712a04ddaso311148066b.2
        for <u-boot-amlogic@groups.io>; Thu, 06 Aug 2026 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011907; x=1786616707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv1YABrvii8UrtQkjUuJYi0yHfAxzY2ARuJun5ZUUg8=;
        b=cLXp2/lfnUU0FksDDNOklaOHGbejgCqttg2efOAI1fQbPlpQpjQrRXG4BjBs3pV7BF
         W7+sWYfTBbnhcVwe5NMNqPONzEguqmn409iX8JrZ0xkbHQsymGnVgadvvIoMvxA/wFMb
         ydxRJW/upE3AICx4lrp4sHMr+i/12NtdLMphJHvIjONlUHqYiKPCjeaHvpnhva9hrAx9
         wdTOPIw7IzN+KlmNNTwmGjYneadBk1cL7XNFh19hRC3QvEipCZGlSYOhIlDGh2cVPqs8
         4geP9ATlEGgas42jiEOmQxwk8GsdgGr0KgG0754CXz7Gv3MHiH1dWstKi5OxUXO5uIHL
         cZsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhHt92vZKgufmBeIMF6MxI0nJelGjDyQQ1qZEBDCapEK8vetJKyT2iNGa5JT7pbZGerit7EnPC2Ya4t7KY7g==@groups.io
X-Gm-Message-State: AOJu0Yzfw+YhhCzweJ7q8RtgDZwNcpjzYvO7zQMt0tlbc+F1rVYB/N0V
	1oNUEBnJcwYbVK1wuPuPPs3E7Xd7iwCRBjbqDj3UUhozTsUIGPW65PspX5FUjA==
X-Gm-Gg: AR+sD12xt8hd3NpAjJ+Jm/MkZJ2+ESH5beIE8KrkTxWlNj8C16PJ061HKpI5qB53u3e
	48oBH85x1YqDj3lmgv9BDN4u0eupahcjyE6HGxtlP9Q+Wlkbfn2DstkS4D/voe1K8I4uQxnuNAH
	JoWBkPjlz8Zx17IRTSotdpOEl9PzKSfGCY9TQIvTtqSGkcd9c+3ogJokNTIOGbaSuyusGfK7Gux
	5KOahD1CsogzRmtcaDF6nO9mmx+c1CtX5w12WSbndI6UyThrCj5jC3g1oTpm7sNopjMgHM0/maM
	0IsjCI9zEu7rr3tja+0MjpKEV+5OMb6AX6+v4/QnUHiM1LvQPjFOERHuYnIHB0RpaIpDjpLIpSz
	3ue5WM9S97CGUdJQvhS5QFejAwyh/6eJ00nX+CXFXMelrgjrMM7s1KpclBTzs9NQXS9MHhxPFbR
	nb91R3J6icEJdi1+fRniWGbtkYbABOSYPzFQ3k6HAqFu3GjT7bsSsJo26DLymFth5Mxl8JySLSN
	3FfeeC9yQ/50W6vPhKIid23Bv4=
X-Received: by 2002:a05:600c:5686:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-4994e7c60c2mr122449515e9.10.1786011492992;
        Thu, 06 Aug 2026 03:18:12 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:18:12 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io,
	Lucas Tanure <tanure@linux.com>
Subject: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
Date: Thu,  6 Aug 2026 11:18:05 +0100
Message-ID: <20260806101809.72526-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 08:11:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3018

This series adds initial mainline support for the Amlogic T7 SoC
family and the Khadas VIM4 board (A311D2):
 - S4-generation UART support
 - the T7 platform code
 - VIM4 board and defconfig
 - VIM4 documentation

Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
(tftpboot) and cold-booted from an SD card.

Lucas Tanure (4):
  serial: meson: add Amlogic S4 UART support
  arm: meson: add Amlogic T7 SoC family support
  board: amlogic: add Khadas VIM4 support
  doc: board: amlogic: add Khadas VIM4 documentation

 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi |  22 ++++
 arch/arm/include/asm/arch-meson/boot0.h       |  18 +++
 arch/arm/mach-meson/Kconfig                   |  10 ++
 arch/arm/mach-meson/Makefile                  |   1 +
 arch/arm/mach-meson/board-t7.c                |  97 ++++++++++++++
 board/amlogic/vim4/MAINTAINERS                |   8 ++
 board/amlogic/vim4/Makefile                   |   4 +
 board/amlogic/vim4/vim4.c                     |  14 ++
 configs/khadas-vim4_defconfig                 |  27 ++++
 doc/board/amlogic/index.rst                   | 119 ++++++++---------
 doc/board/amlogic/khadas-vim4.rst             | 122 ++++++++++++++++++
 drivers/serial/serial_meson.c                 |  51 ++++++--
 12 files changed, 421 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-t7.c
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

-- 
2.55.0


