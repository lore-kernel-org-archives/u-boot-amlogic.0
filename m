Received: by mail-wm1-f67.google.com with SMTP id v15so1775641wml.0
        for <u-boot-amlogic@groups.io>; Wed, 28 Aug 2019 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=heJio/zCxnm3oB0MuS+1IbaV938Y22nnOqjjb1+q/pc=;
        b=vxd6sdFQ5c8qfPE8bq2K6KDL2eLEuqLI8M14AyoI3h6dtL0ODln1SJbBnTggrGyn+F
         MAQGr3vbHE1kxZQmUACkG8zce28nUKzwE/G/PdbRmzSNcDlxX6pBBWmecZB549ypatgN
         bMG+2BnINaY1vxddfjYaxUyBM8GEpZ9IP0aSBZA06R0eEETF7qYVakceC9ZYXT4qvozn
         mFQcL8o7U9CAXXJ4D4itGJoAfPu5L5aBuqPULh6eHuZAUJodFs8/0r73xvRLUkpPiM7+
         v+vF7JzfXpwwJdYV1gYQcvnrAdG64ndWZfvMVQBusrjqAp1ma7CJFEW8W9+bOTU5wl8G
         rrgQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Enable USB host controller on Odroid-C2
References: <20190818134255.7135-1-b.galvani@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9510b9a4-64c0-c275-4038-cb56fcf373f5@baylibre.com>
Date: Wed, 28 Aug 2019 10:22:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190818134255.7135-1-b.galvani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 18/08/2019 15:42, Beniamino Galvani wrote:
> Hi,
> 
> these two patches enable the USB host controller on Odroid-C2. The
> first patch adds a PHY driver; the second one enables the necessary
> configuration options and updates the device tree.
> 
> Note that the DWC2 driver currently does not support enabling PHYs
> from the device tree and so the following series (still on review) is
> needed as runtime requirement for the second patch:
> 
>  [PATCH 0/5] usb: host: dwc2: use driver model for PHY and CLOCK


Pushed to my u-boot-amlogic-next test tree until this dependency is applied.

Thanks,
Neil

> 
> Thanks,
> Beniamino
> 
> Beniamino Galvani (2):
>   phy: meson: add GXBB PHY driver
>   odroid-c2: enable USB host controller
> 
>  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi |   8 +
>  configs/odroid-c2_defconfig                  |   7 +
>  drivers/phy/Kconfig                          |   8 +
>  drivers/phy/Makefile                         |   1 +
>  drivers/phy/meson-gxbb-usb2.c                | 235 +++++++++++++++++++
>  include/configs/meson64.h                    |   5 +
>  6 files changed, 264 insertions(+)
>  create mode 100644 drivers/phy/meson-gxbb-usb2.c
> 

