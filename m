Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.4454.1632209653680335098
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Sep 2021 00:34:14 -0700
Received: by mail-wr1-f52.google.com with SMTP id d21so36289019wra.12
        for <u-boot-amlogic@groups.io>; Tue, 21 Sep 2021 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gvw2jIgyVHK3Qs3X6ZV+ASgc9V5L/DWol2KTZ5lZJbo=;
        b=qPXE6jFYbva9tSr5jNQflWpr6ABHYnwyZbBaYNXe2S4EBP/P6ufcAaNJrphLTsBlJ+
         jzUmbXdzWExcjJ+gbEzcw0X0P7zI2IjWneZU3UzS9wlRR7Eip0Pt7J2LbmUi4eDbyX9f
         5uhYCDpC/lQVIFM75z4rmfrnhHgmKwZcSc46XBzJQt2Hlx4n2V/crLQ9Ft6rHj+4Gqeb
         DSHtAXjoPQa0Oy+GqOe5vXhKxZ1r7FD9HvvkOqFz+TEZDzoSB0vkga511m0O+BIqrqQA
         IYKV8PynkTyDcjNnsah+Cs4B2oh27LzyjtQn2NaQnjjwDP9Bw4CBo1u/T8u98DGmrOTG
         5OIg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] ARM: amlogic: add Radxa Zero
References: <20210915014659.5336-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <05337aed-d0e4-cb46-ef3e-c934059f4b5b@baylibre.com>
Date: Tue, 21 Sep 2021 09:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210915014659.5336-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 15/09/2021 03:46, Christian Hewitt wrote:
> This series alpha sorts the Amlogic Makefile, then adds
> support for the Radxa Zero SBC using the device-tree
> queued in the Amlogic maintainer tree for Linux 5.16.y
> 
> Patches are based on custodians/u-boot-amlogic-next
> 
> Christian Hewitt (4):
>   ARM: dts: sort Amlogic Makefile section
>   ARM: dts: add support for Radxa Zero
>   boards: amlogic: add Radxa Zero defconfig
>   doc: boards: amlogic: update for Radxa Zero
> 
>  arch/arm/dts/Makefile                         |  12 +-
>  .../arm/dts/meson-g12a-radxa-zero-u-boot.dtsi |   7 +
>  arch/arm/dts/meson-g12a-radxa-zero.dts        | 405 ++++++++++++++++++
>  configs/radxa-zero_defconfig                  |  70 +++
>  doc/board/amlogic/index.rst                   |   3 +-
>  doc/board/amlogic/radxa-zero.rst              |  74 ++++
>  6 files changed, 565 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12a-radxa-zero-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12a-radxa-zero.dts
>  create mode 100644 configs/radxa-zero_defconfig
>  create mode 100644 doc/board/amlogic/radxa-zero.rst
> 

Applied to u-boot-amlogic-next

Neil
