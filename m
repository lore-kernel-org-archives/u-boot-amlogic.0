Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.9701.1604656174486074597
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:49:34 -0800
Received: by mail-wr1-f43.google.com with SMTP id n18so637939wrs.5
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=PfF6mEESRmECaLUv5y8zpGcNCZjmRCRSxm7laKPiUdg=;
        b=gqsWvtsRlShHuGsb9bEIYuE8Faah4TXCLjAUUod8VKagoj6ICksSiIh4o82elRYpvB
         SU2tTHTigzXHvHflh1SDF2u6PSvjongURba5VuH+Nr8dB0KObO96pg3AWkOaHSFyuc0G
         D9eK5HPn5QcC1QuYJbgppvJUkfHR+j62q7k0QFTUnN5qDcLyMF2LXQA7eUCFn3AxCFg/
         Q/oxrjrcOKqQbUgjoai1O0urf3qWuPHSbHZdPUWbZKOIN0a8dq7blgY095nJsfF3W4Uc
         RZNXdNazD/xVzurH71iVWi166EBoOdv83O8MatXb+g7iGQ/pVM6DJRCD6iD3fPL4lybE
         K4IQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20201105
Reply-To: narmstrong@baylibre.com
Message-ID: <c64adb73-4f9a-b7a1-7355-e59664b352cd@baylibre.com>
Date: Fri, 6 Nov 2020 10:49:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR fixes some documentation and the android early logo boot flow.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/5274

Thanks,
Neil

The following changes since commit cdeb7b8f984e6d9bcdc5a6fdda6107af156d47bf:

  configs: Resync with savedefconfig (2020-10-29 10:48:01 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20201105

for you to fetch changes up to 014b9f96762d17d04038d8902d419b6476753e4f:

  configs: meson64: relocate config_distro_bootcmmd header (2020-11-05 16:27:31 +0100)

----------------------------------------------------------------
- meson64_android: don't show logo on ROM USB boot
- doc: update support matrix and fix vim3/l build instructions
- meson64: relocate config_distro_bootcmmd header

----------------------------------------------------------------
Guillaume La Roque (1):
      configs: meson64_android: don't show logo on ROM USB boot

Jaehoon Chung (1):
      configs: meson64: relocate config_distro_bootcmmd header

Neil Armstrong (2):
      doc: board: amlogic: Update support matrix
      doc: board: vim3: Fix build instructions

 doc/board/amlogic/index.rst        |  8 +++++---
 doc/board/amlogic/khadas-vim3.rst  |  9 +++++----
 doc/board/amlogic/khadas-vim3l.rst | 11 +++++++----
 include/configs/meson64.h          |  3 ++-
 include/configs/meson64_android.h  | 11 +++++++----
 5 files changed, 26 insertions(+), 16 deletions(-)
