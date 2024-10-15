Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F13CFC29A
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 12:10:20 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.11759.1728994216706202395
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Oct 2024 05:10:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=3QpX/HTB;
 spf=pass (domain: baylibre.com, ip: 209.85.167.42, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so2654336e87.0
        for <u-boot-amlogic@groups.io>; Tue, 15 Oct 2024 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728994215; x=1729599015; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3mlDMVujwPUGZ5GdWkLk3F5vF8r1ZxFSLF9nb7XUr4=;
        b=3QpX/HTB/ewvYKKfTszEJoprpRoNb4sC6z0ZdpTC55x/5uyDUeadDUQeIBVGrxzCSl
         JYPb94sN8zwgmXWofyoOKwpVz4Ry2U0zRZbhqoVUfqOVm//URQY1viJB94tVWRXopp2C
         +TdUS3yq8HiHre5zC8GBoYaYjTymo84ryIt50wU5m31OURfQWW1V/OLyMj7lMzjCPoC5
         hBcZYBmiJuWJkgMo7zV2MCiHhXQA7hXcSr8tYRik1GEIZT3DDlJeP3qfZsYTis95a+Lc
         Qy5DctEW9H3Hdg2k4z4mT6jQkCa1D+lS+O+OQXxe+kAa1FTqsWbo/iNvodEGPeqJvLsE
         PyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994215; x=1729599015;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3mlDMVujwPUGZ5GdWkLk3F5vF8r1ZxFSLF9nb7XUr4=;
        b=GvY2I8A4c5+z4YfPCfgsgEmyR5ItwAOv2duG+pg7NR87VFdJO+lD1hq+nM6YXCF6wj
         wxdy0lKJ9dlLLAymrBjAfxc0rsuQKfgyX+QfB/qPHrxWzTrskJGDdytc+RCOQ+7hSHAY
         Q04PQby6orF/ZLt4ZxA5Po3vPi772ypnux+S9LGcPvw9Ex0SnLe7s+SUw5MIfsfGUWvf
         JUPK1FL8oSYJGaNW/ExEK3sdroiM0NnYX6D01DcmldLUSSWBXn8/3Ji/hD5yv4f72pLg
         uBXPbRYxCKfCu8It922xfKKtuRDcG98UlUYkLbO8n9CDrx0AZJuvybxBML1XypKGRKs8
         PPwA==
X-Gm-Message-State: AOJu0YxGI3fnVz3VZ7uBZDNdoo5ZKiO25P/vtTn0/ozgZGqpG4nkuojI
	62eZGwEvCJ2DoZKeJSokbLcQe3uBZ0Rej9FenTuh4khmjsU9E5UKyPjWIJGGxys=
X-Google-Smtp-Source: AGHT+IF1qDwjzDccz+tNCo4hESciajreBSm/xzgQC9HBMzo5o2kTf9D4zY+/uepW6AMkkpKkSmgSUA==
X-Received: by 2002:a05:6512:238b:b0:539:f7c1:5feb with SMTP id 2adb3069b0e04-539f7c16172mr3354683e87.39.1728994214376;
        Tue, 15 Oct 2024 05:10:14 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1f4csm15982555e9.30.2024.10.15.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:10:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
Date: Tue, 15 Oct 2024 14:10:10 +0200
Message-ID: <87ikttzhwd.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 15 Oct 2024 12:10:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2483

Hi Simon, Dmitry

On lun., oct. 14, 2024 at 15:06, Simon Glass <sjg@chromium.org> wrote:

> Hi Dmitry,
>
> On Mon, 14 Oct 2024 at 14:38, Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
>>
>> Hello Mattijs,
>>
>> On Sat, Oct 12, 2024 at 10:49:08AM +0200, Mattijs Korpershoek wrote:
>> > Hi Dmitry,
>> >
>> > On ven., oct. 11, 2024 at 21:00, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> >
>> > > On Fri, Oct 11, 2024 at 04:20:39PM +0200, Mattijs Korpershoek wrote:
>> > >> On ven., oct. 11, 2024 at 15:30, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
>> > >>
>> > >> > Hi Dmitry,
>> > >> >
>> > >> > Thank you for the patch.
>> > >> >
>> > >> > On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> > >> >
>> > >> >> To enhance code organization, it is beneficial to consolidate all A/B
>> > >> >> BCB management routines into a single super-command.
>> > >> >> The 'bcb' command is an excellent candidate for this purpose.
>> > >> >>
>> > >> >> This patch integrates the separate 'ab_select' command into the 'bcb'
>> > >> >> group as the 'ab_select' subcommand, maintaining the same parameter list
>> > >> >> for consistency.
>> > >> >>
>> > >> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > >> >> ---
>> > >> >>  MAINTAINERS                               |  1 -
>> > >> >>  cmd/Kconfig                               | 15 +------
>> > >> >>  cmd/Makefile                              |  1 -
>> > >> >>  cmd/ab_select.c                           | 66 -------------------------------
>> > >> >>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
>> > >> >>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
>> > >> >>  configs/khadas-vim3_android_ab_defconfig  |  1 -
>> > >> >>  configs/khadas-vim3l_android_ab_defconfig |  1 -
>> > >> >>  configs/sandbox64_defconfig               |  4 +-
>> > >> >>  configs/sandbox_defconfig                 |  4 +-
>> > >> >>  doc/android/ab.rst                        | 12 +++---
>> > >> >>  include/configs/khadas-vim3_android.h     |  2 +-
>> > >> >>  include/configs/khadas-vim3l_android.h    |  2 +-
>> > >> >>  include/configs/meson64_android.h         |  4 +-
>> > >> >>  include/configs/ti_omap5_common.h         |  4 +-
>> > >> >>  test/py/tests/test_android/test_ab.py     |  8 ++--
>> > >> >>  16 files changed, 85 insertions(+), 104 deletions(-)
>> > >> >>
>> > >> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> > >> >> index 7aefda93d017f07d616f0f6d191129914fbeb484..668ccec9ae6df47192b1af668e3fdbeb1dfa15ea 100644
>> > >> >> --- a/MAINTAINERS
>> > >> >> +++ b/MAINTAINERS
>> > >> >> @@ -65,7 +65,6 @@ R:    Sam Protsenko <semen.protsenko@linaro.org>
>> > >> >>  S:     Maintained
>> > >> >>  T:     git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
>> > >> >>  F:     boot/android_ab.c
>> > >> >> -F:     cmd/ab_select.c
>> > >> >>  F:     doc/android/ab.rst
>> > >> >>  F:     include/android_ab.h
>> > >> >>  F:     test/py/tests/test_android/test_ab.py
>> > >> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> > >> >> index dd33266cec70a2b134b7244acae1b7f098b921e8..11e8d363dc9b137723a86a240412d82dd0dbccc5 100644
>> > >> >> --- a/cmd/Kconfig
>> > >> >> +++ b/cmd/Kconfig
>> > >> >> @@ -1067,6 +1067,7 @@ config CMD_ADC
>> > >> >>  config CMD_BCB
>> > >> >>         bool "bcb"
>> > >> >>         depends on PARTITIONS
>> > >> >> +       depends on ANDROID_AB
>> > >> >
>> > >> > When building with khadas-vim3_android_defconfig, we can see that CMD_BCB is no
>> > >> > longer part of that build:
>> > >> >
>> > >> > $ grep CMD_BCB .config
>> > >> > <empty>
>> > >> >
>> > >> > However, if we look at include/configs/meson64_android.h, we can see
>> > >> > that the "bcb" command is not only used for checking the _slot suffix.
>> > >> >
>> > >> > It's also used for checking the bootloader reason. For example, in
>> > >> > BOOTENV_DEV_FASTBOOT, we call:
>> > >> >
>> > >> >    "if bcb test command = bootonce-bootloader; then " \
>> > >> >
>> > >> > Since CMD_BCB is no longer part of the .config (due to this dependency),
>> > >> > the boot script now shows errors:
>> > >> >
>> > >> > """
>> > >> > U-Boot 2024.10-00796-g969325278805 (Oct 11 2024 - 14:46:00 +0200) khadas-vim3
>> > >> >
>> > >> > Model: Khadas VIM3
>> > >> > SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
>> > >> > DRAM:  2 GiB (effective 3.8 GiB)
>> > >> > Core:  411 devices, 36 uclasses, devicetree: separate
>> > >> > MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
>> > >> > Loading Environment from MMC... fs uses incompatible features: 00020000, ignoring
>> > >> > Reading from MMC(2)... *** Warning - bad CRC, using default environment
>> > >> >
>> > >> > In:    usbkbd,serial
>> > >> > Out:   vidconsole,serial
>> > >> > Err:   vidconsole,serial
>> > >> > Net:   eth0: ethernet@ff3f0000
>> > >> >
>> > >> > Hit any key to stop autoboot:  0
>> > >> > Verify GPT: success!
>> > >> > Unknown command 'bcb' - try 'help'
>> > >> > Warning: BCB is corrupted or does not exist
>> > >> > dev: pinctrl@14
>> > >> > dev: pinctrl@40
>> > >> > gpio: pin 88 (gpio 88) value is 1
>> > >> > Unknown command 'bcb' - try 'help'
>> > >> > Warning: BCB is corrupted or does not exist
>> > >> > Loading Android boot partition...
>> > >> > switch to partitions #0, OK
>> > >> > mmc2(part 0) is current device
>> > >> > """
>> > >> >
>> > >> > I know we should not be using a boot script, nor non A/B configs but
>> > >> > it's a bummer that this series breaks an upstream
>> > >> > defconfig (khadas-vim3_android_defconfig)
>> > >> >
>> > >> > My recommendation:
>> > >> >
>> > >> > Make BCB_CMD_AB_SELECT implementation dependant on ANDROID_AB.
>> > >> > This way, users can use CMD_BCB with and without ANDROID_AB being enabled.
>> > >> >
>> > >> > We could do:
>> > >> > When ANDROID_AB=y, implement bcb ab_select subcommand
>> > >> > When ANDROID_AB=n, command is not accessible.
>> > >> >
>> > >> > I'll send you a diff shortly for this.
>> > >>
>> > >> Here is an illustration on how that would work:
>> > >>
>> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> > >> index 861c31e26408..e1a4a97b042d 100644
>> > >> --- a/cmd/Kconfig
>> > >> +++ b/cmd/Kconfig
>> > >> @@ -1055,7 +1055,6 @@ config CMD_ADC
>> > >>  config CMD_BCB
>> > >>    bool "bcb"
>> > >>    depends on PARTITIONS
>> > >> -  depends on ANDROID_AB
>> > >>    help
>> > >>      Read/modify/write the fields of Bootloader Control Block, usually
>> > >>      stored on the flash "misc" partition with its structure defined in:
>> > >> diff --git a/cmd/bcb.c b/cmd/bcb.c
>> > >> index 4fd32186ae65..4fe634f14cc5 100644
>> > >> --- a/cmd/bcb.c
>> > >> +++ b/cmd/bcb.c
>> > >> @@ -438,6 +438,9 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>> > >>    char slot[2];
>> > >>    bool dec_tries = true;
>> > >>
>> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
>> > >> +          return CMD_RET_SUCCESS;
>> > >> +
>> > >>    for (int i = 4; i < argc; i++) {
>> > >>            if (!strcmp(argv[i], "--no-dec"))
>> > >>                    dec_tries = false;
>> > >> @@ -474,6 +477,9 @@ static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>> > >>    struct blk_desc *dev_desc;
>> > >>    struct disk_partition part_info;
>> > >>
>> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
>> > >> +          return CMD_RET_SUCCESS;
>> > >> +
>> > >>    if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
>> > >>                                             &dev_desc, &part_info,
>> > >>                                             false) < 0) {
>> > >>
>> > >
>> > > We also need to include an #ifdef directive for the ab_select_slot()
>> > > function usage; otherwise, the code will not compile successfully.
>> >
>> > Are you sure? Per my understanding, it's possible that the compiler
>> > optimizes this out because CONFIG_IS_ENABLED(AB_SELECT)
>> > is known as build time.
>> >
>> > When I tried this diff with khadas-vim3_android_defconfig I did not see
>> > any build errors. I will try again early next week.
>> >
>>
>> As I recall, the IS_ENABLED() mechanism serves as a runtime checker to
>> determine whether specific CONFIG_* options are enabled. Consequently,
>> all code paths under this mechanism are always compiled. I attempted to
>> disable CONFIG_ANDROID_AB for the sandbox_defconfig, but it resulted in
>> the expected linker error.
>>
>> /tmp/ccAvYrKL.ltrans25.ltrans.o: In function `do_bcb_ab_select':
>> <artificial>:(.text+0x6d5d): undefined reference to `ab_select_slot'
>> collect2: error: ld returned 1 exit status
>> Makefile:1813: recipe for target 'u-boot' failed
>> make: *** [u-boot] Error 1
>>
>> I have already prepared a new version using #ifdef directives. I will
>> send it shortly.
>
> Something else is going on here, since we do this all the time and
> rely on it. So long as the code is behind an if() the dead code should
> be eliminated.
>

I have passed my diff (using CONFIG_IS_ENABLED) through the U-Boot CI:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22700

See the branch:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commits/dmitry/ab-dump-v3

There are some test errors (sandbox test) but the "world build" stage
finished sucessfully.

I have also tested locally using the CI container:
$ cd ~/work/upstream/u-boot
$ git clean -xdf
$ make mproper
$ docker run -v $PWD:$PWD -it trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024 /bin/bash

# In container
uboot@0ba059e8b7af/$ cd /home/mkorpershoek/work/upstream/u-boot
uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ pip install -r test/py/requirements.txt
uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./test/py/test.py --bd sandbox --build -k test_ut

No build errors either.

Dmitry, can you clarify what compiler/build commands you've used to see
that error?

For reference, here is what buildman has in the CI container:

uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./tools/buildman/buildman --list-tool-chains
List of available toolchains (17):
aarch64   : /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
arc       : /opt/gcc-13.2.0-nolibc/arc-linux/bin/arc-linux-gcc
arm       : /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc
c89       : /usr/bin/c89-gcc
c99       : /usr/bin/c99-gcc
i386      : /opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-gcc
m68k      : /opt/gcc-13.2.0-nolibc/m68k-linux/bin/m68k-linux-gcc
microblaze: /opt/gcc-13.2.0-nolibc/microblaze-linux/bin/microblaze-linux-gcc
mips      : /opt/gcc-13.2.0-nolibc/mips-linux/bin/mips-linux-gcc
nios2     : /opt/gcc-13.2.0-nolibc/nios2-linux/bin/nios2-linux-gcc
powerpc   : /opt/gcc-13.2.0-nolibc/powerpc-linux/bin/powerpc-linux-gcc
riscv32   : /opt/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-gcc
riscv64   : /opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc
sandbox   : /usr/bin/cgcc
sh2       : /opt/gcc-13.2.0-nolibc/sh2-linux/bin/sh2-linux-gcc
x86_64    : /usr/bin/x86_64-linux-gnu-gcc
xtensa    : /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-gcc

I think we should use CONFIG_IS_ENABLED if possible


>>
>> [...]
>>
>
> Regards,
> Simon

