Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.33905.1615196962874072479
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Mar 2021 01:49:23 -0800
Received: by mail-wr1-f41.google.com with SMTP id e10so10675231wro.12
        for <u-boot-amlogic@groups.io>; Mon, 08 Mar 2021 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=tV94Il5JGr2U4WZKV/ehoMBGXu36z32ZQPYbdmvfOMw=;
        b=R0fuRLhNG7dQDwQPeLn81165NeBGaFxRfpd32oJmT8oMUNrUvrer5nvvstVq00eyK7
         dxo1wU+HfPpCvxNxzrcK6YSFWQsaKG85XkjSty+8aJZFQYdHVXDgrqqM6MpG9+9itlmf
         1VMUeqzQ3+kxRtyFIRE4JZbngh4K6VKx1Tv38Lg1UaXGQCRwF2R4GTGeKs/nXdRLv/XH
         L6YUThJhdcW7ia3fISCkFd1lWrSTULm3udVGi070VZpCvT4rG9I9dbfY5p7AxtpAttV0
         xseRKHsF85MuhjqSeBplRpYk7XrXRnxB9EomA/9ndwv7r/o6/fm+NcEnDfjAwljUvlLL
         +aKQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210308
Reply-To: narmstrong@baylibre.com
Message-ID: <476093dd-ca30-f8e2-7e11-8a0f179750cc@baylibre.com>
Date: Mon, 8 Mar 2021 10:49:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

These changes fixes s/treshold/threshold/ in ADC button driver, and adds the missing fdtoverlay_addr_r
env variable to make usage of FDT overlay support in PXE boot on Amlogic boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/6696

Thanks,
Neil

The following changes since commit e4dba4ba6f61e8128be0b4200ca2d8cebf62180b:

  Merge https://gitlab.denx.de/u-boot/custodians/u-boot-fsl-qoriq (2021-03-06 07:25:04 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git u-boot-amlogic-20210308

for you to fetch changes up to 266637db88e37686b160722e183571567c61ad1a:

  configs: meson64: add fdtoverlay_addr_r (2021-03-08 10:32:35 +0100)

----------------------------------------------------------------
- button: adc: fix treshold typo
- configs: meson64: add fdtoverlay_addr_r

----------------------------------------------------------------
Neil Armstrong (2):
      button: adc: fix treshold typo
      configs: meson64: add fdtoverlay_addr_r

 drivers/button/button-adc.c | 14 +++++++-------
 include/configs/meson64.h   |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)
