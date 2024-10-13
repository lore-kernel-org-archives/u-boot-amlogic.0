Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6501CF2579
	for <webhook@archiver.kernel.org>; Sun, 13 Oct 2024 16:36:27 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.34964.1728837378743143225
 for <u-boot-amlogic@groups.io>;
 Sun, 13 Oct 2024 09:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=z03g1kEi;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so2102391f8f.3
        for <u-boot-amlogic@groups.io>; Sun, 13 Oct 2024 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728837377; x=1729442177; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObYqYt+JwvbACZxSTxrcCMR0dYuLoYggVvrOJB3GMq0=;
        b=z03g1kEiPj/KLqFpkCzuuDvpbD+nvi9aOoCWAlhtC47dYhaDvpZTe6g4fJWAbK3Lwg
         UmdHMtJmW6jcpPC9IpJGktcQzrzXckzFu9rxg1UkbXkLYBQiaR1QqZOqa6QMeh5xghKz
         djz/sLxXFO7xazYI9V+E3mJLREM76rOoMggRmnAkmZMmJ7G85bX7KBr8jtXKT5rjwJxy
         U+2dggShGf85RuL+uwScGfpDc40wY0IWhGfbLWHq47Dv2iCJVRtA6yjH+H8O1ZGJKLj4
         gHEivJGckHdXBRMsYutGwx2LH9fdfaojApdD0y2AZSmM+L8mrvAGQz4ijNHSemwounwe
         0WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728837377; x=1729442177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObYqYt+JwvbACZxSTxrcCMR0dYuLoYggVvrOJB3GMq0=;
        b=iEUJ1FR0Spggwq7/bJjKnR5XEijeCgSEaoI7iDJoYHi3XfTlVbWkPm10pVJ+FUWb/Y
         hIlq9ZGFzECEzd+ce6Ehj8XE1wUIqnIB+LGnfUbMY/b+Vso24ypBvMz0Ht0WOSF2LJya
         gPN9X2cafKTt8nmhi5H5ITPg26h18XsrW2yNlTvKFUF4KakVvHeyFTxIF8OCJ2IH3n3e
         SWu55slodaN4JrxxxPE2r3MkmecTK8DnGLRDNEmR7HcwYlcsPqp9V7W5j6SAyBVFYy/J
         ISFMM//ZSkUdTuADK5lUWDCAb/zly22aEEtdRR/EEl4+fo9U0PoRXJjPJRLZvNN8kAAN
         HTVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3GAv4NsZzcZptA/rg+FJpd0WqAY+wwUnx9ks4OLYlRVwqypAUXrYvfyAVVTwz8xR72jm1vmjzwmS8ImniJA==@groups.io
X-Gm-Message-State: AOJu0YziDn0e20ZBa3kXd5KBDFd8o9h6rri/4rnlh1gWEo2gNuSvwDEJ
	38QPTCVmhTPBgIDRPikwn8yoRS6IB+HX5DDU5bcH7pT+3cbJ9kYN3n5zCSwJziTHFR7hPvxkwv0
	gKD8=
X-Google-Smtp-Source: AGHT+IEDa+iHnk6mlHgkECEuFGGjjLFKREq+lvUEwYZFFMOxI5xtdv3kzfec9zP3dyTqU75uZI4PjQ==
X-Received: by 2002:adf:f449:0:b0:37d:2db5:b50c with SMTP id ffacd0b85a97d-37d5518e16emr5800992f8f.8.1728837376962;
        Sun, 13 Oct 2024 09:36:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:705a:8bb3:8b50:341e? ([2a01:e0a:982:cbb0:705a:8bb3:8b50:341e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f6f5sm130950675e9.7.2024.10.13.09.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 09:36:16 -0700 (PDT)
Message-ID: <b35d5508-e162-487a-b38c-a21e3a541216@linaro.org>
Date: Sun, 13 Oct 2024 18:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Content-Language: en-GB
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 13 Oct 2024 16:36:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2453

Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> Hello, 2 small fixes for Khadas VIM3 and VIM3L to boot Android.
> 
> Recently, some effort has been made to use the
> upstream android-mainline kernel on these boards [1].
> 
> To use android-mainline kernel, we should:
> * Increase the boot/recovery partition sizes (so that it fits)
> * Drop dtbo support, since these are not part of android-mainline
> 
> [1] https://android-review.googlesource.com/c/kernel/common/+/3296472
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Mattijs Korpershoek (2):
>        configs: khadas-vim3{l}: Increase boot/recovery partition size
>        configs: meson64_android: Remove dtbo support
> 
>   include/configs/khadas-vim3_android.h  |  8 ++++----
>   include/configs/khadas-vim3l_android.h |  8 ++++----
>   include/configs/meson64_android.h      | 26 +-------------------------
>   3 files changed, 9 insertions(+), 33 deletions(-)
> ---
> base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
> change-id: 20241011-yukawa-aosp-parts-77d255a19cda
> 
> Best regards,

Thanks !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

