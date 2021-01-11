Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.31461.1610354852779650518
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 00:47:33 -0800
Received: by mail-wm1-f49.google.com with SMTP id v14so13122430wml.1
        for <u-boot-amlogic@groups.io>; Mon, 11 Jan 2021 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hfNVVLUulj9T8GuMf0QRPcXWEgfK0DfQ5uxI4Z4LtQ=;
        b=nXEKESRpkJLpefzu1cdd2AORzRoOJ9ZPAgXBf8/77jzsQUT0Pll9a/3J3IzKs5anu1
         xPNN43ruxCMV7ATdS8dRbOGLxXTtqNxyzt7GzoW/e7A7hF9F5OPjX2VHRlyjEuIJqB53
         drGfkHz+Bgp9Mt1EGzY0qK+xyNGM6RX35k+GM6frw35qlYE+mNjWryY0YPFjPY/4sDbq
         YvfUCjvOCNzw2S2ZFH0GjSGCD7C2hM2jNYlq3VyP757GkP86y5Eb3/1CWUpM8I86ufcd
         e2LXpz+3OX+7iaLItm27cK4jYh1LElEtuSlXojzOOtzFC/+O5nWB0pjw8gce+Gf0Roas
         c79Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] phy: add support for Amlogic Meson AXG MIPI-DSI PHY function
References: <20201229135901.30090-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2639b559-a902-18b9-e0b9-174118890d98@baylibre.com>
Date: Mon, 11 Jan 2021 09:47:29 +0100
MIME-Version: 1.0
In-Reply-To: <20201229135901.30090-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Simon, Tom,

Could you review patches 1 & 2 of this serie ?

Thanks,
Neil

On 29/12/2020 14:58, Neil Armstrong wrote:
> The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This D-PHY depends on a separate analog PHY.
> 
> The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
> MIPI DSI at the same time.
> 
> In order to configure the DSI PHY timings, a new "configure" PHY op is added to
> permit dynamic (re)configuration of the PHY function.
> 
> Finally, the Linux MIPI D-PHY configuration helpers are imported to provide a standard
> set of default D-PHY timings, timings struct and correct calculations.
> 
> Neil Armstrong (4):
>   phy: dphy: Add configuration helpers
>   generic-phy: add configure op
>   phy: Add Amlogic AXG MIPI D-PHY driver
>   phy: Add Amlogic AXG MIPI PCIe Analog PHY driver
> 
>  drivers/phy/Kconfig                      |  23 ++
>  drivers/phy/Makefile                     |   3 +
>  drivers/phy/meson-axg-mipi-dphy.c        | 393 +++++++++++++++++++++++
>  drivers/phy/meson-axg-mipi-pcie-analog.c | 233 ++++++++++++++
>  drivers/phy/phy-core-mipi-dphy.c         | 161 ++++++++++
>  drivers/phy/phy-uclass.c                 |  11 +
>  include/generic-phy.h                    |  23 ++
>  include/phy-mipi-dphy.h                  | 284 ++++++++++++++++
>  8 files changed, 1131 insertions(+)
>  create mode 100644 drivers/phy/meson-axg-mipi-dphy.c
>  create mode 100644 drivers/phy/meson-axg-mipi-pcie-analog.c
>  create mode 100644 drivers/phy/phy-core-mipi-dphy.c
>  create mode 100644 include/phy-mipi-dphy.h
> 

