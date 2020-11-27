Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.21283.1606494933591146804
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Nov 2020 08:35:34 -0800
Received: by mail-wr1-f68.google.com with SMTP id t4so6152422wrr.12
        for <u-boot-amlogic@groups.io>; Fri, 27 Nov 2020 08:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mkP4GSz4oJ6V15+wN5LNRK73CdV9Y8CgBJeodmD9Hwk=;
        b=dAYCCuYVjNJkkUaWgEgnfjyOCLwbYBCqHum+swJSxG6UHYgcdAcq9swA37EuaCA2gz
         h+mGVYFf20Cff2cCDutDMPfUavxZzVhosHTUSYUJYIA9SaXSXmA8rJEcq+y4VkThKBHu
         86/zTDm8tBRiDF1ow5OmmHb1eziGtUoNjnkYpGJCdZaQryP/SUwX6H3FdtxuERyztwie
         H7gzAVAdeS7g96XXepJiKbObO6KecWEcKKAeq1G9tUCrNJTv2A4p0exQIOTvPVAADqEW
         P2wPIOYxCzbaeBJAGbjwERQS8GHgqRKjGQxnpC9CwHTs7jf9nNK/2kqyJhQHQnPYhyF/
         4/ug==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] meson: Add soc_rev to environment
References: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
 <ff19d6f90e3f827664f8460e98d86a692342506d.1606492351.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c6b25ad9-7903-0456-75ef-5f30fdca5df5@baylibre.com>
Date: Fri, 27 Nov 2020 17:35:09 +0100
MIME-Version: 1.0
In-Reply-To: <ff19d6f90e3f827664f8460e98d86a692342506d.1606492351.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Pascal Vizeli <pvizeli@syshack.ch>
List-ID: <u-boot-amlogic@groups.io>

On 27/11/2020 17:28, Stefan Agner wrote:
> From: Pascal Vizeli <pvizeli@syshack.ch>
> 
> Add SoC revision to environment. This can be useful to select the
> correct device tree at runtime (N2/N2+).
> 
> Signed-off-by: Pascal Vizeli <pvizeli@syshack.ch>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> 
>  arch/arm/include/asm/arch-meson/boot.h |  4 ++++
>  arch/arm/mach-meson/board-info.c       | 12 ++++++++++++
>  board/amlogic/odroid-n2/odroid-n2.c    |  5 +++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a90fe55081..c67d12d06c 100644
> --- a/arch/arm/include/asm/arch-meson/boot.h
> +++ b/arch/arm/include/asm/arch-meson/boot.h
> @@ -7,6 +7,8 @@
>  #ifndef __MESON_BOOT_H__
>  #define __MESON_BOOT_H__
>  
> +#include <linux/types.h>
> +
>  /* Boot device */
>  #define BOOT_DEVICE_RESERVED    0
>  #define BOOT_DEVICE_EMMC        1
> @@ -17,4 +19,6 @@
>  
>  int meson_get_boot_device(void);
>  
> +int meson_get_soc_rev(char *buff, size_t buff_len);
> +
>  #endif /* __MESON_BOOT_H__ */
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index a0bcf38f29..90e7dfaa3c 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -187,3 +187,15 @@ int show_board_info(void)
>  
>  	return 0;
>  }
> +
> +int meson_get_soc_rev(char *buff, size_t buff_len)
> +{
> +	unsigned int socinfo;
> +
> +	socinfo = get_socinfo();
> +	if (!socinfo)
> +		return -1;
> +
> +	/* Write SoC info */
> +	return snprintf(buff, buff_len, "%x", socinfo_to_minor(socinfo));
> +}
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index caf7fd6810..dc0d933a39 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -12,6 +12,7 @@
>  #include <asm/io.h>
>  #include <asm/arch/sm.h>
>  #include <asm/arch/eth.h>
> +#include <asm/arch/boot.h>
>  
>  #define EFUSE_MAC_OFFSET	20
>  #define EFUSE_MAC_SIZE		12
> @@ -23,6 +24,10 @@ int misc_init_r(void)
>  	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>  	ssize_t len;
>  
> +	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG) &&
> +	    meson_get_soc_rev(tmp, sizeof(tmp)) > 0)
> +		env_set("soc_rev", tmp);
> +
>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>  
>  	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applying it u-boot-amlogic-next

Thanks !

Neil

