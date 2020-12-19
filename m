Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web09.14222.1608407627365267766
 for <u-boot-amlogic@groups.io>;
 Sat, 19 Dec 2020 11:53:47 -0800
Received: by mail-yb1-f170.google.com with SMTP id w135so5168607ybg.13
        for <u-boot-amlogic@groups.io>; Sat, 19 Dec 2020 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=da3V1/k7LJgLuPYzqWPIFxUVeadZkuLYghR+CceTzlw=;
        b=bkhri8oJG9zsn3UpF+Dbo0SgUK4v8wYmiOAg0zV8Xi0PpyqYgzbHd+qu/0K3ysBwSL
         KXweBOrzKJiim3iVEzkGR2mj6QRYZOmcqOHLWz6NKApyGD91CJsdNsbdcZRWDQm0UkC4
         S83nPliYx8yER026WKZpcIxv2XdzQKPgRig5jiApU7FaqqBu5BcmM1nWzvIrOOPCf6lb
         mMItA1m26dwyr+ThCAk6C9+h01BoNKswu1QThhHYgfroViY6G23bSQA3OFcXKexH907m
         +28YwL6wQNNI146nRJGuOu0k0vFlL4rfXvNZtxcrMvprXc79no/jAv+pCA3Qch6oXvk2
         Fotg==
MIME-Version: 1.0
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net> <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net> <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net> <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net> <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
 <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net> <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
In-Reply-To: <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 20 Dec 2020 01:23:37 +0530
Message-ID: <CANAwSgQuZbH_E7Kaxycu0vkTxzL-XqC3PneGKM3PpaPvwDQgDg@mail.gmail.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
Content-Type: text/plain; charset="UTF-8"
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Otto Meier <gf435@gmx.net>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Martin,

On Sat, 19 Dec 2020 at 19:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Otto,
>
> On Mon, Dec 14, 2020 at 8:34 PM Otto Meier <gf435@gmx.net> wrote:
> >
> > Hi Martin,
> >
> > Am 13.12.20 um 19:46 schrieb Martin Blumenstingl:
> > > Hi Otto,
> > >
> > > On Mon, Dec 7, 2020 at 1:43 PM Otto Meier <gf435@gmx.net> wrote:
> > > [...]
> > >>>> So with the latest u-boot and the kernel from https://github.com/chewitt/linux/tree/amlogic-5.10.y
> > >>>> commit 725fc8df7898102f9031ba2075f763884ffa3ee8 everything is working again.
> > >>>> USB does hotplugging as expected.
> > >>> So, this fixes USB under Linux ?? It's not clear
> > > if you have time it would be great if you could figure out which of
> > > the patches from Christian's tree fixes USB hotplugging for you.
> > > Or is it fixed in Linux 5.10-rcX even without any patches?
> > >
> > The new mainline kernel 5.10.0 from Linus, without any other patches
> > does detect USB hotpluging,
> > when using u-boot DMI: Hardkernel Co., Ltd. ODROID-C2/ODROID-C2, BIOS
> > 2021.01-rc3-00039-gec79f5ce22-dirty 12/08/2020
> > and the following u-boot patch:
> [...]
> > When i use the last unpatched emmc bootable u-boot 2020.04 the kernel
> > boots, but usb hotplugging
> > does not work.
> Thank you for testing this!
>
> > Hope this describes my findings. If i can help further, please give me a
> > note.
> to be honest: I am a bit lost here. I don't understand how the BOOT_*
> pins interfere with USB.
> I also don't have any Odroid-C2 board myself so I cannot do any
> experiments myself.
> Neil, please let me know if you have any idea here.
>
>
> Best regards,
> Martin
>

I was also looking into this issue so I made some changes in the
phy driver to resolve the issue. Plz share your thoughts on the changes below.

Best Regards
-Anand

amoon@ThinkPad-T440s:~/mainline/linux-aml-5.y-devel$ git diff
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 7c029f552a23..363dd2ac17e6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -20,6 +20,7 @@ usb0_phy: phy@c0000000 {
                        #phy-cells = <0>;
                        reg = <0x0 0xc0000000 0x0 0x20>;
                        resets = <&reset RESET_USB_OTG>;
+                       reset-names = "phy-reset";
                        clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
                        clock-names = "usb_general", "usb";
                        status = "disabled";
@@ -30,6 +31,7 @@ usb1_phy: phy@c0000020 {
                        #phy-cells = <0>;
                        reg = <0x0 0xc0000020 0x0 0x20>;
                        resets = <&reset RESET_USB_OTG>;
+                       reset-names = "phy-reset";
                        clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1>;
                        clock-names = "usb_general", "usb";
                        status = "disabled";
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c
b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 03c061dd5f0d..31523becc878 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -143,14 +143,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
        u32 reg;
        int ret;

-       if (!IS_ERR_OR_NULL(priv->reset)) {
-               ret = reset_control_reset(priv->reset);
-               if (ret) {
-                       dev_err(&phy->dev, "Failed to trigger USB reset\n");
-                       return ret;
-               }
-       }
-
        ret = clk_prepare_enable(priv->clk_usb_general);
        if (ret) {
                dev_err(&phy->dev, "Failed to enable USB general clock\n");
@@ -222,9 +214,23 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
        return 0;
 }

+static int phy_meson8b_usb2_reset(struct phy *phy)
+{
+       struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+
+       if (priv->reset) {
+               reset_control_assert(priv->reset);
+               udelay(10);
+               reset_control_deassert(priv->reset);
+       }
+
+       return 0;
+}
+
 static const struct phy_ops phy_meson8b_usb2_ops = {
        .power_on       = phy_meson8b_usb2_power_on,
        .power_off      = phy_meson8b_usb2_power_off,
+       .reset          = phy_meson8b_usb2_reset,
        .owner          = THIS_MODULE,
 };

@@ -271,6 +277,10 @@ static int phy_meson8b_usb2_probe(struct
platform_device *pdev)
                return -EINVAL;
        }

+       priv->reset = of_reset_control_get_shared(pdev->dev.of_node,
"phy-reset");
+       if (IS_ERR(priv->reset))
+               priv->reset = NULL;
+
        phy = devm_phy_create(&pdev->dev, NULL, &phy_meson8b_usb2_ops);
        if (IS_ERR(phy)) {
                dev_err(&pdev->dev, "failed to create PHY\n");

> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
