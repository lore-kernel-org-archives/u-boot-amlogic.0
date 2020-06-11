Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web12.7357.1591882127024484319
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Jun 2020 06:28:47 -0700
Received: by mail-wm1-f41.google.com with SMTP id l17so4999136wmj.0
        for <u-boot-amlogic@groups.io>; Thu, 11 Jun 2020 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XU+TZMUQEPydzxIxnw88zynB3iRnp5/W9fhNArO2wKo=;
        b=UxP09bF9KnE3BKh9X+iHxcLKDz/Sp0MLgZ0FKQIrM4dURg3cVRKe7Z15/p3wDo5zzr
         WItccyHLhQmzkHLxQQCYLyDQPavaPC6ukXxtjBwvdc+fh5p2CeYKYzlsQJYlgkPPIGwQ
         zC1barIkXbjoiB1a6DhXeDnNFWT6YI2WE0K97aVr0fWz0NtkTUbEogBGhslf/vjN3zBv
         LCOFnml9nLqiE4JMTPMy6KHTcWxQIPrDJvi7US7ym0phdUaA/h1kEAOWjVwmBCKIGD4M
         hKfdTVPvfyo+1DcpWuPzqSb0W85oKv0+hXbW+GSMj/wIcvxaokjB92ZYnBk8Q0m38whH
         iYNA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/2] board: amlogic: move boards doc into doc/board/amlogic
Date: Thu, 11 Jun 2020 15:28:39 +0200
Message-Id: <20200611132841.6546-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, xypron.glpk@gmx.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

As asked by Tom, this moves all the Amlogic board documentation into
doc/board/amlogic into RsT and proper index with feature matrix.

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
 .../board/amlogic/khadas-vim.rst              | 138 +++++++------
 .../board/amlogic/khadas-vim2.rst             | 138 ++++++-------
 .../board/amlogic/khadas-vim3.rst             | 189 +++++++++--------
 .../board/amlogic/khadas-vim3l.rst            | 189 +++++++++--------
 .../board/amlogic/libretech-ac.rst            | 142 ++++++-------
 .../board/amlogic/libretech-cc.rst            | 139 +++++++------
 .../board/amlogic/nanopi-k2.rst               | 136 +++++++------
 .../board/amlogic/odroid-c2.rst               |  50 +++--
 .../board/amlogic/odroid-n2.rst               | 187 +++++++++--------
 .../README.p200 => doc/board/amlogic/p200.rst | 136 ++++++-------
 .../README.p201 => doc/board/amlogic/p201.rst | 136 ++++++-------
 .../README.p212 => doc/board/amlogic/p212.rst | 136 ++++++-------
 .../README.q200 => doc/board/amlogic/q200.rst | 136 ++++++-------
 .../s400/README => doc/board/amlogic/s400.rst | 150 +++++++-------
 .../README => doc/board/amlogic/sei510.rst    | 190 ++++++++---------
 .../README => doc/board/amlogic/sei610.rst    | 185 +++++++++--------
 .../u200/README => doc/board/amlogic/u200.rst | 188 ++++++++---------
 .../README.w400 => doc/board/amlogic/w400.rst | 192 +++++++++---------
 doc/board/index.rst                           |   1 +
 30 files changed, 1502 insertions(+), 1369 deletions(-)
 create mode 100644 doc/board/amlogic/index.rst
 rename board/amlogic/p212/README.khadas-vim => doc/board/amlogic/khadas-vim.rst (24%)
 rename board/amlogic/q200/README.khadas-vim2 => doc/board/amlogic/khadas-vim2.rst (26%)
 rename board/amlogic/w400/README.khadas-vim3 => doc/board/amlogic/khadas-vim3.rst (20%)
 rename board/amlogic/w400/README.khadas-vim3l => doc/board/amlogic/khadas-vim3l.rst (19%)
 rename board/amlogic/p212/README.libretech-ac => doc/board/amlogic/libretech-ac.rst (21%)
 rename board/amlogic/p212/README.libretech-cc => doc/board/amlogic/libretech-cc.rst (46%)
 rename board/amlogic/p200/README.nanopi-k2 => doc/board/amlogic/nanopi-k2.rst (24%)
 rename board/amlogic/p200/README.odroid-c2 => doc/board/amlogic/odroid-c2.rst (56%)
 rename board/amlogic/w400/README.odroid-n2 => doc/board/amlogic/odroid-n2.rst (19%)
 rename board/amlogic/p200/README.p200 => doc/board/amlogic/p200.rst (24%)
 rename board/amlogic/p201/README.p201 => doc/board/amlogic/p201.rst (24%)
 rename board/amlogic/p212/README.p212 => doc/board/amlogic/p212.rst (24%)
 rename board/amlogic/q200/README.q200 => doc/board/amlogic/q200.rst (24%)
 rename board/amlogic/s400/README => doc/board/amlogic/s400.rst (21%)
 rename board/amlogic/sei510/README => doc/board/amlogic/sei510.rst (14%)
 rename board/amlogic/sei610/README => doc/board/amlogic/sei610.rst (16%)
 rename board/amlogic/u200/README => doc/board/amlogic/u200.rst (17%)
 rename board/amlogic/w400/README.w400 => doc/board/amlogic/w400.rst (17%)

-- 
2.22.0

