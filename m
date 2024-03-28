Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CA7C54E67
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 08:27:17 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.10594.1711614434049667239
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Mar 2024 01:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=nq05M2Gy;
 spf=pass (domain: baylibre.com, ip: 209.85.208.176, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d700beb6beso9002221fa.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711614432; x=1712219232; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JweTZVvSpPUteSNqpDRHoXLnsplJ+dsir54YbpRS9TI=;
        b=nq05M2Gynai0vkgdMb2V7CXjHadZSnXW6P8KcDmoq89QRy3cavz+s/xCUTSSgGqi9/
         BhliD3hRBMirreP5cup89kLDBxP3oeOKxt4Z0VxikE/nNe1whzuPuK24Vj/jz1KeUSQZ
         Ny7Y/tUzQ3RSX7IvKUfWrSFC54+9VWAsXyzapwQv97yOqAD12qMaWEGYvPmpdoOWK8AK
         93GoYfz7TGpguiVRs4MZ7SSYOyY52Gp90dypVaIy9eJheAQC9XFZsNP9F9bZo8elBtZW
         XzPn/eEvjuNlVqVuNLGsZ+lkIJOHWwqiWIAndVt7Jz2kpLlb8DvWhMEFTjtsd6lkeVFb
         amYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711614432; x=1712219232;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JweTZVvSpPUteSNqpDRHoXLnsplJ+dsir54YbpRS9TI=;
        b=eaLnmS0/UcOtoXCF/Pgqnd7ALso8l9fFlCk+fUjvyc9BC2gViietlLU5kdAY1TOXCL
         +S1mSik0QhiAEbht3g1hUe20S9kDMReWyxFzaArXjS/6dkYe7e/VC3iQD05trtOIii/x
         SyhdXal1RWcqBZBZ3lF4x3u/9i83v7VYXKwzReE8J14bU4iOTxMm90h/CGcyLvObY9Xi
         JfN28sFfrE7F3xs9IN+R1gMW4AH/SSfXtTnSb438vsgMjPSjqiTeoalonumTOz0cBkaQ
         Lqd2zwTCNkUzJzasivyg0Aot/Ejb61SXq38oXJcXlmxWr6yucbznSYSY0beUJUpxHOrM
         sA+A==
X-Forwarded-Encrypted: i=1; AJvYcCXkCCN7rX6ixjhF9smDKxfnc+CzO6TpM8yNa8XZun/R74iZ2h/hmwIgz2wloEWHqIUTEeIfmdlvFL4KC7CKTBRwX9QJJlXFeDg=
X-Gm-Message-State: AOJu0YzM2AGlHrs4oVvm3S4GA0P1/IryDoCaAH9KoMnvl2prSGjqz6Xp
	5wGZASoJbXkFIKFmCmbtQkxeat+/oZ8u4Te8Inz794cViz9easFXvaPp+TJ4CcE=
X-Google-Smtp-Source: AGHT+IFqmu0qjEVGYkdJ0z6cFcKdJZXwjG5FKh3rDyCkR3Cs7r92Ew75a9jTzbx+FIDHCM49BUKf8w==
X-Received: by 2002:a05:651c:221f:b0:2d6:bbab:8301 with SMTP id y31-20020a05651c221f00b002d6bbab8301mr2051420ljq.0.1711614431610;
        Thu, 28 Mar 2024 01:27:11 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm1099917wrq.44.2024.03.28.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 01:27:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org
Cc: Christian Hewitt <christianshewitt@gmail.com>, Vyacheslav Bocharov
 <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Sumit Garg
 <sumit.garg@linaro.org>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
In-Reply-To: <625e06c4-0410-4067-8ead-5142373bc1ee@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
 <625e06c4-0410-4067-8ead-5142373bc1ee@linaro.org>
Date: Thu, 28 Mar 2024 09:27:05 +0100
Message-ID: <8734sag3s6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 08:27:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2253

Hi,

On jeu., mars 28, 2024 at 09:21, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Mattijs,
>
> On 19/03/2024 15:42, Neil Armstrong wrote:
>> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
>> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
>> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
>> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
>> kept in arch/arm/dts directory for these boards.
>> 
>> Keep A1 DTs locally since the architecture is still young.
>> 
>> CI built & tested at:
>> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>
> Can you check it doesn't break android boot ?

Sorry for the delay. I will test this early next week (Tuesday)

Thank you !

>
> Neil
>
>> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (4):
>>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>>        dts: meson-g12a: Switch to using upstream DT
>>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>> 
>>   arch/arm/dts/Makefile                              |   36 +-
>>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>>   arch/arm/mach-meson/Kconfig                        |    4 +
>>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>>   configs/bananapi-m2s_defconfig                     |    2 +-
>>   configs/bananapi-m5_defconfig                      |    2 +-
>>   configs/beelink-gsking-x_defconfig                 |    2 +-
>>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>>   configs/beelink-gtking_defconfig                   |    2 +-
>>   configs/beelink-gtkingpro_defconfig                |    2 +-
>>   configs/jethub_j100_defconfig                      |    2 +-
>>   configs/jethub_j80_defconfig                       |    2 +-
>>   configs/khadas-vim2_defconfig                      |    2 +-
>>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>>   configs/khadas-vim3_android_defconfig              |    2 +-
>>   configs/khadas-vim3_defconfig                      |    2 +-
>>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>>   configs/khadas-vim3l_android_defconfig             |    2 +-
>>   configs/khadas-vim3l_defconfig                     |    2 +-
>>   configs/khadas-vim_defconfig                       |    2 +-
>>   configs/libretech-ac_defconfig                     |    2 +-
>>   configs/libretech-cc_defconfig                     |    2 +-
>>   configs/libretech-cc_v2_defconfig                  |    2 +-
>>   configs/libretech-s905d-pc_defconfig               |    2 +-
>>   configs/libretech-s912-pc_defconfig                |    2 +-
>>   configs/odroid-c4_defconfig                        |    2 +-
>>   configs/odroid-go-ultra_defconfig                  |    2 +-
>>   configs/odroid-hc4_defconfig                       |    2 +-
>>   configs/odroid-n2_defconfig                        |    2 +-
>>   configs/odroid-n2l_defconfig                       |    2 +-
>>   configs/p212_defconfig                             |    2 +-
>>   configs/radxa-zero2_defconfig                      |    2 +-
>>   configs/radxa-zero_defconfig                       |    2 +-
>>   configs/s400_defconfig                             |    2 +-
>>   configs/sei510_defconfig                           |    2 +-
>>   configs/sei610_defconfig                           |    2 +-
>>   configs/u200_defconfig                             |    2 +-
>>   configs/wetek-core2_defconfig                      |    2 +-
>>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>>   116 files changed, 42 insertions(+), 21511 deletions(-)
>> ---
>> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
>> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>> 
>> Best regards,

