Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F0C6FD1F
	for <webhook@archiver.kernel.org>; Tue,  2 Apr 2024 07:06:38 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.6725.1712041597516951262
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Apr 2024 00:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=qgbtZTAg;
 spf=pass (domain: baylibre.com, ip: 209.85.221.45, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3416a975840so3726735f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712041596; x=1712646396; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=blbAjz+0QgA6vSUeCWNZEKYTYJWXWc4mPc9gNvaE9nk=;
        b=qgbtZTAgELA2P/DIlSG21wDNjBvdv5hatDMJ+mOOOucWEwPHX+IOjTnNVuBVjQAE4H
         lfJsH4hRABQI7kVS3RYgOk5WOkBqjPA9C45MN05EsyKEOPRhE6V5hwrCPzZEtJRTgkDl
         zCNJNxsuCIoDSC945DpPzHyr7ckKSCOhbx9THudFVUNRGBJoC3zzwzzRUg66WyLaqsF3
         r4+XxnYoFpl8zUmhrjl8Y7Il5Jk3xZ+/4QNEq5mu2b9pH6518E2yg60EEDtbgx5eGIMI
         VPV7QUKR46LGuh/x9v+fK5vEI7VvM9+xG0u966rwoEmKpXZcRDyMptMsIX5VznVOZmdr
         jrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041596; x=1712646396;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blbAjz+0QgA6vSUeCWNZEKYTYJWXWc4mPc9gNvaE9nk=;
        b=sL2axPfrCPNS4jNGeRRjFKp458qI6/hWCjJLf8bzfCIuH28bO+Zzdd0e6q7igD0y3Z
         rITWNyr7AgyZWEsx6NQZVLrRViim9FLmLnMoOItWjcO/hrdgAd5LH07LVVWgo1YmL150
         OHaHV7bTeiRY28iCzrWPGpT2sieTQXyR8CTTvuzs34yL3/K5rRiZ4h9+wCdSvIifr4De
         QYyn+nf1UXvd12spKMkqwR8LrLAGRNVzccasvhLAzrkUOJfmwbAcktvvySVjQf5PEr1f
         LWKac1MCdeVe00up3PEnYlkvZTb4DJn9UQIhqULtm7oawyUD49BLA0k4fJgzFTKgLd0s
         muJw==
X-Gm-Message-State: AOJu0YxVNXcnYT8YJlUtdKuKgDMfEAoke4rB53E8YIamzFRflCML/StB
	lkI+D543pZlw6dHO616lWkVrccSOwo9ux+en2MS2HIfsKkzCNw5xNjbXrAmb8xSi8Ddzy1l+f2V
	+
X-Google-Smtp-Source: AGHT+IG02DlSVZMo84L5TcExrrAiKIGSKzRJljh2So8nGoCeKgd5ug378z6LWQnLRxRvYS980oHvew==
X-Received: by 2002:a5d:6547:0:b0:343:6c81:8fd3 with SMTP id z7-20020a5d6547000000b003436c818fd3mr436888wrv.24.1712041595689;
        Tue, 02 Apr 2024 00:06:35 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00343668bc492sm791712wrx.71.2024.04.02.00.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:06:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org, Tom Rini
 <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, Christian
 Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 0/5] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
Date: Tue, 02 Apr 2024 09:06:31 +0200
Message-ID: <87h6gkgs5k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 07:06:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2262

Hi Neil,

Thank you for the series.

On ven., mars 29, 2024 at 18:51, "Neil Armstrong" <neil.armstrong@linaro.org> wrote:

> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
>
> Keep A1 DTs locally since the architecture is still young.
>
> CI built & tested at:
> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1233461384
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - add change to remove prefix in fdtfile
> - collected review tags
> - Link to v1: https://lore.kernel.org/r/20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org

Boot tested AOSP on VIM3.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # khadas-vim3_android

