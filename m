Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718A7D2C551
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 13:24:25 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.18081.1729603459843357475
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 06:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=fwH2ikbg;
 spf=pass (domain: baylibre.com, ip: 209.85.221.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4fd00574so3862799f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603458; x=1730208258; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=syB2xU9i17UZEkH1sKuqW7aEy/PVCDqbKK3UoReWvDI=;
        b=fwH2ikbgkPVxITkrtY2QvAgYvJX/Oeam/hyeD58+mcmvr+5OIfJqZA738CQZz3cp5x
         oI5vx+5ke9IF8zhfSoZz0AKlDAHDkj+go/We8LBDlFf45zhxUdz84PZlv8e885NV9N6A
         WGDtJsi0pCLypJ/RzTEXCAr9UowEVfpXtKJGxSDUbTRPrjXUm/sT8t3lvFJpl62cDoYJ
         9MQSt63ALfjMfRsk28tl3NysrsE/5OPHYVVnIhl5ztBJpzSnLjL3u5WNZQmUAZpwaOyC
         003EZkx0NCTQd3+3uPsVKu2pjg+e/KHM+xE8qEPdcghIMBoEZuwl59VQaNbVR80ZPwVl
         5Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603458; x=1730208258;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syB2xU9i17UZEkH1sKuqW7aEy/PVCDqbKK3UoReWvDI=;
        b=HdX8H11Cv08ASrj9U8IiC5epBYxtheU3NFtS5tm09hrMVc1EV/1f4K+C3U4w6ZDFwi
         tdjHIEKSfyzPwvJTPSA6adfXIQsawqqadbRV4PiqstTUPyrKsYYxbtS9Flt0eTDGvZwM
         hucmmXkNLv10FQUpcQ3Znmte8lZubPB1wFSV7RlWuQLwXTayD450tUaeRhaRUP9riJoB
         +7RfjMXL9N5iaBazDra3FqgzNp4fH+feixcg68p8ce9eSZCC9g/i4Rg+7ExYHmdJF13E
         mLjyGL/xb/HFCNlgI31yVcU7k8/nD1SKeiS1nKzrY+JtPoLwYVbPpqxLdG6p1qUupieA
         GJDA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8icSk1B2/GY63uHhaaS2Iy1AoVs82Ffh9vFrNsKPpmYNt4xQVw175PuWaYqJ7gZw30mfqrviAIqiybJjBw==@groups.io
X-Gm-Message-State: AOJu0YzdJannPIuIJqElcCLFRkQ3lomDmbVHAAjzxp6xOEVNFmOQSaBJ
	wfbuCpGBYE5Gr0lhsfIdldnrUDMKr2b4oi3q+ns65Efb1WTKYmgJevrfPy21gfE=
X-Google-Smtp-Source: AGHT+IHns0rRpQmfdQTEtKZv4weyOloErSD/qfmMMrOtYxYzxMdgYBnsmlWZMvAEAvEdrs/5Zs3rjw==
X-Received: by 2002:adf:e951:0:b0:377:94b:4f51 with SMTP id ffacd0b85a97d-37ef12c25f4mr1928626f8f.22.1729603458126;
        Tue, 22 Oct 2024 06:24:18 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm6678187f8f.84.2024.10.22.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:24:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 1/6] bootstd: android: add support of bootimage v2
In-Reply-To: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 15:24:14 +0200
Message-ID: <87sesouv7l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 13:24:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2517

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Android bootmeth only support boot image v3/4.
>
> Add support of Android Boot Image version 2 [1].
> Vendor boot image is only supported in version 3 and 4 so don't try to
> read it when header version if version is less than 3.

Remove: "if version":
don't try to read it when header is less than 3.

>
> 1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Please use standard link notation (using [1] instead of 1:).
See some examples:

https://source.denx.de/u-boot/u-boot/-/commit/9214627f5ecede8610e33abf2de5a0083f3f80ce
https://source.denx.de/u-boot/u-boot/-/commit/608a31bdec6284ad6f821226e4c62c9cd3052874

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  boot/bootmeth_android.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 19b1f2c377b9..2e7f85e4a708 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  		goto free_priv;
>  	}
>  
> -	if (priv->header_version != 4) {
> -		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
> -		ret = -EINVAL;
> -		goto free_priv;
> -	}
> -
> -	ret = scan_vendor_boot_part(bflow->blk, priv);
> -	if (ret < 0) {
> -		log_debug("scan vendor_boot failed: err=%d\n", ret);
> -		goto free_priv;
> +	if (priv->header_version >= 3) {
> +		ret = scan_vendor_boot_part(bflow->blk, priv);
> +		if (ret < 0) {
> +			log_debug("scan vendor_boot failed: err=%d\n", ret);
> +			goto free_priv;
> +		}
>  	}
>  
>  	/*
> @@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
> -	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
> -	if (ret < 0)
> -		return log_msg_ret("read vendor_boot", ret);
> -
> +	if (priv->header_version >= 3) {
> +		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
> +		if (ret < 0)
> +			return log_msg_ret("read vendor_boot", ret);
> +		set_avendor_bootimg_addr(vloadaddr);
> +	}
>  	set_abootimg_addr(loadaddr);
> -	set_avendor_bootimg_addr(vloadaddr);
>  
>  	ret = bootm_boot_start(loadaddr, bflow->cmdline);
>  
>
> -- 
> 2.34.1

