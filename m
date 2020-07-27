Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.59517.1595867048465203224
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Jul 2020 09:24:09 -0700
Received: by mail-wm1-f44.google.com with SMTP id 184so15374417wmb.0
        for <u-boot-amlogic@groups.io>; Mon, 27 Jul 2020 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=fu0U1cugb+1cxOoW/fnCwQYxjjfxzQskToObS3E95g4=;
        b=avlyxXPjIFNw7V12Cm8vX5dEHDZxp3Xp3RwiVGC9kbw21sRutFiTGV9k3nV6HSNXjQ
         d0FqwaqRFJOJK77lODvRDNRONbLCMbUCOrImq6bTXiP6tX8Yz35WW11fl23vp4cne+um
         KFcPLqPRRx6uuShUJUwcc5lg8ZlFlj36+LkfLwGAZlJ0mUV2Mg98s/CaqHIdJoORGDD6
         Ib+L35X1PEdXMDALtJ5lP9Gxy2cK/sPOWt4HE2QpLWzOsV9Tqlyb4CN1yASELrT0AyMl
         Q1VdLHfyiOkt0qCauW4Qi2PYB8Ra1zroMO43r3h0MOQaXZcMdeH7SncW8tIdtMQU3bYd
         lmMg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200727
Reply-To: narmstrong@baylibre.com
Message-ID: <14fd5200-6dd2-fc29-9724-26faa0b56d8f@baylibre.com>
Date: Mon, 27 Jul 2020 18:24:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR fixes a bug when the Amlogic UART detects error on the console line
and enables HDMI, USB Keyboard & ADC for the Odroid-C2.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/4208

Thanks,
Neil

The following changes since commit 3773028fced4795d52f02b387496395ec387f3bb:

  Merge branch '2020-07-27-misc-env-improvements' (2020-07-27 09:25:53 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200727

for you to fetch changes up to 95ca2df3fd8f7b2cc995bccb2b46cd5650c4a9a7:

  configs: odroid-c2: update for HDMI output, ADC & USB keyboard (2020-07-27 16:35:56 +0200)

----------------------------------------------------------------
- Handle errors in Meson serial driver
- Enable HDMI, keyboard and ADC for Odroid-C2

----------------------------------------------------------------
Anand Moon (1):
      configs: odroid-c2: update for HDMI output, ADC & USB keyboard

Neil Armstrong (1):
      serial: meson: handle RX errors

 configs/odroid-c2_defconfig   | 11 +++++++++++
 drivers/serial/serial_meson.c | 43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 4 deletions(-)
