Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC0CDB483
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:46:35 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.276313.1697615191686950830
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=btecUuth;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40837ebba42so7731865e9.0
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697615190; x=1698219990; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBoXn/+8/BGTauLZ3Q8ZA9tqIJnqJBSZNk80IvPu+Ls=;
        b=btecUuth6o78ovdcbRZCZBZvr6l9UEi6pYEVIPr0j1Z2qgrGchBsvybig1lIV1aI7g
         HNdvWqGT6ZAEGJsZxTdHLEm/I5rcApnfaPmmmZ28lWmW6AUCG0HVh82B+Qom7T20tGUW
         8LuZJlqddS8YiqnPiDxKSMAMyFUi16MkzW9z1W2Fwm8iUVqaFxc8x1DclQVQNG1R1MVh
         wteklYEPGjoDAkfdeFUtxFjq0m8YcRWOM69NxSqlZ2xi8Vk3WgrjLXefcsxsnStUyPbb
         0bKBjc9GWVZrJL4yXHEID1bJrBpNOPh12fa8nkQXt8laRgHS7oIfyde7tl8Fy5Gli+pL
         3i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615190; x=1698219990;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBoXn/+8/BGTauLZ3Q8ZA9tqIJnqJBSZNk80IvPu+Ls=;
        b=UKl4RP5VCq4q2DSj5f2vGk5baWJ4Sg6Y1LDl7K7FXxHFt7lUwS/dWIG0qR3u9RCck9
         Gi7zGkfrPphCmmR3eHhfF/L1034HcXw+99R+7Rwm0sR6VyLMzc4oPXy7n8v65Lp8r2jR
         YwNjtCbdrgIRNu806UTw6p4NemD2wacQFf2L+SXaZvWjqgQozmzb4oEz8vFrajVRLnkJ
         pmIfundlzHt0u5Hp2eKuwMDG6lB62QtAUryZ6KmqOxWu8eKvoXySA9M8eN7uxx71g9K9
         jyv11tH57P1CTjs3UqvS5YTVJyx7FBSMYaZnqgpFW/E0rN/xYSFRG5ti5hMGpAk1x888
         18oA==
X-Gm-Message-State: AOJu0YwY5vgj43Q9Eqz5WoJIEwu6iV48v0/1l2zDH8wPJEDLOlHCUY+L
	eY4qEP2gQPxAC8qEdWxXZSEVST7kfIEmyhSgGfRzUlzk
X-Google-Smtp-Source: AGHT+IHIuncde/euI1ScFE2pyQcKh3cbNgqemPV3y+QR/993jSZprTgr1BPIAYfS2RjRGvkrVpxFQw==
X-Received: by 2002:a05:600c:a48:b0:3fe:2a98:a24c with SMTP id c8-20020a05600c0a4800b003fe2a98a24cmr3336165wmq.26.1697615190070;
        Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b00407efbc4361sm941509wme.9.2023.10.18.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:46:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 avromanov@salutedevices.com
In-Reply-To: <20231017185725.809524-1-glaroque@baylibre.com>
References: <20231017185725.809524-1-glaroque@baylibre.com>
Subject: Re: [PATCH] phy: meson-g12a-usb2: fix ret check on
 power_domain_get
Message-Id: <169761518944.2954297.16595176249313373535.b4-ty@linaro.org>
Date: Wed, 18 Oct 2023 09:46:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:46:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1783

Hi,

On Tue, 17 Oct 2023 20:57:25 +0200, Guillaume La Roque wrote:
> Patch which add A1 SoC support create a regression on khadas vim3/vim3l
> boards when we try to use fastboot command:
> 
>   => fastboot usb 0
>   failed to get power domain
>   failed to get power domain
>   No USB device found
>   USB init failed: -19
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] phy: meson-g12a-usb2: fix ret check on power_domain_get
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f699cb1dd5f4c55aa3f593c226ec797730d02f10

-- 
Neil


