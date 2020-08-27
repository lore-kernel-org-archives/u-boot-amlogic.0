Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.25273.1598551352601464195
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2020 11:02:32 -0700
Received: by mail-wm1-f50.google.com with SMTP id b79so5290694wmb.4
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2020 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=rhtTL8jReJEgTr5bcVTuXaEQ/QFmeOR94aIKc5gGOZ0=;
        b=XdY6H5tjCeISt7x2Lo+LIiXGtzzvctGWEa7w3Pl9hBve6pSAk6jI+iD0hVPThC1Qdz
         wInvqeANWFXQAJCeaHfY9eEty8z/KmsesTRGlgkNmIvg9g0kbbxe+92RXI6Qc3CvZD+0
         c/er1c1kajansYrML6R1hjspa8b7djFwz0whj9wfOmlHEYF4VioD90LjtX8P9hEHOfwQ
         PSR+X83lcEOIPf4meY7m9FzeURN3b5MpcpoVx8pJ3tFLHzccgToNL9IHrxRcP2EzV9nA
         DfEme2D2CDYwjsMrOkGJE6r6miNE0xUPg27EUF3KEj6b8id9YgP3IJTlCFWn1Jv75Jqw
         QywA==
Return-Path: <vicencb@gmail.com>
From: "Vicente Bergas" <vicencb@gmail.com>
Subject: Re: HDMI on Odroid-C4
Date: Thu, 27 Aug 2020 20:02:29 +0200
MIME-Version: 1.0
Message-ID: <babc354c-8522-4753-851e-80437e35d0b7@gmail.com>
In-Reply-To: <4913733d-7689-1173-eb97-fc2a0ddf115e@baylibre.com>
References: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
 <3d8f1054-6dd0-2d46-eba3-95d0a0cdedb9@baylibre.com>
 <8a10df70-91d7-4cd9-8813-0cd056d8623e@gmail.com>
 <4913733d-7689-1173-eb97-fc2a0ddf115e@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Thursday, August 27, 2020 9:26:21 AM CEST, Neil Armstrong wrote:
> Hi,
>
> On 24/08/2020 20:01, Vicente Bergas wrote:
>> On Monday, August 24, 2020 10:32:52 AM CEST, Neil Armstrong wrote: ...
>
> The simplest is to add "#define DEBUG" in include/common.h,=20
> boot and look for errors when the display is probing.

Hi Neil,
thanks for that clue, it helped a lot. Given the errors reported i've been
able to make HDMI work after working around two issues. Tested with u-boot
v2020.10-rc3.

1.- The EDID read fails. It reports "Not a valid EDID" from
common/edid.c:348, called from drivers/video/meson/meson_dw_hdmi.c:194
I've worked-around this using pre_buf from drivers/video/dw_hdmi.c and
populating it the the actual EDID of my monitor. This is just a workaround=
,
not a fix.

2.- The function meson_venc_hdmi_supported_mode from
drivers/video/meson/meson_venc.c:697 is discarding all modes beyond
1920x1200 which include all the modes with detailed timing information of
my monitor. I fixed this increasing the limits to 2560x1440. Another
possible solution is to remove the limits. Another possible solution is to
go for other resolutions that are supported but there are no detailed
timing information in the EDID.

Finally a different issue was with the USB keyboard. To make it work it
needs this change on top of
configs: odroid-c4: update for HDMI output background & USB keyboard

--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -12,6 +12,8 @@
 CONFIG_DEFAULT_DEVICE_TREE=3D"meson-sm1-odroid-c4"
 CONFIG_DEBUG_UART=3Dy
 CONFIG_OF_BOARD_SETUP=3Dy
+CONFIG_USE_PREBOOT=3Dy
+CONFIG_PREBOOT=3D"usb start"
 CONFIG_MISC_INIT_R=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_CMD_BDI is not set
@@ -26,6 +28,7 @@
 CONFIG_OF_CONTROL=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_DM_KEYBOARD=3Dy
 CONFIG_DM_MMC=3Dy
 CONFIG_MMC_MESON_GX=3Dy
 CONFIG_PHY_REALTEK=3Dy

Regards,
  Vicente.

> Neil

