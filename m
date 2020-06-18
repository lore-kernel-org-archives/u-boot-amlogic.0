Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web12.7848.1592487854249595195
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jun 2020 06:44:15 -0700
Received: by mail-wr1-f50.google.com with SMTP id t18so6125391wru.6
        for <u-boot-amlogic@groups.io>; Thu, 18 Jun 2020 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=M8uSlmk4g01JcJu/b8xwha5z1EOeGFYV9ei/znptMtw=;
        b=GyotG5RxFeEezUjnmI/NulleX8Um2Ou40D8qCIhjTb0AK4btDyxVot9eXzFZb3TBQZ
         MMAP1F54vv9HH+yXJlr/AvwZg0C0ZrK8AZfDya8j51/lbTKRqQ4Kggb2kTikyt8Re9oE
         Qa8wRa7tThs2OvFww3u6FlxO3OtU/a1fVEP5kT5XGC6wJ+sdQKrRMAXmph9KOtU4e51r
         RT+7+5eNuIwyHTi87mRzafWG2cfhLAdr+lG7Q2EUm46Qfb7QWkUr/LFupZMAbtEVIXO+
         DlH2m11cL5pA38JyVQP8TjMVFc8PfaL+0556H5Mn+X6KrxYpqz2ivElhN0B6zMCqN8r2
         Lt5Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200618
Reply-To: narmstrong@baylibre.com
Message-ID: <e64ef508-6927-d9da-f7ea-8ca85729b82d@baylibre.com>
Date: Thu, 18 Jun 2020 15:44:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR moves the amlogic boards documentation in doc/board/amlogic in RsT format.


The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/3707

Thanks,
Neil

The following changes since commit 9cb895203a46654f7ee6dd95be5c8ab05e4dfbd3:

  Merge tag 'u-boot-stm32-20200616' of https://gitlab.denx.de/u-boot/custodians/u-boot-stm (2020-06-16 09:18:56 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200618

for you to fetch changes up to 9c55f5d11260c5aa0f91d8cb32aa0ad00910659d:

  board: amlogic: add board doc files to MAINTAINERS (2020-06-18 10:24:13 +0200)

----------------------------------------------------------------
- move amlogic board documentation into doc/board in RsT format

