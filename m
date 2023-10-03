Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.102963.1696317900805387369
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:25:01 -0700
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31f71b25a99so629917f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317899; x=1696922699; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcLN8dO/VlbnaKnnDbYOL6x9VTYmz7ZSfkgHj3t2Esk=;
        b=tNmwpRZuaHLStjqX0aEUm5tDHUlRRrULbdY9uxds9/Z4Akj2FglSGNIxNOmdY4Be0l
         Qszy8YUzwrc0z7m65+KeJKajP+Nt9h1q2bRq1udVCLVsKqsXm6zK0ndRQEPCmzte0IgH
         qov1hWasZMPoJtkVpa7EUOypNBV03yO91fJwYmYC94f4gfUmsFEc75WZVJ5FqIX1IQay
         73MGmOA+wJhS05ZDPCjrqKIOvPqFOuZ2pnjw1ngm4pSSL3a7SI4Uil4TY61rwu+UsWb6
         5p0L92upFy0JrWWRmziVnMzxSynClYgT05xsrr6ZWu2apupgAhMqQQwkx7HumCYh9+zy
         0gRg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <6046140a-48fd-4c28-873c-44adb3bb479c@linaro.org>
Date: Tue, 3 Oct 2023 09:24:57 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/8] dt-bindings: reset: add Meson A1 reset bindings
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-2-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-2-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> Get this from Linux 6.6-rc3.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   .../reset/amlogic,meson-a1-reset.h            | 76 +++++++++++++++++++
>   1 file changed, 76 insertions(+)
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> new file mode 100644
> index 0000000000..2c749c655e
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices, Inc.
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
> +
> +/*	RESET0					*/
> +/*					0	*/
> +#define RESET_AM2AXI_VAD		1
> +/*					2-3	*/
> +#define RESET_PSRAM			4
> +#define RESET_PAD_CTRL			5
> +/*					6	*/
> +#define RESET_TEMP_SENSOR		7
> +#define RESET_AM2AXI_DEV		8
> +/*					9	*/
> +#define RESET_SPICC_A			10
> +#define RESET_MSR_CLK			11
> +#define RESET_AUDIO			12
> +#define RESET_ANALOG_CTRL		13
> +#define RESET_SAR_ADC			14
> +#define RESET_AUDIO_VAD			15
> +#define RESET_CEC			16
> +#define RESET_PWM_EF			17
> +#define RESET_PWM_CD			18
> +#define RESET_PWM_AB			19
> +/*					20	*/
> +#define RESET_IR_CTRL			21
> +#define RESET_I2C_S_A			22
> +/*					23	*/
> +#define RESET_I2C_M_D			24
> +#define RESET_I2C_M_C			25
> +#define RESET_I2C_M_B			26
> +#define RESET_I2C_M_A			27
> +#define RESET_I2C_PROD_AHB		28
> +#define RESET_I2C_PROD			29
> +/*					30-31	*/
> +
> +/*	RESET1					*/
> +#define RESET_ACODEC			32
> +#define RESET_DMA			33
> +#define RESET_SD_EMMC_A			34
> +/*					35	*/
> +#define RESET_USBCTRL			36
> +/*					37	*/
> +#define RESET_USBPHY			38
> +/*					39-41	*/
> +#define RESET_RSA			42
> +#define RESET_DMC			43
> +/*					44	*/
> +#define RESET_IRQ_CTRL			45
> +/*					46	*/
> +#define RESET_NIC_VAD			47
> +#define RESET_NIC_AXI			48
> +#define RESET_RAMA			49
> +#define RESET_RAMB			50
> +/*					51-52	*/
> +#define RESET_ROM			53
> +#define RESET_SPIFC			54
> +#define RESET_GIC			55
> +#define RESET_UART_C			56
> +#define RESET_UART_B			57
> +#define RESET_UART_A			58
> +#define RESET_OSC_RING			59
> +/*					60-63	*/
> +
> +/*	RESET2					*/
> +/*					64-95	*/
> +
> +#endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
