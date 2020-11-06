Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.9714.1604655964825436621
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:46:05 -0800
Received: by mail-wm1-f52.google.com with SMTP id d142so726682wmd.4
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmXiFe0Ais2tddjBqxsaEGBH6q3HjjfDwTAtcFMQwj8=;
        b=GtXUfFpR2QAaLT89B78wK92rDYQZMQLNzC4KPKbPAgbhXTP12dijXwCc4oViDeTtEG
         atvVIXEdSHzmQsWrev6G2ypXCM3Hj1nHAMPCXFcRC2zXdrrpOsADj5qcA/hR2ouyugtb
         RAYQ5RLRHZ3BBdZU5EcRinvA/2z2znQMFtSMLPm40QZTHIUOsuA1pcDqSkhxXv2moEh9
         DriOelYyAb3pafaONceNilOpUKby/uqEcKU9tqmfePcg0cgTl0hIAHPfNsojv8Aqiinb
         n+GLZJjyfiNsYFdhsPUjxFEPlAxpINF7BGjoDGaiGPDZPGjSjYNA3/YDOMsFpQsfU+/7
         21CQ==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH RESEND v2 0/2] arm64: meson: add libretech cc v2 support
Date: Fri,  6 Nov 2020 10:45:53 +0100
Message-Id: <20201106094555.34241-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the Amlogic based libretech cc v2.
Like the v1, this revised platform used the s905x SoC.

Changes since v1:
- Move Makefile change to patch #1
- Amend documentation for libretech cc v2

Jerome Brunet (2):
  arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
  arm64: meson: add support for libretech-cc v2

 arch/arm/dts/Makefile                         |   1 +
 ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 +
 .../dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 ++++++++++++++++++
 board/amlogic/p212/MAINTAINERS                |   1 +
 configs/libretech-cc_v2_defconfig             |  82 +++++
 doc/board/amlogic/index.rst                   | 117 +++----
 doc/board/amlogic/libretech-cc.rst            |  15 +-
 7 files changed, 480 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
 create mode 100644 configs/libretech-cc_v2_defconfig

-- 
2.28.0

