Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB8C54798
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 17:23:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.767.1708708989547975280
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Feb 2024 09:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VGdpcnlx;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41298411aefso1346835e9.1
        for <u-boot-amlogic@groups.io>; Fri, 23 Feb 2024 09:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708708988; x=1709313788; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhpfx/ePUICxS06uEeSdou4myF4uuNjCR2pKvdgsQ0I=;
        b=VGdpcnlxSZyKFDAQd1A2xKL3kYgaFa8lStQCV7jGHWwcn8ydicufkOsOubvSHxxvRF
         yQ8c03uVRKdQoSHB8KplExy44QfLVci0anZ/j5MAKy1zY2hdJcVRcUCNxOzDV/2QeDUU
         F/0YoMTcSkTOk3DbSz7T6bynYdhYk4LANQ0sEPbEqfEL9KKgkL1/qvyi60uRdhU4mo2k
         she+S6gFD3AoktDTVqPqVFW/IJSQ1nXRCBtd0Ou1yBc/ZSxDZJH/hSycEBrEECqr7NRR
         FzEqsV6Vn2a6Oqot5U47kKjri/ZkapqJ127RtJmP1Ogbvvf0qOHSFG1cc83GWqmkmAMb
         KeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708988; x=1709313788;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhpfx/ePUICxS06uEeSdou4myF4uuNjCR2pKvdgsQ0I=;
        b=sUaGQTzY6owO6riHaQObm5KThvkRfW4TEqL6o0jix3KB2Ab4xlg1L3lUkVQFMtfCiG
         6YKCahc67mHbFSYR2hR3WKW8ntwOTld0B3aIu1ULR1ojl7INWrgveX1FZJtFojfUV2oK
         gdpe6A1xoa0ymCrU+7siq2u/YjyQ4NSghdOImQ06hm0Me9PtU+lwI1ypyVfdqKtxqpFn
         pSCqMK09aG5Uree5bAnGkfqjzKbG0f9Jb7T/8QPRp2Ni9ewd1z9Cs8AW0CWPUS0nuHrE
         uyXiVojuHCTTbKAYKSOPsiJsQNPutQtNne1wDOlv/ZInMh9QcqtwbpnUNvsCk9pa7ESC
         8/ww==
X-Forwarded-Encrypted: i=1; AJvYcCV4KYGcX5n3LquOc65Ny7PG6uZGFgyE2MbCZ/keNdz4v8yiVZCGty55+TknQiufDKqgxkdSHVuaC5GJFT3ecx1UArKG8hihoqg=
X-Gm-Message-State: AOJu0YydzE0cYPj01BpPeh+E8/BhijPJg8dolISwPJlNToVVzO2ldmgd
	+637lN6XXcUMTP8ImQ6SbdmaevetuE7mWIgHtms3eb3UXdDz7FgOkVinKRxDpm520kFU7WUOFcl
	lhAcPRw==
X-Google-Smtp-Source: AGHT+IGIsSeQZqBaqBWjThOPRbhNoRHLe5uWldTOgRFDmFR0Vf1J5qrEZNLtxGm1BRL07XJLSRhgfQ==
X-Received: by 2002:a05:600c:19c9:b0:412:8cc3:bf67 with SMTP id u9-20020a05600c19c900b004128cc3bf67mr471767wmq.8.1708708987776;
        Fri, 23 Feb 2024 09:23:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b0040fccf7e8easm3015320wmd.36.2024.02.23.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:23:07 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
Message-Id: <170870898716.200337.2390441000812477288.b4-ty@linaro.org>
Date: Fri, 23 Feb 2024 18:23:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 Feb 2024 17:23:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2129

Hi,

On Fri, 09 Feb 2024 09:58:35 +0100, Mattijs Korpershoek wrote:
> When booting Android with AVB enabled, an OOM is observed:
> 
>   => avb init ${mmcdev}
>   => avb verify _a
>   ## Android Verified Boot 2.0 version 1.1.0
>   read_is_device_unlocked not supported yet
>   read_rollback_index not supported yet
>   avb_util.c:182: ERROR: Failed to allocate memory.
>   OOM error occurred during verification
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: khadas-vim3*_android: fix AVB oom error
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fc0a7431e1729f456690468f2e9570fcc2c18175

-- 
Neil


