Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F4D2E03F
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:31 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.23747.1729087620788412455
 for <u-boot-amlogic@groups.io>;
 Wed, 16 Oct 2024 07:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=ePbLR1OQ;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4A73D12001D;
	Wed, 16 Oct 2024 17:06:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4A73D12001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729087615;
	bh=zF3twJebHbCfjr2R+YAwyUIhEzJvdmCUo7xF+uzstLA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ePbLR1OQW6P1elpKX4GkG2jiG6nEgp65xxyCIC+1JZe5AJz+b0zAtmeIRs47aTscr
	 2nUGZSfyo4Ujg/ZMcieJgwO34kP2bM4nW7eX6MDRI2kOrVGHadNwfuW+UpB+DhhCpV
	 DTUA+s0F2yp5Eo1dnbxCk5ppelNORb1Ae5bJmdsZqEQExVOpF+Ld5U5BTo3WXdRNJI
	 G/TWq2abg9DGi2Qc51WQfTHiA7tEbQJiBjxj/uXDR4ZIBLOcoHVv57QzXstCV4xdqb
	 teaVC1yqHGmSz/juUQ8K+ZBI+PAh73uVf26LXmaPlNiGQ2RlIDsBM5kzDnTBifzC0c
	 yq39VtY0VC6xA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 17:06:54 +0300 (MSK)
Date: Wed, 16 Oct 2024 17:06:54 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot-amlogic@groups.io>, Igor Opaniuk
	<igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
	<u-boot@lists.denx.de>, <rockosov@gmail.com>, <kernel@salutedevices.com>
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb subcommands
Message-ID: <20241016140654.mxms6m4g2rr3vncz@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io>
 <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015132631.qnnbrmnuwp6zr7r5@CAB-WSD-L081021>
 <87cyk1z8sy.fsf@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <87cyk1z8sy.fsf@baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188481 [Oct 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_bl_eng_cat, c15}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;source.denx.de:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;paste.debian.net:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/16 12:29:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/16 12:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/16 12:08:00 #26762169
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 23 Oct 2024 12:18:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2527

