Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.15900.1625263313838247893
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Jul 2021 15:01:54 -0700
Received: by mail-wr1-f51.google.com with SMTP id i94so14120353wri.4
        for <u-boot-amlogic@groups.io>; Fri, 02 Jul 2021 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDTgW18Sefby2eBbYwTtzqqR0tg9TEfGaetqy27lxP4=;
        b=K946qhXJW8gmKISnOHbeyzKFPFLNft24iC+VD45gAyFL8yQuzcnU5HV90syCTE7pB3
         bLCXOxDlM7jxo1e/S5GSSEQWLmZX08ig0XG7OXHkyFb0R2K/78tgpM6bzAkQSTpt+x+V
         IpJZ/lvytAcz0Be/PeiYi2IpAl3SZd8kLPLTG5v0r7FO4MFl+u5lcXi8LTCTHH1c+1iZ
         PzIs/bjgwfY3OruKU3Q+Pk/XqyB5KMmivXux/RGv4BFEKnhj0LvgW2+4TBeH9XRfx7Iw
         Fv8DlLt6QhIF3QK5LUhioowCbjVezLnMQL0GzF4xEhrVWGRw9VVZtXY0Sz8INr+rCSt+
         QQpQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: libretech: set SPI mode to 0
References: <CACdvmAhd8GA=7wpF=b4nMG3pKRX7XV8NMBZLvT+DDR27CPuOGg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d19279ae-9cd6-9b74-2f57-bc0513e0317d@baylibre.com>
Date: Sat, 3 Jul 2021 00:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <CACdvmAhd8GA=7wpF=b4nMG3pKRX7XV8NMBZLvT+DDR27CPuOGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Da Xue <da@libre.computer>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
List-ID: <u-boot-amlogic@groups.io>

On 02/07/2021 23:11, Da Xue wrote:
> Kconfig defaults to mode 3 if CONFIG_SF_DEFAULT_MODE is not set.
> It becomes an issue since meson_spifc does not support SPI_CPHA.
> Needed after commit e2e95e5e25421fbef499e21bf94a5339701f9a99.
> 
> Signed-off-by:Da Xue <da@libre.computer>
> ---
>  configs/libretech-ac_defconfig       | 1 +
>  configs/libretech-cc_v2_defconfig    | 1 +
>  configs/libretech-s905d-pc_defconfig | 1 +
>  configs/libretech-s912-pc_defconfig  | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index ec51f2ad38..9abbcad3c0 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -39,6 +39,7 @@ CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_MTD=y
>  CONFIG_DM_SPI_FLASH=y
> +CONFIG_SF_DEFAULT_MODE=0x0
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_SPI_FLASH_SPANSION=y
>  CONFIG_PHY_MESON_GXL=y
> diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
> index 97c8a9e47b..7dc6ed2f29 100644
> --- a/configs/libretech-cc_v2_defconfig
> +++ b/configs/libretech-cc_v2_defconfig
> @@ -35,6 +35,7 @@ CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_MTD=y
>  CONFIG_DM_SPI_FLASH=y
> +CONFIG_SF_DEFAULT_MODE=0x0
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_PHY_MESON_GXL=y
>  CONFIG_DM_ETH=y
> diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
> index c0301a0aa0..93523c23cf 100644
> --- a/configs/libretech-s905d-pc_defconfig
> +++ b/configs/libretech-s905d-pc_defconfig
> @@ -36,6 +36,7 @@ CONFIG_SARADC_MESON=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_SPI_FLASH=y
> +CONFIG_SF_DEFAULT_MODE=0x0
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_DM_ETH=y
> diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
> index e2faea6242..669f000f7f 100644
> --- a/configs/libretech-s912-pc_defconfig
> +++ b/configs/libretech-s912-pc_defconfig
> @@ -35,6 +35,7 @@ CONFIG_SARADC_MESON=y
>  CONFIG_MMC_MESON_GX=y
>  CONFIG_MTD=y
>  CONFIG_DM_SPI_FLASH=y
> +CONFIG_SF_DEFAULT_MODE=0x0
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_PHY_REALTEK=y
>  CONFIG_DM_ETH=y
> -- 
> 2.30.2
> 
> 

Thanks,
Applying to u-boot-amlogic & sending PR to have it in this release

Neil
