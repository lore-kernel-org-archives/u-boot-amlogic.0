Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.11612.1679312774262615127
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:14 -0700
Received: by mail-wr1-f54.google.com with SMTP id y14so10041509wrq.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClI8K0bVgHtAV00Y4vIPX36r5/Z7oiWGKTY+DpiCK9M=;
        b=UnI2Eg1XpCy5nThneE++AFVeVj9ZmeNYWXWe8HwgQRpXa/pZt2A8jwxcpdlL02BS6v
         HG/undqoNW2mLxmUJ084Ot2af/P9x3SjgJtn1OpG00c6+R9KaAJl4brG9VJX1BeaB+H+
         pnZAlpaOeDn0QpCuJtHJyaa7w4B1DPn1yz3OqCBSyV2XZiYWWrWlqry7qWaei/L8Fcc0
         44Ao19En8q6VWFtKnjiw32DIS/ldXYBF3NvuKt19F6IJm6/ZBbmnQIyy7UYiW5EYHrvI
         6St52Cxdf18mbdrd7sAa6JUfFd5utLAqxGvrxAzI9Cpx1kXwTZSDeb43oVuoTIXfSjmn
         VRwQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 00/33] doc: board: amlogic: spring clean-up of Amlogic docs
Date: Mon, 20 Mar 2023 11:45:36 +0000
Message-Id: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Amlogic documentation spans U-Boot support from 2015-current resulting
in older content being harder to follow. And due to many international
contributors the docs also contain grammar quirks.

This series reworks all board documents to be more consistent. There is
deliberate emphasis on using the amlogic-boot-fip repo for signing tasks
as this is easier for most users to follow. The original/longer signing
process (described as Manual Signing) has been tidied up.

In the index.rst file I've dropped board names from the features table
as this adds considerable width and makes adding new boards a fiddly
process. I've appended the SoC type to the boader header so it shows in
the TOC list to retain a reference between boards and the table.

I've added missing board docs for GS-King-X, BPI-M5, BPI-CM4IO, and we
split ODROID-HC4 into its own document. It originally followed the same
process as the ODROID0-C4, but now has a separate defconfig to enable
SPI-NOR and PCIe SATA support. Users occasionally follow the current
doc and build U-Boot for the C4 which omits this and then struggle to
figure out why SATA boot doesn't work when wiki/forums say it does.

There are other minor cleanups and tweaks for clarity of simply more
up-to-date information for a board or process.

Please review and flag any omissions or issues!

