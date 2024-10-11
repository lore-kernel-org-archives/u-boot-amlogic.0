Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517AD0D7A7
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:20 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.13551.1728657736699600893
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=w84HzAxU;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so23108785e9.0
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728657735; x=1729262535; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLXdBPDRSmqEjjNZKvk7ZTzEERtGuAWK9DyddN5WdBA=;
        b=w84HzAxUggtoQBppXCqpb4rOEqIbzBnHZkZCGqAVIeb2s1UkDYH6HOwsfppTM0Wb7A
         hWrLCDJ/2GLFQSPKaxb7NroAoydmSJxr0ffO37DmJFAdsD1LRnEgd99/kVLsbxI8BCCi
         G5lYGjAVt/9EixLyAMMtRvWOC0LAhuX4FbTmBqxmmpwJVGR5N1tT+xQ3nKmGAVIYgOaA
         ekdKrs9o6C/W+aSqmBr0y9ZpC3Iz4u88ALQe7DLHYFniDVWVwmdNDizUGQBGLSNg8W4e
         1Kxpnd23+72IQoDepdGfrZl0Q8SaPgAJ2+JiQ5E04E54C71j7zb+oITMYo7Ly3L06ncw
         Zs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657735; x=1729262535;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLXdBPDRSmqEjjNZKvk7ZTzEERtGuAWK9DyddN5WdBA=;
        b=fKNB+yRraFuTxyIOT7uTiRl0sBLw+7z1NkGWZSllKexSGnGQjjIEjWXlQ6VImxE1VV
         bcYsh5WVgkexu3zz4iouYdmthhFLY0mInMjkJjXICIHAaZE1Njxmhdrq/ozd+9UcDT+P
         +4GHrwd5nGu3x5joOfVxNsRQrMitb+kkktZt01c1ZrxxExz5mo9AOVkeFJ3GF3S4hi2x
         bRWCb0J/O1Aiu5od5tUHlzZVAF91dqExqPMNqxRIQTawntVUqWgoKZeskjeBu19FIe6n
         B/Pw8TobxxFMmJQjJwVCCp6IQ0r6od4GqS1Li9LUK2IAgOS1YmnQrCz+ng+PlxeKdKS/
         GpUQ==
X-Gm-Message-State: AOJu0YzejX5519Pj8JZbEuWqclafw6daNclNEOEgXjFA847pClIgVtoR
	VmIc9/yg22MtM7M64gC6NTuLgK8iAOz7LbCNWGmiQ+YAdMY+Xq9YETjTRHBzkWhobBVcyZ24gaV
	Rt0U=
X-Google-Smtp-Source: AGHT+IH2lZqK3X61ypK5hclLt3Xn/kifXG0kvpIpzDSMGs23/KMRXA7tLSHV27u1TjUkNw6NtUlsew==
X-Received: by 2002:a05:600c:1e16:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-4311dea3584mr28230705e9.7.1728657735062;
        Fri, 11 Oct 2024 07:42:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
Subject: Re: [PATCH 0/2] ARM: mach-meson: fix HDMI since DT update to v6.11
Message-Id: <172865773433.2734796.4668834305012644771.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 14:42:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2445

Hi,

On Wed, 09 Oct 2024 11:15:19 +0200, Neil Armstrong wrote:
> The DT was updated with unhandled clocks and a shared
> power domain, causing a probe failure and a green output.
> 
> Add the missing clocks and avoid enabling a power domain twice.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] clk: meson: gxbb: add HDMI clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2958fd431af7d08a0b15881b59b0df2e32963ba8
[2/2] power/domain: meson-ee-pwrc: make sure to not enable a domain twice
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/25b489e2cb816f52467138665b9b6203c358f03b

-- 
Neil