On Tue, Oct 15, 2024 at 05:26:37PM +0200, Mattijs Korpershoek wrote:
> Hi Dmitry,
> 
> On mar., oct. 15, 2024 at 16:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > Hi Mattijs,
> >
> > On Tue, Oct 15, 2024 at 02:10:10PM +0200, Mattijs Korpershoek wrote:
> >> Hi Simon, Dmitry
> >> 
> >> On lun., oct. 14, 2024 at 15:06, Simon Glass <sjg@chromium.org> wrote:
> >> 
> >> > Hi Dmitry,
> >> >
> >> > On Mon, 14 Oct 2024 at 14:38, Dmitry Rokosov
> >> > <ddrokosov@salutedevices.com> wrote:
> >> >>
> >> >> Hello Mattijs,
> >> >>
> >> >> On Sat, Oct 12, 2024 at 10:49:08AM +0200, Mattijs Korpershoek wrote:
> >> >> > Hi Dmitry,
> >> >> >
> >> >> > On ven., oct. 11, 2024 at 21:00, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >> >> >
> >> >> > > On Fri, Oct 11, 2024 at 04:20:39PM +0200, Mattijs Korpershoek wrote:
> >> >> > >> On ven., oct. 11, 2024 at 15:30, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
> >> >> > >>
> >> >> > >> > Hi Dmitry,
> >> >> > >> >
> >> >> > >> > Thank you for the patch.
> >> >> > >> >
> >> >> > >> > On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >> >> > >> >
> >> >> > >> >> To enhance code organization, it is beneficial to consolidate all A/B
> >> >> > >> >> BCB management routines into a single super-command.
> >> >> > >> >> The 'bcb' command is an excellent candidate for this purpose.
> >> >> > >> >>
> >> >> > >> >> This patch integrates the separate 'ab_select' command into the 'bcb'
> >> >> > >> >> group as the 'ab_select' subcommand, maintaining the same parameter list
> >> >> > >> >> for consistency.
> >> >> > >> >>
> >> >> > >> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> >> > >> >> ---
> >> >> > >> >>  MAINTAINERS                               |  1 -
> >> >> > >> >>  cmd/Kconfig                               | 15 +------
> >> >> > >> >>  cmd/Makefile                              |  1 -
> >> >> > >> >>  cmd/ab_select.c                           | 66 -------------------------------
> >> >> > >> >>  cmd/bcb.c                                 | 63 +++++++++++++++++++++++++++++
> >> >> > >> >>  configs/am57xx_hs_evm_usb_defconfig       |  1 -
> >> >> > >> >>  configs/khadas-vim3_android_ab_defconfig  |  1 -
> >> >> > >> >>  configs/khadas-vim3l_android_ab_defconfig |  1 -
> >> >> > >> >>  configs/sandbox64_defconfig               |  4 +-
> >> >> > >> >>  configs/sandbox_defconfig                 |  4 +-
> >> >> > >> >>  doc/android/ab.rst                        | 12 +++---
> >> >> > >> >>  include/configs/khadas-vim3_android.h     |  2 +-
> >> >> > >> >>  include/configs/khadas-vim3l_android.h    |  2 +-
> >> >> > >> >>  include/configs/meson64_android.h         |  4 +-
> >> >> > >> >>  include/configs/ti_omap5_common.h         |  4 +-
> >> >> > >> >>  test/py/tests/test_android/test_ab.py     |  8 ++--
> >> >> > >> >>  16 files changed, 85 insertions(+), 104 deletions(-)
> >> >> > >> >>
> >> >> > >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> > >> >> index 7aefda93d017f07d616f0f6d191129914fbeb484..668ccec9ae6df47192b1af668e3fdbeb1dfa15ea 100644
> >> >> > >> >> --- a/MAINTAINERS
> >> >> > >> >> +++ b/MAINTAINERS
> >> >> > >> >> @@ -65,7 +65,6 @@ R:    Sam Protsenko <semen.protsenko@linaro.org>
> >> >> > >> >>  S:     Maintained
> >> >> > >> >>  T:     git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> >> >> > >> >>  F:     boot/android_ab.c
> >> >> > >> >> -F:     cmd/ab_select.c
> >> >> > >> >>  F:     doc/android/ab.rst
> >> >> > >> >>  F:     include/android_ab.h
> >> >> > >> >>  F:     test/py/tests/test_android/test_ab.py
> >> >> > >> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> >> > >> >> index dd33266cec70a2b134b7244acae1b7f098b921e8..11e8d363dc9b137723a86a240412d82dd0dbccc5 100644
> >> >> > >> >> --- a/cmd/Kconfig
> >> >> > >> >> +++ b/cmd/Kconfig
> >> >> > >> >> @@ -1067,6 +1067,7 @@ config CMD_ADC
> >> >> > >> >>  config CMD_BCB
> >> >> > >> >>         bool "bcb"
> >> >> > >> >>         depends on PARTITIONS
> >> >> > >> >> +       depends on ANDROID_AB
> >> >> > >> >
> >> >> > >> > When building with khadas-vim3_android_defconfig, we can see that CMD_BCB is no
> >> >> > >> > longer part of that build:
> >> >> > >> >
> >> >> > >> > $ grep CMD_BCB .config
> >> >> > >> > <empty>
> >> >> > >> >
> >> >> > >> > However, if we look at include/configs/meson64_android.h, we can see
> >> >> > >> > that the "bcb" command is not only used for checking the _slot suffix.
> >> >> > >> >
> >> >> > >> > It's also used for checking the bootloader reason. For example, in
> >> >> > >> > BOOTENV_DEV_FASTBOOT, we call:
> >> >> > >> >
> >> >> > >> >    "if bcb test command = bootonce-bootloader; then " \
> >> >> > >> >
> >> >> > >> > Since CMD_BCB is no longer part of the .config (due to this dependency),
> >> >> > >> > the boot script now shows errors:
> >> >> > >> >
> >> >> > >> > """
> >> >> > >> > U-Boot 2024.10-00796-g969325278805 (Oct 11 2024 - 14:46:00 +0200) khadas-vim3
> >> >> > >> >
> >> >> > >> > Model: Khadas VIM3
> >> >> > >> > SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> >> >> > >> > DRAM:  2 GiB (effective 3.8 GiB)
> >> >> > >> > Core:  411 devices, 36 uclasses, devicetree: separate
> >> >> > >> > MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> >> >> > >> > Loading Environment from MMC... fs uses incompatible features: 00020000, ignoring
> >> >> > >> > Reading from MMC(2)... *** Warning - bad CRC, using default environment
> >> >> > >> >
> >> >> > >> > In:    usbkbd,serial
> >> >> > >> > Out:   vidconsole,serial
> >> >> > >> > Err:   vidconsole,serial
> >> >> > >> > Net:   eth0: ethernet@ff3f0000
> >> >> > >> >
> >> >> > >> > Hit any key to stop autoboot:  0
> >> >> > >> > Verify GPT: success!
> >> >> > >> > Unknown command 'bcb' - try 'help'
> >> >> > >> > Warning: BCB is corrupted or does not exist
> >> >> > >> > dev: pinctrl@14
> >> >> > >> > dev: pinctrl@40
> >> >> > >> > gpio: pin 88 (gpio 88) value is 1
> >> >> > >> > Unknown command 'bcb' - try 'help'
> >> >> > >> > Warning: BCB is corrupted or does not exist
> >> >> > >> > Loading Android boot partition...
> >> >> > >> > switch to partitions #0, OK
> >> >> > >> > mmc2(part 0) is current device
> >> >> > >> > """
> >> >> > >> >
> >> >> > >> > I know we should not be using a boot script, nor non A/B configs but
> >> >> > >> > it's a bummer that this series breaks an upstream
> >> >> > >> > defconfig (khadas-vim3_android_defconfig)
> >> >> > >> >
> >> >> > >> > My recommendation:
> >> >> > >> >
> >> >> > >> > Make BCB_CMD_AB_SELECT implementation dependant on ANDROID_AB.
> >> >> > >> > This way, users can use CMD_BCB with and without ANDROID_AB being enabled.
> >> >> > >> >
> >> >> > >> > We could do:
> >> >> > >> > When ANDROID_AB=y, implement bcb ab_select subcommand
> >> >> > >> > When ANDROID_AB=n, command is not accessible.
> >> >> > >> >
> >> >> > >> > I'll send you a diff shortly for this.
> >> >> > >>
> >> >> > >> Here is an illustration on how that would work:
> >> >> > >>
> >> >> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> >> > >> index 861c31e26408..e1a4a97b042d 100644
> >> >> > >> --- a/cmd/Kconfig
> >> >> > >> +++ b/cmd/Kconfig
> >> >> > >> @@ -1055,7 +1055,6 @@ config CMD_ADC
> >> >> > >>  config CMD_BCB
> >> >> > >>    bool "bcb"
> >> >> > >>    depends on PARTITIONS
> >> >> > >> -  depends on ANDROID_AB
> >> >> > >>    help
> >> >> > >>      Read/modify/write the fields of Bootloader Control Block, usually
> >> >> > >>      stored on the flash "misc" partition with its structure defined in:
> >> >> > >> diff --git a/cmd/bcb.c b/cmd/bcb.c
> >> >> > >> index 4fd32186ae65..4fe634f14cc5 100644
> >> >> > >> --- a/cmd/bcb.c
> >> >> > >> +++ b/cmd/bcb.c
> >> >> > >> @@ -438,6 +438,9 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
> >> >> > >>    char slot[2];
> >> >> > >>    bool dec_tries = true;
> >> >> > >>
> >> >> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
> >> >> > >> +          return CMD_RET_SUCCESS;
> >> >> > >> +
> >> >> > >>    for (int i = 4; i < argc; i++) {
> >> >> > >>            if (!strcmp(argv[i], "--no-dec"))
> >> >> > >>                    dec_tries = false;
> >> >> > >> @@ -474,6 +477,9 @@ static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> >> >> > >>    struct blk_desc *dev_desc;
> >> >> > >>    struct disk_partition part_info;
> >> >> > >>
> >> >> > >> +  if (!CONFIG_IS_ENABLED(AB_SELECT))
> >> >> > >> +          return CMD_RET_SUCCESS;
> >> >> > >> +
> >> >> > >>    if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> >> >> > >>                                             &dev_desc, &part_info,
> >> >> > >>                                             false) < 0) {
> >> >> > >>
> >> >> > >
> >> >> > > We also need to include an #ifdef directive for the ab_select_slot()
> >> >> > > function usage; otherwise, the code will not compile successfully.
> >> >> >
> >> >> > Are you sure? Per my understanding, it's possible that the compiler
> >> >> > optimizes this out because CONFIG_IS_ENABLED(AB_SELECT)
> >> >> > is known as build time.
> >> >> >
> >> >> > When I tried this diff with khadas-vim3_android_defconfig I did not see
> >> >> > any build errors. I will try again early next week.
> >> >> >
> >> >>
> >> >> As I recall, the IS_ENABLED() mechanism serves as a runtime checker to
> >> >> determine whether specific CONFIG_* options are enabled. Consequently,
> >> >> all code paths under this mechanism are always compiled. I attempted to
> >> >> disable CONFIG_ANDROID_AB for the sandbox_defconfig, but it resulted in
> >> >> the expected linker error.
> >> >>
> >> >> /tmp/ccAvYrKL.ltrans25.ltrans.o: In function `do_bcb_ab_select':
> >> >> <artificial>:(.text+0x6d5d): undefined reference to `ab_select_slot'
> >> >> collect2: error: ld returned 1 exit status
> >> >> Makefile:1813: recipe for target 'u-boot' failed
> >> >> make: *** [u-boot] Error 1
> >> >>
> >> >> I have already prepared a new version using #ifdef directives. I will
> >> >> send it shortly.
> >> >
> >> > Something else is going on here, since we do this all the time and
> >> > rely on it. So long as the code is behind an if() the dead code should
> >> > be eliminated.
> >> >
> >> 
> >> I have passed my diff (using CONFIG_IS_ENABLED) through the U-Boot CI:
> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22700
> >> 
> >> See the branch:
> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commits/dmitry/ab-dump-v3
> >> 
> >> There are some test errors (sandbox test) but the "world build" stage
> >> finished sucessfully.
> >> 
> >> I have also tested locally using the CI container:
> >> $ cd ~/work/upstream/u-boot
> >> $ git clean -xdf
> >> $ make mproper
> >> $ docker run -v $PWD:$PWD -it trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024 /bin/bash
> >> 
> >> # In container
> >> uboot@0ba059e8b7af/$ cd /home/mkorpershoek/work/upstream/u-boot
> >> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ pip install -r test/py/requirements.txt
> >> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./test/py/test.py --bd sandbox --build -k test_ut
> >> 
> >> No build errors either.
> >> 
> >> Dmitry, can you clarify what compiler/build commands you've used to see
> >> that error?
> >> 
> >> For reference, here is what buildman has in the CI container:
> >> 
> >> uboot@0ba059e8b7af:/home/mkorpershoek/work/upstream/u-boot$ ./tools/buildman/buildman --list-tool-chains
> >> List of available toolchains (17):
> >> aarch64   : /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
> >> arc       : /opt/gcc-13.2.0-nolibc/arc-linux/bin/arc-linux-gcc
> >> arm       : /opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc
> >> c89       : /usr/bin/c89-gcc
> >> c99       : /usr/bin/c99-gcc
> >> i386      : /opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-gcc
> >> m68k      : /opt/gcc-13.2.0-nolibc/m68k-linux/bin/m68k-linux-gcc
> >> microblaze: /opt/gcc-13.2.0-nolibc/microblaze-linux/bin/microblaze-linux-gcc
> >> mips      : /opt/gcc-13.2.0-nolibc/mips-linux/bin/mips-linux-gcc
> >> nios2     : /opt/gcc-13.2.0-nolibc/nios2-linux/bin/nios2-linux-gcc
> >> powerpc   : /opt/gcc-13.2.0-nolibc/powerpc-linux/bin/powerpc-linux-gcc
> >> riscv32   : /opt/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-gcc
> >> riscv64   : /opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc
> >> sandbox   : /usr/bin/cgcc
> >> sh2       : /opt/gcc-13.2.0-nolibc/sh2-linux/bin/sh2-linux-gcc
> >> x86_64    : /usr/bin/x86_64-linux-gnu-gcc
> >> xtensa    : /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-gcc
> >> 
> >> I think we should use CONFIG_IS_ENABLED if possible
> >
> > I just run build on the my x86 Ubuntu machine.
> >
> > $ cd uboot
> > $ make mproper
> > $ make sandbox_defconfig
> > $ make -j$(nproc)
> 
> I tried these commands:
> Here is the successfull build output:
> 
> https://paste.debian.net/1332378/
> 
> I use:
> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* gcc --version
> gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
> Copyright (C) 2024 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* ld --version
> GNU ld version 2.41-37.fc40
> Copyright (C) 2023 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) a later version.
> This program has absolutely no warranty.
> 
> What toolchains do you use?
> 

By default, my machine, which I typically use for cross-compilation, has
an outdated toolchain version:

$ gcc --version
gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ ld --version
GNU ld (GNU Binutils for Ubuntu) 2.30
Copyright (C) 2018 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.

> >
> > That's all.
> >
> > I've already sent the v4 patch with #ifdef. I can prepare the v5 patch
> > using the IS_ENABLED() macro and will aim to send it today.
> >
> > But I have one question:
> >
> > Do we really want to display the ab_select and ab_dump subcommands to
> > users if these commands are just stubs? Perhaps we should consider
> > adding #ifdef directives to the subcommand arrays.
> 
> That's a valid concern. I don't think we should display
> the ab_select and ab_dump commands to the users but I still want to have
> IS_ENABLED wherever possible to keep the code simple.

-- 
Thank you,
Dmitry

