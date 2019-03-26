Received: by mail-wr1-f66.google.com with SMTP id y13so13447429wrd.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XCXJezdcoAwSWCNDC4IDG+yshBLL2bZqt6EGl2v8GB8=;
        b=snRltC8swXz7vxJ+4+TbYrhQ0KRm+YIc5Hd8fCaCdvPGWUzzES1KUttxnDgCLzxnw2
         z2Pb3mWDa37jHUigAUsQ1E334HWxlvqwBiuykf2YfUa4RtxAqZD0KXVU9i791PlU0qiY
         cTX5NMBm5bKS5U5qBnbzrHBOGxUcCrMcgEA1KZbYslh1kW6O0nlK0zfOooQu/h2W0PU+
         sAiHSFm3ydAFj5ffKTZsn8PSKIt1SP8Q2N42JgZ8tioJrDvxDY8gvht2GKWY6iKCRk0N
         DID145BCOEX7yH6+8JAH0dWdXS6O4Fv7Gg78yC2tQ5POxZ4ROrna6LsJzvNqybxU7JtB
         d+BQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v5 0/5] ARM: meson: add support for p200 and p201 boards
References: <20190323115200.1675-1-mohammad.rasim96@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <428e8f84-cc11-6f68-e975-fead1b1b2be7@baylibre.com>
Date: Tue, 26 Mar 2019 10:26:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190323115200.1675-1-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Mohammad,

On 23/03/2019 12:52, Mohammad Rasim wrote:
> This adds support for p200 and p201 reference boards from amlogic
> 
> Mohammad Rasim (5):
>   ARM: board: meson: rename odroid-c2 to p200
>   ARM: dts: meson: add p200 and p201 boards
>   ARM: dts: meson: add u-boot.dtsi for p200 and p201
>   ARM: board: meson: add p200 board
>   ARM: board: meson: add p201 board
> 
>  arch/arm/dts/Makefile                         |   2 +
>  arch/arm/dts/meson-gxbb-p200-u-boot.dtsi      |   7 +
>  arch/arm/dts/meson-gxbb-p200.dts              |  99 +++++++
>  arch/arm/dts/meson-gxbb-p201-u-boot.dtsi      |   7 +
>  arch/arm/dts/meson-gxbb-p201.dts              |  26 ++
>  arch/arm/dts/meson-gxbb-p20x.dtsi             | 247 ++++++++++++++++++
>  arch/arm/mach-meson/Kconfig                   |   2 +-
>  board/amlogic/{odroid-c2 => p200}/MAINTAINERS |   6 +-
>  board/amlogic/{odroid-c2 => p200}/Makefile    |   2 +-
>  .../{odroid-c2 => p200}/README.nanopi-k2      |   0
>  .../{odroid-c2 => p200}/README.odroid-c2      |   0
>  board/amlogic/p200/README.p200                | 103 ++++++++
>  .../{odroid-c2/odroid-c2.c => p200/p200.c}    |   0
>  board/amlogic/p201/MAINTAINERS                |   5 +
>  board/amlogic/p201/Makefile                   |   5 +
>  board/amlogic/p201/README.p201                | 103 ++++++++
>  board/amlogic/p201/p201.c                     |  43 +++
>  configs/p200_defconfig                        |  41 +++
>  configs/p201_defconfig                        |  41 +++
>  19 files changed, 734 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>  create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>  rename board/amlogic/{odroid-c2 => p200}/MAINTAINERS (70%)
>  rename board/amlogic/{odroid-c2 => p200}/Makefile (82%)
>  rename board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 (100%)
>  rename board/amlogic/{odroid-c2 => p200}/README.odroid-c2 (100%)
>  create mode 100644 board/amlogic/p200/README.p200
>  rename board/amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} (100%)
>  create mode 100644 board/amlogic/p201/MAINTAINERS
>  create mode 100644 board/amlogic/p201/Makefile
>  create mode 100644 board/amlogic/p201/README.p201
>  create mode 100644 board/amlogic/p201/p201.c
>  create mode 100644 configs/p200_defconfig
>  create mode 100644 configs/p201_defconfig

Thanks, applied to u-boot-amlogic !

Neil

> 
> --
> 2.21.0
> 

