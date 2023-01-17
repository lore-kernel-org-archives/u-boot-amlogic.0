Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.192438.1673948639102648090
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jan 2023 01:43:59 -0800
Received: by mail-wm1-f52.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2583725wms.4
        for <u-boot-amlogic@groups.io>; Tue, 17 Jan 2023 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA+r2d2VvGC2iSgTK8AKD1qTgcdgGDpMaBnjMbAUTPM=;
        b=735Ct0A2HbWEzcwoZI2U3l1DX1uspvxxQQRYPA+ZAjjSm3u4tFveRQAcykrWXJZqJ+
         CdaFB1XTWS2JQnOP4nfce8KkfEOCLFnS4tjEVcByvkERvAbOylawgs9BeDLgpTf6z7CS
         fkZ+TpWGX6Ewm39RDAfGgIeQWPMxNKfjunjEIDMwAWtF3D7Kp9+vJI6gwaDLz2/ImjcV
         uMpmngYfKZ6zW/Myp3m8JBEIPziLpg6eLdQ1fCVc0qfIOusnr2jH/C+h+WhJlumFxqcz
         wGwpPXivDRJwgMqX8WhKMwq0ftk8xUD7CqUrMcgmn/s63r9XnC7Z7djvER2EcZK2BCsk
         cdhQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 2/2] ARM: meson: switch AXG & GX dwc2 otg to DM
In-Reply-To: <20230117-u-boot-usb-gxl-otg-dm-v1-2-2853f6d75b06@linaro.org>
References: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
 <20230117-u-boot-usb-gxl-otg-dm-v1-2-2853f6d75b06@linaro.org>
