Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.15126.1589119738395462369
 for <u-boot-amlogic@groups.io>;
 Sun, 10 May 2020 07:08:58 -0700
Received: by mail-wr1-f66.google.com with SMTP id y3so7563499wrt.1
        for <u-boot-amlogic@groups.io>; Sun, 10 May 2020 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1afxX8QlHNSOt4uPTFvuobe8vfkQZTYSqfvWDNAbo/g=;
        b=o9xvUkcQZ2cJtx55dqor1h8YM+nVMW07Wm6mU+0z4oMIGCWS3D+/HV2cypmNGYnlUO
         BDWcDuOVhLbBbcJqqHZVyOEEtjUuQFe8TJkf5j29AjBynnmcr07hvVMLOeHY8j7UaBf8
         3Pdd9OVLypzN3QBvbQNvWR9rKkMxA0Zyupr+dnvbfr6ODzbI5akhRpoLJepxVRFBd5dt
         Z3GQqhnSSJv5ZgMEuORuuIQ5ufytAv0OO6cgDRbPQ7RtMd3z/WXs1wWWHr0DiUWvJdpS
         wnte8hvnHGggrgpHY5C+MxGSNKb1CaGtiGpigB4xCg/Vu44al+HDJUTCpewiymAex/tK
         vV0g==
Return-Path: <b.galvani@gmail.com>
Date: Sun, 10 May 2020 16:08:29 +0200
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH 2/2] odroid-c2: enable USB host controller
Message-ID: <20200510140829.GA1602@gmail.com>
References: <20190818134255.7135-1-b.galvani@gmail.com>
 <20190818134255.7135-3-b.galvani@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190818134255.7135-3-b.galvani@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Sun, Aug 18, 2019 at 03:42:55PM +0200, Beniamino Galvani wrote:
> Enable the second USB controller, which is connected to a hub with 4
> ports. The first controller is for the OTG port and is currently not
> supported.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi | 8 ++++++++
>  configs/odroid-c2_defconfig                  | 7 +++++++
>  include/configs/meson64.h                    | 5 +++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> index c35158d7e9..484b40504d 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> @@ -5,3 +5,11 @@
>   */
>  
>  #include "meson-gx-u-boot.dtsi"
> +
> +&usb0 {
> +	status = "disabled";
> +};
> +
> +&usb1 {
> +	hnp-srp-disable;
> +};
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 8849058d33..366ea125af 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -16,6 +16,7 @@ CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_OF_CONTROL=y
> @@ -29,13 +30,19 @@ CONFIG_MMC_MESON_GX=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_DM_ETH=y
>  CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY=y
> +CONFIG_MESON_GXBB_USB_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_GXBB=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_DM_RESET=y
>  CONFIG_DEBUG_UART_MESON=y
>  CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_DEBUG_UART_SKIP_INIT=y
>  CONFIG_MESON_SERIAL=y
> +CONFIG_USB=y
> +CONFIG_DM_USB=y
> +CONFIG_USB_DWC2=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index f8d3eee292..483a8f567c 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -16,6 +16,11 @@
>  #define GICC_BASE			0xc4302000
>  #endif
>  
> +/* USB */
> +#if defined(CONFIG_MESON_GXBB)
> +#define CONFIG_DWC2_UTMI_WIDTH		16
> +#endif

Hi Neil,

I noticed this change to the bus width configuration isn't actually
needed. The USB port works with or without it. The kernel driver
doesn't set 16bit mode, so can you please remove these 4 lines from
the commit before sending the pull request?

Thanks,
Beniamino
