Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.4447.1632209262234160147
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Sep 2021 00:27:42 -0700
Received: by mail-wr1-f51.google.com with SMTP id t18so36372291wrb.0
        for <u-boot-amlogic@groups.io>; Tue, 21 Sep 2021 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMl7ISzr//frn3j0GeI7XkmnmdJ2QVB9T7mT8TquoG4=;
        b=4ZTZWtSik2ANxDIXDnxncOola5485/oY1IurjKCm0+4l1znoLflzXFO2KHMuL/kmne
         u/H9tJl3FYBTOWpZjVhZitvtuRzDIPdS5+Nl9N+4ZjKzsQrZ7zm4yzpk5ngkHkeAUItS
         bjJ1uEF5xqVml1Z6CqwDi9OXuHnZTLsaGDtDBB4jWj+2WzRwnFS1JBYOuxbt99dvNaNg
         r5ZR3+EWgibO+KBxYwG+2Gm5el2mbbPP33DHngAeotKUUKbO7CJywHiKR/P2JP2fVMTm
         SOrpAmdQog2CieriQzuwmg0XEfIwmC4qgS4qLMUJPrYGuUkWnaNtAxr20fYjrr6E967K
         WYMw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/3] ARM: meson: add support for JetHub D1/H1
References: <20210920084016.2536084-1-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ca98d587-e12d-0e28-ed7e-090409d9138b@baylibre.com>
Date: Tue, 21 Sep 2021 09:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <20210920084016.2536084-1-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 20/09/2021 10:40, Vyacheslav Bocharov wrote:
> Add support for new home automation devices manufactured by JetHome.
> Patches prepared for use with the "ARM: meson: Sync Amlogic DT from Linux 5.14" patch series by Neil Armstrong
> 
> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller with the following features:
> - DIN Rail Mounting case
> - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 512Mb/1GB DDR3
> - 8/16GB eMMC flash
> - 1 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
> - 2 x gpio LEDS
> - GPIO user Button
> - 1 x 1-Wire
> - 2 x RS-485
> - 4 x dry contact digital GPIO inputs
> - 3 x relay GPIO outputs
> - DC source with a voltage of 9 to 56 V / Passive POE
> 
> JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller with the following features:
> - Square plastic case
> - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 1GB DDR3
> - 8/16GB eMMC flash
> - 2 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
> - MicroSD 2.x/3.x/4.x DS/HS cards.
> - 1 x gpio LED
> - ADC user Button
> - DC source 5V microUSB with serial console
> 
> Changes from v2:
> - fix "Alignment should match open parenthesis" in board/amlogic/jethub-j80/jethub-j80.c
> - add missing files to board/amlogic/jethub-j80/MAINTAINERS
> - fix unexpected unindent in doc files
> 
> Changes from v1:
> - fix BOOT_TARGET_DEVICES in jethub.h (patch 1/3)
> - add lore URLs to description (patch 2/3)
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> 
> Vyacheslav Bocharov (3):
>   ARM: amlogic: add JetHub common config header
>   ARM: amlogic: add JetHub D1/H1 device support
>   ARM: amlogic: add JetHub D1/H1 docs
> 
>  arch/arm/dts/Makefile                         |   2 +
>  .../arm/dts/meson-axg-jethome-jethub-j100.dts | 361 ++++++++++++++++++
>  .../meson-gxl-s905w-jethome-jethub-j80.dts    | 241 ++++++++++++
>  board/amlogic/jethub-j80/MAINTAINERS          |   9 +
>  board/amlogic/jethub-j80/Makefile             |   6 +
>  board/amlogic/jethub-j80/jethub-j80.c         |  68 ++++
>  configs/jethub_j100_defconfig                 |  55 +++
>  configs/jethub_j80_defconfig                  |  63 +++
>  doc/board/amlogic/index.rst                   | 128 ++++---
>  doc/board/amlogic/jethub-j100.rst             | 108 ++++++
>  doc/board/amlogic/jethub-j80.rst              |  97 +++++
>  include/configs/jethub.h                      |  40 ++
>  12 files changed, 1115 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
>  create mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
>  create mode 100644 board/amlogic/jethub-j80/MAINTAINERS
>  create mode 100644 board/amlogic/jethub-j80/Makefile
>  create mode 100644 board/amlogic/jethub-j80/jethub-j80.c
>  create mode 100644 configs/jethub_j100_defconfig
>  create mode 100644 configs/jethub_j80_defconfig
>  create mode 100644 doc/board/amlogic/jethub-j100.rst
>  create mode 100644 doc/board/amlogic/jethub-j80.rst
>  create mode 100644 include/configs/jethub.h
> 


Applied to u-boot-amlogic-next

Neil
