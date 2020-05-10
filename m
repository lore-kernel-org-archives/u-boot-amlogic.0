Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
 by mx.groups.io with SMTP id smtpd.web10.468.1589143021401320671
 for <u-boot-amlogic@groups.io>;
 Sun, 10 May 2020 13:37:01 -0700
Received: by mail-ot1-f68.google.com with SMTP id m13so5929783otf.6
        for <u-boot-amlogic@groups.io>; Sun, 10 May 2020 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMAr4xJAez3jIzjdwrM2xtMJTlZ/qSyNynrpKg21D6o=;
        b=cw4YPdKA0GIF29If2e9+tqan2ENEsMO1TkKdn11sZ9nmXP+qdqqOTvn8Zgyhtmlu5p
         cMxJEW2LgSnxgFpk8kVNTuVLTmSQcNBPVoMi7SrqOFO9vY2ImYezMon6c1Xn6IiaSDnt
         H4CCRS868LU9MmCu7DrsnAs9/flcocC18D+5s=
MIME-Version: 1.0
References: <20200407024032.82983-1-sjg@chromium.org> <20200406203250.13.I470731da548fee846f1d7f35a1330a9de6f590c1@changeid>
 <d9b45054-fc1e-6400-f3c7-9f6830f60f57@xilinx.com>
In-Reply-To: <d9b45054-fc1e-6400-f3c7-9f6830f60f57@xilinx.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 May 2020 14:36:48 -0600
Message-ID: <CAPnjgZ1XRt8tRyktg2o-v5zAa6-8MU8DF1j9z-_jdqsao98MhA@mail.gmail.com>
Subject: Re: [PATCH 13/18] common: Drop asm/ptrace.h from common header
Content-Type: text/plain; charset="UTF-8"
To: Michal Simek <michal.simek@xilinx.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alex Marginean <alexandru.marginean@nxp.com>, Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Huan Wang <alison.wang@nxp.com>, Ibai Erkiaga <ibai.erkiaga-elorza@xilinx.com>, Joe Hershberger <joe.hershberger@ni.com>, Kever Yang <kever.yang@rock-chips.com>, Luca Ceresoli <luca@lucaceresoli.net>, Lukasz Majewski <lukma@denx.de>, Mario Six <mario.six@gdsys.cc>, Max Filippov <jcmvbkbc@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rajan Vaja <rajan.vaja@xilinx.com>, Sergey Temerkhanov <s.temerkhanov@gmail.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Thomas Hebb <tommyhebb@gmail.com>, Thomas Schaefer <thomas.schaefer@kontron.com>, Trevor Woerner <trevor@toganlabs.com>, Udit Agarwal <udit.agarwal@nxp.com>, Vagrant Cascadian <vagrant@debian.org>, Wolfgang Denk <wd@denx.de>, Yuantian Tang <andy.tang@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Michal,

