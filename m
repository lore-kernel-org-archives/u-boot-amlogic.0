Received: by mail-wr1-f66.google.com with SMTP id f14so18685995wrj.5
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1T5QD3ukLdsgrsnOy0pTSc5xe5zCI0VnFAAz9Nz++nY=;
        b=zLBEuT/BuVkWIcbld1/y/+uJK6xiBIutfUn22/SUdVbhbuK3UGNsdsqXjfSWkmicSY
         UFvEAWO1z0aze3kPhCQsMxhDdMhMsgzCmdUw5zC4bo0CBJawT/Yx4KvFs8WtvSmeeezm
         7FlM4qZqWBx2Rs/jwWcH6yn1IVzxUw/xGgC7K/n7ihbd59hk+leU+5Xjq5QZ4TCbTkHl
         h+IeEGVxN3OK83hlU6u0aqmdYrjygJtJlPzs7WXgSY4d8fHiYQHg3dviLQ2ozz3vh00c
         m15uAOpKBlckpEUTUtsRL0Gq+vM+d2VVz8S0QMGPmLYmrIx7JwGA5RhXZxivnld9joOw
         2KUg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: enable PHY_REALTEK for selected boards
References: <20190410144609.1091-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8db86eec-ea14-3d16-6a97-faf4069a4d65@baylibre.com>
Date: Tue, 23 Apr 2019 11:29:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190410144609.1091-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/04/2019 16:46, Neil Armstrong wrote:
> When using the generic PHY on boards using an RGMII Realtek PHY,
> gigabit speed is not always reliable.
> 
> This patch enables the Realtek PHY driver for such boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  configs/khadas-vim2_defconfig | 1 +
>  configs/nanopi-k2_defconfig   | 1 +
>  configs/odroid-c2_defconfig   | 1 +
>  configs/s400_defconfig        | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
> index 080dd19590..f7fb9338e2 100644
> --- a/configs/khadas-vim2_defconfig
> +++ b/configs/khadas-vim2_defconfig
> @@ -31,6 +31,7 @@ CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_ETH=y
>  CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY_REALTEK=y
>  CONFIG_PHY=y
>  CONFIG_MESON_GXL_USB_PHY=y
>  CONFIG_PINCTRL=y
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 8bbf48f41f..106c5c0193 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -28,6 +28,7 @@ CONFIG_DM_MMC=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_DM_ETH=y
>  CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY_REALTEK=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_GXBB=y
>  CONFIG_DM_REGULATOR=y
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 747da184b3..91baddbb60 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -29,6 +29,7 @@ CONFIG_DM_MMC=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_DM_ETH=y
>  CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY_REALTEK=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_GXBB=y
>  CONFIG_DM_REGULATOR=y
> diff --git a/configs/s400_defconfig b/configs/s400_defconfig
> index 1bd4b7127b..9b8448e003 100644
> --- a/configs/s400_defconfig
> +++ b/configs/s400_defconfig
> @@ -26,6 +26,7 @@ CONFIG_DM_MMC=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_DM_ETH=y
>  CONFIG_ETH_DESIGNWARE=y
> +CONFIG_PHY_REALTEK=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_MESON_AXG=y
>  CONFIG_DM_REGULATOR=y
> 

Applied to u-boot-amlogic
