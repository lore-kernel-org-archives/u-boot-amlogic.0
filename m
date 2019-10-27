Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.507.1572198494073119657
 for <u-boot-amlogic@groups.io>;
 Sun, 27 Oct 2019 10:48:14 -0700
Received: by mail-wr1-f68.google.com with SMTP id n15so7477977wrw.13
        for <u-boot-amlogic@groups.io>; Sun, 27 Oct 2019 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iERJ2P5FIV17zBMoekP5ghEf+/FM3j8+thScOVaGFyI=;
        b=MzybMq1jFvcann2SnqzofseQBuwyQ+y0j2NRdj1TBP01WlIHtfBs+20rrxCP5pyc+F
         XUrDmgcJpKH5oZRLjN/wNdXcttKo/hbiAqsXxzPeTqq7Uz5CuxuwEm4CVwWFlkdwC5z+
         jr5JULSoHaCvzYKvNbLRYtlpp1Le840HD69Bppky98VsSBMsVCK4wjeULq30VZW0BaT8
         7QJ+CfzBCjWlD3kEJGx1xdwi5wZytWSb/kqjpWWrieiX4Aao3ENEgjecYCbKKhGLLIDM
         g02fZOxf1x5WYguuKyBEXYUT7crjtYxCGjl11NNtRF+4qumTnIXP786Ob4mdVtESPlpJ
         19FA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 23/30] video: meson: Drop unnecessary header includes
References: <20191027155410.187957-1-sjg@chromium.org>
 <20191027155410.187957-23-sjg@chromium.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <aa3e6b42-a3f6-bbe1-4d66-02aa1597a2cf@baylibre.com>
Date: Sun, 27 Oct 2019 18:48:10 +0100
MIME-Version: 1.0
In-Reply-To: <20191027155410.187957-23-sjg@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 27/10/2019 16:54, Simon Glass wrote:
> These files should not be included in meson header files. Drop them and
> tidy up the affected C files.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  drivers/video/meson/meson_canvas.c   |  4 ++++
>  drivers/video/meson/meson_plane.c    |  5 +++++
>  drivers/video/meson/meson_vclk.c     |  2 ++
>  drivers/video/meson/meson_venc.c     |  4 ++++
>  drivers/video/meson/meson_vpu.c      | 18 +++++++++++++++---
>  drivers/video/meson/meson_vpu.h      | 17 +++++------------
>  drivers/video/meson/meson_vpu_init.c |  4 ++++
>  include/video.h                      |  2 ++
>  8 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/meson/meson_canvas.c b/drivers/video/meson/meson_canvas.c
> index b71cbfcc0b..eccac2f8f2 100644
> --- a/drivers/video/meson/meson_canvas.c
> +++ b/drivers/video/meson/meson_canvas.c
> @@ -6,6 +6,10 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> +#include <common.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +
>  #include "meson_vpu.h"
>  
>  /* DMC Registers */
> diff --git a/drivers/video/meson/meson_plane.c b/drivers/video/meson/meson_plane.c
> index 2bc9327e1e..8edf451f13 100644
> --- a/drivers/video/meson/meson_plane.c
> +++ b/drivers/video/meson/meson_plane.c
> @@ -6,6 +6,11 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> +#include <common.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +
>  #include "meson_vpu.h"
>  
>  /* OSDx_BLKx_CFG */
> diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
> index 0f628e920b..01bfa4bcb8 100644
> --- a/drivers/video/meson/meson_vclk.c
> +++ b/drivers/video/meson/meson_vclk.c
> @@ -6,6 +6,8 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> +#include <common.h>
> +#include <dm.h>
>  #include <edid.h>
>  #include "meson_vpu.h"
>  #include <linux/iopoll.h>
> diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
> index 5da4b3f096..89e859b02a 100644
> --- a/drivers/video/meson/meson_venc.c
> +++ b/drivers/video/meson/meson_venc.c
> @@ -6,7 +6,11 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> +#include <common.h>
> +#include <dm.h>
>  #include <edid.h>
> +#include <fdtdec.h>
> +#include <asm/io.h>
>  #include "meson_vpu.h"
>  
>  enum {
> diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
> index c3af9b013c..4eb66398d0 100644
> --- a/drivers/video/meson/meson_vpu.c
> +++ b/drivers/video/meson/meson_vpu.c
> @@ -6,13 +6,17 @@
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   */
>  
> -#include "meson_vpu.h"
> +#include <common.h>
> +#include <display.h>
> +#include <dm.h>
>  #include <efi_loader.h>
> -#include <dm/device-internal.h>
> -#include <dm/uclass-internal.h>
>  #include <fdt_support.h>
>  #include <linux/sizes.h>
>  #include <asm/arch/mem.h>
> +#include <dm/device-internal.h>
> +#include <dm/uclass-internal.h>
> +
> +#include "meson_vpu.h"
>  #include "meson_registers.h"
>  #include "simplefb_common.h"
>  
> @@ -27,6 +31,14 @@ static struct meson_framebuffer {
>  	bool is_cvbs;
>  } meson_fb = { 0 };
>  
> +bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
> +			     enum vpu_compatible family)
> +{
> +	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
> +
> +	return compat == family;
> +}
> +
>  static int meson_vpu_setup_mode(struct udevice *dev, struct udevice *disp)
>  {
>  	struct video_uc_platdata *uc_plat = dev_get_uclass_platdata(dev);
> diff --git a/drivers/video/meson/meson_vpu.h b/drivers/video/meson/meson_vpu.h
> index 0d9fddad2e..d9588c3775 100644
> --- a/drivers/video/meson/meson_vpu.h
> +++ b/drivers/video/meson/meson_vpu.h
> @@ -9,14 +9,12 @@
>  #ifndef __MESON_VPU_H__
>  #define __MESON_VPU_H__
>  
> -#include <common.h>
> -#include <dm.h>
>  #include <video.h>
> -#include <display.h>
> -#include <linux/io.h>
> -#include <linux/bitfield.h>
>  #include "meson_registers.h"
>  
> +struct display_timing;
> +struct udevice;
> +
>  enum {
>  	/* Maximum size we support */
>  	VPU_MAX_WIDTH		= 3840,
> @@ -38,13 +36,8 @@ struct meson_vpu_priv {
>  	void __iomem *dmc_base;
>  };
>  
> -static inline bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
> -					   enum vpu_compatible family)
> -{
> -	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
> -
> -	return compat == family;
> -}
> +bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
> +			     enum vpu_compatible family);
>  
>  #define hhi_update_bits(offset, mask, value) \
>  	writel_bits(mask, value, priv->hhi_base + offset)
> diff --git a/drivers/video/meson/meson_vpu_init.c b/drivers/video/meson/meson_vpu_init.c
> index 12f8c4194a..8408c59eaa 100644
> --- a/drivers/video/meson/meson_vpu_init.c
> +++ b/drivers/video/meson/meson_vpu_init.c
> @@ -8,6 +8,10 @@
>  
>  #define DEBUG
>  
> +#include <common.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +
>  #include "meson_vpu.h"
>  
>  /* HHI Registers */
> diff --git a/include/video.h b/include/video.h
> index 485071d072..e7c58e86cb 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -17,6 +17,8 @@
>  
>  #include <stdio_dev.h>
>  
> +struct udevice;
> +
>  struct video_uc_platdata {
>  	uint align;
>  	uint size;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
