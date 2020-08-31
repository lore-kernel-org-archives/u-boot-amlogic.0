Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.48569.1598857904054569878
 for <u-boot-amlogic@groups.io>;
 Mon, 31 Aug 2020 00:11:45 -0700
Received: by mail-wm1-f45.google.com with SMTP id b79so4274541wmb.4
        for <u-boot-amlogic@groups.io>; Mon, 31 Aug 2020 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWyfTdheQTb+r+4W7ts+8JYVee1+X1InJx71TqpuqIM=;
        b=OYUVlHiFSSYxbuemBRzhKt0ztCZLQcRGtUGe5ytOC0MMyynTu0B8LF3Vspckp9GVwd
         lrWISsu5RMPXPubKBwmXyDveHHtsgGC7WCL0wYlBCgm4PGcFXQN4BgCrNAK1RjcNzNUu
         ymWffxqwS3I604pLN4s+J44LtaGX0CY1u7fOLx4I/YbHTIE3g7vph2P23hg7n9DwK+Ce
         JOZOOT78j7bLApb+Fi/vb2HOFPxN/Py+qjt98ek7iPcqyoa1CXYLYL86vPR7eLdj4I7g
         sPApXmTu1AflQJ8Z+bn/Sow0uOI6GDniOu+oDKq+NMqAQpvHCOtqqpJIJFt5a6OuugH6
         XGyQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: HDMI on Odroid-C4
References: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
 <3d8f1054-6dd0-2d46-eba3-95d0a0cdedb9@baylibre.com>
 <8a10df70-91d7-4cd9-8813-0cd056d8623e@gmail.com>
 <4913733d-7689-1173-eb97-fc2a0ddf115e@baylibre.com>
 <babc354c-8522-4753-851e-80437e35d0b7@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <53594c11-4496-05fe-518f-c013038eda17@baylibre.com>
Date: Mon, 31 Aug 2020 09:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <babc354c-8522-4753-851e-80437e35d0b7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vicente Bergas <vicencb@gmail.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Thanks for debugging.

On 27/08/2020 20:02, Vicente Bergas wrote:
> On Thursday, August 27, 2020 9:26:21 AM CEST, Neil Armstrong wrote:
>> Hi,
>>
>> On 24/08/2020 20:01, Vicente Bergas wrote:
>>> On Monday, August 24, 2020 10:32:52 AM CEST, Neil Armstrong wrote: ...
>>
>> The simplest is to add "#define DEBUG" in include/common.h, boot and look for errors when the display is probing.
> 
> Hi Neil,
> thanks for that clue, it helped a lot. Given the errors reported i've been
> able to make HDMI work after working around two issues. Tested with u-boot
> v2020.10-rc3.
> 
> 1.- The EDID read fails. It reports "Not a valid EDID" from
> common/edid.c:348, called from drivers/video/meson/meson_dw_hdmi.c:194
> I've worked-around this using pre_buf from drivers/video/dw_hdmi.c and
> populating it the the actual EDID of my monitor. This is just a workaround,
> not a fix.
> 
> 2.- The function meson_venc_hdmi_supported_mode from
> drivers/video/meson/meson_venc.c:697 is discarding all modes beyond
> 1920x1200 which include all the modes with detailed timing information of
> my monitor. I fixed this increasing the limits to 2560x1440. Another
> possible solution is to remove the limits. Another possible solution is to
> go for other resolutions that are supported but there are no detailed
> timing information in the EDID.

The modes are limited to 1920x1200 because I'm not sure if higher resolutions
would be correctly supported in DMT mode.

It's weird your monitor doesn't have at least a standard VESA mode in detailed timings ?

could you share the binary edid ?

Neil

> 
> Finally a different issue was with the USB keyboard. To make it work it
> needs this change on top of
> configs: odroid-c4: update for HDMI output background & USB keyboard
> 
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -12,6 +12,8 @@
> CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
> CONFIG_DEBUG_UART=y
> CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="usb start"
> CONFIG_MISC_INIT_R=y
> # CONFIG_DISPLAY_CPUINFO is not set
> # CONFIG_CMD_BDI is not set
> @@ -26,6 +28,7 @@
> CONFIG_OF_CONTROL=y
> CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_DM_KEYBOARD=y
> CONFIG_DM_MMC=y
> CONFIG_MMC_MESON_GX=y
> CONFIG_PHY_REALTEK=y
> 
> Regards,
>  Vicente.
> 
>> Neil
> 

