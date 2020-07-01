Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.23334.1593614601654714386
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 07:43:22 -0700
Received: by mail-wr1-f67.google.com with SMTP id b6so24159101wrs.11
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a87g00hLPqDRELyh3hrWArf9xIg/buSzfqjXutEI8yI=;
        b=AJ+8NONF/cWlrdmEZBXq+qWrdcyOn935q0iIG6iSm06UCHdr078TRTtAx1rse8wnZQ
         mLQFFOVahP0/oyMa6oWLj6Axw948lTcypmfcMy7Hp4oVzxelhFRwh6J4aqGWjsDfUYPL
         d2PR/0yg8UygAGvwJrxmXwqmhGAgQyiNAKDlvYl8G256zucwVlPQvN3lecunMous4ny9
         Kl3nC5kwJg35+vdl6sBzdcVZvuLeyGhu6FH+xX8KLGw1bQKNifYTb2yWf3Y7QqRt8bv/
         R6g4MMwk5O+NJ/xKsagU6+edANS+/BK7GpYZpvWA71V253asB3ndyPQ363A0VJOJeBqR
         Dtng==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] board: amlogic: add Odroid C4 support
Date: Wed,  1 Jul 2020 16:43:07 +0200
Message-Id: <20200701144310.25481-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, linux.amoon@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the Hardkernel Odroid-C4 board
based on an Amlogic S905X3 SoC (SM1).

These patches were made very early from Christian Hewitt when the device
was unveiled by Hardkernel, and superseed the patchset from Beniamino Galvani
posted later.

Beniamino, sorry for posting this over your patchset, but they are essentially
the same and this one is already used by LibreELEC, Armbian and out KernelCI
boards.

It used the new Odroid-N2 board support instead of W400, and adds a doc
file in RsT format.

Christian Hewitt (2):
  ARM: dts: sync amlogic G12A/G12B/SM1 DT from Linux 5.8-rc1
  boards: amlogic: add Odroid C4 support

Neil Armstrong (1):
  ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset

 arch/arm/dts/Makefile                        |   1 +
 arch/arm/dts/meson-g12-common.dtsi           |  13 +-
 arch/arm/dts/meson-g12.dtsi                  |  32 +-
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi     |  22 +-
 arch/arm/dts/meson-g12b-s922x.dtsi           |  15 +
 arch/arm/dts/meson-g12b.dtsi                 |  22 +
 arch/arm/dts/meson-khadas-vim3.dtsi          |   4 +-
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi |  13 +
 arch/arm/dts/meson-sm1-odroid-c4.dts         | 402 +++++++++++++++++++
 arch/arm/dts/meson-sm1-sei610.dts            |   2 +-
 arch/arm/dts/meson-sm1.dtsi                  |  24 ++
 board/amlogic/odroid-n2/MAINTAINERS          |   2 +
 configs/odroid-c4_defconfig                  |  62 +++
 doc/board/amlogic/index.rst                  |   3 +-
 doc/board/amlogic/odroid-c4.rst              | 133 ++++++
 15 files changed, 713 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
 create mode 100644 configs/odroid-c4_defconfig
 create mode 100644 doc/board/amlogic/odroid-c4.rst

-- 
2.22.0

