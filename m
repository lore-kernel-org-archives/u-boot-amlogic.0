Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C92CF58FC
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 09:27:38 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.5141.1726480921982517404
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 03:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=n8gFFElo;
 spf=pass (domain: linaro.org, ip: 209.85.215.179, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db4f323b12so599843a12.1
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726480921; x=1727085721; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUNCq/Bym/5pya1wBmlxBtW7izxYsMhCT+/QGvBsK0Y=;
        b=n8gFFElov/S2dbZaV6hMBz3XJ/QTV1NW8QzC2prkY1b1gwL2lpACLvHYOM2D1GMg5t
         ok6uD45pIwKWShdK/ByUIScX1tpDXfn0HPAj2XYS/F1icjgRHfBJ4xFYksZJfK1QhP6B
         vJogtxShVRG8GTDRi5F7hX0qQKX+Ze0n2mcVZRH0HLJnb8BZw/F+UAF/puZ9IVmWDPG8
         Ouu4Gb+9T9g03hQHFdkw8fme0CcAKfig9hzS4Wnsjvz4De9z16GEEe8z7B7TbG4imrqW
         pl/Y0yM+3lR3fJdh1afVqceu3eWIqr3zOkH1tXhJlFi8c80QeQ+swy5VhmQ7WIQN/h/n
         E3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726480921; x=1727085721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUNCq/Bym/5pya1wBmlxBtW7izxYsMhCT+/QGvBsK0Y=;
        b=hX0X1ArzXvbfleV8jc1GtH6mVogoTgErL16Q2zudUGDGnJrcwLEKuJHAdIFwy3pdVR
         nXDCA6G+iWQ3Rp7R4nw+qjIjChaIN27qK9Kqkr10swid3NBCstlM0tyNdN/zjVmeAoid
         65Hq2QD05EVdhVzpZzWJ8pgkH9+TjK1ZCcfEmBjtARwUf93KG9+po93A9Gu0cBhVTDrh
         aVX5vXxIv3oDZwg/t/YYrCyOGWE9awaRS6949E1LrZNaOSlznmNCLrfg9Jkk9ueaW6Of
         tv5pfz9E0FjSew08Ca0B3XfeOooSZHZ75BB1Ps3sKIVVXM92HWPXBkgPuBwM2c31JIL+
         rnDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDBb7lD7lCO9RCePaz+1BhnbY+yrf2vOP0bXOtl0aWBnedV2RS6guMhQkdC8bWDgo8jg3kF3A93U9cxcBh+A==@groups.io
X-Gm-Message-State: AOJu0YzRAGicwiLeDLxIqMJs5v3lClKk1iDIugtBjo8O7ehoPX90QWjq
	Gn9/RrZpVbWjpDlDg/JVBhVRNgBzRxcmaB6zsQhK20B7yBA3+tlYIvEEA6xwjmLAVf8AOVu56FF
	qL2rAX/LA1/7aEj+qKJXboooSRZrvfFQVrESAdQ==
X-Google-Smtp-Source: AGHT+IFI/NIjPOYkJHDsBH99WqZFOUC66wqvtzLeCntW55cBlLranQhWHIKOYkB2a3CZLqO8kEeFrVrg8on1XnysCv4=
X-Received: by 2002:a17:90a:890d:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2dba0093514mr15158197a91.41.1726480921169; Mon, 16 Sep 2024
 03:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org> <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Sep 2024 13:01:25 +0300
Message-ID: <CAC_iWjLY3V=CGFDzXv38r0_oZjhMC5T=hzxHNDCEbULw0Q_FuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: libre-computer: aml-s805-cc: Enable capsule updates
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
	Da Xue <da@libre.computer>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:27:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2398

Thanks Neil!

On Mon, 16 Sept 2024 at 12:41, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Since the aml-s805-cc works well using EFI, and now the capsule updates
> backend has been merged, let's enable the missing configs and add
> the required structures to support it.
>
> The GUID is dynamically generated for the board, to get it:
> => efidebug capsule esrt
> ========================================
> ESRT: fw_resource_count=1
> ESRT: fw_resource_count_max=1
> ESRT: fw_resource_version=1
> [entry 0]==============================
> ESRT: fw_class=B8079027-9B2C-57D4-86AA-CC782ADA598C
> ESRT: fw_type=unknown
> ESRT: fw_version=0
> ESRT: lowest_supported_fw_version=0
> ESRT: capsule_flags=0
> ESRT: last_attempt_version=0
> ESRT: last_attempt_status=success
> ========================================
>
> On the host (with the aml_encrypt_gxl result binary):
> $ eficapsule --guid B8079027-9B2C-57D4-86AA-CC782ADA598C -i 1 u-boot.bin u-boot.cap
>
> On the board (from USB disk containing u-boot.cap at root):
> => load usb 0:1 $kernel_addr_r u-boot.cap
> => efidebug capsule update $kernel_addr_r
>
> The binary will then be flashed on the SPI.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 14 ++++++++++++++
>  configs/libretech-ac_defconfig                   |  5 +++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> index ae9834c0bf8..ba14df54967 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -8,6 +8,7 @@
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> +#include <efi_loader.h>
>  #include <asm/io.h>
>  #include <asm/arch/gx.h>
>  #include <asm/arch/sm.h>
> @@ -19,6 +20,19 @@
>  #define EFUSE_MAC_OFFSET       52
>  #define EFUSE_MAC_SIZE         6
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .fw_name = u"AML_S805X_AC_BOOT",
> +               .image_index = 1,
> +       },
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
>  int misc_init_r(void)
>  {
>         u8 mac_addr[EFUSE_MAC_SIZE + 1];
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index 11d9795e05d..f146a495654 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -35,6 +35,7 @@ CONFIG_SYS_MAXARGS=32
>  # CONFIG_CMD_IMI is not set
>  CONFIG_CMD_ADC=y
>  CONFIG_CMD_DFU=y
> +CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_GPIO=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> @@ -42,6 +43,7 @@ CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_EFIDEBUG=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
> @@ -49,6 +51,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SARADC_MESON=y
>  CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_MTD=y
> @@ -98,3 +101,5 @@ CONFIG_VIDEO_BMP_RLE8=y
>  CONFIG_BMP_16BPP=y
>  CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

