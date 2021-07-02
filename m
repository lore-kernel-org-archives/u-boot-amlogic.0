Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.15951.1625263603123268797
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Jul 2021 15:06:43 -0700
Received: by mail-wm1-f53.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso7280858wmj.0
        for <u-boot-amlogic@groups.io>; Fri, 02 Jul 2021 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=D5qjS0fGJiAShSTRh1O66OnJGhY+CkvBUceCMQ7dF1w=;
        b=IQb0xTKj0epBpEfghveQf8JILg/qP3KYd10FqcPdnGK+CLLWbmngYy2zXDw7bJxIGn
         3ocKXAcmsqJh0c+sI9M39cj9G+H5/+i3iDxjR4jY0jzzy1Ggk4qpgTUSULIFroZH1swy
         zjVlqsJQx80znkEwfWpGEdBB3UX+ZVVEOzeuE7AxrejNUISHtOSSKj2jcIlkZUViBhAQ
         3sKAWJlu4ER4IlGJNrsghnbIkMa1zWREEDwlU0zbwcPLKwDCD983MBBPW7Nd3o6NGbJY
         Vk89Tde2/wCoHdO64TBxbPE3nd/x84+42rfTsFbyLe8x+38KP36M+70DGubl7uVUAkha
         YwHA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210703
Reply-To: narmstrong@baylibre.com
Message-ID: <a1cbacc6-042d-32c1-eb91-8baa577598b4@baylibre.com>
Date: Sat, 3 Jul 2021 00:06:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Please find a very late fix for a SPI NOR Flash probe fail on the Amlogic based libretech boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/8015

Thanks,
Neil

The following changes since commit b7ad721c83fdbeeb71189d5f259c109cb1c38895:

  Revert "TEST: USB_HOST not USB" (2021-06-30 13:10:02 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210703

for you to fetch changes up to 8c6d8c32192049f8dafaaafae68eb9124b21c1e0:

  configs: libretech: set SPI mode to 0 (2021-07-02 23:59:27 +0200)

----------------------------------------------------------------
- configs: libretech: set SPI mode to 0 to fix SPI NOR Flash probe

----------------------------------------------------------------
Da Xue (1):
      configs: libretech: set SPI mode to 0

 configs/libretech-ac_defconfig       | 1 +
 configs/libretech-cc_v2_defconfig    | 1 +
 configs/libretech-s905d-pc_defconfig | 1 +
 configs/libretech-s912-pc_defconfig  | 1 +
 4 files changed, 4 insertions(+)
