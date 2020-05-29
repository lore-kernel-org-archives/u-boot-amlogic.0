Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.32849.1590753184042403089
 for <u-boot-amlogic@groups.io>;
 Fri, 29 May 2020 04:53:05 -0700
Received: by mail-wr1-f46.google.com with SMTP id r7so3281377wro.1
        for <u-boot-amlogic@groups.io>; Fri, 29 May 2020 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=TkfuU4DcD5sWDDQbiYTfuExVAEK7P3MAGPGiZfHr9Ww=;
        b=nViE4MWFHXGsWU+RRHXCWiBBusFG047Lxc6qpqkQW3GKLbVzu19BsfWkwbZjEHboI/
         L4YsDucrVfWVeddbcR6wJseiJXkfZiOv1/beGKfXlhoLsx/9Ai0Qd/yAPF3Ts7ZC6OqE
         DC9zhs6uNAG+FPMDweR1sD/HE58XgkN7IB0q85X8pcQxV8YHcq5XnLPciRrxOALr9Lhc
         FlLx6g1bJgOTtq+iDqxkL93Q3GwN5HQUGmdlLr7ZooXcqT+iLV9AGsN+TGdWH41+b4nA
         f8mnclBTC01i3NRa1zDHxKocyK5x5EMakD58eSaK8kw5SoALzVRUV2COQMmY6tL7jjIP
         rSMw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200529
Reply-To: narmstrong@baylibre.com
Message-ID: <0bf95451-23be-3f5f-251d-e1ebd0f75140@baylibre.com>
Date: Fri, 29 May 2020 13:53:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR enables HDMI on Khadas VIM3/VIM3 board and fixes USB gadget support for
libretech-ac/pc & vim/vim2 boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/3473

Thanks,
Neil

The following changes since commit ab80137cc436e977ef91a154372ae5aeae3f4fb0:

  Merge https://gitlab.denx.de/u-boot/custodians/u-boot-marvell (2020-05-27 10:56:25 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200529

for you to fetch changes up to 3678a5f0597d1cd491e3bded19ea72e570b5c8b1:

  arm: dts: meson-gxl: fix USB gadget by adding missing nodes for U-Boot (2020-05-29 10:20:34 +0200)

----------------------------------------------------------------
- Finally enable config to support HDMI console output in VIM3 boards
- Fix USB gadget support for libretech-ac/pc & vim/vim2 boards

----------------------------------------------------------------
Neil Armstrong (3):
      arm: dts: khadas-vim3: include meson-g12-common-u-boot.dtsi to enable HDMI output
      configs: khadas-vim3: enable HDMI output
      arm: dts: meson-gxl: fix USB gadget by adding missing nodes for U-Boot

 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 6 +++++-
 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi | 6 +++++-
 arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi   | 4 ++++
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi        | 6 +++++-
 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi  | 6 +++++-
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi            | 2 ++
 configs/khadas-vim3_defconfig                         | 9 +++++++++
 configs/khadas-vim3l_defconfig                        | 4 ++++
 8 files changed, 39 insertions(+), 4 deletions(-)
