Received: by mail-wm1-f67.google.com with SMTP id f65so3396178wma.2
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RbAPNk6AHAt0T6e4vvE2YthaolliuL9IR/dBDU1xkrM=;
        b=Kce7rgMpRHXvE2jxjYLfE9lyTyj7EMt33i5huDiPCWqGa7YKqLHABoe1SCkcVE6F4s
         +WgAdGOKpKyIbvTiWzoZouCQ3fZ7fYnkPfZTszlRpNyQzsIOOl5ZKsHbWJ7Q0bbAluOp
         eu/NtF3+Cb/cwNbfKw8UiZxAwsNuBfngFmaqUuTLfC2lWax8cYTCl+XP37+pByVYWO3l
         7Gy7ysl4imFStpSzUV5rbRSneZcf1b3C4Xyvs0wTUbPNlWvkmHnjX4sxHCZg7Y93h9Le
         uu1M4zdDezFAVqcxwVH5bdl0MmIYy3xA5axFsj52DbCYLihWF0TPQxvUAyj1J0dI1128
         JdQQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] ARM: meson: add p200 and p201 boards
References: <5c8a69f8.1c69fb81.cc832.5b07@mx.google.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <42c693d1-4a08-68bb-1ac4-51352814cd34@baylibre.com>
Date: Thu, 14 Mar 2019 16:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <5c8a69f8.1c69fb81.cc832.5b07@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

seems you mismatched the To entry as :
"u-boot@lists.denx.deu-boot-amlogic"@groups.io

Not sure the u-boot ML received the patches.

Neil

On 14/03/2019 15:02, Mohammad Rasim wrote:
> This adds support for p200 and p201 reference boards from amlogic
> 
> Mohammad Rasim (2):
>   ARM: dts: meson: add p200 and p201 boards
>   ARM: board: meson: add p200 and p201 boards
> 
>  arch/arm/dts/Makefile               |   2 +
>  arch/arm/dts/meson-gxbb-p200.dts    |  99 +++++++++++
>  arch/arm/dts/meson-gxbb-p201.dts    |  26 +++
>  arch/arm/dts/meson-gxbb-p20x.dtsi   | 247 ++++++++++++++++++++++++++++
>  board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++
>  board/amlogic/p201/MAINTAINERS      |   6 +
>  board/amlogic/p201/Makefile         |   5 +
>  board/amlogic/p201/README.p201      | 103 ++++++++++++
>  board/amlogic/p201/p201.c           |  43 +++++
>  configs/p200_defconfig              |  41 +++++
>  configs/p201_defconfig              |  41 +++++
>  11 files changed, 716 insertions(+)
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

