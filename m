Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.10787.1621007886875433727
 for <u-boot-amlogic@groups.io>;
 Fri, 14 May 2021 08:58:07 -0700
Received: by mail-wr1-f54.google.com with SMTP id n2so30552555wrm.0
        for <u-boot-amlogic@groups.io>; Fri, 14 May 2021 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=psnl3GBrgOgWgHlILQbe2ovyO9MH2YZoT+V5slX+LwE=;
        b=sF179xnRij0dDCjPZG4zu6DnR3+10JUuOfvdhNctZuR0/sIFgsFQrcj5ytlsW26+1U
         KsaxPOwoasoTjFyRhwlOjSkIfGfGzaiyWMWzFkiNbYHW8a0mCeZFL+MDA3f8J+61q51p
         lvjk5+aqbkC9QecEDKAPSCLFZjDbH4cF8f5pfxZQdNsEWIBvA5FsiktT/b6H5en2e8iV
         xKj2aqDVpJ8YLg+vSX3eAjHT5EcSuvFWp51xUqq/rxJmCCBAWJguAJXuhYPu7oszWZzO
         rVIP3m2byQkN7dU2f3n4EV2pUeqIgLFiW4B/KONolv9pfrm8moa7Ogp9TYtZx8FCkDod
         KCFw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210514
Reply-To: narmstrong@baylibre.com
Message-ID: <dc4fe719-b0fd-d1be-a57b-144045bec05a@baylibre.com>
Date: Fri, 14 May 2021 17:58:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

please find a few dwmac meson8b glue fixes, dwc3 meson-g12a probe fix and the missing stuff
to have HDMI working on the Beelink GTKing/King-Pro boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/7516

Thanks,
Neil

The following changes since commit 530c8d4af2e18c6142ab7cac6f11dd92c02b2bc9:

  Merge branch '2021-05-13-extension-board-detection-and-DT-overlay-application' (2021-05-13 13:09:14 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210514

for you to fetch changes up to 4c2eb955cfd77d667485c5141cda2821aa1f97ef:

  net: designware: meson8b: add g12a compatible (2021-05-14 17:46:50 +0200)

----------------------------------------------------------------
- dts: add missing -u-boot.dtsi to enable HDMI on Beelink GTKing/King-Pro
- usb: dwc3-meson-g12a: skip phy on -ENODATA aswell
- net: dwmac_meson8b: do not set TX delay in TXID & RXID
- net: designware: meson8b: add g12a compatible

----------------------------------------------------------------
Neil Armstrong (4):
      ARM: dts: add missing -u-boot.dtsi to enable HDMI on Beelink GTKing/King-Pro
      usb: dwc3-meson-g12a: skip phy on -ENODATA aswell
      net: dwmac_meson8b: do not set TX delay in TXID & RXID
      net: designware: meson8b: add g12a compatible

 arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi |  7 +++++++
 arch/arm/dts/meson-g12b-gtking-u-boot.dtsi     |  7 +++++++
 drivers/net/dwmac_meson8b.c                    | 24 ++++++++++++++++++++----
 drivers/usb/dwc3/dwc3-meson-g12a.c             |  2 +-
 4 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12b-gtking-pro-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-gtking-u-boot.dtsi
