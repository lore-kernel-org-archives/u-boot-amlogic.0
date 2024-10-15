Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF658D1D879
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 15:26:46 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.16519.1729006003179623084
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Oct 2024 08:26:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Gfs1nT/R;
 spf=pass (domain: baylibre.com, ip: 209.85.128.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314311959aso5892855e9.1
        for <u-boot-amlogic@groups.io>; Tue, 15 Oct 2024 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729006001; x=1729610801; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndrAEEoHHzra0vuLMqmz7E37jYXINL2zDAnT/tX+vPU=;
        b=Gfs1nT/RtM2ts+iOrtnQr80xs119PUnYcpA0wmhTq695DrlBeZRvs+BHAoQ5bRn6+K
         Sml+6QdBHf72ume71p3Q0pwC0M2EM0Ag78B6/eTMz9inJoYg5dnJ++m7QCrjEaKIK748
         75VRgxV6NtcXN8fP7IFNE/HkFclk7exk6hcCeU6B/eV1er6Gr0cNMWqPVqro1s015Ovx
         1nAPe7x8r9XsHdhn8otiSiusVCyEUGOB0jq5pQ7GID8g9PU8tPOHLFF5sCH2Blx7sjmJ
         opggBq+hF39P6KYRcQmK6Qx0Zlf+o9gVOgXDvKb41cb+kxJ/PHdFYRQ9av6xwDLHFEQH
         skaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006001; x=1729610801;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndrAEEoHHzra0vuLMqmz7E37jYXINL2zDAnT/tX+vPU=;
        b=L8uY8vLRvDrcWPBeDtdZb8mj3x6g7dy7/h99YM6JKMCDVQSTJ+6diqz2pMU7G4iyFc
         JC0mQwazR1G7bASwdgyjF0RaxO/cUnouQy2V+KvYirGH+qM81XEOkG1+CDbFiizJlQjj
         qH8ZK5PMBsqQWfpNUM+DfqMobsp6K97qXq8sku24KMj/UNTigvbuWhgZX5Ug1LWqJYli
         egWJyNJ2ymdQj1jeJnLT31SDfmpQ3hB81xRbvtzCJpX+KAHmkJBufbif7ypqUAMZfBI0
         TbgmZyt8uKkoYAtjZn4u8+BY3JkcJwZHF+lBmlV81C1jk66V4gaP4NZBkkvoy3D2rwee
         IwLA==
X-Forwarded-Encrypted: i=1; AJvYcCUr4A/U7QWgPaxNU0WKb10NBX5AmDLqxXClUEABilLpuldPhNk2tVrgHN9Ki+KDHDCV1TgqElLdXog9tGbjlg==@groups.io
X-Gm-Message-State: AOJu0YzpYgAzK65SuBeFwzw0MI1dfzwsJ+BNM3ZB6h7Z+VLmbhopAwYa
	NS6pa1rt8f/PhrUFE02BMfsExRD69mKSyVUfiGM3HluEnN/GLYnfLM5HToZtesA=
X-Google-Smtp-Source: AGHT+IGCQftwpfk346b25k2zUvyhgoR965cGJ4SNaniZ5EUpih5dJXspn4hzmcnqrfMId8lc4kT2cA==
X-Received: by 2002:a05:600c:354e:b0:42f:8267:69e6 with SMTP id 5b1f17b1804b1-431255d4afcmr106903665e9.3.1729006001259;
        Tue, 15 Oct 2024 08:26:41 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c567esm20478085e9.45.2024.10.15.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:26:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <20241015132631.qnnbrmnuwp6zr7r5@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015132631.qnnbrmnuwp6zr7r5@CAB-WSD-L081021>
Date: Tue, 15 Oct 2024 17:26:37 +0200
Message-ID: <87cyk1z8sy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 15 Oct 2024 15:26:46 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2485

Hi Dmitry,

On mar., oct. 15, 2024 at 16:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Hi Mattijs,
>
> On Tue, Oct 15, 2024 at 02:10:10PM +0200, Mattijs Korpershoek wrote:
>> Hi Simon, Dmitry
>> 
>> On lun., oct. 14, 2024 at 15:06, Simon Glass <sjg@chromium.org> wrote:
>> 
>> > Hi Dmitry,
>> >
>> > On Mon, 14 Oct 2024 at 14:38, Dmitry Rokosov
>> > <ddrokosov@salutedevices.com> wrote:
>> >>
>> >> Hello Mattijs,
>> >>
>> >> On Sat, Oct 12, 2024 at 10:49:08AM +0200, Mattijs Korpershoek wrote:
>> >> > Hi Dmitry,
>> >> >
>> >> > On ven., oct. 11, 2024 at 21:00, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> >> >
>> >> > > On Fri, Oct 11, 2024 at 04:20:39PM +0200, Mattijs Korpershoek wrote:
>> >> > >> On ven., oct. 11, 2024 at 15:30, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
>> >> > >>
>> >> > >> > Hi Dmitry,
>> >> > >> >
>> >> > >> > Thank you for the patch.
>> >> > >> >
>> >> > >> > On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> >> > >> >
>> >> > >> >> To enhance code organization, it is beneficial to consolidate all A/B
>> >> > >> >> BCB management routines into a single super-command.
>> >> > >> >> The 'bcb' command is an excellent candidate for this purpose.
>> >> > >> >>
>> >> > >> >> This patch integrates the separate 'ab_select' command into the 'bcb'
>> >> > >> >> group as the 'ab_select' subcommand, maintaining the same parameter list
>> >> > >> >> for consistency.
>> >> > >> >>
>> >> > >> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> >> > >> >> ---
>> >> > >> >>  MAINTAINERS                               |  1 -
>> >> > >> >>  cmd/Kconfig                               | 15 +------
>> >> > >> >>  cmd/Makefile                              |  1 -
>> >> > >> >>  cmd/ab_select.c                           | 66 -------------------------------
>> >> > >> >>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
>> >> > >> >>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
>> >> > >> >>  configs/khadas-vim3_android_ab_defconfig  |  1 -
>> >> > >> >>  configs/khadas-vim3l_android_ab_defconfig |  1 -
>> >> > >> >>  configs/sandbox64_defconfig               |  4 +-
>> >> > >> >>  configs/sandbox_defconfig                 |  4 +-
>> >> > >> >>  doc/android/ab.rst                        | 12 +++---
>> >> > >> >>  include/configs/khadas-vim3_android.h     |  2 +-
>> >> > >> >>  include/configs/khadas-vim3l_android.h    |  2 +-
>> >> > >> >>  include/configs/meson64_android.h         |  4 +-
>> >> > >> >>  include/configs/ti_omap5_common.h         |  4 +-
>> >> > >> >>  test/py/tests/test_android/test_ab.py     |  8 ++--
>> >> > >> >>  16 files changed, 85 insertions(+), 104 deletions(-)
>> >> > >> >>
>> >> > >> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> > >> >> index 7aefda93d017f07d616f0f6d191129914fbeb484..668ccec9ae6df47192b1af668e3fdbeb1dfa15ea 100644
>> >> > >> >> --- a/MAINTAINERS
>> >> > >> >> +++ b/MAINTAINERS
>> >> > >> >> @@ -65,7 +65,6 @@ R:    Sam Protsenko <semen.protsenko@linaro.org>
>> >> > >> >>  S:     Maintained
>> >> > >> >>  T:     git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
>> >> > >> >>  F:     boot/android_ab.c
>> >> > >> >> -F:     cmd/ab_select.c
>> >> > >> >>  F:     doc/android/ab.rst
>> >> > >> >>  F:     include/android_ab.h
>> >> > >> >>  F:     test/py/tests/test_android/test_ab.py
>> >> > >> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> >> > >> >> index dd33266cec70a2b134b7244acae1b7f098b921e8..11e8d363dc9b137723a86a240412d82dd0dbccc5 100644
>> >> > >> >> --- a/cmd/Kconfig
>> >> > >> >> +++ b/cmd/Kconfig
>> >> > >> >> @@ -1067,6 +1067,7 @@ config CMD_ADC
>> >> > >> >>  config CMD_BCB
>> >> > >> >>         bool "bcb"
>> >> > >> >>         depends on PARTITIONS
>> >> > >> >> +       depends on ANDROID_AB
>> >> > >> >
>> >> > >> > When building with khadas-vim3_android_defconfig, we can see that CMD_BCB is no
>> >> > >> > longer part of that build:
>> >> > >> >
>> >> > >> > $ grep CMD_BCB .config
>> >> > >> > <empty>
>> >> > >> >
>> >> > >> > However, if we look at include/configs/meson64_android.h, we can see
>> >> > >> > that the "bcb" command is not only used for checking the _slot suffix.
>> >> > >> >
>> >> > >> > It's also used for checking the bootloader reason. For example, in
>> >> > >> > BOOTENV_DEV_FASTBOOT, we call:
>> >> > >> >
>> >> > >> >    "if bcb test command = bootonce-bootloader; then " \
>> >> > >> >
>> >> > >> > Since CMD_BCB is no longer part of the .config (due to this dependency),
>> >> > >> > the boot script now shows errors:
>> >> > >> >
>> >> > >> > """
>> >> > >> > U-Boot 2024.10-00796-g969325278805 (Oct 11 2024 - 14:46:00 +0200) khadas-vim3
>> >> > >> >
>> >> > >> > Model: Khadas VIM3
>> >> > >> > SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
>> >> > >> > DRAM:  2 GiB (effective 3.8 GiB)
>> >> > >> > Core:  411 devices, 36 uclasses, devicetree: separate
>> >> > >> > MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
>> >> > >> > Loading Environment from MMC... fs uses incompatible features: 00020000, ignoring
>> >> > >> > Reading from MMC(2)... *** Warning - bad CRC, using default environment
>> >> > >> >
>> >> > >> > In:    usbkbd,serial
>> >> > >> > Out:   vidconsole,serial
>> >> > >> > Err:   vidconsole,serial
>> >> > >> > Net:   eth0: ethernet@ff3f0000
>> >> > >> >
>> >> > >> > Hit any key to stop autoboot:  0
>> >> > >> > Verify GPT: success!
>> >> > >> > Unknown command 'bcb' - try 'help'
>> >> > >> > Warning: BCB is corrupted or does not exist
>> >> > >> > dev: pinctrl@14
>> >> > >> > dev: pinctrl@40
>> >> > >> > gpio: pin 88 (gpio 88) value is 1
>> >> > >> > Unknown command 'bcb' - try 'help'
>> >> > >> > Warning: BCB is corrupted or does not exist
>> >> > >> > Loading Android boot partition...
>> >> > >> > switch to partitions #0, OK
>> >> > >> > mmc2(part 0) is current device
>> >> > >> > """
>> >> > >> >
>> >> > >> > I know we should not be using a boot script, nor non A/B configs but
>> >> > >> > it's a bummer that this series breaks an upstream
>> >> > >> > defconfig (khadas-vim3_android_defconfig)
>> >> > >> >
>> >> > >> > My recommendation:
>> >> > >> >
>> >> > >> > Make BCB_CMD_AB_SELECT implementation dependant on ANDROID_AB.
>> >> > >> > This way, users can use CMD_BCB with and without ANDROID_AB being enabled.
>> >> > >> >
>> >> > >> > We could do:
>> >> > >> > When ANDROID_AB=y, implement bcb ab_select subcommand
>> >> > >> > When ANDROID_AB=n, command is not accessible.
>> >> > >> >
>> >> > >> > I'll send you a diff shortly for this.
>> >> > >>
>> >> > >> Here is an illustration on how that would work:
>> >> > >>
>> >> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> >> > >> index 861c31e26408..e1a4a97b042d 100644
>> >> > >> --- a/cmd/Kconfig
>> >> > >> +++ b/cmd/Kconfig
>> >> > >> @@ -1055,7 +1055,6 @@ config CMD_ADC
>> >> > >>  config CMD_BCB
>> >> > >>    bool "bcb"
>> >> > >>    depends on PARTITIONS
>> >> > >> -  depends on ANDROID_AB
>> >> > >>    help
>> >> > >>      Read/modify/write the fields of Bootloader Control Block, usually
>> >> > >>      stored on the flash "misc" partition with its structure defined in:
>> >> > >> diff --git a/cmd/bcb.c b/cmd/bcb.c
>> >> > >> index 4fd32186ae65..4fe634f14cc5 100644
>> >> > >> --- a/cmd/bcb.c
>> >> > >> +++ b/cmd/bcb.c
>> >> > >> @@ -438,6 +438,9 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>> >> > >>    char slot[2];
>> >> > >>    bool dec_tries = true;
>> >> > >>
>> >> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
>> >> > >> +          return CMD_RET_SUCCESS;
>> >> > >> +
>> >> > >>    for (int i = 4; i < argc; i++) {
>> >> > >>            if (!strcmp(argv[i], "--no-dec"))
>> >> > >>                    dec_tries = false;
>> >> > >> @@ -474,6 +477,9 @@ static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>> >> > >>    struct blk_desc *dev_desc;
>> >> > >>    struct disk_partition part_info;
>> >> > >>
>> >> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
>> >> > >> +          return CMD_RET_SUCCESS;
>> >> > >> +
>> >> > >>    if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
>> >> > >>                                             &dev_desc, &part_info,
>> >> > >>                                             false) < 0) {
>> >> > >>
>> >> > >
>> >> > > We also need to include an #ifdef directive for the ab_select_slot()
>> >> > > function usage; otherwise, the code will not compile successfully.
>> >> >
>> >> > Are you sure? Per my understanding, it's possible that the compiler
>> >> > optimizes this out because CONFIG_IS_ENABLED(AB_SELECT)
>> >> > is known as build time.
>> >> >
>> >> > When I tried this diff with khadas-vim3_android_defconfig I did not see
>> >> > any build errors. I will try again early next week.
>> >> >
>> >>
>> >> As I recall, the IS_ENABLED() mechanism serves as a runtime checker to
>> >> determine whether specific CONFIG_* options are enabled. Consequently,
>> >> all code paths under this mechanism are always compiled. I attempted to
>> >> disable CONFIG_ANDROID_AB for the sandbox_defconfig, but it resulted in
>> >> the expected linker error.
>> >>
>> >> /tmp/ccAvYrKL.ltrans25.ltrans.o: In function `do_bcb_ab_select':
>> >> <artificial>:(.text+0x6d5d): undefined reference to `ab_select_slot'
>> >> collect2: error: ld returned 1 exit status
>> >> Makefile:1813: recipe for target 'u-boot' failed
>> >> make: *** [u-boot] Error 1
>> >>
>> >> I have already prepared a new version using #ifdef directives. I will
>> >> send it shortly.
>> >
>> > Something else is going on here, since we do this all the time and
>> > rely on it. So long as the code is behind an if() the dead code should
>> > be eliminated.
>> >
>> 
>> I have passed my diff (using CONFIG_IS_ENABLED) through the U-Boot CI:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22700
>> 
>> See the branch:
>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commits/dmitry/ab-dump-v3
>> 
>> There are some test errors (sandbox test) but the "world build" stage
>> finished sucessfully.
>> 
>> I have also tested locally using the CI container:
>> $ cd ~/work/upstream/u-boot
>> $ git clean -xdf
>> $ make mproper
>> $ docker run -v $PWD:$PWD -it trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024 /bin/bash
>> 
>> # In container
>> uboot@0ba059e8b7af/$ cd /home/mkorpershoek/work/upstream/u-boot
>> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ pip install -r test/py/requirements.txt
>> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./test/py/test.py --bd sandbox --build -k test_ut
>> 
>> No build errors either.
>> 
>> Dmitry, can you clarify what compiler/build commands you've used to see
>> that error?
>> 
>> For reference, here is what buildman has in the CI container:
>> 
>> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./tools/buildman/buildman --list-tool-chains
>> List of available toolchains (17):
>> aarch64   : /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
>> arc       : /opt/gcc-13.2.0-nolibc/arc-linux/bin/arc-linux-gcc
>> arm       : /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc
>> c89       : /usr/bin/c89-gcc
>> c99       : /usr/bin/c99-gcc
>> i386      : /opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-gcc
>> m68k      : /opt/gcc-13.2.0-nolibc/m68k-linux/bin/m68k-linux-gcc
>> microblaze: /opt/gcc-13.2.0-nolibc/microblaze-linux/bin/microblaze-linux-gcc
>> mips      : /opt/gcc-13.2.0-nolibc/mips-linux/bin/mips-linux-gcc
>> nios2     : /opt/gcc-13.2.0-nolibc/nios2-linux/bin/nios2-linux-gcc
>> powerpc   : /opt/gcc-13.2.0-nolibc/powerpc-linux/bin/powerpc-linux-gcc
>> riscv32   : /opt/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-gcc
>> riscv64   : /opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc
>> sandbox   : /usr/bin/cgcc
>> sh2       : /opt/gcc-13.2.0-nolibc/sh2-linux/bin/sh2-linux-gcc
>> x86_64    : /usr/bin/x86_64-linux-gnu-gcc
>> xtensa    : /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-gcc
>> 
>> I think we should use CONFIG_IS_ENABLED if possible
>
> I just run build on the my x86 Ubuntu machine.
>
> $ cd uboot
> $ make mproper
> $ make sandbox_defconfig
> $ make -j$(nproc)

I tried these commands:
Here is the successfull build output:

https://paste.debian.net/1332378/

I use:
$ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* gcc --version
gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* ld --version
GNU ld version 2.41-37.fc40
Copyright (C) 2023 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.

What toolchains do you use?

>
> That's all.
>
> I've already sent the v4 patch with #ifdef. I can prepare the v5 patch
> using the IS_ENABLED() macro and will aim to send it today.
>
> But I have one question:
>
> Do we really want to display the ab_select and ab_dump subcommands to
> users if these commands are just stubs? Perhaps we should consider
> adding #ifdef directives to the subcommand arrays.

That's a valid concern. I don't think we should display
the ab_select and ab_dump commands to the users but I still want to have
IS_ENABLED wherever possible to keep the code simple.

>
> -- 
> Thank you,
> Dmitry

