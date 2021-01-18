Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.31597.1610965345871389695
 for <u-boot-amlogic@groups.io>;
 Mon, 18 Jan 2021 02:22:26 -0800
Received: by mail-wm1-f41.google.com with SMTP id y187so13300738wmd.3
        for <u-boot-amlogic@groups.io>; Mon, 18 Jan 2021 02:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53NDSOvIRSFkcgAhdnZj3w0cyNnFLgk2XkNsywtchv8=;
        b=CDW4K+dc+qRxc+Pj/HMWLlpF524YdcCzoM77Gb4L5px4iUVKIje4VDZHgpc2hpfzt4
         QqGuGIQ4T/EsI/ENPZVceSrG8XjiCIaxlOW6ec7ZeDhZxqiCooLn4d7ucJdHckbuVefU
         s9reHQFi/1DSYvxLpa1CEVPiN2LF6DfEAV5xq1LmhXKm5Towh9R1AWhJIHI5gSuIWni+
         MGEdYAQQffWi/uVPcmfb40k3dSKdAMhzUSUCZ9BvthGsPHV3tzlliNzo+99LZOs1zhZQ
         XWDfh9lWVAQJCZjspfBWeeEOJiYrqa18MnR1ez5vmCmTBHnoUjBxfOfu1EV+4yaLQHyr
         eV7Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] phy: add support for Amlogic Meson AXG MIPI-DSI PHY function
References: <20201229135901.30090-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3db628e4-5ff9-1509-206c-cd53dcdc591b@baylibre.com>
Date: Mon, 18 Jan 2021 11:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <20201229135901.30090-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

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

Applied to u-boot-amlogic

Neil
