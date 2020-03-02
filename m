Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web09.11847.1583141566482302530
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:32:46 -0800
Received: by mail-wm1-f66.google.com with SMTP id f15so10235721wml.3
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DipINA55HJu0WQAGyLiPY6RVxvv+DBWVXBW/r4SQihI=;
        b=tg7mHaaXJQdJRcOSuSqWOuBOcR0s66y+BrHKqyX2lPmCEOO/eWpYYsGAn9QSoovxlY
         oEDDOk3hQ9RFzAJDwZhVuYFfz0twXNEGpAQpfw3QnK3IWMTFEGI0z2RTT7iVyEei5UaS
         1DPAFBOhfH36thhhdLqm6s0iSyI3DfcFlqnJDFPs4xxiJDqDByIBn3agZbA4jil8bSIQ
         jpomDH8dncIaT5CXycnvB5YNe5VJDg5DXMdW3D18bmMoaw8pJHoRMsRm/DjlksM9Snhr
         qs8Gqp+ztx1mTs3dJX+psR7VIX7ds9V8M1I2kO5TjuLagfoWKaAcXPwTUv/Shu1r/giK
         vEgw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: import common led bindings from linux v5.5
References: <20200227112738.494579-1-jbrunet@baylibre.com>
 <20200227112738.494579-2-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d21ddbe4-1fec-424b-c501-261b65281b45@baylibre.com>
Date: Mon, 2 Mar 2020 10:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200227112738.494579-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 27/02/2020 12:27, Jerome Brunet wrote:
> Import the common leds bindings definition from linux
> d5226fa6dbae ("Linux 5.5")
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/leds/common.h | 75 +++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 include/dt-bindings/leds/common.h
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> new file mode 100644
> index 000000000000..9e1256a7c1bf
> --- /dev/null
> +++ b/include/dt-bindings/leds/common.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides macros for the common LEDs device tree bindings.
> + *
> + * Copyright (C) 2015, Samsung Electronics Co., Ltd.
> + * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
> + *
> + * Copyright (C) 2019 Jacek Anaszewski <jacek.anaszewski@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_LEDS_H
> +#define __DT_BINDINGS_LEDS_H
> +
> +/* External trigger type */
> +#define LEDS_TRIG_TYPE_EDGE	0
> +#define LEDS_TRIG_TYPE_LEVEL	1
> +
> +/* Boost modes */
> +#define LEDS_BOOST_OFF		0
> +#define LEDS_BOOST_ADAPTIVE	1
> +#define LEDS_BOOST_FIXED	2
> +
> +/* Standard LED colors */
> +#define LED_COLOR_ID_WHITE	0
> +#define LED_COLOR_ID_RED	1
> +#define LED_COLOR_ID_GREEN	2
> +#define LED_COLOR_ID_BLUE	3
> +#define LED_COLOR_ID_AMBER	4
> +#define LED_COLOR_ID_VIOLET	5
> +#define LED_COLOR_ID_YELLOW	6
> +#define LED_COLOR_ID_IR		7
> +#define LED_COLOR_ID_MAX	8
> +
> +/* Standard LED functions */
> +#define LED_FUNCTION_ACTIVITY "activity"
> +#define LED_FUNCTION_ALARM "alarm"
> +#define LED_FUNCTION_BACKLIGHT "backlight"
> +#define LED_FUNCTION_BLUETOOTH "bluetooth"
> +#define LED_FUNCTION_BOOT "boot"
> +#define LED_FUNCTION_CPU "cpu"
> +#define LED_FUNCTION_CAPSLOCK "capslock"
> +#define LED_FUNCTION_CHARGING "charging"
> +#define LED_FUNCTION_DEBUG "debug"
> +#define LED_FUNCTION_DISK "disk"
> +#define LED_FUNCTION_DISK_ACTIVITY "disk-activity"
> +#define LED_FUNCTION_DISK_ERR "disk-err"
> +#define LED_FUNCTION_DISK_READ "disk-read"
> +#define LED_FUNCTION_DISK_WRITE "disk-write"
> +#define LED_FUNCTION_FAULT "fault"
> +#define LED_FUNCTION_FLASH "flash"
> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
> +#define LED_FUNCTION_INDICATOR "indicator"
> +#define LED_FUNCTION_KBD_BACKLIGHT "kbd_backlight"
> +#define LED_FUNCTION_LAN "lan"
> +#define LED_FUNCTION_MAIL "mail"
> +#define LED_FUNCTION_MTD "mtd"
> +#define LED_FUNCTION_MICMUTE "micmute"
> +#define LED_FUNCTION_MUTE "mute"
> +#define LED_FUNCTION_NUMLOCK "numlock"
> +#define LED_FUNCTION_PANIC "panic"
> +#define LED_FUNCTION_PROGRAMMING "programming"
> +#define LED_FUNCTION_POWER "power"
> +#define LED_FUNCTION_RX "rx"
> +#define LED_FUNCTION_SD "sd"
> +#define LED_FUNCTION_SCROLLLOCK "scrolllock"
> +#define LED_FUNCTION_STANDBY "standby"
> +#define LED_FUNCTION_STATUS "status"
> +#define LED_FUNCTION_TORCH "torch"
> +#define LED_FUNCTION_TX "tx"
> +#define LED_FUNCTION_USB "usb"
> +#define LED_FUNCTION_WAN "wan"
> +#define LED_FUNCTION_WLAN "wlan"
> +#define LED_FUNCTION_WPS "wps"
> +
> +#endif /* __DT_BINDINGS_LEDS_H */
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
