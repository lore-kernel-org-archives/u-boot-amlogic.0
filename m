Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web12.16072.1608417078165977704
 for <u-boot-amlogic@groups.io>;
 Sat, 19 Dec 2020 14:31:18 -0800
Received: by mail-ej1-f46.google.com with SMTP id 6so8416678ejz.5
        for <u-boot-amlogic@groups.io>; Sat, 19 Dec 2020 14:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaXdLw3v1jonc9NWcCJTOo369ubiSnEjm3+3KJqRATM=;
        b=uQqNkRGeDbmEZf4kwXHXdZus/yBb9aGrXrYXzpM/NAjenzirVeNEPGFXpHHmW/NBcN
         kg7Z7y+MubT+NkUCOFlBHyIUM0b+yryaAK07G9BxtrKR2xLWklqRtp1Ie/xCGgob6rcW
         bAKvUsZB3gn8eAyhBE9oqRXgvZ6G7nSplApte/51SDjbZDvjawcWBiZpLHg7tDQ1kJ0O
         rAve4WEYo/P5Gtgx8QP68ykvEhv9cu0MZP50LJosNaREQzgZaEZ6Okn94h075BJxALZt
         jQrq+khvdTro17fIUnE1CRivcYq1UwYhPaexuAY+AXVpP2bizq9rOpNzeXKWPBmNRgjK
         t2Ew==
MIME-Version: 1.0
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net> <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net> <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net> <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net> <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
 <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net> <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
 <CANAwSgQuZbH_E7Kaxycu0vkTxzL-XqC3PneGKM3PpaPvwDQgDg@mail.gmail.com>
In-Reply-To: <CANAwSgQuZbH_E7Kaxycu0vkTxzL-XqC3PneGKM3PpaPvwDQgDg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 19 Dec 2020 23:31:05 +0100
Message-ID: <CAFBinCDaT_z_+bbQ-LaSc56wuWLPmr6kz-2aYowCnQwN9VNqUw@mail.gmail.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
Content-Type: text/plain; charset="UTF-8"
To: Anand Moon <linux.amoon@gmail.com>
Cc: Otto Meier <gf435@gmx.net>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Anand,

On Sat, Dec 19, 2020 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> I was also looking into this issue so I made some changes in the
> phy driver to resolve the issue. Plz share your thoughts on the changes below.
first I have some questions :-)
1. do you see the same problem that Otto sees? this means: a) USB
hotplug works as long as at least one device is plugged in at boot b)
(if I understand Otto correctly then) it breaks once all USB devices
have been removed
2. does the mainline u-boot patch mentioned by Otto fix the problem
for you? according to him it fixes the problem and he did not have to
modify the USB PHY driver

> amoon@ThinkPad-T440s:~/mainline/linux-aml-5.y-devel$ git diff
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 7c029f552a23..363dd2ac17e6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -20,6 +20,7 @@ usb0_phy: phy@c0000000 {
>                         #phy-cells = <0>;
>                         reg = <0x0 0xc0000000 0x0 0x20>;
>                         resets = <&reset RESET_USB_OTG>;
> +                       reset-names = "phy-reset";
>                         clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB0>;
>                         clock-names = "usb_general", "usb";
>                         status = "disabled";
> @@ -30,6 +31,7 @@ usb1_phy: phy@c0000020 {
>                         #phy-cells = <0>;
>                         reg = <0x0 0xc0000020 0x0 0x20>;
>                         resets = <&reset RESET_USB_OTG>;
> +                       reset-names = "phy-reset";
>                         clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1>;
>                         clock-names = "usb_general", "usb";
>                         status = "disabled";
I don't see why the above two changes are needed
see my comment about of_reset_control_get_shared below

> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c
> b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index 03c061dd5f0d..31523becc878 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -143,14 +143,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>         u32 reg;
>         int ret;
>
> -       if (!IS_ERR_OR_NULL(priv->reset)) {
> -               ret = reset_control_reset(priv->reset);
> -               if (ret) {
> -                       dev_err(&phy->dev, "Failed to trigger USB reset\n");
> -                       return ret;
> -               }
> -       }
> -
>         ret = clk_prepare_enable(priv->clk_usb_general);
>         if (ret) {
>                 dev_err(&phy->dev, "Failed to enable USB general clock\n");
> @@ -222,9 +214,23 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
>         return 0;
>  }
>
> +static int phy_meson8b_usb2_reset(struct phy *phy)
> +{
> +       struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +       if (priv->reset) {
> +               reset_control_assert(priv->reset);
> +               udelay(10);
> +               reset_control_deassert(priv->reset);
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct phy_ops phy_meson8b_usb2_ops = {
>         .power_on       = phy_meson8b_usb2_power_on,
>         .power_off      = phy_meson8b_usb2_power_off,
> +       .reset          = phy_meson8b_usb2_reset,
>         .owner          = THIS_MODULE,
>  };
I tested this on my Odroid-C1: phy_meson8b_usb2_reset is never called
after checking the dwc2 code this is expected: only in one very
specific case the dwc2 driver calls phy_reset
can you please find out how phy_meson8b_usb2_reset is called in your kernel?

> @@ -271,6 +277,10 @@ static int phy_meson8b_usb2_probe(struct
> platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       priv->reset = of_reset_control_get_shared(pdev->dev.of_node,
> "phy-reset");
this causes a memory-leak upon driver removal
also a few lines above we are already getting the reset line, so why
is this needed?


Best regards,
Martin
