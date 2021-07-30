Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.22748.1627644949862351589
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 04:35:50 -0700
Received: by mail-wr1-f46.google.com with SMTP id m12so6124922wru.12
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iHrzoR5IEQ2CvZELZRKHl5K2h2BRnoBgQfd6uYYth4=;
        b=Nqx8JUUxmxVGCW6f0ZF9PfWOTN+xRs2XAAHMimRVvR8t9WVSigG6Uv+aWho1ftxslB
         pbN2OZRz7OEsim8+ObxVog1dsX/adjHkmTI21Gf1xOpvU7hfStbx/HfxU7o75mHi9gSE
         NnaKhF7ODM/Jw5g7c50gu+bPhpD0gen3w38YZxYc4aDf7JwzESnYrpfI09iQyVgirZbT
         HaNuuPPCJ+e4km1Oc/awW3sdwURFUodhlPJ14n9ldR7A4NwL7iUP+GgqMQwkXrsjFG2T
         F2FJd/0MJUEWb9lJmCMtrr7H+kro+zqzsYRuk/OuabbAnfRYvbkopN36go6JOIGvJKpH
         Nbeg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] meson64_android: use BCB for reboot reason
References: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2a76c618-8d6a-8a1c-19dd-2ce899c49459@baylibre.com>
Date: Fri, 30 Jul 2021 13:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 30/07/2021 10:55, Mattijs Korpershoek wrote:
> The SEI-610 and SEI-510 boards are well supported in the
> Android Open Source project via the yukawa [1] platform.
> 
> Their U-Boot version, despite being public [2] is not in mainline.
> 
> Android has multiple OSes it can boot into:
> * Main android
> * Recovery OS
> * Fastbootd (recovery OS with fastboot mode)
> * Bootloader (U-Boot) with fastboot mode
> 
> The decision of which OS to boot into is taken by the bootloader based on
> the "reboot reason".
> 
> For amlogic boards, we pass the reboot reason via a custom smc call.
> This support is limited: we don't r
> 
> These series reworks the reboot reason handling to use the BCB, which
> is the standard Android way.
> 
> [1] https://android.googlesource.com/device/amlogic/yukawa
> [2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
> 
> Mattijs Korpershoek (5):
>   Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
>   configs: meson64_android: use BCB for reboot to bootloader
>   configs: meson64_android: implement recovery boot via BCB
>   configs: meson64_android: reboot to fastbootd from bootloader
>   configs: sei610/sei510: set CONFIG_CMD_BCB=y
> 
>  arch/arm/mach-meson/board-common.c | 34 -----------------
>  configs/sei510_defconfig           |  1 +
>  configs/sei610_defconfig           |  1 +
>  include/configs/meson64_android.h  | 60 ++++++++++++++++++++----------
>  4 files changed, 42 insertions(+), 54 deletions(-)
> 

Looks fine, but I'll move the patch 1 as last.

Can you re-post ?

Please add:
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

to all patches if you repost.

Neil
