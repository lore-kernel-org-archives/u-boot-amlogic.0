Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.22741.1696435407054428986
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Oct 2023 09:03:27 -0700
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso23983335e9.3
        for <u-boot-amlogic@groups.io>; Wed, 04 Oct 2023 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696435405; x=1697040205; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPvjO8lYvdOLsOicndz0QDkBhUs1H4o8/7ctqlMJDgc=;
        b=KPnZd3ceLXvVkua81KfGp9yOokUGf+0QExEiHZi68qwvYMoqHeAkTPfOAeWMXyG5Xp
         6w3ufF2LrJg/IP2hQeGzxeFqMvyzdyzlg0ZOfEBINh7pEIW1SVS8011hL2eV1HynMd3S
         6P+5bo1SruHQoB/Zx+Q68RL1KR3n3956MKf8n2t9PZUDhJvfaP2hx4qP2ans75c3nAQW
         uONtCsVo95Y4Hp18yhFKcat5uIuiyv4412Tyl5ynYMHQ/bsg+sY8vFT8sRQD3Sy5Pwgi
         elV0ehou+n9UuAa6MKg7F8jhl08dHBOL1OW6bpOeeytfb/FtVwkuWCTychG/uQ0g6yPR
         SVKg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <d45fa973-3ea1-4d97-a285-f7f85e67e614@linaro.org>
Date: Wed, 4 Oct 2023 18:03:23 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/8] Support USB for Meson A1
References: <20231003112838.41503-1-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 03/10/2023 13:28, Alexey Romanov wrote:
> Hello!
> 
> This patchset adds USB stack support for Amlogic A1 SoC's
> series. Made reset / phy / dwc3 drivers more flexible and
> added support for A1 board.
> 
> V2:
> 
> - Made power domain for PHY optional.
> - Add missing CLKID_USB_PHY gate.
> - Drop patch with USB stack initialization in board-a1.c.
> Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
> - Support A1 in g12a_child_pre_probe/post_remove functions
> in dwc3 driver.
> 
> 
> Alexey Romanov (7):
>    dt-bindings: reset: add Meson A1 reset bindings
>    reset: add support for Amlogic A1 family
>    phy: get rid of raw hex values
>    phy: move clk enable/disable in init/exit
>    phy: support Amlogic A1 family
>    dwc3: add support for Amlogic A1 family
>    ad401: enable USB stack
> 
> Igor Prusov (1):
>    a1: clk: Add missing USB_PHY_IN and USB_PHY gates
> 
>   configs/ad401_defconfig                       |   3 +
>   drivers/clk/meson/a1.c                        |   6 +
>   drivers/phy/Kconfig                           |   2 +-
>   drivers/phy/meson-g12a-usb2.c                 | 235 ++++++++++++++++--
>   drivers/reset/reset-meson.c                   |  42 +++-
>   drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
>   .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
>   7 files changed, 403 insertions(+), 34 deletions(-)
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 

The PHY and DWC3 patches don't apply cleanly, could you rebase on top of:
https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commits/u-boot-amlogic

Thanks,
Neil
