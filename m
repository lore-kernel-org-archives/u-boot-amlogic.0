Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.19278.1594136897822207066
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jul 2020 08:48:18 -0700
Received: by mail-wr1-f68.google.com with SMTP id a6so45711309wrm.4
        for <u-boot-amlogic@groups.io>; Tue, 07 Jul 2020 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=F0N4s9eQDQtTw1I2EV80dbkYnPWAqK2UOxdCCWO1IyQ=;
        b=iG8xDulbYeqEE6dj/o15w7fvYgNGIVTHiJ5BzF/aRd/SPjvdD+566CJ5lKHXMY592k
         +QvuHSs71IGynBZAXiE/7OcUYXVbHcwwt+PZ03WXTNaadzLTEMqUy1A/GQ8V16i/7A/K
         QdhJI6ppKKWgnqyzqL5UKqxHuipJ0sav7KQkq/XJLTwgcnkTr2yX5KwhsyU+Ut4GGWUq
         fkGDCODRFJ6ieDDdxFAsHeqya8Pvc2sVkV8lN5GcgR9RdPlkFxpvY+NS4L+MqVD0vN8O
         YndI90g/KgORn3Tsl2VGXEP0ZNc9pwYCZXVAQYLaHwlaLWz+ziSRdNalLlQ7axakgq3e
         VnOA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] board: amlogic: add Odroid C4 support
References: <20200701144310.25481-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a7985357-14a6-a6f3-e91f-b0e8faab5e3c@baylibre.com>
Date: Tue, 7 Jul 2020 17:48:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200701144310.25481-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com, linux.amoon@gmail.com
List-ID: <u-boot-amlogic@groups.io>



Le 01/07/2020 =E0 16:43, Neil Armstrong a =E9crit :
> This patchset adds support for the Hardkernel Odroid-C4 board
> based on an Amlogic S905X3 SoC (SM1).
>=20
> These patches were made very early from Christian Hewitt when the device
> was unveiled by Hardkernel, and superseed the patchset from Beniamino Gal=
vani
> posted later.
>=20
> Beniamino, sorry for posting this over your patchset, but they are essent=
ially
> the same and this one is already used by LibreELEC, Armbian and out Kerne=
lCI
> boards.
>=20
> It used the new Odroid-N2 board support instead of W400, and adds a doc
> file in RsT format.
>=20
> Christian Hewitt (2):
>   ARM: dts: sync amlogic G12A/G12B/SM1 DT from Linux 5.8-rc1
>   boards: amlogic: add Odroid C4 support
>=20
> Neil Armstrong (1):
>   ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset
>=20
>  arch/arm/dts/Makefile                        |   1 +
>  arch/arm/dts/meson-g12-common.dtsi           |  13 +-
>  arch/arm/dts/meson-g12.dtsi                  |  32 +-
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi     |  22 +-
>  arch/arm/dts/meson-g12b-s922x.dtsi           |  15 +
>  arch/arm/dts/meson-g12b.dtsi                 |  22 +
>  arch/arm/dts/meson-khadas-vim3.dtsi          |   4 +-
>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi |  13 +
>  arch/arm/dts/meson-sm1-odroid-c4.dts         | 402 +++++++++++++++++++
>  arch/arm/dts/meson-sm1-sei610.dts            |   2 +-
>  arch/arm/dts/meson-sm1.dtsi                  |  24 ++
>  board/amlogic/odroid-n2/MAINTAINERS          |   2 +
>  configs/odroid-c4_defconfig                  |  62 +++
>  doc/board/amlogic/index.rst                  |   3 +-
>  doc/board/amlogic/odroid-c4.rst              | 133 ++++++
>  15 files changed, 713 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
>  create mode 100644 configs/odroid-c4_defconfig
>  create mode 100644 doc/board/amlogic/odroid-c4.rst
>=20

Applied to u-boot-amlogic
