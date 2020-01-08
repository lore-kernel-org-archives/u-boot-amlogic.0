Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web09.7276.1578488307174829582
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Jan 2020 04:58:27 -0800
Received: by mail-wm1-f68.google.com with SMTP id m24so2371510wmc.3
        for <u-boot-amlogic@groups.io>; Wed, 08 Jan 2020 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YI0vVBbl3l4MwdzjThs3VK6G00UGdgC2y6oWfPoehek=;
        b=xOFhuMG3wfZeBXfyjVJJ6FLB1MIJ/cHeVRty2C8EOlSoHhN7XlMAKL5puPzhrg/vgH
         vJ2xJBVr47+NaQbVk27T19DUMxYJPik9ttLvqQeMJGFKR0MErHvzvTFmlra19wNNGBKT
         55otpwbJR7kF6Ov89dmFodxBg3jNiU5Pvy+ssh1z9MI5ot5HkQ95p9TnvInk2feQVSP7
         v96M/KG34SnTWwoWmNZyvaoMFBgcZrucvPvVM+VCpvRMqJu92tIc/YDQpq035E24hTrH
         LRO2+nk6ORj7/NWzhT2nuQsSgzpIa0TQgaFxshSUl+o+XMz7APA6dawRcdON/CYGeaUC
         auLg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20191018
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <fc28b03e-b133-b683-94bd-770bc89ce5aa@baylibre.com>
Message-ID: <64b6447b-b37f-d064-3695-dcd65b54cdae@baylibre.com>
Date: Wed, 8 Jan 2020 13:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <fc28b03e-b133-b683-94bd-770bc89ce5aa@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Wrong subject, please ignore....

On 08/01/2020 13:57, Neil Armstrong wrote:
> Hi Tom,
> 
> This PR adds more support for the Khadas VIM3L, variant of VIM3 but
> using the Amlogic SM1 S905D3 SoC, plus various small fixes.
> 
> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/1780
> 
> Thanks,
> Neil
> 
> The following changes since commit 0b0c6af38738f2c132cfd41a240889acaa031c8f:
> 
>   Prepare v2020.01 (2020-01-06 15:56:31 -0500)
> 
> are available in the Git repository at:
> 
>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200108
> 
> for you to fetch changes up to 262d34363373c10a00279036c1561283c30495c2:
> 
>   board: amlogic: select PWRSEQ for all amlogic platform (2020-01-07 14:50:41 +0100)
> 
> ----------------------------------------------------------------
> - Khadas VIM3L based on Amlogic S905D3 support
> - Various fixups for amlogic boards
> - Unnecessary header includes drop into video/meson
> 
> ----------------------------------------------------------------
> Anand Moon (2):
>       configs: meson64: enable GIC support for G12A/G12B
>       board: amlogic: select PWRSEQ for all amlogic platform
> 
> Christian Hewitt (2):
>       ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
>       boards: amlogic: add Khadas VIM3L support
> 
> Simon Glass (1):
>       video: meson: Drop unnecessary header includes
> 
>  arch/arm/dts/Makefile                   |   1 +
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts |  95 +++++++++++++++++++++++
>  arch/arm/mach-meson/Kconfig             |   1 +
>  board/amlogic/w400/MAINTAINERS          |   1 +
>  board/amlogic/w400/README.khadas-vim3l  | 132 ++++++++++++++++++++++++++++++++
>  configs/khadas-vim3l_defconfig          |  62 +++++++++++++++
>  drivers/video/meson/meson_canvas.c      |   4 +
>  drivers/video/meson/meson_plane.c       |   5 ++
>  drivers/video/meson/meson_vclk.c        |   2 +
>  drivers/video/meson/meson_venc.c        |   4 +
>  drivers/video/meson/meson_vpu.c         |  18 ++++-
>  drivers/video/meson/meson_vpu.h         |  17 ++--
>  drivers/video/meson/meson_vpu_init.c    |   4 +
>  include/configs/meson64.h               |   2 +-
>  include/video.h                         |   2 +
>  15 files changed, 334 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
>  create mode 100644 board/amlogic/w400/README.khadas-vim3l
>  create mode 100644 configs/khadas-vim3l_defconfig
> 

