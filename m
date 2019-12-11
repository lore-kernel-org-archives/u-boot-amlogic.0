Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web11.1355.1576056060781339914
 for <u-boot-amlogic@groups.io>;
 Wed, 11 Dec 2019 01:21:00 -0800
Received: by mail-pf1-f195.google.com with SMTP id l127so229187pfl.1
        for <u-boot-amlogic@groups.io>; Wed, 11 Dec 2019 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dy52K7fbq5mkxtR48VU3O+3OHQrTkWrm49RFXqhs+lU=;
        b=DTbube27xFFoul9s2enr58aZvyh3T3bpmrj9d3gnl6bP+ozX3CUi3jjiE3zKaXSWlT
         Cor/WCI7ZABE7BiDUr3XS116itgs7UhZAbQdOFXEcKL+yikp6ap85a8SUhCEgRBH1f+a
         FFfi9lIyLhljXHJ5VUvdL1JgaOuaRlpZhgLIS7w3i0UaiwvnWOXSssj1Z+Sz2kXXa5Fe
         GRYGRFBxzHD2McrQCGx1IjJj8shhBRRr0wnaMdfMlZgnSsem/vh3nIV1gtIpWijEFKYW
         klZHuvOn2OgJYNej+vED57GEjwz7babaTDgYXNrrMoLs39hgoLSZajuFWCuY4+4L7fUA
         fpeA==
Return-Path: <christianshewitt@gmail.com>
From: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] amlogic: add Khadas VIM3L support
Date: Wed, 11 Dec 2019 13:20:52 +0400
Message-Id: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Khadas VIM3L is a new revision of the VIM3 board that swaps the premium
A311D chip for Amlogic's mid-range S905D3 chip.

Christian Hewitt (2):
  ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
  boards: amlogic: add Khadas VIM3L support

 arch/arm/dts/Makefile                   |   1 +
 arch/arm/dts/meson-sm1-khadas-vim3l.dts |  95 +++++++++++++++++++++++
 board/amlogic/w400/README.khadas-vim3l  | 132 ++++++++++++++++++++++++++++++++
 configs/khadas-vim3l_defconfig          |  62 +++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
 create mode 100644 board/amlogic/w400/README.khadas-vim3l
 create mode 100644 configs/khadas-vim3l_defconfig

-- 
2.7.4

