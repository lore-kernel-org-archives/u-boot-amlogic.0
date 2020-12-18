Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by mx.groups.io with SMTP id smtpd.web11.8123.1608289159438631082
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 02:59:20 -0800
Date: Fri, 18 Dec 2020 11:59:16 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: <a9274a4b-6012-e5af-a919-ec5ef0a57950@baylibre.com> (message from
	Neil Armstrong on Fri, 18 Dec 2020 11:47:02 +0100)
Subject: Re: [PATCH] ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4
References: <CGME20201218104353eucas1p266e5210f6272fc60b316881e3fb3c210@eucas1p2.samsung.com>
 <20201218104345.18370-1-m.szyprowski@samsung.com> <a9274a4b-6012-e5af-a919-ec5ef0a57950@baylibre.com>
Message-ID: <42689caf589944f8@bloch.sibelius.xs4all.nl>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: m.szyprowski@samsung.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, jh80.chung@samsung.com, b.zolnierkie@samsung.com
List-ID: <u-boot-amlogic@groups.io>

> From: Neil Armstrong <narmstrong@baylibre.com>
> Date: Fri, 18 Dec 2020 11:47:02 +0100
> 
> On 18/12/2020 11:43, Marek Szyprowski wrote:
> > For the proper reboot Odroid-C4 board requires to switch TFLASH_VDD_EN
> > pin to the high impedance mode, otherwise the board is stuck in the
> > middle of loading early stages of the bootloader from SD card.
> > 
> > This can be achieved by using the OPEN_DRAIN flag instead if the
> > ACTIVE_HIGH, what will leave the pin in input to achieve high state (pin
> > has the pull-up) and solve the issue.
> > 
> > Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > This is a result of the discussion in the "[PATCH/RFC] board: amlogic:
> > Fix Odroid-C4 SD card reboot issue" thread:
> > https://lists.denx.de/pipermail/u-boot/2020-December/435295.html
> > 
> > Patch for the upstream Linux DTS has been already submitted:
> > https://lore.kernel.org/linux-amlogic/20201218102228.16211-1-m.szyprowski@samsung.com/
> > ---
> >  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> > index c431988075..fbcc8287c5 100644
> > --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> > +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> > @@ -11,3 +11,7 @@
> >  	snps,reset-delays-us = <0 10000 1000000>;
> >  	snps,reset-active-low;
> >  };
> > +
> > +&tflash_vdd {
> > +	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
> > +};
> > 
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Applying it to u-boot-amlogic, and will send it asap so it's applied for v2020.10

Cool.  It works on the HC4 as well.