>
> ---
> Neil Armstrong (5):
>       configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
>       dts: meson: Switch GXL, GXM & AXG to using upstream DT
>       dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>       dts: meson-g12a: Switch to using upstream DT
>       dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>
>  arch/arm/dts/Makefile                              |   36 +-
>  arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>  arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>  arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>  arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>  arch/arm/dts/meson-g12.dtsi                        |  385 ---
>  arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>  arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>  arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>  arch/arm/dts/meson-g12a.dtsi                       |  140 --
>  arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>  arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>  arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>  arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>  arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>  arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>  arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>  arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>  arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>  arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>  arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>  arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>  arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>  arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>  arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>  arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>  arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>  arch/arm/dts/meson-g12b.dtsi                       |  146 --
>  arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>  arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>  arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>  arch/arm/dts/meson-gx.dtsi                         |  675 ------
>  arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>  arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>  arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>  .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>  arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>  arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>  arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>  arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>  arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>  arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>  arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>  arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>  arch/arm/dts/meson-gxm.dtsi                        |  216 --
>  arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>  arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>  arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>  arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>  arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>  arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>  arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>  arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>  arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>  arch/arm/mach-meson/Kconfig                        |    4 +
>  configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>  configs/bananapi-m2-pro_defconfig                  |    2 +-
>  configs/bananapi-m2s_defconfig                     |    2 +-
>  configs/bananapi-m5_defconfig                      |    2 +-
>  configs/beelink-gsking-x_defconfig                 |    2 +-
>  configs/beelink-gt1-ultimate_defconfig             |    2 +-
>  configs/beelink-gtking_defconfig                   |    2 +-
>  configs/beelink-gtkingpro_defconfig                |    2 +-
>  configs/jethub_j100_defconfig                      |    2 +-
>  configs/jethub_j80_defconfig                       |    2 +-
>  configs/khadas-vim2_defconfig                      |    2 +-
>  configs/khadas-vim3_android_ab_defconfig           |    2 +-
>  configs/khadas-vim3_android_defconfig              |    2 +-
>  configs/khadas-vim3_defconfig                      |    2 +-
>  configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>  configs/khadas-vim3l_android_defconfig             |    2 +-
>  configs/khadas-vim3l_defconfig                     |    2 +-
>  configs/khadas-vim_defconfig                       |    2 +-
>  configs/libretech-ac_defconfig                     |    2 +-
>  configs/libretech-cc_defconfig                     |    2 +-
>  configs/libretech-cc_v2_defconfig                  |    2 +-
>  configs/libretech-s905d-pc_defconfig               |    2 +-
>  configs/libretech-s912-pc_defconfig                |    2 +-
>  configs/odroid-c4_defconfig                        |    2 +-
>  configs/odroid-go-ultra_defconfig                  |    2 +-
>  configs/odroid-hc4_defconfig                       |    2 +-
>  configs/odroid-n2_defconfig                        |    2 +-
>  configs/odroid-n2l_defconfig                       |    2 +-
>  configs/p212_defconfig                             |    2 +-
>  configs/radxa-zero2_defconfig                      |    2 +-
>  configs/radxa-zero_defconfig                       |    2 +-
>  configs/s400_defconfig                             |    2 +-
>  configs/sei510_defconfig                           |    2 +-
>  configs/sei610_defconfig                           |    2 +-
>  configs/u200_defconfig                             |    2 +-
>  configs/wetek-core2_defconfig                      |    2 +-
>  include/configs/meson64.h                          |    8 +-
>  include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>  include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>  include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>  include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>  include/dt-bindings/power/meson-axg-power.h        |   14 -
>  include/dt-bindings/power/meson-g12a-power.h       |   13 -
>  include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>  include/dt-bindings/power/meson-sm1-power.h        |   18 -
>  .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>  .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>  .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>  .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>  .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>  include/dt-bindings/sound/meson-aiu.h              |   18 -
>  include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>  include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>  117 files changed, 49 insertions(+), 21512 deletions(-)
> ---
> base-commit: 6e2228fb052b68c84688d5baff06e2ebc787a4a5
> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2256): https://groups.io/g/u-boot-amlogic/message/2256
> Mute This Topic: https://groups.io/mt/105220383/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

