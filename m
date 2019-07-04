Received: by mail-wr1-f46.google.com with SMTP id v14so6812557wrr.4
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=kZGQj72W+qsUFuSBySrzQCYfd5X2U1dC46XHytgkFzo=;
        b=kJQigb9n5X9UtbjX53rFUQH0alcSeCtY/B3SMdiMhMuuHyfRHsYAdLzIwU6kGTZmgs
         komfpsQKeAzXNJ8ffnxxMJFD/qtldVW7EyNxyr+AP94tXNEsmJ72k+yerl0hlyO2mzQm
         Vikt7/AZ73opFgkYHQXleEVDmOkeeROTfJfRZodGWD0OW/yZCsUG7kYIiucvORua8K/M
         Vj5Pw9jaurFeRAVxnaDQJoXdjZeuYJiizy5afcFnW5qUYRvsAyOQWuJnH3NMgFYwqmya
         NzGqILbBdFUZQ+TW9LWlEGedNqRypBGtjN3PzEOa341DmNJ+mo0x8FE7oNZPLN/3jRPg
         rd+A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190704
Message-ID: <6963e3dd-9003-e696-5cc7-bfec825752d0@baylibre.com>
Date: Thu, 4 Jul 2019 16:12:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This is my first PR from gitlab !
Since I'll be on vacation next 2 weeks, this PR is for the next release, after v2019.07 is tagged.

It contains a small typo fix from Andreas, and adds support for generating an unique MAC
addresses from the SoC serial number in case none has been fused or saved in the env.

Thanks,
Neil

The following changes since commit ca4491f2d2af93d8b77c48c5d272d88094fc06eb:

  Merge tag 'rockchip-for-v2019.07-rc5-2' of https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip (2019-07-02 08:18:19 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20190704

for you to fetch changes up to 3f1f9f08eb2031e14a7e2037feed18a69f1437c6:

  board: amlogic: Generate unique MAC address for Q200 and P212 based boards (2019-07-04 16:04:59 +0200)

----------------------------------------------------------------
- fix khadas-vim README
- add support for unique generated MAC adresses from SoC serial,
  limited to Amlogic GXL/GXM boards for now

----------------------------------------------------------------
Andreas Färber (1):
      board: amlogic: vim: Fix README

Neil Armstrong (3):
      ARM: meson: sm: Add secure monitor calls to retrieve SoC serial number
      ARM: meson: add unique MAC address generation
      board: amlogic: Generate unique MAC address for Q200 and P212 based boards

 arch/arm/include/asm/arch-meson/eth.h |  3 +++
 arch/arm/include/asm/arch-meson/sm.h  |  4 ++++
 arch/arm/mach-meson/board-common.c    | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-meson/sm.c              | 24 ++++++++++++++++++++++++
 board/amlogic/p212/README.khadas-vim  |  2 +-
 board/amlogic/p212/p212.c             |  2 ++
 board/amlogic/q200/q200.c             |  2 ++
 7 files changed, 67 insertions(+), 1 deletion(-)