----------------------------------------------------------------
Neil Armstrong (2):
      board: amlogic: move boards doc into doc/board/amlogic
      board: amlogic: add board doc files to MAINTAINERS

 MAINTAINERS                                        |   1 +
 board/amlogic/p200/MAINTAINERS                     |   3 +
 board/amlogic/p200/README.nanopi-k2                |  98 ---------------
 board/amlogic/p200/README.p200                     | 102 ---------------
 board/amlogic/p201/MAINTAINERS                     |   1 +
 board/amlogic/p201/README.p201                     | 102 ---------------
 board/amlogic/p212/MAINTAINERS                     |   4 +
 board/amlogic/p212/README.khadas-vim               | 101 ---------------
 board/amlogic/p212/README.libretech-ac             | 102 ---------------
 board/amlogic/p212/README.libretech-cc             | 134 --------------------
 board/amlogic/p212/README.p212                     | 102 ---------------
 board/amlogic/q200/MAINTAINERS                     |   1 +
 board/amlogic/q200/README.khadas-vim2              | 102 ---------------
 board/amlogic/q200/README.q200                     | 101 ---------------
 board/amlogic/s400/MAINTAINERS                     |   1 +
 board/amlogic/s400/README                          | 109 ----------------
 board/amlogic/sei510/MAINTAINERS                   |   1 +
 board/amlogic/sei510/README                        | 122 ------------------
 board/amlogic/sei610/MAINTAINERS                   |   1 +
 board/amlogic/sei610/README                        | 118 ------------------
 board/amlogic/u200/MAINTAINERS                     |   1 +
 board/amlogic/u200/README                          | 127 -------------------
 board/amlogic/w400/MAINTAINERS                     |   4 +
 board/amlogic/w400/README.khadas-vim3              | 131 --------------------
 board/amlogic/w400/README.khadas-vim3l             | 131 --------------------
 board/amlogic/w400/README.odroid-n2                | 129 -------------------
 board/amlogic/w400/README.w400                     | 129 -------------------
 doc/board/amlogic/index.rst                        |  95 ++++++++++++++
 doc/board/amlogic/khadas-vim.rst                   | 101 +++++++++++++++
 doc/board/amlogic/khadas-vim2.rst                  | 102 +++++++++++++++
 doc/board/amlogic/khadas-vim3.rst                  | 132 ++++++++++++++++++++
 doc/board/amlogic/khadas-vim3l.rst                 | 130 +++++++++++++++++++
 doc/board/amlogic/libretech-ac.rst                 | 110 +++++++++++++++++
 doc/board/amlogic/libretech-cc.rst                 | 135 ++++++++++++++++++++
 doc/board/amlogic/nanopi-k2.rst                    | 104 ++++++++++++++++
 .../board/amlogic/odroid-c2.rst                    |  52 ++++----
 doc/board/amlogic/odroid-n2.rst                    | 130 +++++++++++++++++++
 doc/board/amlogic/p200.rst                         | 102 +++++++++++++++
 doc/board/amlogic/p201.rst                         | 102 +++++++++++++++
 doc/board/amlogic/p212.rst                         | 102 +++++++++++++++
 doc/board/amlogic/q200.rst                         | 101 +++++++++++++++
 doc/board/amlogic/s400.rst                         | 109 ++++++++++++++++
 doc/board/amlogic/sei510.rst                       | 130 +++++++++++++++++++
 doc/board/amlogic/sei610.rst                       | 133 ++++++++++++++++++++
 doc/board/amlogic/u200.rst                         | 135 ++++++++++++++++++++
 doc/board/amlogic/w400.rst                         | 137 +++++++++++++++++++++
 doc/board/index.rst                                |   1 +
 47 files changed, 2134 insertions(+), 1967 deletions(-)
 delete mode 100644 board/amlogic/p200/README.nanopi-k2
 delete mode 100644 board/amlogic/p200/README.p200
 delete mode 100644 board/amlogic/p201/README.p201
 delete mode 100644 board/amlogic/p212/README.khadas-vim
 delete mode 100644 board/amlogic/p212/README.libretech-ac
 delete mode 100644 board/amlogic/p212/README.libretech-cc
 delete mode 100644 board/amlogic/p212/README.p212
 delete mode 100644 board/amlogic/q200/README.khadas-vim2
 delete mode 100644 board/amlogic/q200/README.q200
 delete mode 100644 board/amlogic/s400/README
 delete mode 100644 board/amlogic/sei510/README
 delete mode 100644 board/amlogic/sei610/README
 delete mode 100644 board/amlogic/u200/README
 delete mode 100644 board/amlogic/w400/README.khadas-vim3
 delete mode 100644 board/amlogic/w400/README.khadas-vim3l
 delete mode 100644 board/amlogic/w400/README.odroid-n2
 delete mode 100644 board/amlogic/w400/README.w400
 create mode 100644 doc/board/amlogic/index.rst
 create mode 100644 doc/board/amlogic/khadas-vim.rst
 create mode 100644 doc/board/amlogic/khadas-vim2.rst
 create mode 100644 doc/board/amlogic/khadas-vim3.rst
 create mode 100644 doc/board/amlogic/khadas-vim3l.rst
 create mode 100644 doc/board/amlogic/libretech-ac.rst
 create mode 100644 doc/board/amlogic/libretech-cc.rst
 create mode 100644 doc/board/amlogic/nanopi-k2.rst
 rename board/amlogic/p200/README.odroid-c2 => doc/board/amlogic/odroid-c2.rst (56%)
 create mode 100644 doc/board/amlogic/odroid-n2.rst
 create mode 100644 doc/board/amlogic/p200.rst
 create mode 100644 doc/board/amlogic/p201.rst
 create mode 100644 doc/board/amlogic/p212.rst
 create mode 100644 doc/board/amlogic/q200.rst
 create mode 100644 doc/board/amlogic/s400.rst
 create mode 100644 doc/board/amlogic/sei510.rst
 create mode 100644 doc/board/amlogic/sei610.rst
 create mode 100644 doc/board/amlogic/u200.rst
 create mode 100644 doc/board/amlogic/w400.rst
