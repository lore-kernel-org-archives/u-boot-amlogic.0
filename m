Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.45483.1674135861549183944
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Jan 2023 05:44:21 -0800
Received: by mail-wm1-f52.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3036971wmb.0
        for <u-boot-amlogic@groups.io>; Thu, 19 Jan 2023 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=draiPVVe9G17TwdeLVB1TVlBeyCbgaPiZCJxtYg0c5w=;
        b=tvLVRWR5QvCigJWTQcR2oq3cGDGV65My0CC9dzKcY4j6L1kXDWuV+O8O5ZrTrpMd4g
         huz6/XHRC3vdTtCWutlv3VQw3rnOcFv3npQIThv7n7kdrNylr+FPRssuwNXqAnFKQZQh
         uEPPzc1EEj8Tm6g9H6hnWgWn6t+9NFxhHJb80JU2TZapc4w/oWaLoTssE4amvK/t8F4H
         KbsQyPYJGXxG962VLDQggz/E0eICgLKjmVxueYTDZjD7g3qDdNpzzkV2T1XL9arVR8qx
         3IchHlxV+KKLRyHKKKkhI6PSlDSwfmWnSk//F99Dadew58rN89uS1IZ3dfiuodWxMSBj
         x9fA==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: arch-meson: add support for Odroid Go Ultra
Date: Thu, 19 Jan 2023 14:44:17 +0100
Message-Id: <20230119-u-boot-odroid-go-ultra-v1-0-f96bab9db396@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

This adds initial support for the Hardkernel Odroid Go Ultra.

The Odroid Go Ultra is a portable gaming device with the following
characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

The following are not yet handled:
- Battery RK818 Gauge and Charging
- 5inch 854×480 MIPI-DSI TFT LCD
- Power Halt

Cc: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (2):
      ARM: dts: sync Amlogic ARM64 DT from v6.2-rc1
      ARM: meson: add support for Odroid Go Ultra

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/meson-g12-common.dtsi                 | 167 +++--
 arch/arm/dts/meson-g12a.dtsi                       |   5 +
 .../arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi |  16 +
 arch/arm/dts/meson-g12b-odroid-go-ultra.dts        | 722 +++++++++++++++++++++
 arch/arm/dts/meson-g12b.dtsi                       |   5 +
 arch/arm/dts/meson-sm1.dtsi                        |  52 +-
 configs/odroid-go-ultra_defconfig                  |  70 ++
 doc/board/amlogic/index.rst                        |   4 +-
 doc/board/amlogic/odroid-go-ultra.rst              |  34 +
 10 files changed, 999 insertions(+), 77 deletions(-)
---
base-commit: 62e2ad1ceafbfdf2c44d3dc1b6efc81e768a96b9
change-id: 20230119-u-boot-odroid-go-ultra-9d3c7ae3c910

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
