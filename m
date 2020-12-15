Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.8046.1608019351096479481
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 00:02:31 -0800
Received: by mail-wm1-f44.google.com with SMTP id a6so15985213wmc.2
        for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 00:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=aiy0wlb64PAymA2Coyl262QgcP8toh05RF4qniVl8pY=;
        b=FFca9Ezlm8XHRUsXhteaRJKHRzvmyhXUA+QhsffhHVUTGdHLRosCIcnDdXzW91U5XJ
         0z27SAehVlafyhD01rLyHvFLJ/lfN/U7LR18glBk5DuT1Tlfa9sdrCZCOhpF2O3Qmdln
         +C/1bpUyZoiDMUNXJst6nCqkoqpfvPBftBaFCitHA89HM0lkARAuapLgAvm1YcvKfURi
         6TOQY3X5fBCiYDWplkPkrGl79h61yfu67LAFWWlt86nalYuz+1l56bMuHVulEQu+NJXs
         c5AQu4TWhGrDxH22H8MFgLQHWl+enwJlzD/FkvJgDn/9+O+GckLyPhu5rw5bkMqKsXvZ
         cxtQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20201215
Reply-To: narmstrong@baylibre.com
Message-ID: <7df22695-a473-2941-5399-98955174e10f@baylibre.com>
Date: Tue, 15 Dec 2020 09:02:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR fixes the pinctrl bias bit handling code and the dr-mode setup on the G12A DWC3 glue driver
when switching USB device/host back and forth.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/5575

Thanks,
Neil

The following changes since commit 5a1a8a63be8f7262a300eddafb18020926b12fb6:

  Merge tag 'u-boot-atmel-fixes-2021.01-b' of https://gitlab.denx.de/u-boot/custodians/u-boot-atmel (2020-12-11 15:55:17 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20201215

for you to fetch changes up to 5ccd5d2cc98224108ae9fb09593a862c9caa5e80:

  pinctrl: meson: fix bit manipulation of pin bias configuration (2020-12-14 19:58:54 +0100)

----------------------------------------------------------------
- fix pinctrl BIAS setup which caused failure on some eMMC models
- fix dr-mode configuration in dwc3-meson-g12a glue driver

----------------------------------------------------------------
Marek Szyprowski (1):
      usb: dwc3-meson-g12a: always configure dr-mode

Neil Armstrong (1):
      pinctrl: meson: fix bit manipulation of pin bias configuration

 drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
 drivers/usb/dwc3/dwc3-meson-g12a.c    | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

