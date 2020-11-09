Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web12.5559.1604886065688215688
 for <u-boot-amlogic@groups.io>;
 Sun, 08 Nov 2020 17:41:06 -0800
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201109014102epoutp021e5905a916738a6fa567e8d4a383761a~Fs17807SY2227022270epoutp02G
	for <u-boot-amlogic@groups.io>; Mon,  9 Nov 2020 01:41:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201109014102epoutp021e5905a916738a6fa567e8d4a383761a~Fs17807SY2227022270epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604886062;
	bh=gpzcbMyY3tXbFe+JOeL7AWO00kvA9ixwouGRtw22zCc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=OYXXwJSy6pVPr2TTnIsTr0axggcEAqolQmDSCtUXRlSm2q6NLMQGi3R5wRMSIEdqj
	 wm+W9y3IPcj/Px6rEmMHaJSPWgzbgEL7DTfQgy5Cj8MwLiDcjMhJcgcf5FMPyyixOu
	 qKNq21/pG44+O4haV4Hi2ZEWMKp5WupiZpIqtjy0=
Subject: Re: [PATCH 0/3] mmc: meson-gx: fix mmc & scard failure on SM1 SoCs
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <4133c4ef-0211-5e82-afbe-e21573bf987c@samsung.com>
Date: Mon, 9 Nov 2020 10:41:15 +0900
MIME-Version: 1.0
In-Reply-To: <20201106092755.2250773-1-narmstrong@baylibre.com>
References: <CGME20201106093022epcas1p1e3b7a19d34c0f75b67edce7a6f751645@epcas1p1.samsung.com>
	<20201106092755.2250773-1-narmstrong@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Dear Neil,

On 11/6/20 6:27 PM, Neil Armstrong wrote:
> Amlogic SM1 SoCs doesn't handle very well high clocks from the DIV2 input
> Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
> frequencies via the first input from a composite clock.
> 
> Here 26MHz corresponds to MMC_HS clock speed.

When i have checked, it's working with 52MHz.

mmc1(part 0) is current device
Odroid N2> mmcinfo
Device: mmc@ffe07000
Manufacturer ID: 15
OEM: 100
Name: BJTD4
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 29.1 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 29.1 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH


Device: sd@ffe05000
Manufacturer ID: 3
OEM: 5344
Name: SB16G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 14.8 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
Odroid N2> ums 0 mmc 0

If you can wait for more time, i can fix it.
I think that it's better than applying this patch.
But i don't know which boards are SM1 SoC..(Odroid-c4 and VIM3L?)

Best Regards,
Jaehoon Chung

> 
> We also add a u-boot only sm1 compatible to distinguish the controller in a new
> meson-sm1-u-boot.dtsi and reworks the other -u-boot.dtsi to use this for SM1 based boards.
> 
> Finally a TOFIX is added to precise the clock management should use
> the clock controller instead of local management with fixed clock rates.
> 
> Neil Armstrong (3):
>   mmc: meson-gx: move arch header to local header
>   mmc: meson-gx: limit max frequency on SM1 SoCs
>   ARM: dts: meson-sm1: add u-boot specific MMC controller compatible
> 
>  .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |  1 +
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  2 --
>  .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  1 +
>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |  2 +-
>  arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |  2 +-
>  arch/arm/dts/meson-sm1-u-boot.dtsi            | 20 +++++++++++++
>  drivers/mmc/meson_gx_mmc.c                    | 28 ++++++++++++++++---
>  .../sd_emmc.h => drivers/mmc/meson_gx_mmc.h   | 10 ++++---
>  8 files changed, 54 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm/dts/meson-sm1-u-boot.dtsi
>  rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (95%)
> 

