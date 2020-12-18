Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.7721.1608284997852139563
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:49:58 -0800
Received: by mail-wr1-f41.google.com with SMTP id a12so1443339wrv.8
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i68DHKWuidoiLSCjV7Xg6b+4uHNmCRXnOuj5cVbm9rw=;
        b=05B+BYsTW+FvCB9LCMoqSbVULdUp85baC/MO0WnyfrQI0SLrOsx2hjAsDlIMtxZbEr
         D7131ePnDtqLEHgyBvDS9BztCid3lMaevi7v0WpB/04sejkEQ0/tYWXMhEFG83EQ57sX
         HcVaMqtoWMoFueO88KR6k3x4arentx866HvbJrDDXOxTQHMVHrOHBHObSW34LqOmtath
         wVmaYo/q7QWW2SM/lX5mdK93TYthmJpzMkY2I7Vsq6Tox3uMDxXddzP9Tg4kGyACs6zZ
         PNQjox69ljMrRl78/kWXciHUWSZsWcx0WR2AgsAUAquCM8E/pZtckVpzxPeH/ERSED9m
         6Cwg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] board: amlogic: add Beelink GT-King/Pro support
References: <20201218084545.29135-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <19d7f4a3-4c48-54f9-c4f0-73756ea4dc09@baylibre.com>
Date: Fri, 18 Dec 2020 10:49:54 +0100
MIME-Version: 1.0
In-Reply-To: <20201218084545.29135-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 09:45, Christian Hewitt wrote:
> This patchset adds support for the Beelink GT-King and GT-King Pro boxes
> based on the Amlogic S922X (G12B/W400) SoC. Patches are based on the
> u-boot-amlogic-next branch in the custodians tree.
> 
> Christian Hewitt (5):
>   ARM: dts: import Beelink GT-King/Pro DTs from Linux 5.10
>   boards: amlogic: add Beelink S922X board family support
>   boards: amlogic: add Beelink GT-King defconfig
>   boards: amlogic: add Beelink GT-King Pro defconfig
>   boards: amlogic: update documentation for Beelink GT-King/Pro
> 
>  arch/arm/dts/Makefile                       |   2 +
>  arch/arm/dts/meson-g12b-gtking-pro.dts      | 125 ++++++
>  arch/arm/dts/meson-g12b-gtking.dts          | 145 +++++++
>  arch/arm/dts/meson-g12b-w400.dtsi           | 425 ++++++++++++++++++++
>  board/amlogic/beelink-s922x/MAINTAINERS     |   9 +
>  board/amlogic/beelink-s922x/Makefile        |   6 +
>  board/amlogic/beelink-s922x/beelink-s922x.c |  54 +++
>  configs/beelink-gtking_defconfig            |  71 ++++
>  configs/beelink-gtkingpro_defconfig         |  71 ++++
>  doc/board/amlogic/beelink-gtking.rst        | 115 ++++++
>  doc/board/amlogic/beelink-gtkingpro.rst     | 116 ++++++
>  doc/board/amlogic/index.rst                 |   4 +-
>  12 files changed, 1142 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/meson-g12b-gtking-pro.dts
>  create mode 100644 arch/arm/dts/meson-g12b-gtking.dts
>  create mode 100644 arch/arm/dts/meson-g12b-w400.dtsi
>  create mode 100644 board/amlogic/beelink-s922x/MAINTAINERS
>  create mode 100644 board/amlogic/beelink-s922x/Makefile
>  create mode 100644 board/amlogic/beelink-s922x/beelink-s922x.c
>  create mode 100644 configs/beelink-gtking_defconfig
>  create mode 100644 configs/beelink-gtkingpro_defconfig
>  create mode 100644 doc/board/amlogic/beelink-gtking.rst
>  create mode 100644 doc/board/amlogic/beelink-gtkingpro.rst
> 

Applying to u-boot-amlogic-next
