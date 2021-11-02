Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.6563.1635842670203804217
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Nov 2021 01:44:30 -0700
Received: by mail-wm1-f41.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so1476240wmb.5
        for <u-boot-amlogic@groups.io>; Tue, 02 Nov 2021 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vme2zJUL36IdYeIPWvxFGStsSQ94QNc0YWiKJr/6nzE=;
        b=70xx6JXhAcJKPYxWqRYDgyPrhghFU29fezlssr8XPtvv8+Siw0Hk8TWycloE9X3vOC
         IfVXcJWNhz7bMLWXArJIOuPG9X1p8KAk2mhGJbzo9LW7W/AZC5QKHVqZFgHkSZe0KjNY
         RBy2sw4VzAf8Sk7l6T8jhw6hzci6WrMY0DVjyNB+omkTWNTx+7NvFswVMtrsilRWXu/t
         l++SgYNwF5+DKXqKGBqQ+B7E3lw1uoGYIsmigPjswVemL7jYQfDWZ3/RGb9q9LwDVWR7
         TEnmEQqhLg1rAK1MIbnnN9D6TPinaR7INMixC0JKG2ShHR+05hWtuMxmxSrv/pFTolOb
         UJhw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20211102
Reply-To: narmstrong@baylibre.com
Message-ID: <cde80735-f811-68f1-1b47-3daf4f597d6e@baylibre.com>
Date: Tue, 2 Nov 2021 09:44:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's 2 simple changes, one to add commands to read/write fuses and another to add
proper MAC generation for the JetHub D1 product.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/9712

Thanks,
Neil

The following changes since commit aafc378a6caef453a40f2f9f3d6bef69e592c28d:

  Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2021-10-28 07:57:54 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20211102

for you to fetch changes up to 4f4f974a46244270c1c6723017711c0aa8250206:

  ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI (2021-10-29 19:16:07 +0200)

----------------------------------------------------------------
- add sm efuse write support and cmd for read/write efuse
- add JetHub D1 eth mac generation with manufacturer OUI

----------------------------------------------------------------
Vyacheslav Bocharov (2):
      ARM: amlogic: add sm efuse write support and cmd for read/write efuse
      ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI

 arch/arm/mach-meson/sm.c                | 68 ++++++++++++++++++++++++++++++++-
 board/amlogic/jethub-j100/MAINTAINERS   |  8 ++++
 board/amlogic/jethub-j100/Makefile      |  6 +++
 board/amlogic/jethub-j100/jethub-j100.c | 42 ++++++++++++++++++++
 board/amlogic/jethub-j80/MAINTAINERS    |  3 +-
 configs/jethub_j100_defconfig           |  1 +
 6 files changed, 125 insertions(+), 3 deletions(-)
 create mode 100644 board/amlogic/jethub-j100/MAINTAINERS
 create mode 100644 board/amlogic/jethub-j100/Makefile
 create mode 100644 board/amlogic/jethub-j100/jethub-j100.c
