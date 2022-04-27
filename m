Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.5516.1651045943040075782
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Apr 2022 00:52:24 -0700
Received: by mail-wr1-f50.google.com with SMTP id k2so1282034wrd.5
        for <u-boot-amlogic@groups.io>; Wed, 27 Apr 2022 00:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:subject
         :content-language:organization:content-transfer-encoding;
        bh=0VkuTjG7hEJS9C2rIGhiskPzxKgpEPF/g9mJ8r+MdJQ=;
        b=CGNhJHPGsFaZfDqaN7S4B29n8McuVcWciKi92VdyU3Pbqt9ElJJBPQUDTb7ttojv89
         4UnDj8gzyP2gg9FfJfSnnZGpn9dbsIX0rhwHQGB+5NBJS+VP6fpWpOZjIrTx5y+PbtAS
         U4wBoXKYxLx+1EK46AgUZJpmat4sx51TSSCu78aKM+e+iu4DU4XowwjpMxdnZd0A838m
         zewAcbuG/jGtwzAAPZ9hSGToi281MChsIEyhKaITC1KW7cmTiMfXkPBmdsbikUhcBwqU
         O/k77Ew3SRY9idaJemUEfwU2R/o6gQHKG4sQrBfbQWWC4xMRliVngQmeBEFp+kkDChuq
         Zqjg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <37171ed2-cdc6-4c62-3722-9752c57ac16e@baylibre.com>
Date: Wed, 27 Apr 2022 09:52:20 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-amlogic-20220427
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's changes for next release, nothing big, no new boards either:
- Add AXG support for SARADC, including minimal ao-clk driver
- Update Amlogic documentation for Matrix & Jethub D1

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/11877

Thanks,
Neil

The following changes since commit 9bb99fa95826d1a608737ca821977b4136a1a278:

   Merge branch '2022-04-22-assorted-updates' (2022-04-23 08:06:28 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20220427

for you to fetch changes up to 5a9e5922ceccd55dc6427b3cf61b4dc74c7322ab:

   doc: boards: amlogic: update jethub d1 specifications (2022-04-26 14:35:27 +0200)

----------------------------------------------------------------
- Add AXG support for SARADC, including minimal ao-clk driver
- Update Amlogic documentation for Matrix & Jethub D1

----------------------------------------------------------------
Vyacheslav Bocharov (8):
       clk: meson: add minimal driver for axg-ao clocks
       clk: meson: fix driver name for g12a-ao clocks
       clk: meson: update driver for g12a-ao clocks
       adc: meson-saradc: add AXG variant
       board: amlogic: jethub j100: enable saradc in dts
       board: amlogic: jethub j100: enable saradc in config
       doc: boards: amlogic: update documentation for ADC support for AXG
       doc: boards: amlogic: update jethub d1 specifications

  .../dts/meson-axg-jethome-jethub-j100-u-boot.dtsi  | 10 +++
  configs/jethub_j100_defconfig                      |  5 ++
  doc/board/amlogic/index.rst                        |  2 +-
  doc/board/amlogic/jethub-j100.rst                  | 26 ++++---
  drivers/adc/meson-saradc.c                         |  2 +
  drivers/clk/meson/Makefile                         |  1 +
  drivers/clk/meson/axg-ao.c                         | 86 ++++++++++++++++++++++
  drivers/clk/meson/g12a-ao.c                        | 17 +++--
  8 files changed, 131 insertions(+), 18 deletions(-)
  create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
  create mode 100644 drivers/clk/meson/axg-ao.c