Date: Tue, 17 Jan 2023 10:43:56 +0100
Message-ID: <87r0vtmr6r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Jan 17, 2023 at 10:11, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> With CONFIG_DM_USB_GADGET=y, we no longer need any board_usb_*() logic
> because:
> * the dwc2 driver is DM compatible, and handles its own clock enabling
> * the dwc3-meson-gxl glue drivers handles "force mode switching"
>
> Remove all mach-meson gx & axg usb code and enable CONFIG_DM_USB_GADGET.
>
> Note: Only configs having both CONFIG_USB_DWC3_MESON_GXL=y *and*
>       USB_GADGET_DWC2_OTG=y have been updated.
>
> Thanks for the original work from Mattijs at [1]
>
> [1] https://lore.kernel.org/all/20221024-meson-dm-usb-v1-2-2ab077a503b9@baylibre.com/
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/arm/mach-meson/board-axg.c      | 129 ---------------------------------
>  arch/arm/mach-meson/board-gx.c       | 137 -----------------------------------
>  configs/jethub_j100_defconfig        |   1 +
>  configs/jethub_j80_defconfig         |   1 +
>  configs/khadas-vim2_defconfig        |   1 +
>  configs/khadas-vim_defconfig         |   1 +
>  configs/libretech-ac_defconfig       |   1 +
>  configs/libretech-cc_defconfig       |   1 +
>  configs/libretech-s905d-pc_defconfig |   1 +
>  configs/libretech-s912-pc_defconfig  |   1 +
>  configs/s400_defconfig               |   1 +
>  configs/wetek-core2_defconfig        |   1 +
>  12 files changed, 10 insertions(+), 266 deletions(-)
>
> diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
> index 236ec81579..fdf18752cd 100644
> --- a/arch/arm/mach-meson/board-axg.c
> +++ b/arch/arm/mach-meson/board-axg.c
> @@ -15,12 +15,6 @@
>  #include <asm/io.h>
>  #include <asm/armv8/mmu.h>
>  #include <linux/sizes.h>
> -#include <usb.h>
> -#include <linux/usb/otg.h>
> -#include <asm/arch/usb-gx.h>
> -#include <usb/dwc2_udc.h>
> -#include <clk.h>
> -#include <phy.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -90,126 +84,3 @@ static struct mm_region axg_mem_map[] = {
>  };
>  
>  struct mm_region *mem_map = axg_mem_map;
> -
> -#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
> -	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> -static struct dwc2_plat_otg_data meson_gx_dwc2_data;
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -	struct fdtdec_phandle_args args;
> -	const void *blob = gd->fdt_blob;
> -	int node, dwc2_node;
> -	struct udevice *dev, *clk_dev;
> -	struct clk clk;
> -	int ret;
> -
> -	/* find the usb glue node */
> -	node = fdt_node_offset_by_compatible(blob, -1,
> -					     "amlogic,meson-axg-usb-ctrl");
> -	if (node < 0) {
> -		debug("Not found usb-control node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, node)) {
> -		debug("usb is disabled in the device tree\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> -	if (ret) {
> -		debug("Not found usb-control device\n");
> -		return ret;
> -	}
> -
> -	/* find the dwc2 node */
> -	dwc2_node = fdt_node_offset_by_compatible(blob, node,
> -						  "amlogic,meson-g12a-usb");
> -	if (dwc2_node < 0) {
> -		debug("Not found dwc2 node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
> -		debug("dwc2 is disabled in the device tree\n");
> -		return -ENODEV;
> -	}
> -
> -	meson_gx_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
> -	if (meson_gx_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
> -		debug("usbotg: can't get base address\n");
> -		return -ENODATA;
> -	}
> -
> -	/* Enable clock */
> -	ret = fdtdec_parse_phandle_with_args(blob, dwc2_node, "clocks",
> -					     "#clock-cells", 0, 0, &args);
> -	if (ret) {
> -		debug("usbotg has no clocks defined in the device tree\n");
> -		return ret;
> -	}
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_CLK, args.node, &clk_dev);
> -	if (ret)
> -		return ret;
> -
> -	if (args.args_count != 1) {
> -		debug("Can't find clock ID in the device tree\n");
> -		return -ENODATA;
> -	}
> -
> -	clk.dev = clk_dev;
> -	clk.id = args.args[0];
> -
> -	ret = clk_enable(&clk);
> -	if (ret) {
> -		debug("Failed to enable usbotg clock\n");
> -		return ret;
> -	}
> -
> -	meson_gx_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -						     "g-rx-fifo-size", 0);
> -	meson_gx_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -							"g-np-tx-fifo-size", 0);
> -	meson_gx_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -						     "g-tx-fifo-size", 0);
> -
> -	/* Switch to peripheral mode */
> -	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_PERIPHERAL);
> -	if (ret)
> -		return ret;
> -
> -	return dwc2_udc_probe(&meson_gx_dwc2_data);
> -}
> -
> -int board_usb_cleanup(int index, enum usb_init_type init)
> -{
> -	const void *blob = gd->fdt_blob;
> -	struct udevice *dev;
> -	int node;
> -	int ret;
> -
> -	/* find the usb glue node */
> -	node = fdt_node_offset_by_compatible(blob, -1,
> -					     "amlogic,meson-axg-usb-ctrl");
> -	if (node < 0) {
> -		debug("Not found usb-control node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, node))
> -		return -ENODEV;
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> -	if (ret)
> -		return ret;
> -
> -	/* Switch to OTG mode */
> -	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_HOST);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -#endif
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index 01fafd81c4..f28f84d86f 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -16,12 +16,6 @@
>  #include <asm/io.h>
>  #include <asm/armv8/mmu.h>
>  #include <linux/sizes.h>
> -#include <usb.h>
> -#include <linux/usb/otg.h>
> -#include <asm/arch/usb-gx.h>
> -#include <usb/dwc2_udc.h>
> -#include <clk.h>
> -#include <phy.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -108,134 +102,3 @@ static struct mm_region gx_mem_map[] = {
>  };
>  
>  struct mm_region *mem_map = gx_mem_map;
> -
> -#if CONFIG_IS_ENABLED(USB_DWC3_MESON_GXL) && \
> -	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> -static struct dwc2_plat_otg_data meson_gx_dwc2_data;
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -	struct fdtdec_phandle_args args;
> -	const void *blob = gd->fdt_blob;
> -	int node, dwc2_node;
> -	struct udevice *dev, *clk_dev;
> -	struct clk clk;
> -	int ret;
> -
> -	/* find the usb glue node */
> -	node = fdt_node_offset_by_compatible(blob, -1,
> -					     "amlogic,meson-gxl-usb-ctrl");
> -	if (node < 0) {
> -		node = fdt_node_offset_by_compatible(blob, -1,
> -					"amlogic,meson-gxm-usb-ctrl");
> -		if (node < 0) {
> -			debug("Not found usb-control node\n");
> -			return -ENODEV;
> -		}
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, node)) {
> -		debug("usb is disabled in the device tree\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> -	if (ret) {
> -		debug("Not found usb-control device\n");
> -		return ret;
> -	}
> -
> -	/* find the dwc2 node */
> -	dwc2_node = fdt_node_offset_by_compatible(blob, node,
> -						  "amlogic,meson-g12a-usb");
> -	if (dwc2_node < 0) {
> -		debug("Not found dwc2 node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
> -		debug("dwc2 is disabled in the device tree\n");
> -		return -ENODEV;
> -	}
> -
> -	meson_gx_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
> -	if (meson_gx_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
> -		debug("usbotg: can't get base address\n");
> -		return -ENODATA;
> -	}
> -
> -	/* Enable clock */
> -	ret = fdtdec_parse_phandle_with_args(blob, dwc2_node, "clocks",
> -					     "#clock-cells", 0, 0, &args);
> -	if (ret) {
> -		debug("usbotg has no clocks defined in the device tree\n");
> -		return ret;
> -	}
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_CLK, args.node, &clk_dev);
> -	if (ret)
> -		return ret;
> -
> -	if (args.args_count != 1) {
> -		debug("Can't find clock ID in the device tree\n");
> -		return -ENODATA;
> -	}
> -
> -	clk.dev = clk_dev;
> -	clk.id = args.args[0];
> -
> -	ret = clk_enable(&clk);
> -	if (ret) {
> -		debug("Failed to enable usbotg clock\n");
> -		return ret;
> -	}
> -
> -	meson_gx_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -						     "g-rx-fifo-size", 0);
> -	meson_gx_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -							"g-np-tx-fifo-size", 0);
> -	meson_gx_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> -						     "g-tx-fifo-size", 0);
> -
> -	/* Switch to peripheral mode */
> -	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_PERIPHERAL);
> -	if (ret)
> -		return ret;
> -
> -	return dwc2_udc_probe(&meson_gx_dwc2_data);
> -}
> -
> -int board_usb_cleanup(int index, enum usb_init_type init)
> -{
> -	const void *blob = gd->fdt_blob;
> -	struct udevice *dev;
> -	int node;
> -	int ret;
> -
> -	/* find the usb glue node */
> -	node = fdt_node_offset_by_compatible(blob, -1,
> -					     "amlogic,meson-gxl-usb-ctrl");
> -	if (node < 0) {
> -		node = fdt_node_offset_by_compatible(blob, -1,
> -					"amlogic,meson-gxm-usb-ctrl");
> -		if (node < 0) {
> -			debug("Not found usb-control node\n");
> -			return -ENODEV;
> -		}
> -	}
> -
> -	if (!fdtdec_get_is_enabled(blob, node))
> -		return -ENODEV;
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> -	if (ret)
> -		return ret;
> -
> -	/* Switch to OTG mode */
> -	ret = dwc3_meson_gxl_force_mode(dev, USB_DR_MODE_HOST);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -#endif
> diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
> index c2651580f8..dac775bd3b 100644
> --- a/configs/jethub_j100_defconfig
> +++ b/configs/jethub_j100_defconfig
> @@ -55,6 +55,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC2=y
> diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
> index f3c47a001a..1d11a961b9 100644
> --- a/configs/jethub_j80_defconfig
> +++ b/configs/jethub_j80_defconfig
> @@ -59,6 +59,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC2=y
> diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
> index a8d11a83c9..3af6b446ec 100644
> --- a/configs/khadas-vim2_defconfig
> +++ b/configs/khadas-vim2_defconfig
> @@ -59,6 +59,7 @@ CONFIG_MESON_SPIFC=y
>  CONFIG_SYSINFO=y
>  CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
> index d1ed45ff88..6bb2200a6b 100644
> --- a/configs/khadas-vim_defconfig
> +++ b/configs/khadas-vim_defconfig
> @@ -50,6 +50,7 @@ CONFIG_MESON_SERIAL=y
>  CONFIG_SYSINFO=y
>  CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index a333106692..2f44771a84 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -65,6 +65,7 @@ CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
> index 60b40e6270..05311d8e08 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -49,6 +49,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
> index d3e600ec02..4e3aee7542 100644
> --- a/configs/libretech-s905d-pc_defconfig
> +++ b/configs/libretech-s905d-pc_defconfig
> @@ -61,6 +61,7 @@ CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
> index 8b4f052d08..c9ceb35ff6 100644
> --- a/configs/libretech-s912-pc_defconfig
> +++ b/configs/libretech-s912-pc_defconfig
> @@ -60,6 +60,7 @@ CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_MESON_SPIFC=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/s400_defconfig b/configs/s400_defconfig
> index 827bd548c7..91930d7f48 100644
> --- a/configs/s400_defconfig
> +++ b/configs/s400_defconfig
> @@ -42,6 +42,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
> index 13940dd56f..b730700630 100644
> --- a/configs/wetek-core2_defconfig
> +++ b/configs/wetek-core2_defconfig
> @@ -51,6 +51,7 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
>  CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>
> -- 
> 2.34.1
