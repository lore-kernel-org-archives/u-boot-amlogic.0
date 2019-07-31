Received: by mail-wr1-f68.google.com with SMTP id x1so19044000wrr.9
        for <u-boot-amlogic@groups.io>; Wed, 31 Jul 2019 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=slkC4oGQTdipE7Uy+DjE2/APEuK9DADVA/NU/KH7a/Y=;
        b=dz+J4TrRoEWr/PnnVjJUhtWatZLOYPKTSnF1xTk1bJiKz4J7cpdWYVVVHzaSzOHtGb
         sOIpjT74OfN83n9te7SG5rbFO/7T9qyZvDl1eRFilk9BuxLD3BvTGvoyjfbi+fgtWasC
         gIrnw6/KasIU2zj8wmlpL3tgc48fT6RO09rJqDrvUpusdMLCZK4Bl81Z/bQgQa/mYw2L
         7RB/WXmNDzlzFW7XjihEZ5AhJdNMQjopkeyiSbaT6NOprVN9VOQKeKqd7nvPq1VTAb2d
         b35e6DPL/mh6rOszpKbBxYprt8MEk3i65v1I1oWOjDyOS0a9hxVCYgAVfKsmJf4H3rPh
         Egsw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 0/3] amlogic: Add support for Odroid-N2
References: <20190729134552.8860-1-narmstrong@baylibre.com>
 <e7b105e3-d40f-16fc-9dc0-09a3108730bd@baylibre.com>
 <5438e3a51c242447@bloch.sibelius.xs4all.nl>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8d572778-2914-17d7-cccf-707ec50eea68@baylibre.com>
Date: Wed, 31 Jul 2019 11:54:39 +0200
MIME-Version: 1.0
In-Reply-To: <5438e3a51c242447@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 31/07/2019 11:30, Mark Kettenis wrote:
>> From: Neil Armstrong <narmstrong@baylibre.com>
>> Date: Wed, 31 Jul 2019 09:18:10 +0200
>>
>> On 29/07/2019 15:45, Neil Armstrong wrote:
>>> ODROID-N2 is a single board computer manufactured by Hardkernel Co. Ltd
>>> with the following specifications:
>>>
>>>  - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
>>>  - 4GB DDR4 SDRAM
>>>  - Gigabit Ethernet
>>>  - HDMI 2.1 4K/60Hz display
>>>  - 40-pin GPIO header
>>>  - 4 x USB 3.0 Host, 1 x USB OTG
>>>  - eMMC, microSD
>>>  - Infrared receiver
>>>
>>> This patchset :
>>> - adds the Odroid-N2 from Linux 5.3-rc1
>>> - fixes 4GiB memory support
>>> - adds board support
>>>
>>> The board directory is W400, the name of the Amlogic Reference Design
>>> of Amlogic G12B with Gigabit boards, which will be used for similar
>>> boards.
>>>
>>> Changes since v1:
>>> - Fix typo in README.odroid-n2
>>>
>>> Neil Armstrong (3):
>>>   ARM: dts: add support for Odroid-N2
>>>   ARM: meson-g12a: Handle 4GiB DRAM size
>>>   board: amlogic: add support for Odroid-N2
>>>
>>>  arch/arm/dts/Makefile                         |   3 +-
>>>  arch/arm/dts/meson-g12b-odroid-n2.dts         | 386 ++++++++++++++++++
>>>  arch/arm/dts/meson-g12b.dtsi                  |  82 ++++
>>>  arch/arm/mach-meson/board-g12a.c              |  13 +-
>>>  board/amlogic/w400/MAINTAINERS                |   6 +
>>>  board/amlogic/w400/Makefile                   |   6 +
>>>  board/amlogic/w400/README.odroid-n2           | 130 ++++++
>>>  board/amlogic/w400/README.w400                | 130 ++++++
>>>  board/amlogic/w400/w400.c                     |  18 +
>>>  configs/odroid-n2_defconfig                   |  56 +++
>>>  .../dt-bindings/sound/meson-g12a-tohdmitx.h   |  13 +
>>>  11 files changed, 836 insertions(+), 7 deletions(-)
>>>  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
>>>  create mode 100644 arch/arm/dts/meson-g12b.dtsi
>>>  create mode 100644 board/amlogic/w400/MAINTAINERS
>>>  create mode 100644 board/amlogic/w400/Makefile
>>>  create mode 100644 board/amlogic/w400/README.odroid-n2
>>>  create mode 100644 board/amlogic/w400/README.w400
>>>  create mode 100644 board/amlogic/w400/w400.c
>>>  create mode 100644 configs/odroid-n2_defconfig
>>>  create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h
>>>
>>
>> Applied on u-boot-amlogic
> 
> FWIW, this made it possible for me to finally build a U-Boot with UEFI
> support that can run the OpenBSD bootloader and kernel.  Now I just
> need to finish writing the device drivers for the Amlogic-specific
> hardware blocks ;).
> 
> So, feel free to add:
> 
>   Tested-by: Mark Kettenis <kettenis@openbsd.org>
> 
> if for some reason you need to respin the series
> 

Nice, I haven't sent the PR, so I'll add it !

Thanks for testing !

Neil

