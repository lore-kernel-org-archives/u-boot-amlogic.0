Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.70096.1674726514737733847
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Jan 2023 01:48:38 -0800
Received: by mail-wm1-f44.google.com with SMTP id o17-20020a05600c511100b003db021ef437so725367wms.4
        for <u-boot-amlogic@groups.io>; Thu, 26 Jan 2023 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2QdupnyyFdxIVgVbjalyK3fdtSstFzKtHOZCo+U9MM=;
        b=ty174gPzVuyKqM+Z4DQaIFe9xLPvip9WZI/qio7087OdfvCajoPo4JiJT5zmpoMq01
         QRSyRTrIfdT5Q0jdCtfOnJKKeCddv6/S/kXVl+QthVWdyAFaylz6r80vk4gN5/lplCk9
         JjWOh0SE6CbImjwGCkQTs8hG5PdbiUvMALHdfUfwcIPCiEI2BGlGI1n6Zje4bfWza2Xd
         swn4g0OW05yJG+KSgIwZ1CnyT6ERv3M73E17u6yIgg95zF0oKFhpqrZYUzmr8+U9kbhb
         DnDlMg6JWlU25nSOyBZYZYfAvk/W4xIShWAuYgsnKc9TfMFjH5oX9PNuMhvwCMXVNREJ
         aF+g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: meson: Add support for Odroid-N2L
Date: Thu, 26 Jan 2023 10:48:19 +0100
Message-Id: <20230126-u-boot-odroid-n2l-v1-0-c60f695e0f6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed
- On-board RTC is removed
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
  are available
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
  is recommended or a tall passive sink is optional
- 3.5mm earjack is removed
- IR remote receiver is removed
- MIPI DSI port is added

Is uses Odroid-N2L support posted at [1] and merged for Linux v6.3-rc1.

It doesn't use the odroid-n2 board support since ADC revision
collides with Odroid-N2+ and since it doesn't have on-board ethernet
no need to load the MAC address from eFuses.

[1] https://lore.kernel.org/all/20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      ARM: dts: Import Odroid-N2L support
      ARM: meson: Add support for Odroid-N2L

 arch/arm/dts/Makefile                          |   1 +
 arch/arm/dts/meson-g12b-odroid-n2.dtsi         | 410 +----------------------
 arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi |   7 +
 arch/arm/dts/meson-g12b-odroid-n2l.dts         | 125 +++++++
 arch/arm/dts/meson-g12b-odroid.dtsi            | 445 +++++++++++++++++++++++++
 configs/odroid-n2l_defconfig                   |  70 ++++
 doc/board/amlogic/index.rst                    |   2 +
 doc/board/amlogic/odroid-n2l.rst               |  31 ++
 8 files changed, 693 insertions(+), 398 deletions(-)
---
base-commit: 640192d04f9c4003959c967d11b2f98c3756c451
change-id: 20230126-u-boot-odroid-n2l-dc8b370b43c6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

