Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.20315.1592233350963961915
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Jun 2020 08:02:31 -0700
Received: by mail-wm1-f45.google.com with SMTP id d128so15180116wmc.1
        for <u-boot-amlogic@groups.io>; Mon, 15 Jun 2020 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqB6snNUz3fwIMXhWA8+GoasIloWFgaX0twO8xYjKuc=;
        b=uWVX20Dg9W3hRG03k41HjvRz3jgW9MUb0YD6z9tRxOs84RKVxxFBhb7eIwcCls/r8E
         HFDSxpamCEHpltE/WZRK+rLfDUEQo3nzlILZ6UcQVGcqNNa2h8K1b5apXgpBpmjbI3d4
         YDZsApKn4wI2aKD5Cu+GejD44R9onVm84f2eO2+T/9WdI1MKUicNSo/UMgaOjjfA2ZpK
         3i2vGKFvN1R3mfEtpl+degZT+g4Ly8JIiUf0el99XuOayvgAGNu0S9QAbSQsV9WQ/9Jj
         2E9vOWpsGlpzp6K+k3fTE8eQ1SkWVqzqRDptgL5MxZI9BxztKp36x63v3Rwf0JGZe58d
         zROA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] board: amlogic: move boards doc into doc/board/amlogic
Date: Mon, 15 Jun 2020 17:02:23 +0200
Message-Id: <20200615150225.25841-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, xypron.glpk@gmx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

As asked by Tom, this moves all the Amlogic board documentation into
doc/board/amlogic into RsT and proper index with feature matrix.

Changes since v1:
- added SPDX-License-Identifier to rst files

Neil Armstrong (2):
  board: amlogic: move boards doc into doc/board/amlogic
  board: amlogic: add board doc files to MAINTAINERS

 MAINTAINERS                                   |   1 +
 board/amlogic/p200/MAINTAINERS                |   3 +
 board/amlogic/p201/MAINTAINERS                |   1 +
 board/amlogic/p212/MAINTAINERS                |   4 +
 board/amlogic/q200/MAINTAINERS                |   1 +
 board/amlogic/s400/MAINTAINERS                |   1 +
 board/amlogic/sei510/MAINTAINERS              |   1 +
 board/amlogic/sei610/MAINTAINERS              |   1 +
 board/amlogic/u200/MAINTAINERS                |   1 +
 board/amlogic/w400/MAINTAINERS                |   4 +
 doc/board/amlogic/index.rst                   |  95 +++++++++
 .../board/amlogic/khadas-vim.rst              | 140 ++++++-------
 .../board/amlogic/khadas-vim2.rst             | 138 ++++++-------
 .../board/amlogic/khadas-vim3.rst             | 191 ++++++++---------
 .../board/amlogic/khadas-vim3l.rst            | 191 +++++++++--------
 .../board/amlogic/libretech-ac.rst            | 144 +++++++------
 .../board/amlogic/libretech-cc.rst            | 141 ++++++-------
 .../board/amlogic/nanopi-k2.rst               | 138 +++++++------
 .../board/amlogic/odroid-c2.rst               |  52 +++--
 .../board/amlogic/odroid-n2.rst               | 189 ++++++++---------
 .../README.p200 => doc/board/amlogic/p200.rst | 138 ++++++-------
 .../README.p201 => doc/board/amlogic/p201.rst | 138 ++++++-------
 .../README.p212 => doc/board/amlogic/p212.rst | 138 ++++++-------
 .../README.q200 => doc/board/amlogic/q200.rst | 138 ++++++-------
 .../s400/README => doc/board/amlogic/s400.rst | 152 +++++++-------
 .../README => doc/board/amlogic/sei510.rst    | 192 ++++++++---------
 .../README => doc/board/amlogic/sei610.rst    | 187 +++++++++--------
 .../u200/README => doc/board/amlogic/u200.rst | 190 +++++++++--------
 .../README.w400 => doc/board/amlogic/w400.rst | 194 +++++++++---------
 doc/board/index.rst                           |   1 +
 30 files changed, 1536 insertions(+), 1369 deletions(-)
 create mode 100644 doc/board/amlogic/index.rst
 rename board/amlogic/p212/README.khadas-vim => doc/board/amlogic/khadas-vim.rst (24%)
 rename board/amlogic/q200/README.khadas-vim2 => doc/board/amlogic/khadas-vim2.rst (26%)
 rename board/amlogic/w400/README.khadas-vim3 => doc/board/amlogic/khadas-vim3.rst (19%)
 rename board/amlogic/w400/README.khadas-vim3l => doc/board/amlogic/khadas-vim3l.rst (19%)
 rename board/amlogic/p212/README.libretech-ac => doc/board/amlogic/libretech-ac.rst (21%)
 rename board/amlogic/p212/README.libretech-cc => doc/board/amlogic/libretech-cc.rst (46%)
 rename board/amlogic/p200/README.nanopi-k2 => doc/board/amlogic/nanopi-k2.rst (24%)
 rename board/amlogic/p200/README.odroid-c2 => doc/board/amlogic/odroid-c2.rst (56%)
 rename board/amlogic/w400/README.odroid-n2 => doc/board/amlogic/odroid-n2.rst (19%)
 rename board/amlogic/p200/README.p200 => doc/board/amlogic/p200.rst (23%)
 rename board/amlogic/p201/README.p201 => doc/board/amlogic/p201.rst (23%)
 rename board/amlogic/p212/README.p212 => doc/board/amlogic/p212.rst (23%)
 rename board/amlogic/q200/README.q200 => doc/board/amlogic/q200.rst (24%)
 rename board/amlogic/s400/README => doc/board/amlogic/s400.rst (21%)
 rename board/amlogic/sei510/README => doc/board/amlogic/sei510.rst (14%)
 rename board/amlogic/sei610/README => doc/board/amlogic/sei610.rst (16%)
 rename board/amlogic/u200/README => doc/board/amlogic/u200.rst (17%)
 rename board/amlogic/w400/README.w400 => doc/board/amlogic/w400.rst (17%)

-- 
2.22.0

