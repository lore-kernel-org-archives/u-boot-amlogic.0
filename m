Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.192337.1673946710276768442
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jan 2023 01:11:50 -0800
Received: by mail-wm1-f49.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so20465809wma.1
        for <u-boot-amlogic@groups.io>; Tue, 17 Jan 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SF5s2IX+3Xh7hC+IDwpzzbovesvDaJnFzQQWTrU1/IA=;
        b=uBX7E8u02Dkhb5m/CpaD0TXNV0ZOqiqsgFT3sZ002Q+fMlYuhFmAqbHi91adJTnvIi
         VJupB67k7fPiqPZfOc6fj+gYgHvgoxHSoXsv2snzBfnQDJU8ytdI8/NUUo6cIhxW9Mpi
         WG1GRpsheG9rWa2dn84KA78w5A5jMoHfcKpYrIcaPavi+7WjEWEEaf8HXzeSR+rs5wSj
         fH8euvUrdng/zGxHwXu4rdKssa10E4wD8eWPN72svELVzfl/YJpgNGpcpBLiSpy9+410
         47X80lc64QqN09N/LxnrGGZ+p1oVJIB/BMwmcMBlUAxx4KLub0L1SnFi5KGVtojjbKvi
         sXKQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] mach-meson: port GXL & AXG dwc2_otg usage to CONFIG_DM_USB_GADGET=y
Date: Tue, 17 Jan 2023 10:11:45 +0100
Message-Id: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

This is the port of Mattijs work at [1] for G12A over GXL & AXG.

It uses the same design and should work as-is, it still needs to be
be extensively tested over the main GXL & AXG boards.

[1] https://lore.kernel.org/all/20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com/

To: Marek Vasut <marex@denx.de>
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (2):
      usb: dwc3-meson-gxl: force mode on child add/removal
      ARM: meson: switch AXG & GX dwc2 otg to DM

 arch/arm/mach-meson/board-axg.c      | 129 ---------------------------------
 arch/arm/mach-meson/board-gx.c       | 137 -----------------------------------
 configs/jethub_j100_defconfig        |   1 +
 configs/jethub_j80_defconfig         |   1 +
 configs/khadas-vim2_defconfig        |   1 +
 configs/khadas-vim_defconfig         |   1 +
 configs/libretech-ac_defconfig       |   1 +
 configs/libretech-cc_defconfig       |   1 +
 configs/libretech-s905d-pc_defconfig |   1 +
 configs/libretech-s912-pc_defconfig  |   1 +
 configs/s400_defconfig               |   1 +
 configs/wetek-core2_defconfig        |   1 +
 drivers/usb/dwc3/dwc3-meson-gxl.c    |  18 +++++
 13 files changed, 28 insertions(+), 266 deletions(-)
---
base-commit: b96640cbfb319071aea7915cfa2f7aefe08bbc08
change-id: 20230117-u-boot-usb-gxl-otg-dm-013ee8718190

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
