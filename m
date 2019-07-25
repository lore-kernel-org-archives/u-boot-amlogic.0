Received: by mail-wm1-f53.google.com with SMTP id s3so43954322wms.2
        for <u-boot-amlogic@groups.io>; Thu, 25 Jul 2019 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=8+odWUGFcbegH37IhcwuKe2V9bq6Utj/+tgoaqOBS8M=;
        b=tm66I/kGmjVeKtHSUkt3QhXgKOlqXEqCC13sD7HRQRcHQJpYki2C0FgDP4EDsi51N7
         7LJW7r82WtXinJiQOMX2EzusNhzCTf890BGJiJxw6zzL0efJVrv140NKcrJmnerI9hDW
         Nc3pEAi3j/FkQHVBEEJHskx3wMkoZz3JXaZG4A35QZpIyVfueXRhpDdl93YGNkIrC66C
         JyxecxGizu8hMC10v280YPNubUwtbmGnEn1M7PcZYs5CnTXhk/CkESQZ+DkxOyxiduup
         ebapwmUnMrbXrxv01NgXeUvLl0jRpPDrvBVXTAuE6JX9Tq29DMPtw0ItENy5ZxGhhykZ
         K3HA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: how to encrypt fip for GXB P201 and possible bug in docs
References: <16bdc4f8-71de-05c0-f976-0a9a76e96f57@baylibre.com>
 <12517.1564004163819307992@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5f5ee7b6-ac19-a33a-3aa0-aebe1b080b0f@baylibre.com>
Date: Thu, 25 Jul 2019 09:30:10 +0200
MIME-Version: 1.0
In-Reply-To: <12517.1564004163819307992@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, krecis@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 24/07/2019 à 23:36, krecis@gmail.com a écrit :
> Thanks for your answer .
> 
> I'm trying to expand my know-how about u-boot and I think that the closest description is this one ( I have an A95X F1 ) :
> https://github.com/CoreELEC/device-trees-amlogic/blob/master/gxl_p281_2g_a95xr2.dts
> 
> At this point I need a guide about how to support this new board starting from already existing config files and sources .

We always avoided replacing the bootloader of a closed device, because we don't have the source of
the FIP components (DDR setup, Power Pins & PWM, DVFS table), and usually these boxes has custom
setups that could diverge from the reference designs.

If you feel confident enough, you'll need to dump the eMMC content to save the original
bootloader (in the first 4MiB) and use the p281 amlogic u-boot config to generate the FIP
binaries as explained in the mainline README file of P212.
If not, simply chainload the mainline u-boot.bin binary (not packaged with FIP stuff) from the
original u-boot on the device, it should work well.

Then simply use the P212 mainline u-boot defconfig as a start.

> Do you have any pointers ? I know how to build u-boot, but I don't know how and what I have to modify in order to achieve what I want .
> 
> PS
> It's not clear to me if I can mix and match device tree definitions from the linux kernel and using them for u-boot

The mainline u-boot syncs the mainline Linux device tree, which was entirely rewritten to match
the standard rules and requirements of upstream development, so you can't use the amlogic linux
device tree files.

The following https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
should work on your device.

Neil

> 
> 
