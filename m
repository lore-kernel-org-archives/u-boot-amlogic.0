Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.319.1608560149505846111
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Dec 2020 06:15:49 -0800
Received: by mail-ej1-f47.google.com with SMTP id jx16so13624364ejb.10
        for <u-boot-amlogic@groups.io>; Mon, 21 Dec 2020 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVWeBj5fgHTaMKGehda8OSKLPtVv9gvyP4TwsB0xMbY=;
        b=E2seaBKfR/frVo5mpoOwEM4ChWCwKn+3h/PVpcuqtIwkJc3aeEV9kPEUl3diT6VgWE
         ZP56MfCMPekV/s5R7hjzXp5yn49+5hqDgZH7t0pMI3/Nh78FaWmRnuDGyoit7CRo6ibz
         u7+fyaraMM/WEnB6RnvS/KyoG+mCu7C3ybG1ypnYC5doxo6gw+i4PycYbFO5AiPlr0hr
         mEG4h1PVAWwTYEceHd+v4Z3X7x4rKSl0k/uMDsFRn8a/7Vj8n+Suz/l0ZUDByVX0Z6Kg
         gKcTHsntMK1JYTshTiL7m07zRlDF9Y1KNukCqM1K5xPLNf/XrSJmE461QbrU32P4J2SN
         88Zw==
MIME-Version: 1.0
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net> <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net> <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net> <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net> <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
 <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net> <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
 <CANAwSgQuZbH_E7Kaxycu0vkTxzL-XqC3PneGKM3PpaPvwDQgDg@mail.gmail.com>
 <CAFBinCDaT_z_+bbQ-LaSc56wuWLPmr6kz-2aYowCnQwN9VNqUw@mail.gmail.com>
 <CANAwSgRED_HEjjCO+bTzz4Yqzp=b+jPHAjFoZ5txSJ-KKyPSLQ@mail.gmail.com> <CAFBinCB9ybe_kGXodY4=XN2XaKO4-nU0Oj7FH00LR3=NY_=Dow@mail.gmail.com>
In-Reply-To: <CAFBinCB9ybe_kGXodY4=XN2XaKO4-nU0Oj7FH00LR3=NY_=Dow@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 21 Dec 2020 19:45:37 +0530
Message-ID: <CANAwSgSqMx-SyWNyxdH1jPZGX8wSMGf7xeoeekmmQcBVMdma7A@mail.gmail.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
Content-Type: text/plain; charset="UTF-8"
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Otto Meier <gf435@gmx.net>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Martin,

On Sun, 20 Dec 2020 at 20:04, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sun, Dec 20, 2020 at 2:46 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > On Sat, Dec 19, 2020 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > [...]
> > > > I was also looking into this issue so I made some changes in the
> > > > phy driver to resolve the issue. Plz share your thoughts on the changes below.
> > > first I have some questions :-)
> > > 1. do you see the same problem that Otto sees? this means: a) USB
> > > hotplug works as long as at least one device is plugged in at boot b)
> > > (if I understand Otto correctly then) it breaks once all USB devices
> > > have been removed
> >
> > On C1/C2 issue is when single usb hdd is connected to board it will
> > not get detected.
> > unless you connect another usb keyboard or wireless dongle to the board.
> >
> > *USB hot plug only works if two ore more usb devices are connected.*
> I am not sure if that's really the same issue as described by Otto
>
OK.
> [...]
> > > > amoon@ThinkPad-T440s:~/mainline/linux-aml-5.y-devel$ git diff
> > > > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > > > b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > > > index 7c029f552a23..363dd2ac17e6 100644
> > > > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > > > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > > > @@ -20,6 +20,7 @@ usb0_phy: phy@c0000000 {
> > > >                         #phy-cells = <0>;
> > > >                         reg = <0x0 0xc0000000 0x0 0x20>;
> > > >                         resets = <&reset RESET_USB_OTG>;
> > > > +                       reset-names = "phy-reset";
> > > >                         clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
> > > >                         clock-names = "usb_general", "usb";
> > > >                         status = "disabled";
> > > > @@ -30,6 +31,7 @@ usb1_phy: phy@c0000020 {
> > > >                         #phy-cells = <0>;
> > > >                         reg = <0x0 0xc0000020 0x0 0x20>;
> > > >                         resets = <&reset RESET_USB_OTG>;
> > > > +                       reset-names = "phy-reset";
> > > >                         clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1>;
> > > >                         clock-names = "usb_general", "usb";
> > > >                         status = "disabled";
> > > I don't see why the above two changes are needed
> > > see my comment about of_reset_control_get_shared below
> > >
> >
> > Yep I borrowed this logic from rockchip usb phy controller.
> > but I missed the action on reset.
> >
> > err = devm_add_action_or_reset(base->dev, rockchip_usb_phy_action,  rk_phy);
> > if (err)
> > return err;
> (assuming that your comment relates to the of_reset_control_get_shared
> call below)
> I checked rockchip_usb_phy_action and it's not calling reset_control_put either
> this looks strange to me and I would say that there's a memory leak.
>
Ok, I will try to check this, my approach was just to get the reset code
to get trigger, but is seem that it is not getting triggered,

> [...]
> > > >  static const struct phy_ops phy_meson8b_usb2_ops = {
> > > >         .power_on       = phy_meson8b_usb2_power_on,
> > > >         .power_off      = phy_meson8b_usb2_power_off,
> > > > +       .reset          = phy_meson8b_usb2_reset,
> > > >         .owner          = THIS_MODULE,
> > > >  };
> > > I tested this on my Odroid-C1: phy_meson8b_usb2_reset is never called
> > > after checking the dwc2 code this is expected: only in one very
> > > specific case the dwc2 driver calls phy_reset
> > > can you please find out how phy_meson8b_usb2_reset is called in your kernel?
> > >
> >
> > Yep, Its not getting called on my board, l might be missing some thing.
> are you sure that your patch fixes USB hotplug for you?
>
> the new reset callback is a no-op because it's not called
> the code below (of_reset_control_get_shared) only fetches the same
> reset line that we are already using
> so I am not sure what changed behavior you are seeing - can you please
> explain this in more detail?

I am looking into the phy-meson-gxl-usb2.c and I will try to model these changes
and see if it works on my boards.

Thanks
-Anand

>
> > > > @@ -271,6 +277,10 @@ static int phy_meson8b_usb2_probe(struct
> > > > platform_device *pdev)
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > +       priv->reset = of_reset_control_get_shared(pdev->dev.of_node,
> > > > "phy-reset");
> > > this causes a memory-leak upon driver removal
> > > also a few lines above we are already getting the reset line, so why
> > > is this needed?
> >
> > I had a feeling that USB_OTG reset will be shared between both the phy
> > controller.
> indeed, the USB_OTG reset is shared
>
> > Odroid C2 reset controller have additional RESET_USB_DDR_[0,3] reset,
> > but Odroid C1 dose not have this feature.
> have you found where the patched Amlogic kernel/u-boot use these reset lines?
> if they need to be managed by us then we probably have a bug, because
> we're not currently using these anywhere
>
> > Next time I will try to do more testing on both the devices C1/C2.
> > before sending some code for review or testing.
> I am happy about everyone who helps fixing the USB hotplug issue!
> it's a tricky issue where I don't even know if the USB PHY, dwc2
> controller or something else is the culprit
> so any help is appreciated :)
>
Ok,
>
> Best regards,
> Martin
