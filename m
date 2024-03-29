Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC334CD1283
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 17:51:59 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.2129.1711734715378747338
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Mar 2024 10:51:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wvyeSXIM;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4154bf94fe4so6983905e9.2
        for <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711734714; x=1712339514; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/3PMyTILLvsaICgzC2lvs5HwOM7NLCfRWcD03y4/xk=;
        b=wvyeSXIMtPy1dT4jONZm6utJQ4wRFx3FG+Paty+jKSTt19daO5FFjs434fv3IHIp9a
         IHKPTcyd5jIhimHQHPfSgBuHd/coE0h0RarFH8wVItOPMWiz7vcGTfyS7uUG5vdj/XV0
         qhWoRb+C63o0qe2wra7yBkpj7mmWlr0CjumC8+I8NJt1x/HLrnDUb2ZAXXfMCceylDTA
         FVLdLpx2Y0DHptDJLOhctzuSYTLkXT6Q/H2xi2rZ4nMZBekbOCUJVpplewJC6elwu9+f
         bKkGrc/Xh4FFflR7S3m+9e2Evb7Nk8Fok421XSCzeqMymY8D85S2OWAeBy2MxLhZchX7
         /o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734714; x=1712339514;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/3PMyTILLvsaICgzC2lvs5HwOM7NLCfRWcD03y4/xk=;
        b=EJ9a81OU0v0Q4jP7DM8E38XrkVD2Xt4s9kj1hApm9c7WjZiOwhTTBIzqpWYNWHg5OD
         QmHev1/iYpvChXeDNpOFpqEIc1rBJEun4KHtnrIe0zDYQK/yrfjsTPhdbKeRrbt2gIon
         iN8SeDBEcFIA4gvaS2mfIKPAxuSgtApyFmEHEhTSSMmseKO3V/DYqPJUVBeJA00pU5Xv
         gXjlcRSlrzI1SplpXfwXCvy225MofyG/eVK2NlsmHKjSk5uIMLt1gM1NdaxuHEh30rKx
         wIo0XmnOhWjrUTjVBGKKmhxLTUVd3r7BRHf9He3Vx6dFOYCW4JHVhl+DMqd5YowtrhYV
         2CLg==
X-Gm-Message-State: AOJu0Yy+LsCi0DXuO3PrLr3ljFn6jQR+ANtCUkM347iEwhORY76zCXDm
	X+EvhKC7a+Bc6AqdwMc33RAo1XvQrOI5YsqRnjPTnfpoehhMF1GYg5u1IcSiCnk=
X-Google-Smtp-Source: AGHT+IFabk3pXe2gWP20yiqByoTO8Xmuo2u0MhMcvUrpG4WdRNl5DE5gPj4ckyLRbZ0UfMnU9dl9Yw==
X-Received: by 2002:a7b:c4d1:0:b0:412:fa5f:7f85 with SMTP id g17-20020a7bc4d1000000b00412fa5f7f85mr1784402wmk.19.1711734713607;
        Fri, 29 Mar 2024 10:51:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:51:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
Date: Fri, 29 Mar 2024 18:51:47 +0100
Message-Id: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALP/BmYC/32NQQ6CMBBFr0Jm7ZhSCxFX3sOwKDCFSZQhUyAaw
 t2tHMDle8l/f4NIyhThlm2gtHJkGRPYUwbt4MeekLvEYI115pJXuGAjMqMEXKY4K/kXutIVLnT
 UFeQhDSelwO8j+qgTDxxn0c/xseY/+ze35mgwXG3TVoHKqjX3J49e5SzaQ73v+xcPd11dtQAAA
 A==
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8788;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=d1DUC1yr1yhEE84wRyIvlKTGYre4PIe0/w1fGgBfX6I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+2c8aLgSZRXkljoNlSBI8wMltWQ6hBLc3Yarxa
 4FX8IiGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/tgAKCRB33NvayMhJ0V8oEA
 DCbFu3wM4NIVq18FmMH3xRaUhTGHpvSKyURwROutG4yMkrRpGDrjj8oJvG8OgsqyOm18Yb3uMR00Z5
 62qEBoKXIbrO22FWKPEf1gHfLSdhMGYnDlbZrYF1wrCBeFxcHYqGHzkTZ/TDtkcZQcwwau6Yfzx87G
 V9dZ8QciOYwModd1pDYc3Eqfh7kPSts+QZD1w3UFFunbovuGdZnItpXYyPpyw5iJDFuD+19PoZa3XP
 Jq7c2tgX1jv/nyOsTyNV1yS81T6FIRCmorTbOA4doGQfc9w2IcmmRFQgVfufxQoqCn7cWtyoUh/6PP
 e4S07ZMjj+1gV+Oz0NI9D5W1JBtQiFXEokubdVlvWotU2jyQEoKxtQ/cvKdSs558EQ6uCWyR9pRW1I
 ZwPVWYRo2KcxEMw4zNvugcqGmYYpcPuFZt97f52YOIxdT297cvwgumadHuWfww6+o+hORL7ROwSzyR
 ++okq+1EVcN1VXI5LqIJSKOKnlQd42HZfk6eLLur1S/+mE2kSdiZ2CwtKK9+DuVDbjYRTmAEfMqgbO
 /EMDEgbkzjBye+x5IvEa0qsaXo9hLWCGcilu5X0QdeUh8etvkU+Wk+BtlcBFeYMN5a8pZ0FwSa5POD
 XlHciN5KQnpQs28UQyyUKxkxDxUwPw9OcboCgafqaGP+Gpmk34az4CF5fNwA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 17:51:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2256

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
kept in arch/arm/dts directory for these boards.

