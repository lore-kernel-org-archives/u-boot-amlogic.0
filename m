Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.10350.1608035539917357545
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 04:32:20 -0800
Received: by mail-wr1-f44.google.com with SMTP id m5so19657440wrx.9
        for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 04:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+OR7lXHQ+vBxZnd/FEq2j4oj0f/p1g8GrMx8D1l9GCE=;
        b=iSE716U2kuwBM4Fm7CZcoFO65a1ULnmWaX3a+ixSvXc9tQIE6+LUcSQuAyxo4b1SaU
         8quaBZNEsyIpAWxX1ZttEyM0nGJ+kx8DNIkgB4D1oBDGSAiI6QJULuGjg7xk+5Gqv2ag
         YX6DMg+2sYCNQ6ZaByvIe3engYdBJ+y7LgpKaMYqjNYWKrsJaBSeJVKCahbQNeNCPZ9c
         OByndnpD1lS96mXYp+Az3oYyXdy9/IpKNG/0obyHR03ZLD1IibEjkGaf6/Ev5D02aTOy
         Ls/fknMuzbvhyERBXa5/A+hFTFIAh3rni1GmTYOQKuxFBW4zr5n7tCQA81hdJk8Wrcuw
         jpog==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] board: amlogic: add WeTek Core2 support
Date: Tue, 15 Dec 2020 12:32:11 +0000
Message-Id: <20201215123214.18661-1-christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for the WeTek Core2 box which is based on the
Amlogic S912 (GXM) SoC. Patches are based on u-boot-amlogic-next branch
in the custodians tree.

Christian Hewitt (3):
  ARM: dts: import WeTek Core2 DTs from Linux 5.10
  boards: amlogic: add WeTek Core2 support
  boards: amlogic: update documentation for WeTek Core2

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/meson-gx-p23x-q20x.dtsi          | 324 ++++++++++++++++++
 .../arm/dts/meson-gxm-wetek-core2-u-boot.dtsi |   7 +
 arch/arm/dts/meson-gxm-wetek-core2.dts        |  87 +++++
 configs/wetek-core2_defconfig                 |  70 ++++
 doc/board/amlogic/index.rst                   |   3 +-
 doc/board/amlogic/wetek-core2.rst             |  90 +++++
 7 files changed, 581 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-gx-p23x-q20x.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-wetek-core2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-wetek-core2.dts
 create mode 100644 configs/wetek-core2_defconfig
 create mode 100644 doc/board/amlogic/wetek-core2.rst

-- 
2.17.1

