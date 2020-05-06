Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web10.2237.1588751961498731494
 for <u-boot-amlogic@groups.io>;
 Wed, 06 May 2020 00:59:22 -0700
Received: by mail-wr1-f65.google.com with SMTP id h9so1018554wrt.0
        for <u-boot-amlogic@groups.io>; Wed, 06 May 2020 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TN/6PFrYu46mcJaPG19QHtmTRCiBzM6dh9A/Ag/Wg0=;
        b=hDit4b8PgbXgx0a4+rhtJiu6O5GwUz4VaWDuNdRuT14XOPBzqkoKQEkWR1HbJQE2LN
         tlAFdngV2p4Urm3Vj801GfrcsLT4NrTLAJ1w5h5m/Ic2RQ1O0Q/O6I3+PE/g4jOzKvJV
         hqrAWki/M0ipvi5FgAC3GSSiLlkDWF4AwktxDHhWvHw8/Rr7CsZpDjK3C1UOK1gYOUGb
         0ukYXCq5lycvm2PnQGArHfUSjmBTLnZj31cp1nWs7utzqQSbRGuxQGrQMNs7rOAGSZz3
         9CldqA+HLSI0UMqVUdIRCNfJe7FXqge62esKRWGzHzXaWHUIf0qXhuspwoNKzpbHBKj0
         h9vw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
References: <20200505202217.7849-1-b.galvani@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4b3c7fda-d644-4a4b-46de-7f243a1dc33a@baylibre.com>
Date: Wed, 6 May 2020 09:59:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200505202217.7849-1-b.galvani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Beniamino,

On 05/05/2020 22:22, Beniamino Galvani wrote:
> Hi,
> 
> these two patches add initial u-boot support for Hardkernel ODROID-C4.

Thanks for the patchset, I already have one in my test tree, by you did beat me
by sending it to the list !

> 
> https://wiki.odroid.com/odroid-c4/odroid-c4
> 
> Beniamino Galvani (2):
>   arm: dts: import ODROID-C4 device tree

The DT is not yet applied by kevin, thus I'll prefer waiting it to be accepted
and merged in a stable linux tree to keep DT synced.

>   boards: amlogic: add ODROID-C4 support

Please re-use the w400 board instead of adding a new board, there is no need for a new
one until you'll need to add more functionalities.

I know meson_generate_serial_ethaddr() is absent from w400, I'll add it shortly.

Neil

> 
>  arch/arm/dts/Makefile                |   1 +
>  arch/arm/dts/meson-sm1-odroid-c4.dts | 399 +++++++++++++++++++++++++++
>  board/amlogic/odroid-c4/MAINTAINERS  |   6 +
>  board/amlogic/odroid-c4/Makefile     |   3 +
>  board/amlogic/odroid-c4/README       |  83 ++++++
>  board/amlogic/odroid-c4/odroid-c4.c  |  17 ++
>  configs/odroid-c4_defconfig          |  63 +++++
>  7 files changed, 572 insertions(+)
>  create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
>  create mode 100644 board/amlogic/odroid-c4/MAINTAINERS
>  create mode 100644 board/amlogic/odroid-c4/Makefile
>  create mode 100644 board/amlogic/odroid-c4/README
>  create mode 100644 board/amlogic/odroid-c4/odroid-c4.c
>  create mode 100644 configs/odroid-c4_defconfig
> 

