Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79EC87FDA
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 15:27:30 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.54853.1754580169697856837
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Aug 2025 08:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Rnmd1AG3;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so10857775e9.0
        for <u-boot-amlogic@groups.io>; Thu, 07 Aug 2025 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754580168; x=1755184968; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJMqAiLZBfMzcgH+4cc0KROaqlvcSvrO/53Ei60uLVc=;
        b=Rnmd1AG3OgEQaDTjh9xts5tryAMyx+sqJJ5lUViPQ/a0eQVReywq03iFiIsR4peSLd
         e8QfsxItmnh+RJzp1t9vSGZf1sd+7lS60O37xiS4sas4ItbzOwsrFZ+FMSmBQqo7+yQG
         L9DqMwxSz0asqdF12CiqxWw5hBi6bDnFv/w7PD6N7rbFmBzF8gm6QuaV9cmJRmawDU+g
         gCBzAEtUQgZFEH6VKUpu6NDTIb1h0o/Kl/Pu5cYXotpUuSTC2+P8wIEl16+fuBrFYhDP
         6Geu9/xyaBfOSkzKetru/SSqtHF2ANu72c06hkcrhVXz+aL9VxJFtiSZDGRBi36mYG0f
         5dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580168; x=1755184968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJMqAiLZBfMzcgH+4cc0KROaqlvcSvrO/53Ei60uLVc=;
        b=izhm1f6KP64O91b4cL4U0Hu9iLzni93vRvkcHyzSYD9RDyTVjz1xDC0XWN19fiE0S+
         4kI0enJLifrAnU7EeRdmMm76TbaI5DgRn9H7JIc1KPcpUD7E/rCHDAhisB/X3OtoP/zu
         JvVv5wnwKo3pbT9hkh7Tn9TIb82YemrbBQQjwGzxAiMypyBcZgPM54iJ5Pj1Fd2LmFvI
         Uiv/qwPrO2F4xJBHbi6v6c5bTo5Xr5aZUn7nAacFd41NRhPR6Rc6XW0SSYg15kr4NUh/
         XreKnnrTPJl8u6n7QcUCKk8oqd2rC5iMmrQrbepk+u76L2qP/5x1U90vjUlK652g4lDm
         6Pyw==
X-Gm-Message-State: AOJu0Ywk2j/fJYWlK/D2b0s9XrTySdalsWovJ9JZGJqtWWAXoQnyWbk5
	hoO5TzJ0e27awGPvvcZEaiR5kR8/rG2jowYgbK7vc0biVDXxPo5yjOInuGtubxiYNfo=
X-Gm-Gg: ASbGnctbKfwmtkv0qIt09F2KfjrgOOLF6BVM4YQtbZNBkwCIHjWW3JO90Tkeo2C9f4v
	1Ea3ApsKUjAm0p2+s6Zst8Hryl+tAAuimACVot9XOAFd+y3H7z12YNajwVk+XRow2IYCmYOgjYv
	b9Ss8Jg5Ux3LoEQ8SVwzn3MSDhs8iXsz2g05cC/DYlntriCbcfnz4EWShtPhEtbXuWP4zOkQLPc
	L1N1lbBeIOp2W2zz6iJn09vyY8TJ7P3hZn+Ms8lu4Lvj27WwWrFceXMNn7wBLGJ5Yz9xu+mpKWP
	WBIL7TBcWIJyZKE1SvT91wvGLApdFVk0kdwpBAKBzQz4AoSbEMGczaSs7gJw97f1auHR+hBTaB9
	fpH+xkywLbojLh+E4c4+uV/mz5tXhzY5He1XZVtMWQoRslGuMNgFDwxOxc4TOLIiKZsmP3HqDpF
	ADHQ==
X-Google-Smtp-Source: AGHT+IG+S6wbRf+5EtYGrRIQK8rAZIBoMJodiJVNXaAt4xCBVT+el9Zc4s9Gut992+o/Yx83qiy0jw==
X-Received: by 2002:a05:600c:1911:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-459f358b94fmr14058045e9.4.1754580168076;
        Thu, 07 Aug 2025 08:22:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf? ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5853104sm98636655e9.8.2025.08.07.08.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 08:22:47 -0700 (PDT)
Message-ID: <492b9fe5-c25a-4523-8819-3886ecbbdd5e@linaro.org>
Date: Thu, 7 Aug 2025 16:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: meson: Remove unreachable code
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 07 Aug 2025 15:27:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2734

On 23/07/2025 17:37, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/meson/g12a.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 5d7faaa3eab..a7a42b2edb6 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -916,8 +916,6 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>   			return -EINVAL;
>   	case CLKID_PCIE_PLL:
>   		return meson_pcie_pll_set_rate(clk, rate);
> -
> -		return 0;
>   	case CLKID_VPU:
>   		return meson_clk_set_rate_by_id(clk,
>   				meson_mux_get_parent(clk, CLKID_VPU), rate,
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-clk_meson-3d90bc29f8dc
> 
> Best regards,

Is there anything else needed before this can be merged please?

Thanks,
Andrew