Christian Hewitt (33):
  doc: boards: amlogic: update documentation for index page
  doc: boards: amlogic: update documentation for boot-flow
  doc: boards: amlogic: update documentation for pre-generated-fip's
  doc: boards: amlogic: update documentation for Beelink GT-King
  doc: boards: amlogic: update documentation for Beelink GT-King Pro
  doc: boards: amlogic: update documentation for JetHub J100
  doc: boards: amlogic: update documentation for JetHub J80
  doc: boards: amlogic: update documentation for Khadas VIM
  doc: boards: amlogic: update documentation for Khadas VIM2
  doc: boards: amlogic: update documentation for Khadas VIM3
  doc: boards: amlogic: update documentation for Khadas VIM3L
  doc: boards: amlogic: update documentation for LaFrite
  doc: boards: amlogic: update documentation for LePotato
  doc: boards: amlogic: update documentation for NanoPi-K2
  doc: boards: amlogic: update documentation for ODROID-C2
  doc: boards: amlogic: update documentation for ODROID-C4
  doc: boards: amlogic: update documentation for ODROID GO ULTRA
  doc: boards: amlogic: update documentation for ODROID-N2/N2+
  doc: boards: amlogic: update documentation for ODROID-N2L
  doc: boards: amlogic: update documentation for P200
  doc: boards: amlogic: update documentation for P201
  doc: boards: amlogic: update documentation for Q200
  doc: boards: amlogic: update documentation for Radxa Zero
  doc: boards: amlogic: update documentation for S400
  doc: boards: amlogic: update documentation for SEI510
  doc: boards: amlogic: update documentation for SEI610
  doc: boards: amlogic: update documentation for U200
  doc: boards: amlogic: update documentation for W400
  doc: boards: amlogic: update documentation for WeTek Core2
  doc: boards: amlogic: add documentation for BananaPi CM4IO
  doc: boards: amlogic: add documentation for BananaPi M5
  doc: boards: amlogic: add documentation for GS-King-X
  doc: boards: amlogic: add documentation for ODROID-HC4

 board/amlogic/beelink-s922x/MAINTAINERS |   3 +-
 board/amlogic/u200/MAINTAINERS          |   1 -
 board/amlogic/w400/MAINTAINERS          |   2 +
 doc/board/amlogic/bananapi-cm4io.rst    | 152 ++++++++++++++++++++
 doc/board/amlogic/bananapi-m5.rst       | 141 +++++++++++++++++++
 doc/board/amlogic/beelink-gskingx.rst   | 121 ++++++++++++++++
 doc/board/amlogic/beelink-gtking.rst    | 120 ++++++++--------
 doc/board/amlogic/beelink-gtkingpro.rst | 120 ++++++++--------
 doc/board/amlogic/boot-flow.rst         | 178 ++++++++++++------------
 doc/board/amlogic/index.rst             | 141 +++++++++----------
 doc/board/amlogic/jethub-j100.rst       |  66 ++++-----
 doc/board/amlogic/jethub-j80.rst        |  46 +++---
 doc/board/amlogic/khadas-vim.rst        |  76 +++++-----
 doc/board/amlogic/khadas-vim2.rst       |  76 +++++-----
 doc/board/amlogic/khadas-vim3.rst       | 137 +++++++++---------
 doc/board/amlogic/khadas-vim3l.rst      | 137 +++++++++---------
 doc/board/amlogic/libretech-ac.rst      |  77 +++++-----
 doc/board/amlogic/libretech-cc.rst      | 109 ++++++---------
 doc/board/amlogic/nanopi-k2.rst         |  93 +++++++------
 doc/board/amlogic/odroid-c2.rst         |  54 +++----
 doc/board/amlogic/odroid-c4.rst         | 117 ++++++++--------
 doc/board/amlogic/odroid-go-ultra.rst   |  25 +++-
 doc/board/amlogic/odroid-hc4.rst        | 141 +++++++++++++++++++
 doc/board/amlogic/odroid-n2.rst         | 122 ++++++++--------
 doc/board/amlogic/odroid-n2l.rst        |  33 +++--
 doc/board/amlogic/p200.rst              |  87 +++++++-----
 doc/board/amlogic/p201.rst              |  87 +++++++-----
 doc/board/amlogic/pre-generated-fip.rst | 138 +++++++++++-------
 doc/board/amlogic/q200.rst              |  76 +++++-----
 doc/board/amlogic/radxa-zero.rst        |  45 +++---
 doc/board/amlogic/s400.rst              |  89 ++++++------
 doc/board/amlogic/sei510.rst            | 113 ++++++++-------
 doc/board/amlogic/sei610.rst            | 118 ++++++++--------
 doc/board/amlogic/u200.rst              | 113 ++++++++-------
 doc/board/amlogic/w400.rst              | 115 ++++++++-------
 doc/board/amlogic/wetek-core2.rst       |  83 ++++++-----
 36 files changed, 2042 insertions(+), 1310 deletions(-)
 create mode 100644 doc/board/amlogic/bananapi-cm4io.rst
 create mode 100644 doc/board/amlogic/bananapi-m5.rst
 create mode 100644 doc/board/amlogic/beelink-gskingx.rst
 create mode 100644 doc/board/amlogic/odroid-hc4.rst

-- 
2.34.1

