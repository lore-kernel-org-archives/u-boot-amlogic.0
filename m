Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A3C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 08:37:45 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.79170.1701938259568063111
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Dec 2023 00:37:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=s+k4PUe/;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33334480eb4so796787f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 07 Dec 2023 00:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701938258; x=1702543058; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFYAQJcbliMGT3D4kBOifEL3kDjCqoAlJPtzq2V7r5s=;
        b=s+k4PUe/WQTIRtHEz9lL2XSOZiYhEUR3V6zWYYcLf9tIPh0iIoEST1re5B+SNWhkh5
         vaNwt0vlvjf5Ab2r/w9ObxgDUo2UL7xcYOwNNgNnF9gyrL5ZVTcGcsc+mMSa8yL1CTVf
         WBTHgaFjC+vMmWuaGMAzok335IoFNRId80MFHWTtzk2howGtpnvcnsOspl+0wtUY/Ccy
         zdKpKWGrDUy91I4tDoTcSnCoMNTmMSy79dgHc+QtXHzWnZKtofCTq61R5ERDDaKi78ho
         W0VLHb8720y/gN56UGe/TEfaXPZ+XXHrGhJzE1QIxHBUr+667wCvr3Ri8+zD7HDxngoT
         d+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938258; x=1702543058;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFYAQJcbliMGT3D4kBOifEL3kDjCqoAlJPtzq2V7r5s=;
        b=VPZOK0OD0ziA24Eg/DB6p68Y9V9/dIuBB+pIa8dljDyqG/LCLsE5IN+v8WbUXwEveD
         l4y2CsOb1xZcOyOFnFp6dAIgpYxo7kz0jmBUAr9ywmN58RgCJFlHFmBZxGLEG8l3b4Um
         tWqkJWaONE3/8bG9X11jW0USV4rR8gsM0DqMSejkV2w4XfetMQiVqn547Y18N3Jsq1uJ
         VlukjNSvBc5vlxbd42ODEqCe9Wqj8N/S/oPvy2VrFG5rmupdxrUcrwBccHa+Mexm6sg/
         3MsMIUjdQsIvYOBitYYO3qzGqV6bFUoplEI25lhYrW2MYiKsvv3oI6+jbWqPrrdD4rIK
         YMug==
X-Gm-Message-State: AOJu0YxC6XHwMTeqFNOtxjjHpyKw2PF+84HKQ1c9ZXwMqabUQkRIVKcE
	KtzbI/ZF9BCosqsjRZVikXV+kg==
X-Google-Smtp-Source: AGHT+IGZoqe1Ds9m9O+sUhEjYW6tx5jHstgF/NpE6GJ/eQChBP+5qsHppkcAUAReWBBoli+W1uACAQ==
X-Received: by 2002:a05:6000:1e86:b0:332:ffaf:d215 with SMTP id dd6-20020a0560001e8600b00332ffafd215mr1098886wrb.22.1701938257970;
        Thu, 07 Dec 2023 00:37:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o13-20020adfe80d000000b003333d46a9e8sm813637wrm.56.2023.12.07.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:37:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
References: <20231206-u-boot-m2s-fix-usb-gadget-v1-1-1c4c66cd10f3@linaro.org>
Subject: Re: [PATCH] configs: meson: enable missing DM_USB_GADGET
Message-Id: <170193825733.516078.7333267804190703458.b4-ty@linaro.org>
Date: Thu, 07 Dec 2023 09:37:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 07 Dec 2023 08:37:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1899

Hi,

On Wed, 06 Dec 2023 10:04:21 +0100, Neil Armstrong wrote:
> Since commit b96640cbfb ("ARM: meson: g12a: switch dwc2 otg to DM")
> and commit e327e2affd ("ARM: meson: switch AXG & GX dwc2 otg to DM")
> Amlogic boards now requires DM_USB_GADGET to have USB Gadget to work.
> 
> Add it to the boards configs as returned by:
> $ grep -L DM_USB_GADGET $(grep -l CONFIG_USB_GADGET $(grep -l MESON configs/*))
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: meson: enable missing DM_USB_GADGET
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4005729c0de234ffcf36465f6471755617b42375

-- 
Neil


