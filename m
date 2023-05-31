Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.10186.1685526410157109480
 for <u-boot-amlogic@groups.io>;
 Wed, 31 May 2023 02:46:50 -0700
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so41004165e9.1
        for <u-boot-amlogic@groups.io>; Wed, 31 May 2023 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685526408; x=1688118408;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xj2WSCt0dxsD+2utpqVdcqunaFeqqTfc/GtxH2LeNU0=;
        b=b+rVkvK+Wj4xSNlZuhzTZ9s/iB10M0cF/2ueLS50SNE4akm9x3Iw1Dwfgz0DbYxLXd
         eo0vCAf0Vyn7Z8LPBEdOjpE28KwPybP90FrtvjcLLeKR2S0DalMYNzXMhUvgQaieT5Ih
         AN6YEzsPzmUD9r64K8T7y5fNgpV8giJcE5zBkNeA7YQJQIRYCVzMr4ROQ+BWFj6t5bfH
         6N3j5sPhws/WQ4Ysnhruxf16YhwDyLZJw79sfNQ4msa/b9ZaikphJpBpakop9YECvDih
         efQfnqC2OdvdR6E0OiSQFU/xKkJcYMmbFN6JFc1wN1lHOnzBJlHFS/QJGY45x/wPqowg
         fXSw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <304ed72e-d2cb-cde1-2f7e-130f0398cf09@linaro.org>
Date: Wed, 31 May 2023 11:46:47 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] dt-bindings: power: add Meson A1 PWRC bindings
References: <20230531093156.29240-1-avromanov@sberdevices.ru>
 <20230531093156.29240-3-avromanov@sberdevices.ru>
In-Reply-To: <20230531093156.29240-3-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@sberdevices.ru>, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 31/05/2023 11:31, Alexey Romanov wrote:
> We can use them in secure pwrc driver.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   include/dt-bindings/power/meson-a1-power.h | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 include/dt-bindings/power/meson-a1-power.h
> 
> diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindings/power/meson-a1-power.h
> new file mode 100644
> index 00000000000..8e39dfc0b62
> --- /dev/null
> +++ b/include/dt-bindings/power/meson-a1-power.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + * Author: Alexey Romanov <avromanov@sberdevices.ru>
> + */
> +
> +#ifndef _DT_BINDINGS_MESON_A1_POWER_H
> +#define _DT_BINDINGS_MESON_A1_POWER_H
> +
> +#define PWRC_DSPA_ID	8
> +#define PWRC_DSPB_ID	9
> +#define PWRC_UART_ID	10
> +#define PWRC_DMC_ID	11
> +#define PWRC_I2C_ID	12
> +#define PWRC_PSRAM_ID	13
> +#define PWRC_ACODEC_ID	14
> +#define PWRC_AUDIO_ID	15
> +#define PWRC_OTP_ID	16
> +#define PWRC_DMA_ID	17
> +#define PWRC_SD_EMMC_ID	18
> +#define PWRC_RAMA_ID	19
> +#define PWRC_RAMB_ID	20
> +#define PWRC_IR_ID	21
> +#define PWRC_SPICC_ID	22
> +#define PWRC_SPIFC_ID	23
> +#define PWRC_USB_ID	24
> +#define PWRC_NIC_ID	25
> +#define PWRC_PDMIN_ID	26
> +#define PWRC_RSA_ID	27
> +#define PWRC_MAX_ID	28
> +
> +#endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
