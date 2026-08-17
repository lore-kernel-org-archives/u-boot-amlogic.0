Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CAC61DB9
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65.1786986987303774265
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=v2yyN5an;
 spf=pass (domain: brivo.com, ip: 209.85.219.45, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-902fc790cd5so22147526d6.1
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986986; x=1787591786; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTPbFoyA3t3S6oeZhs0Xhv7J45/3gq46lhnRwUHXSbk=;
        b=v2yyN5anOUdaOZwVKt7XLtw+Dw3Qli9ybXtEjittLQZopxsPnqhyI5q2sLKU6wITv/
         WV5K4R9ImnI7evC+B8BpUA/AnXS5AWc7uWBzTLU58xE1Gmt2O6MlcyyRpXUBPM+mnE5w
         MVzM8LGg+QqPy2bXKJkEEhkYSmAiQA/2EIwSpW7upsz+MpiCQ1Hv6+HQkJbW4bsAKPgZ
         +ZUjPK13BssaTa8Ee0l5Zfct5194XpIUY6GzIQt5IluVuATXS1fbDTBVMcQvmEooC6K3
         nWot0NPAbz7287o995a4yNWq2ltTTZo/Kpu+8KYeTTNGsYCR/pvXgsJkqvt8lLAQ/A10
         REdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986986; x=1787591786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTPbFoyA3t3S6oeZhs0Xhv7J45/3gq46lhnRwUHXSbk=;
        b=WNeuW096iau1kY9GqiGdCGNwRREsC/dzt1jdQe1kVqVIZOb5yKJhrzFyOQlrtyLsQ3
         cmIeT2ZIBFga4ftXazYF8l/nsWmCHm9cxGExx78/nc1bc97IuR/MEnVnWxlOZtSZHElf
         p7vS2qAyaGs4KA/zgNEpQUDa/Tl1uQT0mgTuDNXR2ZVggd6w0Jn0qZZFxJksyUwWeMRF
         8D1GWe5vI6nHstHmd0n8FBW7Kgc9Gwido54XQ6pxkm6ZdQRAwooMF9uuIa8RNgI6RkXd
         sSG582+8hW1mBd7eUu/l0ClycHemFTUm45oVUFU4nA3Jhv0Pudaw0BOZTx3KSwOx9Myh
         vY7Q==
X-Gm-Message-State: AOJu0YzeFse6SK9dNQ9ugUOlung3LMxVnlLbr6ONGJkZe1P6TIFQKXVN
	BVIeoz5qa0Z6y8r9jdfL3795Mk5k/rk2dbun5PQU++qzTGttBuLXop5Vl9/IQ4TZzwla11U6KBQ
	BTvcPF605Eu4Q/hqhpvsjMqw5TvO3RqfM2IzkL2Y1CVjQJY6oDzgbsA==
X-Gm-Gg: AR+sD13wcLN4Pnpysbv405iKLrR+WyfB8KXYkyrlLei8CcZ8FmxmpwZRu7PVezw4AkY
	ykTgXSMeIbUeKyFQZ3R1N0906C5nlFeAKaUeSZK0CqGqXVXfW1m/t7aAwcBM2TK5VS86W2pUGx4
	FURCUeLZUx3DW6p646aZhN0hwzndjqmq6YyJ+lEpWKBKUYJAQFAsHUN38D8wvoYLRsxnyR9CuZ/
	xcOFtR7UkiNn1jTLJMhsglfhCDQQeS6h42gQwWTD8id7yOPlgXjN0Cj5XqbjJGHX+oM88NuYq4h
	bI02cWTxhG6Sw4whydHHP7OpneujWco/B3nvVD2b93AXifX7Op4omPRR2H8TTzHNxkYBia3ZjbB
	DT4H3AchclZWoiiQTUKZIuUzAjW7FTVq0Q2hRPpgOF7JWj9TniNs7BA1kl66yQFiNYVmbjSJZOJ
	7V6hIleZh8RkXxmZvoPokAsaE4BAhXjYUWMtBz7hbN9cDhFv1dABBBtrq+qGR/bEsnVruaBKU9Q
	qJn6tXla3AfGYCUequ1V6nZVdI=
X-Received: by 2002:a05:6214:3f8f:b0:8df:1814:3a1d with SMTP id 6a1803df08f44-90c4b3ded05mr25865496d6.22.1786986985957;
        Mon, 17 Aug 2026 10:16:25 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:25 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/9] arm64: meson: Add s4 support
Date: Mon, 17 Aug 2026 13:15:11 -0400
Message-ID: <20260817171623.1943847-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3036

This series (along with several patches submitted separately) adds basic
support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
patches on it is at [1].

I developed this for a custom board, but I believe a better candidate
for a defconfig would be the publicly-available Khadas VIM1S [2].
Unfortunately, I don't own any VIM1S boards, but I have included a
sample defconfig in the last patch. If anyone has a VIM1S, please test
that patch. You will need to use AMLogic's FIP [3], as I have not yet
gotten around to submitting a PR to LibreELEC's FIP.

[1] https://github.com/brivolabs/u-boot/tree/meson_s4
[2] https://www.khadas.com/vim1s
[3] https://github.com/khadas/u-boot-fip-yocto


Sean Anderson (9):
  arm64: meson: Add s4 SoC support
  clk: meson: a1: Eliminate separate id parameter
  clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
  clk: meson: Use soc-specific naming for common functions
  clk: meson: Export a1 functions to common file
  clk: meson: Support fractional fixed-factor clocks
  clk: meson: Support power-of-two dividers
  clk: meson: Add s4 clock driver
  [RFT] meson: Add Khadas VIM1S support

 arch/arm/include/asm/arch-meson/boot0.h |  14 +
 arch/arm/mach-meson/Kconfig             |   7 +
 arch/arm/mach-meson/Makefile            |   1 +
 arch/arm/mach-meson/board-s4.c          |  50 ++
 board/amlogic/q200/MAINTAINERS          |   1 +
 configs/khadas-vim1s_defconfig          |  80 ++++
 drivers/clk/meson/Kconfig               |   8 +
 drivers/clk/meson/Makefile              |   2 +
 drivers/clk/meson/a1.c                  | 495 +-------------------
 drivers/clk/meson/axg-ao.c              |  12 +-
 drivers/clk/meson/axg.c                 |  16 +-
 drivers/clk/meson/clk_meson.c           | 376 +++++++++++++++
 drivers/clk/meson/clk_meson.h           | 149 ++++++
 drivers/clk/meson/g12a-ao.c             |  12 +-
 drivers/clk/meson/g12a.c                |  24 +-
 drivers/clk/meson/gxbb.c                |  24 +-
 drivers/clk/meson/s4.c                  | 587 ++++++++++++++++++++++++
 17 files changed, 1318 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c
 create mode 100644 configs/khadas-vim1s_defconfig
 create mode 100644 drivers/clk/meson/clk_meson.c
 create mode 100644 drivers/clk/meson/s4.c

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_clk

-- 
2.53.0


