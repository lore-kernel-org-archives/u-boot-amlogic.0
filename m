Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744FFCDB47E
	for <webhook@archiver.kernel.org>; Sun, 15 Oct 2023 10:30:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.88933.1697365844161346269
 for <u-boot-amlogic@groups.io>;
 Sun, 15 Oct 2023 03:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=g6t+TNnA;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40572aeb673so35037625e9.0
        for <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697365842; x=1697970642; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ8+lB8xjkrKXuhw6KX+exudZ5+xHXE/3ru6Cc9nRT8=;
        b=g6t+TNnAnR489D1MXYsHChHBd5F2QMfmh034IDIuwU6Ml5a6ylTxQaLByzsTqVLvQ+
         OfhI4mczOH9gh6eHqFiYFKXPVLIakBpl7mlrOfygIDHkXSbXYtjCY/pRSR17BdIwqANu
         6bfXIm0yaDED+oGPpsEhIJtmFqHOy26RlyKTyDCYy8aHQhrfUw5eByfCJe6w2IPVzZk+
         AyRFUTAK15j3tMEkRLaZl1c0SzZLtVap9Xu0O31seo4AbMzd2KV82V0Fs7LhmS9dmHsa
         moVlG7i1HFGDh6oNFvUHoki1/oOFH7Q1KPYH3kSj+ckjtPZASWIXsQbveMVbsP1uiGZY
         VFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697365842; x=1697970642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ8+lB8xjkrKXuhw6KX+exudZ5+xHXE/3ru6Cc9nRT8=;
        b=UQQ9Wbb/40UX5KwHPJ4opcLasJ34W01M/vNZI/x26Bk2kO2jEr7znB7FoLpAtGfV/3
         5u7MfAtMX80YXTjxwY/xpRhqO16xA4MpEdObgFA0dagAnTSE1N9rXXvNPC2G0kPIbEA6
         fbBwOgGkjw5yD8IOkYRiGgVMxlBFKVHwLnfS+xGIptgmfmpbhclGm3zU3fQwJD/BDO1s
         wyfYccvTikv8QOfZq26YnQySRzwGOe/xOCQIum9UVyxlOzkMRh+FuepKB/iODgE5kxGz
         ulh2N6ETAQqp1B2BkJWrwGDhsHF753wh/OXa/qWoTVnmXtGyPMpP9/egIP9ApjipZf4z
         wtEA==
X-Gm-Message-State: AOJu0YxWWzZDiamtP+Lyq1VR5Jg8oNEChj4NqnDGfabM2+iUuhrGBkVz
	W9MYWvUB5i2VM4OWAzGH0GBSk19GZWit8fWwKCMC2qwa
X-Google-Smtp-Source: AGHT+IEtwWzqQSbk98K0SnnEqvAngBwDd8fdPRIDIWuY6E049qTIrPboZQ2Yl1NZA5cnm6al7/TaEg==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id g11-20020a7bc4cb000000b00401cb453fb8mr27605244wmk.38.1697365841782;
        Sun, 15 Oct 2023 03:30:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4847:ec26:6b78:66be? ([2a01:e0a:982:cbb0:4847:ec26:6b78:66be])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004063977eccesm4207607wmb.42.2023.10.15.03.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 03:30:41 -0700 (PDT)
Message-ID: <25322756-2d1a-f14d-134b-8e394f2979d3@linaro.org>
Date: Sun, 15 Oct 2023 12:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1] drivers: don't compile Secure Monitor UCLASS
 unconditionally
Content-Language: en-GB
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231013130411.46569-1-avromanov@salutedevices.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231013130411.46569-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 10:30:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1755

Le 13/10/2023 à 15:04, Alexey Romanov a écrit :
> It makes no sense to compile Secure Monitor unconditionally.
> For example, this break the SPL build on boards with a small
> allowed SPL image size.
> 
> Fixes: 126fbbefd89e ("drivers: introduce Secure Monitor uclass")
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b7bd3633b1..1a768fed2b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_$(SPL_TPL_)VIRTIO) += virtio/
>   obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox/
>   obj-$(CONFIG_$(SPL_)REMOTEPROC) += remoteproc/
>   obj-$(CONFIG_$(SPL_)SYSINFO) += sysinfo/
> +obj-$(CONFIG_$(SPL_TPL_)SM) += sm/
>   obj-$(CONFIG_$(SPL_TPL_)TPM) += tpm/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_$(SPL_)FPGA) += fpga/
> @@ -124,4 +125,3 @@ obj-$(CONFIG_DM_RNG) += rng/
>   endif
>   
>   obj-y += soc/
> -obj-y += sm/

Thanks, squashed into 126fbbefd89e ("drivers: introduce Secure Monitor uclass")

Neil

