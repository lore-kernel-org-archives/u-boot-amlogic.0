Received: by mail-wr1-f65.google.com with SMTP id w2so8859384wrt.11
        for <u-boot-amlogic@groups.io>; Fri, 15 Mar 2019 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CD2mC41ECfVkPDofIYMIzbi7XFYhE5+T8fURXWcTq8k=;
        b=ECxKeMuN0IGYSzAhxl+4W6OxrM0XC1T53GsXC1Fsm8qsAdnhv3qOTodXcKlH0Ry7iM
         qNVA4E+cBzk8I6tLNe7HsITJdMF2ufg1ibmit5S4c0enDH8TXwGUS4av+oJi0JuYpsji
         WI/jlnoQG/SnhfQcQrI7GlXCSuYcc4s4exKi6zw5sZi3g5SpitKT6KaoPcyB7H7YPcvI
         zWm76sycylUXgJDJfsIG/NaVpVnkNPTVmpzg1ZIHczpxlCtR9jWKjr+6C9M2YMS8gEHT
         p0+ZxIawECEXTu/KsUZmCXM9C7xljwRGKUDul9IPZJJpnlr2yYNAenAOpXWqIlBskDXp
         7T1w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/3] ARM: meson: add p200 and p201 boards
References: <20190314210920.11006-1-mohammad.rasim96@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e9af1828-51e9-e6d3-0836-c72304e6416d@baylibre.com>
Date: Fri, 15 Mar 2019 10:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190314210920.11006-1-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Thanks for the reactivity !

On 14/03/2019 22:09, Mohammad Rasim wrote:
> This adds support for p200 and p201 reference boards from amlogic
> 
> Mohammad Rasim (3):
>   ARM: dts: meson: add p200 and p201 boards
>   ARM: board: meson: add p201 board
>   ARM: board: meson: add p200 board
> 
>  arch/arm/dts/Makefile               |   2 +
>  arch/arm/dts/meson-gxbb-p200.dts    |  99 +++++++++++
>  arch/arm/dts/meson-gxbb-p201.dts    |  26 +++
>  arch/arm/dts/meson-gxbb-p20x.dtsi   | 247 ++++++++++++++++++++++++++++
>  board/amlogic/odroid-c2/MAINTAINERS |   1 +
>  board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++
>  board/amlogic/p201/MAINTAINERS      |   5 +
>  board/amlogic/p201/Makefile         |   5 +
>  board/amlogic/p201/README.p201      | 103 ++++++++++++
>  board/amlogic/p201/p201.c           |  43 +++++
>  configs/p200_defconfig              |  41 +++++
>  configs/p201_defconfig              |  41 +++++
>  12 files changed, 716 insertions(+)
>  create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>  create mode 100644 board/amlogic/odroid-c2/README.p200
>  create mode 100644 board/amlogic/p201/MAINTAINERS
>  create mode 100644 board/amlogic/p201/Makefile
>  create mode 100644 board/amlogic/p201/README.p201
>  create mode 100644 board/amlogic/p201/p201.c
>  create mode 100644 configs/p200_defconfig
>  create mode 100644 configs/p201_defconfig
> 
> --
> 2.21.0
> 

Nearly perfect, but :
- can you add a small text in the commits logs of patches 2 & 3 ?
- can you add a patch adding arch/arm/dts/meson-gxbb-p200-u-boot.dtsi and arch/arm/dts/meson-gxbb-p201-u-boot.dtsi based on arch/arm/dts/meson-gx-u-boot.dtsi ?

With these I'll take them !

Thanks,
Neil