Keep A1 DTs locally since the architecture is still young.

CI built & tested at:
https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1233461384

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- add change to remove prefix in fdtfile
- collected review tags
- Link to v1: https://lore.kernel.org/r/20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org

---
Neil Armstrong (5):
      configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
      dts: meson: Switch GXL, GXM & AXG to using upstream DT
      dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      dts: meson-g12a: Switch to using upstream DT
      dts: meson: Drop redundant G12A, G12B & SM1 devicetree files

 arch/arm/dts/Makefile                              |   36 +-
 arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
 arch/arm/dts/meson-axg-s400.dts                    |  602 -----
 arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
 arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
 arch/arm/dts/meson-g12.dtsi                        |  385 ---
 arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
 arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
 arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
 arch/arm/dts/meson-g12a.dtsi                       |  140 --
 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
 arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
 arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
 arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
 arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
 arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
 arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
 arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
 arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
 arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
 arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
 arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
 arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
 arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
 arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
 arch/arm/dts/meson-g12b.dtsi                       |  146 --
 arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
 arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
 arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
 arch/arm/dts/meson-gx.dtsi                         |  675 ------
 arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
 arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
 arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
 arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
 arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
 arch/arm/dts/meson-gxl.dtsi                        |  940 --------
 arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
 arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
 arch/arm/dts/meson-gxm.dtsi                        |  216 --
 arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
 arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
 arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
 arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
 arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
 arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
 arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
 arch/arm/dts/meson-sm1.dtsi                        |  550 -----
 arch/arm/mach-meson/Kconfig                        |    4 +
 configs/bananapi-cm4-cm4io_defconfig               |    2 +-
 configs/bananapi-m2-pro_defconfig                  |    2 +-
 configs/bananapi-m2s_defconfig                     |    2 +-
 configs/bananapi-m5_defconfig                      |    2 +-
 configs/beelink-gsking-x_defconfig                 |    2 +-
 configs/beelink-gt1-ultimate_defconfig             |    2 +-
 configs/beelink-gtking_defconfig                   |    2 +-
 configs/beelink-gtkingpro_defconfig                |    2 +-
 configs/jethub_j100_defconfig                      |    2 +-
 configs/jethub_j80_defconfig                       |    2 +-
 configs/khadas-vim2_defconfig                      |    2 +-
 configs/khadas-vim3_android_ab_defconfig           |    2 +-
 configs/khadas-vim3_android_defconfig              |    2 +-
 configs/khadas-vim3_defconfig                      |    2 +-
 configs/khadas-vim3l_android_ab_defconfig          |    2 +-
 configs/khadas-vim3l_android_defconfig             |    2 +-
 configs/khadas-vim3l_defconfig                     |    2 +-
 configs/khadas-vim_defconfig                       |    2 +-
 configs/libretech-ac_defconfig                     |    2 +-
 configs/libretech-cc_defconfig                     |    2 +-
 configs/libretech-cc_v2_defconfig                  |    2 +-
 configs/libretech-s905d-pc_defconfig               |    2 +-
 configs/libretech-s912-pc_defconfig                |    2 +-
 configs/odroid-c4_defconfig                        |    2 +-
 configs/odroid-go-ultra_defconfig                  |    2 +-
 configs/odroid-hc4_defconfig                       |    2 +-
 configs/odroid-n2_defconfig                        |    2 +-
 configs/odroid-n2l_defconfig                       |    2 +-
 configs/p212_defconfig                             |    2 +-
 configs/radxa-zero2_defconfig                      |    2 +-
 configs/radxa-zero_defconfig                       |    2 +-
 configs/s400_defconfig                             |    2 +-
 configs/sei510_defconfig                           |    2 +-
 configs/sei610_defconfig                           |    2 +-
 configs/u200_defconfig                             |    2 +-
 configs/wetek-core2_defconfig                      |    2 +-
 include/configs/meson64.h                          |    8 +-
 include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
 include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
 include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
 include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
 include/dt-bindings/power/meson-axg-power.h        |   14 -
 include/dt-bindings/power/meson-g12a-power.h       |   13 -
 include/dt-bindings/power/meson-gxbb-power.h       |   13 -
 include/dt-bindings/power/meson-sm1-power.h        |   18 -
 .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
 .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
 include/dt-bindings/sound/meson-aiu.h              |   18 -
 include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
 include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
 117 files changed, 49 insertions(+), 21512 deletions(-)
---
base-commit: 6e2228fb052b68c84688d5baff06e2ebc787a4a5
change-id: 20240319-u-boot-of-upstream-46454fded5ea

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


