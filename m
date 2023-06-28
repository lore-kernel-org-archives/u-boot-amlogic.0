Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.12536.1687946471414543670
 for <u-boot-amlogic@groups.io>;
 Wed, 28 Jun 2023 03:01:11 -0700
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31114b46d62so6325706f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 28 Jun 2023 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687946470; x=1690538470;
        h=content-transfer-encoding:subject:organization:content-language:cc
         :to:reply-to:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3bAnqmIKHT+4UxbelUSzMVPeOlsiXmI4sh6POAP5eY=;
        b=KL61dVtaZynoCsN4GQ06bE2OTJ8HVrHgjDxgYGgTHIoBc6GsWFrIdv7qWmuiZ/C+mW
         90uaUHY3hisuCHhJloz1ZFMHcx90Y69o8DiNNG9Qx7czdZsPsl1C5oyh5+OIMayQ8TOp
         T/Hq1Rp9WiMSLZk73QfGzhx6xdyf5i0+cVSIxsL3RXES6rsuxyOJGpqZ/Du6w5ibBzp/
         nAqIQs7f3+zudTjY++hTuymqg65j6K+SzR1ZAiS9SFSQPeyo0hWaMTMcnEJR68UiRn9e
         C+53eNAODyyU7ylKp5Ap0dUvnVgIHWKM7A+6pFxxIHVhhj26ZxfOJCUhSjxRo69W/w33
         tgig==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <40724077-3912-36c6-6ac5-56ae8fb12b7c@linaro.org>
Date: Wed, 28 Jun 2023 12:01:08 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20230628
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

A set of changes for next release, including:
- A1 SoC support with associated reference boards
- KII Pro board support based on GXBB SoC
- New Secure power domains driver for A1 SoC

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/16718

Thanks,
Neil

The following changes since commit eef4a771e85fc30a18719316a23d0ad1476ae1a5:

   Merge branch '2023-06-21-fix-get_ram_size-with-cache-enabled' into next (2023-06-22 09:59:43 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20230628

for you to fetch changes up to 58edf5773adcc95105bbd814dcbe43b1d9804391:

   drivers: meson: introduce secure power controller driver (2023-06-28 10:05:34 +0200)

----------------------------------------------------------------
- add support for Amlogic A1 SoC and ad401 board
- add support for Videostrong KII Pro
- introduce secure power domain for A1 SoC

----------------------------------------------------------------
Alexey Romanov (3):
       arch/arm: meson: sm: introduce power domain functions
       dt-bindings: power: add Meson A1 PWRC bindings
       drivers: meson: introduce secure power controller driver

Ferass El Hafidi (3):
       arm: dts: add support for Videostrong KII Pro
       boards: amlogic: add KII Pro defconfig
       doc: boards: amlogic: add documentation for KII Pro

Igor Prusov (5):
       ARM: dts: Add Amlogic Meson A1 DT from Linux 6.3-rc7
       ARM: dts: sync meson-a1-ad401 from Linux 6.3-rc7
       ARM: meson: add A1 support
       pinctrl: meson: add pinctrl driver for Amlogic A1
       board: amlogic: add support for AD401 board

  arch/arm/dts/Makefile                       |   2 +
  arch/arm/dts/meson-a1-ad401.dts             |  30 +
  arch/arm/dts/meson-a1.dtsi                  | 161 ++++++
  arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi |  13 +
  arch/arm/dts/meson-gxbb-kii-pro.dts         | 140 +++++
  arch/arm/include/asm/arch-meson/a1.h        |  20 +
  arch/arm/include/asm/arch-meson/sm.h        |  30 +
  arch/arm/mach-meson/Kconfig                 |   7 +
  arch/arm/mach-meson/Makefile                |   1 +
  arch/arm/mach-meson/board-a1.c              |  59 ++
  arch/arm/mach-meson/sm.c                    |  14 +
  board/amlogic/ad401/MAINTAINERS             |   6 +
  board/amlogic/ad401/Makefile                |   4 +
  board/amlogic/ad401/ad401.c                 |  15 +
  board/amlogic/p200/MAINTAINERS              |   2 +
  configs/ad401_defconfig                     |  54 ++
  configs/videostrong-kii-pro_defconfig       |  70 +++
  doc/board/amlogic/index.rst                 |   1 +
  doc/board/amlogic/videostrong-kii-pro.rst   | 112 ++++
  drivers/pinctrl/meson/Kconfig               |   4 +
  drivers/pinctrl/meson/Makefile              |   1 +
  drivers/pinctrl/meson/pinctrl-meson-a1.c    | 867 ++++++++++++++++++++++++++++
  drivers/power/domain/Kconfig                |   7 +
  drivers/power/domain/Makefile               |   1 +
  drivers/power/domain/meson-secure-pwrc.c    | 160 +++++
  include/configs/meson64.h                   |   3 +
  include/dt-bindings/gpio/meson-a1-gpio.h    |  73 +++
  include/dt-bindings/power/meson-a1-power.h  |  32 +
  28 files changed, 1889 insertions(+)
  create mode 100644 arch/arm/dts/meson-a1-ad401.dts
  create mode 100644 arch/arm/dts/meson-a1.dtsi
  create mode 100644 arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
  create mode 100644 arch/arm/include/asm/arch-meson/a1.h
  create mode 100644 arch/arm/mach-meson/board-a1.c
  create mode 100644 board/amlogic/ad401/MAINTAINERS
  create mode 100644 board/amlogic/ad401/Makefile
  create mode 100644 board/amlogic/ad401/ad401.c
  create mode 100644 configs/ad401_defconfig
  create mode 100644 configs/videostrong-kii-pro_defconfig
  create mode 100644 doc/board/amlogic/videostrong-kii-pro.rst
  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-a1.c
  create mode 100644 drivers/power/domain/meson-secure-pwrc.c
  create mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h
  create mode 100644 include/dt-bindings/power/meson-a1-power.h


