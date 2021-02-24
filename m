Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.7632.1614176924244324255
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Feb 2021 06:28:44 -0800
Received: by mail-wm1-f46.google.com with SMTP id m1so2013328wml.2
        for <u-boot-amlogic@groups.io>; Wed, 24 Feb 2021 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqOQzece2Bw64CZ3luHsDFIPAioxyaYaBJNItRqkc/A=;
        b=0hpGhfOzgfJIAVjO1rTNGBurHjriRZ2isjm6nCCVudjF6FPFxLmx4kqf7CQ/oHGmxf
         y3mUDBHzuwHijvLplkuw0Rau9q+IHvZYC62SMwCMMzYF7i8XRYAlvx41xJdpsOFpYhoO
         QghMwTUBbA9mzSNExXYGPSvYPPcqzO3+o/a7hLje63fBpPKgjKfBjYLhps1MfCqb4LEf
         7QDs9C2IKLpyEkRYkb6VJ+/2A879Uu50DbWa75OdkwJ8F2CmSD5PsSo7oISu2TtQF5yX
         BxyigG6lqZc/Ht1XxqlI7GZqUi3eHLN8SqkO6K/pj86HQbF1XgRYKsuAlqEcoWjQptE0
         qtUA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: meson64: add fdtoverlay_addr_r
References: <20210210142605.1372944-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <29c9466c-5dfb-e9c8-f41b-3e3f852491b6@baylibre.com>
Date: Wed, 24 Feb 2021 15:28:40 +0100
MIME-Version: 1.0
In-Reply-To: <20210210142605.1372944-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/02/2021 15:26, Neil Armstrong wrote:
> In order to support loading FTD Overlays when booting with the pxe
> command (or extlinux.conf), supported with [1], add the missing
> fdtoverlay_addr_r used to load the overlay before applying it to
> the FDT loaded at fdt_addr_r.
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20210120085453.2783678-1-narmstrong@baylibre.com/
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/configs/meson64.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index 52cc01f73d..7e97f89052 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -80,6 +80,7 @@
>  	"scriptaddr=0x08000000\0" \
>  	"kernel_addr_r=0x08080000\0" \
>  	"pxefile_addr_r=0x01080000\0" \
> +	"fdtoverlay_addr_r=0x01000000\0" \
>  	"ramdisk_addr_r=0x13000000\0" \
>  	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
>  	BOOTENV
> 

Applied to u-boot-amlogic
