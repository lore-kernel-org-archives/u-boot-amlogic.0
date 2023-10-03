Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.102952.1696317868210287719
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:24:28 -0700
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso646641f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317866; x=1696922666; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqOarbBAHVYROdznDeCSbHW2kcf1Z7RIdFBA5ve+RkE=;
        b=HYkQ28y3Vu3PVDkpO49uf4IxXpXFO7WMa6B7g5DBxTRjPkVtkda4GG3qj7LNSMROdQ
         63+CyCm0OMXBENp/hzN9mXWbFBFzeteOinbrcloT5Z0Fd2AABrx1LKJxwSKaEYCC8SKu
         getjmUvh9tXkKnEqXlDK2EGvlntkS+w1GZL6g8r1GC+agoMJX1BOvkGW+zN6yxhndPpo
         R+STcbBK1HRpbXGbQohrhxVRH4G2mauT7jFwzFhkX/Bwixz1+YOHmgjc3DvqvBnO4kw7
         qQMEyj3TTqUvBe8qbtoVf9ON8wlDzT9LZxJPaFVk3VopYHhDPX35iWKMrm0MTMddHmFB
         6IWQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <da5f0733-7a53-4878-9b68-01b3c3e040a6@linaro.org>
Date: Tue, 3 Oct 2023 09:24:24 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 8/8] arch: a1: introduce USB initialization functionality
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-9-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-9-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 02/10/2023 18:58, Alexey Romanov wrote:
> This is entrypoint for USB stack initialization. Function
> board_usb_init will be called from cmd/fastboot.c code.

This should not be needed anymore, using DM_USB_GADGET should work,
look how it was changed for G12A/SM1 and GXL/AXG:
https://lore.kernel.org/all/20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com
and
https://lore.kernel.org/all/20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org

Neil

> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   arch/arm/mach-meson/board-a1.c | 89 ++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
> index 967bb67182..781d5cfb33 100644
> --- a/arch/arm/mach-meson/board-a1.c
> +++ b/arch/arm/mach-meson/board-a1.c
> @@ -4,12 +4,17 @@
>    */
>   
>   #include <common.h>
> +#include <dm.h>
> +#include <usb.h>
>   #include <asm/arch/a1.h>
>   #include <asm/arch/boot.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/io.h>
>   #include <linux/compiler.h>
>   #include <linux/sizes.h>
> +#include <linux/usb/otg.h>
> +#include <asm/arch/usb.h>
> +#include <usb/dwc2_udc.h>
>   
>   phys_size_t get_effective_memsize(void)
>   {
> @@ -57,3 +62,87 @@ static struct mm_region a1_mem_map[] = {
>   };
>   
>   struct mm_region *mem_map = a1_mem_map;
> +
> +#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
> +	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +
> +static struct dwc2_plat_otg_data meson_a1_dwc2_data;
> +
> +int board_usb_init(int index, enum usb_init_type init)
> +{
> +	int node, dwc2_node;
> +	const void *blob = gd->fdt_blob;
> +	struct udevice *dev;
> +	int ret;
> +
> +	node = fdt_node_offset_by_compatible(blob, -1,
> +					     "amlogic,meson-a1-usb-ctrl");
> +	if (node < 0) {
> +		pr_err("not found usb-control node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, node)) {
> +		pr_err("usb is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> +	if (ret) {
> +		pr_err("not found usb-control device\n");
> +		return ret;
> +	}
> +
> +	dwc2_node = fdt_node_offset_by_compatible(blob, node,
> +						  "amlogic,meson-a1-usb");
> +	if (dwc2_node < 0) {
> +		pr_err("not found dwc2 node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
> +		pr_err("dwc2 is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	meson_a1_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
> +	if (meson_a1_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
> +		pr_err("can't get base address\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-rx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.rx_fifo_sz < 0) {
> +		pr_err("failed to get g-rx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-np-tx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.np_tx_fifo_sz < 0) {
> +		pr_err("failed to get g-np-tx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-tx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.tx_fifo_sz < 0) {
> +		pr_err("failed to get g-tx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
> +	if (ret) {
> +		pr_err("failed to force usb mode to peripheral\n");
> +		return ret;
> +	}
> +
> +	return dwc2_udc_probe(&meson_a1_dwc2_data);
> +}
> +
> +int board_usb_cleanup(int index, enum usb_init_type init)
> +{
> +	return 0;
> +}
> +#endif

