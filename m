Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.11473.1585316154616890885
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Mar 2020 06:35:54 -0700
Received: by mail-wr1-f68.google.com with SMTP id u10so11424099wro.7
        for <u-boot-amlogic@groups.io>; Fri, 27 Mar 2020 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67lAKFcBlohbq3S3hlo2owskh4YzGLV8oikkn8nxSLw=;
        b=fYiNJaVuuwRezwivyuOsURZu+BNTqKJHYtufNMVdgv3ZM8Sn/kT++amApuqmNWc9yD
         V+UFNzpNiKO+B0/ijW5J56R2vECq1XuJNJD3uEL+ltZch5Pb1xgJnXVPlkngEzzu6BsV
         uctfBI0ydbhIf2kj/oZfFoLk8QyNZ8PLn/qLAs7yVPdzYCPAsQuZAJ1Lud6fQ4Kw1ITa
         4NFQ5aWKVlbTnBRpHf3TUOSxagaqCU4zo5py17zEf6YLw4+6qMi8CYAbEHJza3Pe8EOi
         +VtKI2FdA/c9l/EpXJ9qo7mtKngjF66dCzJGm0IR3+LSN//+h4+9ATKy9Z8aRHxuWnLv
         CAxw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Enable USB host controller on Odroid-C2
References: <20190818134255.7135-1-b.galvani@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f09bd116-97de-81da-50cc-4afa2c1381e8@baylibre.com>
Date: Fri, 27 Mar 2020 14:35:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190818134255.7135-1-b.galvani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

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

Could you re-test with v6 of DWC2 patchset at http://patchwork.ozlabs.org/project/uboot/list/?series=163388 ?

Neil
