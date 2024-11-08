Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E783D42BA3
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9525.1731060535757809386
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Nov 2024 02:08:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GIgkoZ3u;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: massonju.eseo@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d47b38336so1475727f8f.3
        for <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731060534; x=1731665334; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRLYTdOM6l0kAvtmGPa77gHpnx7MiBdeWBTsHLMJxmo=;
        b=GIgkoZ3uJ3YJnLYdqrTU9pQH/YBpwcZoh7tVwxKQd9ttyggM9KOWP0tY6uxYmQugDt
         35Vc13ERkJYCWnW72FwUtrDkoFQ9aoXbYbhNwm4PQqRuIC7lONkV8uMmHNIoPl/5OE7K
         P6xzWCmbdkNJuuhhkvLgI1WNWasENd8fcTnd4+UoWPs+72ueNgp064UMvlwY81V9REB6
         z+PkXnScqazspT/QxVkHOd56Zq2efcqWHhnjQ4tUEZoJ+vPJoe7sxoZiGu+pPMRRPA7I
         PxZGNvC1/G7yGxYqIhL6SXPx7ZKsTXwSITf62nVR81LuBg7v8lmA7MmMvc9SfnytE6aZ
         lDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060534; x=1731665334;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRLYTdOM6l0kAvtmGPa77gHpnx7MiBdeWBTsHLMJxmo=;
        b=ac3sHJ9TK4Ii7SZku3ocZRH8pe9uL5GsZxJQ2dbz1O7yh0YlByxUwfyX0jPSqDznyz
         /5i19TqUiyhAOcRYJVNmn02pdckwFcrHrBXoGsfVVEdRhKg0u3U/d8HfNOWBfio/u7A9
         RICr/xDkJb/64Tv2tfPWJP3Os2J/ZGvJgnqVOC4fLTtLa31KVY/ZS4vFrX62qcl/8WJF
         qKHZQST2N4XAnX7OwSKVF9lcecUr2nCi+xRmM5JOMbgLTqK/uWfdnaRwrZ60Fj7GlPry
         JOG3ahJKyExg6StY9SXkMtkI0dyUlDfg5cRPacUYy8qJ7ZxKT714/GGfEqi1QFFLAgen
         PHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjLrT6tMAGTycIh7eYurRQP4gKzZ1VjHm75ojLEHG5W4tKirtMcDZlM+PNfrMWVDtzJ2jDtzP0FkKFS+TLQA==@groups.io
X-Gm-Message-State: AOJu0YxVwH/7ZsZWNtl0Z+gHVgKrInCQlbp+C3drZRePgchjMXKHDLC5
	NVKZ4f07Ix2jSI+SFN6jAxI1O4lFqPjHJT3oqYQ+90scCRCrBc/a
X-Google-Smtp-Source: AGHT+IHQAbWx+puJ5qS+WpcRF4XXnLDrl12pxr7CQ6HnnCW0DmfzuKFMcLgprHBLI70LrNS8Q7ra6A==
X-Received: by 2002:a05:6000:1449:b0:381:b716:2470 with SMTP id ffacd0b85a97d-381f1883dc8mr1832563f8f.40.1731060533858;
        Fri, 08 Nov 2024 02:08:53 -0800 (PST)
Received: from localhost ([2a04:cec2:a:e411:4963:a2f2:7806:b10e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04211sm4122711f8f.94.2024.11.08.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:08:53 -0800 (PST)
From: Julien Masson <massonju.eseo@gmail.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, Guillaume La Roque
 <glaroque@baylibre.com>,
 <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>,
 <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
Subject: Re: [PATCH 1/6] bootstd: android: add support of bootimage v2
In-Reply-To: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
Date: Fri, 08 Nov 2024 11:08:52 +0100
Message-ID: <8734k2javf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2542


On Fri 08 Nov 2024 at 11:07, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Android bootmeth only support boot image v3/4.
> 
> Add support of Android Boot Image version 2 [1].
> Vendor boot image is only supported in version 3 and 4 so don't try to
> read it when header version if version is less than 3.
> 
> 1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2
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
> 
> 
>

Tested on mediatek MT8365 EVK board with boot image V2.

Tested-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson

