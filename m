Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web12.25714.1598552802159367702
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2020 11:26:42 -0700
Received: by mail-wr1-f53.google.com with SMTP id r15so6257786wrp.13
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2020 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=eWuqOpeC7cSzu40fCwCCfIbChDcNm0O5L4wgeI5y3Qo=;
        b=uayVck4QLWwyQNSLb7aGjWCUuQVumKLSvoZAQxV2iv9FbEdASLPStIDV3Xqj1J6vJB
         l9dRRo2kIJHI387GW1FWHol17wpKi8Vyu5Kvtu9EUhcHI6/FzaDGO5SeqsuBy65aQx/c
         TUr1APHe52marCpBcsjFM3UalvltT/hR5nl2AFYkgUtMmh9PGmonmyd61eCzNHSlHdhI
         2rnliUOf+MRx7+kPRbTGjB3obG/vzOqr2wg8v9+vcntc4ghWDmurmwG3fBa0lTKwVyxw
         OaepNMwJ8DXbdvOQe1EJdHkxBoUuSfgDvo3P4FewXIGfhFQNxMuVGA0tykJYref27VRa
         VqJg==
Return-Path: <vicencb@gmail.com>
From: "Vicente Bergas" <vicencb@gmail.com>
Subject: Re: HDMI on Odroid-C4
Date: Thu, 27 Aug 2020 20:26:38 +0200
MIME-Version: 1.0
Message-ID: <346f1478-0898-4477-8daf-9341cd6dacd6@gmail.com>
In-Reply-To: <babc354c-8522-4753-851e-80437e35d0b7@gmail.com>
References: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
 <3d8f1054-6dd0-2d46-eba3-95d0a0cdedb9@baylibre.com>
 <8a10df70-91d7-4cd9-8813-0cd056d8623e@gmail.com>
 <4913733d-7689-1173-eb97-fc2a0ddf115e@baylibre.com>
 <babc354c-8522-4753-851e-80437e35d0b7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Thursday, August 27, 2020 8:02:29 PM CEST, Vicente Bergas wrote:
> On Thursday, August 27, 2020 9:26:21 AM CEST, Neil Armstrong wrote:
>> Hi,
>>=20
>> On 24/08/2020 20:01, Vicente Bergas wrote:
>>> On Monday, August 24, 2020 10:32:52 AM CEST, Neil Armstrong wrote: ...
>>=20
>> The simplest is to add "#define DEBUG" in include/common.h,=20
>> boot and look for errors when the display is probing.
>
> Hi Neil,
> thanks for that clue, it helped a lot. Given the errors reported i've be=
en
> able to make HDMI work after working around two issues. Tested with u-bo=
ot
> v2020.10-rc3.
>
> 1.- The EDID read fails. It reports "Not a valid EDID" from
> common/edid.c:348, called from drivers/video/meson/meson_dw_hdmi.c:194
> I've worked-around this using pre_buf from drivers/video/dw_hdmi.c and
> populating it the the actual EDID of my monitor. This is just a workarou=
nd,
> not a fix.

Point No.1 above is a false alarm. The EDID read works fine.

> 2.- The function meson_venc_hdmi_supported_mode from
> drivers/video/meson/meson_venc.c:697 is discarding all modes beyond
> 1920x1200 which include all the modes with detailed timing information o=
f
> my monitor. I fixed this increasing the limits to 2560x1440. Another
> possible solution is to remove the limits. Another possible solution is =
to
> go for other resolutions that are supported but there are no detailed
> timing information in the EDID.
>
> Finally a different issue was with the USB keyboard. To make it work it
> needs this change on top of
> configs: odroid-c4: update for HDMI output background & USB keyboard
>
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -12,6 +12,8 @@
> CONFIG_DEFAULT_DEVICE_TREE=3D"meson-sm1-odroid-c4"
> CONFIG_DEBUG_UART=3Dy
> CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_USE_PREBOOT=3Dy
> +CONFIG_PREBOOT=3D"usb start"
> CONFIG_MISC_INIT_R=3Dy
> # CONFIG_DISPLAY_CPUINFO is not set
> # CONFIG_CMD_BDI is not set
> @@ -26,6 +28,7 @@
> CONFIG_OF_CONTROL=3Dy
> CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_DM_KEYBOARD=3Dy
> CONFIG_DM_MMC=3Dy
> CONFIG_MMC_MESON_GX=3Dy
> CONFIG_PHY_REALTEK=3Dy
>
> Regards,
>  Vicente.
>
>> Neil

