Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.12429.1637343915394306630
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 09:45:16 -0800
Received: by mail-wm1-f44.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso11080751wmr.4
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KGpBybteKjUeAI3i60hiAsOFhtjilU3r9TYuazKYq3Q=;
        b=YnloO6jE2qQY2BMO69LxeTna7n22ZkWxrJb9gzYtsbpAXE6A99zH1h9zKcr9r9vZuM
         zp6QdJYj95IFiS9/631lVZp4a09sP/lJ1xD6jXBrZ4Muef19gcHxL+ya2aLPTF2nU2EB
         h2Z3qiQXgRx9/P53KEr1rP2cbBcXk/T/mCBhjaBPiYZr259srdfNEsV9u6cfM2s7WJcb
         j2GnVWx3Gv424cIGyQSGWChZX1cYoEZwEHbob7K2E9nNLC1EYYg8SUYG0N80TZN8r0Ex
         HyoRCMsGFzCgXZoyB79zLxg2v8fYSaJo9NKqlLihX/16HPVoU4S+0Xeko3YkqRSPTSwF
         cvbQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20211119
Reply-To: narmstrong@baylibre.com
Message-ID: <eec6afbf-97d1-2e65-3c16-3ea75f0aefe2@baylibre.com>
Date: Fri, 19 Nov 2021 18:45:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's a change to fix GPIO declaration in the Meson PINCTRL driver, and a couple
of changes to handle boot errors when using the meson64 android config and permit
recovering the board via fastboot when the boot media is invalid.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/9918

Thanks,
Neil

The following changes since commit 8391a0f3d97c0300d7eafe7581b6712afb18f283:

  Merge branch '2021-11-18-regression-fixes' (2021-11-18 18:25:19 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20211119

for you to fetch changes up to 28f70cfcfd82ac509c8da772b74e5dc2df795fd2:

  configs: meson64_android: add PANIC stage for SYSTEM fails (2021-11-19 18:15:26 +0100)

----------------------------------------------------------------
- pinctrl: Correct the driver GPIO declaration
- meson64_android: handle errors on boot and run fastboot on boot failure

----------------------------------------------------------------
Neil Armstrong (2):
      configs: meson64_android: bypass other checks on run_fastboot=1
      configs: meson64_android: add PANIC stage for SYSTEM fails

Simon Glass (1):
      pinctrl: meson: Correct the driver GPIO declaration

 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-gx.h     |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c   |  4 +--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c    |  4 +--
 include/configs/meson64_android.h            | 47 +++++++++++++++++-----------
 5 files changed, 35 insertions(+), 24 deletions(-)
