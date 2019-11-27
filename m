Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web09.6836.1574865742649647805
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 06:42:22 -0800
Received: by mail-il1-f196.google.com with SMTP id u17so21238271ilq.5
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlqTBBl4WJReEaPRPEK2vvzAMH5M80O2XPQZzrw5ROk=;
        b=pmHfRo8C3kY90Qb+7pA6QKUkvS+ZHQguiOAlR7HiVXjkrNqFVwLDzWhZ1y1Amp1cnB
         iGEdXJMEQGYwHFWQS1pYxfIt34xTr4+BSkPnePSHcxTHeEiNIt5r17dU3cz2kO4v3VLl
         E1zX6LxNA33/HsYT24N0hG90jKAr5hHEv6epPpUGPzR9hbQiFcEHjWNYh18DEQZX+Cdr
         GN92sX6edv0gq9Q5IgMKVR74eTcv2rdHBUJucCjDMnQJkaB/4uuREizjBq4Hu+HwUAx0
         SQLeujX2aoxCbr6i5aQWniQNYC9fyLsSirulM+kvzwC/bTI61cMPSXc+i614I/eDD42v
         PPDQ==
MIME-Version: 1.0
References: <20191126211206.4537-1-linux.amoon@gmail.com> <20191126211206.4537-2-linux.amoon@gmail.com>
 <cbd329c9-a14b-3d50-595e-0cfb6bf625c7@baylibre.com>
In-Reply-To: <cbd329c9-a14b-3d50-595e-0cfb6bf625c7@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 27 Nov 2019 20:12:11 +0530
Message-ID: <CANAwSgTd_DReosGwjfo5cVkRogXYuHNS8_9cJOdEOKVvFYcy5A@mail.gmail.com>
Subject: Re: [U-Boot] [PATCH 1/4] mmc: meson-gx: Fix tx phase in the tuning process
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 27 Nov 2019 at 18:30, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 26/11/2019 22:12, Anand Moon wrote:
> > odroid n2 eMMC module would failed to boot up,
> > because of TX phase clk failure, fix the typo in
> > TX phase macro to help tune correct clk freqency.
> >
> > Before these changes.
> >   clock is enabled (380953Hz)
> >   clock is enabled (25000000Hz)
> > after these changes
> >   clock is enabled (380953Hz)
> >   clock is enabled (25000000Hz)
> >   clock is enabled (52000000Hz)
> >   clock is enabled (52000000Hz)
> >   clock is enabled (52000000Hz)
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Tested on
> > new orange - eMMC AJNB4R 14.6 GiB MMC 5.1
> > old back   - eMMC CGND3R 58.2 GiB MMC 5.0
> > ---
> >  drivers/mmc/meson_gx_mmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> > index 031cc79ccb..87bea2888b 100644
> > --- a/drivers/mmc/meson_gx_mmc.c
> > +++ b/drivers/mmc/meson_gx_mmc.c
> > @@ -53,7 +53,7 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> >       meson_mmc_clk |= CLK_CO_PHASE_180;
> >
> >       /* 180 phase tx clock */
> > -     meson_mmc_clk |= CLK_TX_PHASE_000;
> > +     meson_mmc_clk |= CLK_TX_PHASE_180;
> >
> >       /* clock settings */
> >       meson_mmc_clk |= clk_src;
> >
>
> I don't understand what this change helps, the linux driver sets the TX phase to 0,
> why 180 would help here ?
>
> Neil

I narrow down to this small changes, without this small change
it fails to detect the eMMC module. See the below log.

U-Boot 2020.01-rc3-00082-g4b19b89ca4-dirty (Nov 27 2019 - 18:56:37
+0530) odroid-n2

Model: Hardkernel ODROID-N2
SoC:   Amlogic Meson G12B (S922X) Revision 29:a (40:2)
DRAM:  3.8 GiB
mmc_bind: alias ret=-2, devnum=-1
mmc_bind: alias ret=-2, devnum=-1
MMC:   clock is enabled (380953Hz)
clock is enabled (380953Hz)
sd@ffe05000: 0, mmc@ffe07000: 1
In:    serial@3000
Out:   serial@3000
Err:   serial@3000
Net:   gpio_request_tail: Node 'ethernet@ff3f0000', property
'snps,reset-gpio', failed to request GPIO index 0: -2

Warning: ethernet@ff3f0000 (eth0) using random MAC address - 26:1e:2a:2a:67:d6
eth0: ethernet@ff3f0000
Hit any key to stop autoboot:  0
clock is disabled (0Hz)
regulator_common_set_enable: dev='regulator-tflash_vdd', enable=1,
delay=0, has_gpio=1
regulator_common_set_enable: done
clock is enabled (380953Hz)
Card did not respond to voltage select!
gpio_request_tail: Node 'regulator-vcc_3v3', property 'gpio', failed
to request GPIO index 0: -2
Regulator 'regulator-vcc_3v3' optional enable GPIO - not found! Error: -2
gpio_request_tail: Node 'regulator-flash_1v8', property 'gpio', failed
to request GPIO index 0: -2
Regulator 'regulator-flash_1v8' optional enable GPIO - not found! Error: -2
clock is disabled (0Hz)
regulator_common_set_enable: dev='regulator-vcc_3v3', enable=1,
delay=0, has_gpio=0
clock is enabled (380953Hz)
clock is enabled (25000000Hz)
unable to select a mode
switch to partitions #0, OK
mmc1(part 0) is current device
** No partition table - mmc 1 **
MMC Device 2 not found
no mmc device at slot 2
starting USB...
Bus usb@ff500000: gpio_request_tail: Node 'regulator-vcc_5v', property
'gpio', failed to request GPIO index 0: -2
Regulator 'regulator-vcc_5v' optional enable GPIO - not found! Error: -2
regulator_common_set_enable: dev='regulator-usb_pwr_en', enable=1,
delay=0, has_gpio=1
regulator_common_set_enable: done
Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
scanning bus usb@ff500000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

-Anand
