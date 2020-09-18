Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web12.2720.1600451957794529456
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 10:59:18 -0700
Received: by mail-pl1-f195.google.com with SMTP id m15so3376303pls.8
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=M3N49OI+UAMKxxUS+DaVjAIdiglxeRuvUiu+F+Uwpmg=;
        b=n9U626ayEMQIyQ53zrLcEqz69JgjjFSdhiiNPxwlKrCB6JooVi5AZzkfeUOozTLeRb
         jvmbK+EkWWxd2Xku/zAh29TDzqFKaIgXIKMrg1G+2ArpZjhr5uTCO28kLnvgtnJpKzbF
         7yshQxGrGSorYwOzgXzKoSzGbVVkL1zZRc9dhtXbov50yHAaSa6jHo9qj8Gal6sM+8IZ
         A5K2uMSEpEkFrjbID2LIr4xBJTysMMBEBf0J8VXsC6Zr6MyAWpR08KDiFpKDNfBiL+y/
         g5QR8hGjrEZS1QQPrQRNQUrozHDd9V+buNYSNguWBOOl+FxliAwsi0yek8E4n8qNiu+x
         lwog==
Return-Path: <khilman@baylibre.com>
From: "Kevin Hilman" <khilman@baylibre.com>
Subject: Re: [PATCH 4/4] board: amlogic: vim3: add support for dynamic PCIe enable
In-Reply-To: <20200918092902.28028-5-narmstrong@baylibre.com>
References: <20200918092902.28028-1-narmstrong@baylibre.com> <20200918092902.28028-5-narmstrong@baylibre.com>
Date: Fri, 18 Sep 2020 10:59:15 -0700
Message-ID: <7h4knvdkzw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Neil Armstrong <narmstrong@baylibre.com> writes:

> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> an USB3.0 Type A connector and a M.2 Key M slot.
> The PHY driving these differential lines is shared between
> the USB3.0 controller and the PCIe Controller, thus only
> a single controller can use it.
>
> This adds this dynamic switching right before booting Linux.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  board/amlogic/vim3/vim3.c      | 116 +++++++++++++++++++++++++++++++++
>  configs/khadas-vim3_defconfig  |   3 +
>  configs/khadas-vim3l_defconfig |   3 +
>  3 files changed, 122 insertions(+)
>
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 02d8cd0ce0..cf730fa0d1 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -11,6 +11,122 @@
>  #include <net.h>
>  #include <asm/io.h>
>  #include <asm/arch/eth.h>
> +#include <i2c.h>
> +#include "khadas-mcu.h"

This file doesn't exist in this series, so it doesn't compile.

Copying it from Linux, it compiles and works fine.

Kevin
