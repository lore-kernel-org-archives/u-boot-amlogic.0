Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.5612.1574859337694658619
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 04:55:38 -0800
Received: by mail-wr1-f68.google.com with SMTP id w9so26614694wrr.0
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xAkOgG7IpW94c9Ft7FVGD1sfahLxtgqMt45GoYuLfBs=;
        b=GD3FKHbqaKEp7PgxeiNXw/tuFdYDqrlUGfxVE0w6MTBKhMxU1KxNGoFVsCzwlc73gj
         MjWr2X1SkPuvGsP0+KPMwV5+fEUFxi2lWirIfJjeC+TC5Vd+g81xwgvDPpWkmWfHqtuP
         CP+Y5WyiiRbpx7us5T1fAYEDyYXUA6rRyLzVBfzOMA8Pr7AmvUYTop14HV9hpTTjO12G
         cFeFEalWPwpk39Jv9g0SFUgU19tuXyXseLI3Fw35eSQXDGTEzJ4M+o+6n3PH/aExDvDa
         AU8vUN79Ud0RMcIa6BKtILRhEJy5osazPap4A2rkaE03MVFhusXiDOPswn95Suh5jXE7
         V6nw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 4/4] board: amlogic: Add missing config option
References: <20191126211206.4537-1-linux.amoon@gmail.com>
 <20191126211206.4537-5-linux.amoon@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <455903af-cba5-6ff5-d1af-b2367626d309@baylibre.com>
Date: Wed, 27 Nov 2019 13:55:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191126211206.4537-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 26/11/2019 22:12, Anand Moon wrote:
> Add missing config option CONFIG_MESON_GXBB and CONFIG_SYS_BOARD,
> for odroid-c2 and nanopi k2 board
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  configs/nanopi-k2_defconfig | 2 ++
>  configs/odroid-c2_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 7bdeb7906a..3d6265c587 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -1,6 +1,8 @@
>  CONFIG_ARM=y
> +CONFIG_SYS_BOARD="p200"
>  CONFIG_ARCH_MESON=y
>  CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_MESON_GXBB=y
>  CONFIG_ENV_SIZE=0x2000
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 1f5a52c57c..700c871918 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -1,6 +1,8 @@
>  CONFIG_ARM=y
> +CONFIG_SYS_BOARD="p200"
>  CONFIG_ARCH_MESON=y
>  CONFIG_SYS_TEXT_BASE=0x01000000
> +CONFIG_MESON_GXBB=y
>  CONFIG_ENV_SIZE=0x2000
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_DEBUG_UART_BASE=0xc81004c0
> 

These are not present since they are the default values, thus not exported in savedefconfig.

Neil
