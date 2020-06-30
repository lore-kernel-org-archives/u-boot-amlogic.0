Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
 by mx.groups.io with SMTP id smtpd.web11.402.1593532981930381520
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Jun 2020 09:03:02 -0700
Received: by mail-io1-f67.google.com with SMTP id i4so21542419iov.11
        for <u-boot-amlogic@groups.io>; Tue, 30 Jun 2020 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmVcVAyJ915+NJlV6yPMeMr4pmEQyiCM+YIU3DzUdDY=;
        b=pUDY5wnmaF3cz3kXrwbM8fM7WpIYIdaGs4PzX5TfW+pP2bQsCR1omGCwcs84Q8/umH
         09WK8R7JsS/GToKCekmBo/wIi3r4P/ntKCeJKmLeONrwtmce6tyQOAcZ6kRn29X2pyY1
         j5yM+xA5zQ2GjjMKwmxQgzYjgrvy06jfcKBS6SSu4F8k3apTcujnXW4J8X4TpaxkclTL
         gwo+yvi4NhOf2xaxO9bryDozs8Rd77dpRvjcWs3RAo/NdmhGuwzQseL0z+FXdqgJOR6F
         g/ypgSVSLjUncLu5Q+UrR20YbmhxGwMeWVt32bdrtLOPyEQQptTnjrLRqGqyHFEb8gWx
         kE6w==
MIME-Version: 1.0
References: <20200505202217.7849-1-b.galvani@gmail.com> <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
 <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com>
In-Reply-To: <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 30 Jun 2020 21:32:49 +0530
Message-ID: <CANAwSgR8jX+Z+xZ3EXHQbq80dswn6WjaF-vyJHjyxQREVf+Mfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Tue, 30 Jun 2020 at 18:30, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 30/06/2020 13:33, Anand Moon wrote:
> > Hi Beniamino,
> >
> > On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> these two patches add initial u-boot support for Hardkernel ODROID-C4.
> >>
> >> https://wiki.odroid.com/odroid-c4/odroid-c4
> >>
> >> Beniamino Galvani (2):
> >>   arm: dts: import ODROID-C4 device tree
> >>   boards: amlogic: add ODROID-C4 support
> >>
> >
> > Can you respin this patches, I would like to see these get merged in
> > the current u-boot release
> >
> > -Anand
> >
>
> The Odroid-C4 could re-use the new Odroid-N2 board support I submitted at [1]
>
> Anand, is the MAC address stored stored the same way on the C4 ?
>
> Neil
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/

I gave this patches a try on latest u-boot but I cannot make my Odroid
C4 to boot up uinsg microSD card and eMMC
Here are the logs.

SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
bl2_stage_init 0x01
bl2_stage_init 0x81
hw id: 0x0000 - pwm id 0x01
bl2_stage_init 0xc1
bl2_stage_init 0x02

no sdio debug board detected
L0:00000000
L1:00000703
L2:00008067
L3:15000020
S1:00000000
B2:20282000
B1:a0f83180

TE: 260148

BL2 Built : 22:54:32, Apr 28 2020. g12a ga659aac-dirty - changqing.gao@droid11

Board ID = 1
Set cpu clk to 24M
Set clk81 to 24M
Use GP1_pll as DSU clk.
DSU clk: 1200 Mhz
CPU clk: 1200 MHz
Set clk81 to 166.6M
DDR driver_vesion: LPDDR4_PHY_V_0_1_15 build time: Apr 28 2020 22:54:28
board id: 1
Load FIP HDR from SD, src: 0x00010200, des: 0xfffd0000, size:
0x00004000, part: 0
fw parse done
Load ddrfw from SD, src: 0x00030200, des: 0xfffd0000, size: 0x0000c000, part: 0
Load ddrfw from SD, src: 0x0002c200, des: 0xfffd0000, size: 0x00004000, part: 0
PIEI prepare done
fastboot data load
fastboot data verify
verify result: 255
Cfg max: 2, cur: 1. Board id: 255. Force loop cfg
DDR4 probe
ddr clk to 1320MHz
Load ddrfw from SD, src: 0x00014200, des: 0xfffd0000, size: 0x0000c000, part: 0

dmc_version 0001
Check phy result
INFO : End of initialization
INFO : End of read enable training
INFO : End of fine write leveling
INFO : End of read dq deskew training
INFO : End of MPR read delay center optimization
INFO : End of Write leveling coarse delay
INFO : End of write delay center optimization
INFO : End of read delay center optimization
INFO : End of max read latency training
INFO : Training has run successfully!
1D training succeed
Load ddrfw from SD, src: 0x00020200, des: 0xfffd0000, size: 0x0000c000, part: 0
Check phy result
INFO : End of initialization
INFO : End of 2D read delay Voltage center optimization
INFO : End of 2D write delay Voltage center optimization
INFO : Training has run successfully!

R0_RxClkDly_Margin==106 ps 9
R0_TxDqDly_Margi==118 ps 10


R1_RxClkDly_Margin==0 ps 0
R1_TxDqDly_Margi==0 ps 0

 dwc_ddrphy_apb_wr((0<<20)|(2<<16)|(0<<12)|(0xb0):0001

soc_vref_reg_value 0x 0000004e 0000004e 0000004e 0000004d 0000004f
0000004e 0000004e 0000004f 0000004c 0000004d 0000004e 0000004c
0000004c 0000004e 0000004f 0000004e 00000050 0000004e 0000004d
0000004e 0000004e 0000004c 0000004d 0000004d 0000004d 0000004f
0000004f 0000004f 0000004d 0000004d 0000004d 0000004f
dram_vref_reg_value 0x 00000021
2D training succeed
aml_ddr_fw_vesion: LPDDR4_PHY_V_0_1_15 build time: Jun 18 2019 20:29:43
auto size-- 65535DDR cs0 size: 2048MB
DDR cs1 size: 2048MB
DMC_DDR_CTRL: 00700024DDR size: 3928MB
cs0 DataBus test pass
cs1 DataBus test pass
cs0 AddrBus test pass
cs1 AddrBus test pass

non-sec scramble use zero key
ddr scramble enabled

100bdlr_step_size ps== 461
result report
boot times 0Enable ddr reg access
Load FIP HDR from SD, src: 0x00010200, des: 0x01700000, size:
0x00004000, part: 0
Load BL3X from SD, src: 0x0003c200, des: 0x0172c000, size: 0x00090000, part: 0
0.0;M3 CHK:0;cm4_sp_mode 0
MVN_1=0x00000000
MVN_2=0x00000000
[Image: g12a_v1.1.3386-3b31431 2019-05-21 10:41:54 luan.yuan@droid15-sz]
OPS=0x10
ring efuse init
2b 0c 10 00 01 13 20 00 00 0f 36 30 43 57 50 50
[0.017319 Inits done]
secure task start!
high task start!
low task start!
run into bl31
NOTICE:  BL31: v1.3(release):4fc40b1
NOTICE:  BL31: Built : 15:57:33, May 22 2019
NOTICE:  BL31: G12A normal boot!
NOTICE:  BL31: BL33 decompress pass
ERROR:   Error initializing runtime service opteed_fast


U-Boot 2020.07-rc5-00076-g46e5b60e21 (Jun 30 2020 - 21:08:25 +0530) odroid-c4

Model: Hardkernel ODROID-C4
SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
DRAM:  3.8 GiB
MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
stdio_add_devices: Video device failed (ret=-22)
In:    serial@3000
Out:   serial@3000
Err:   serial@3000
Net:   Could not get PHY for ethernet@ff3f0000: addr 8
No ethernet found.

Hit any key to stop autoboot:  0

-Anand