On Tue, 7 Apr 2020 at 00:50, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 07. 04. 20 4:40, Simon Glass wrote:
> > Move this uncommon header out of the common header.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/cpu/arm1136/mx35/timer.c       | 1 +
> >  arch/arm/cpu/arm926ejs/mx25/timer.c     | 1 +
> >  arch/arm/cpu/arm926ejs/mx27/timer.c     | 1 +
> >  arch/arm/cpu/arm926ejs/spear/spl.c      | 1 +
> >  arch/arm/cpu/arm926ejs/spear/timer.c    | 1 +
> >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 1 +
> >  arch/arm/cpu/armv8/sec_firmware.c       | 1 +
> >  arch/arm/lib/interrupts.c               | 1 +
> >  arch/arm/lib/interrupts_64.c            | 1 +
> >  arch/arm/mach-imx/sip.c                 | 1 +
> >  arch/arm/mach-meson/board-common.c      | 1 +
> >  arch/arm/mach-meson/sm.c                | 1 +
> >  arch/arm/mach-mvebu/arm64-common.c      | 1 +
> >  arch/m68k/lib/interrupts.c              | 1 +
> >  arch/m68k/lib/traps.c                   | 1 +
> >  arch/mips/lib/traps.c                   | 1 +
> >  arch/powerpc/cpu/mpc83xx/interrupts.c   | 1 +
> >  arch/powerpc/cpu/mpc83xx/traps.c        | 1 +
> >  arch/powerpc/cpu/mpc85xx/interrupts.c   | 1 +
> >  arch/powerpc/cpu/mpc85xx/traps.c        | 1 +
> >  arch/powerpc/cpu/mpc86xx/interrupts.c   | 1 +
> >  arch/powerpc/cpu/mpc86xx/traps.c        | 1 +
> >  arch/powerpc/cpu/mpc8xx/interrupts.c    | 1 +
> >  arch/powerpc/cpu/mpc8xx/traps.c         | 1 +
> >  arch/powerpc/lib/interrupts.c           | 1 +
> >  arch/powerpc/lib/kgdb.c                 | 1 +
> >  arch/x86/cpu/i386/interrupt.c           | 1 +
> >  arch/xtensa/cpu/exceptions.c            | 1 +
> >  board/cavium/thunderx/atf.c             | 1 +
> >  board/xilinx/zynqmp/zynqmp.c            | 1 +
> >  cmd/bedbug.c                            | 1 +
> >  common/bedbug.c                         | 1 +
> >  common/kgdb.c                           | 1 +
> >  common/kgdb_stubs.c                     | 1 +
> >  drivers/clk/clk_versal.c                | 1 +
> >  drivers/firmware/firmware-zynqmp.c      | 1 +
> >  drivers/timer/mpc83xx_timer.c           | 1 +
> >  include/common.h                        | 1 -
> >  38 files changed, 37 insertions(+), 1 deletion(-)
> >

[...]

> > diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> > index 76758237c00..4f8a0453f46 100644
> > --- a/board/xilinx/zynqmp/zynqmp.c
> > +++ b/board/xilinx/zynqmp/zynqmp.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/arch/psu_init_gpl.h>
> >  #include <asm/cache.h>
> >  #include <asm/io.h>
> > +#include <asm/ptrace.h>
>
> I did a grep and I can't see ptrace macros used anywhere in the code.
> I see show_regs used by architecture and common code but not by boards.
> That's why at least for zynqmp please remove this header because nothing
> is used from it.

For example: xilinx_zynqmp_virt

ilinx_zynqmp_virt
+WARNING: BL31 file bl31.bin NOT found, U-Boot will run in EL3
+board/xilinx/zynqmp/zynqmp.c: In function 'chip_id':
+board/xilinx/zynqmp/zynqmp.c:198:17: error: storage size of 'regs' isn't known
+  struct pt_regs regs;
+                 ^~~~
+make[2]: *** [board/xilinx/zynqmp/zynqmp.o] Error 1
+make[1]: *** [board/xilinx/zynqmp] Error 2
+make: *** [sub-make] Error 2



+WARNING: BL31 file bl31.bin NOT found, U-Boot will run in EL3
+drivers/firmware/firmware-zynqmp.c: In function 'xilinx_pm_request':
+drivers/firmware/firmware-zynqmp.c:159:17: error: storage size of
'regs' isn't known
+  struct pt_regs regs;
+                 ^~~~
+ }
+ ^
+make[3]: *** [drivers/firmware/firmware-zynqmp.o] Error 1
+make[2]: *** [drivers/firmware] Error 2
+make[1]: *** [drivers] Error 2
+make: *** [sub-make] Error 2
w+drivers/firmware/firmware-zynqmp.c:159:17: warning: unused variable
'regs' [-Wunused-variable]
w+drivers/firmware/firmware-zynqmp.c:181:1: warning: control reaches
end of non-void function [-Wreturn-type]

Regards,
Simon
