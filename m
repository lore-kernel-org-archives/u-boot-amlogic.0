Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.9297.1660033305677191245
 for <u-boot-amlogic@groups.io>;
 Tue, 09 Aug 2022 01:21:46 -0700
Received: by mail-wr1-f45.google.com with SMTP id z12so13450388wrs.9
        for <u-boot-amlogic@groups.io>; Tue, 09 Aug 2022 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:organization:content-language:subject:cc
         :to:from:user-agent:mime-version:date:message-id:from:to:cc;
        bh=x8yIzKXrTMP0V+Du0boiCheeLZsQLh3aPtLSsKeP+2k=;
        b=OlKpf0fVmRTpm8T7AnxVF7xt3tN2vkROEeCjfFxwxs8XQh7FJE2LeKu+f3PnMISx/h
         kcYT912RsYM0mEm/ti3hPcCrmeNDQzdaFaSn6z6hi5R9hI8AU6giTlAEk0oMew5JFb39
         5khTsbsuOoC5lC3uuuqINxQ+423Uavvzs4OW0cJUBzjDJZfKDMhmUR7fDy/YdqK4OCaT
         lPMP85KL6grJZEWUzgS+TNoKp85TMxfP6mbc8nC1oq2c2tJEalPvmSzUSRvdj2trM0Ms
         I9QX7pjZuu1xsE3U2ZPzFEU2SuSNzd9IBwJB6equ7RXetKBJipga0HKN5jN5+envsej+
         0vOA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <7635ad28-344c-4a83-03aa-c23c3fd866d0@baylibre.com>
Date: Tue, 9 Aug 2022 10:21:42 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-amlogic-20220809
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

Here's changes for next release:
- fixup error on efuse commands return
- add documentation on boot flow

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/13087

Thanks,
Neil

The following changes since commit 2d2c61ff0460740d9ec5a44dbef9255a8c690696:

   Merge tag 'efi-2022-07-rc7' of https://source.denx.de/u-boot/custodians/u-boot-efi (2022-07-06 09:17:08 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20220809

for you to fetch changes up to 3145e0d0ff0837647351f2ca261b4cde779f83e0:

   ARM: meson: fixup error on efuse commands return (2022-08-08 09:56:38 +0200)

----------------------------------------------------------------
- fixup error on efuse commands return
- add documentation on boot flow

----------------------------------------------------------------
Jerome Brunet (1):
       ARM: meson: fixup error on efuse commands return

Neil Armstrong (1):
       doc: board: amlogic: add documentation on boot flow

  arch/arm/mach-meson/sm.c        |   9 +--
  doc/board/amlogic/boot-flow.rst | 134 ++++++++++++++++++++++++++++++++++++++++
  doc/board/amlogic/index.rst     |   1 +
  3 files changed, 138 insertions(+), 6 deletions(-)
  create mode 100644 doc/board/amlogic/boot-flow.rst
