Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web08.1056.1638384223781424651
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Dec 2021 10:43:43 -0800
Received: by mail-qt1-f170.google.com with SMTP id n15so25104811qta.0
        for <u-boot-amlogic@groups.io>; Wed, 01 Dec 2021 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pwXgj6NWZRCnSoEPGVibBGSgV5QvTyqW4SBj7Gc3Yw=;
        b=Ap7zen9aY+3IDE+7XSL7WanKaAu0EYDvKRJ+acnjSQh8tyJ9Qd2uQ28IPDFGzHzklY
         6OHdPUJZXdl+AxR3ToOd3ea/FgPPKrNkO/I9bwBe2j4GKXiho+inATjVRcQtgqNt2t83
         7w3gtWYDxJk+dWxbrgHyFFqfNmfGoFpebT7XaIXzradtVSupluKhSoU4vQoL4mx7brbt
         CsEvXZFxT7cv5zV+XX4kGVnoAr1uBL4AmZVxzCXfDHDK13F2MvxMsHV+XWNc+KYCAGFQ
         6+b6gf8gk4nW21KFS/41Bgo1ghmsMASH+fIbuFAfqOgYzMosZMc3xyoGO+fdfJr4ZUYC
         FZbA==
Return-Path: <seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/5] clk: Clean up optional helpers, and add API docs to HTML
Date: Wed,  1 Dec 2021 13:43:27 -0500
Message-Id: <20211201184332.2166897-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dariobin@libero.it>, Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <monstr@monstr.eu>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This cleans up the various optional helpers for clocks, and adds a new one.
While we're at it, also convert the existing API docs to our HTML documentation.


Sean Anderson (5):
  clk: Rename clk_get_optional_nodev
  clk: Inline clk_get_*_optional
  clk: Add client API to HTML docs
  clk: Add driver API to HTML docs
  clk: Add clk_get_by_name_optional

 doc/api/clk.rst            |  19 +++
 doc/api/index.rst          |   1 +
 drivers/clk/clk-uclass.c   |  21 ---
 drivers/clk/clk_zynq.c     |   5 +-
 drivers/phy/phy-mtk-tphy.c |   8 +-
 drivers/rng/meson-rng.c    |   4 +-
 include/clk-uclass.h       | 187 +++++++++++++----------
 include/clk.h              | 306 +++++++++++++++++++++----------------
 8 files changed, 310 insertions(+), 241 deletions(-)
 create mode 100644 doc/api/clk.rst

-- 
2.33.0

