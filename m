Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6069D0D79F
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:20 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.13513.1728657735843347539
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KaAbJ3Y/;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4305413aec9so19172285e9.2
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728657734; x=1729262534; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRcv7osLv8GG3JVgJNSN589Vr5QBk9sct5/iG33DVrI=;
        b=KaAbJ3Y/t3bk3pBAjXMmSS4jcaWl014U2e6thsWwSFzhZTnIe+xZZTvf3e0cwUjCm9
         gqilNBAUtkfH5xCdm/dIRRauFM0x7r26clvkr08dSKJw9oZwbpxoDR6DaHBL3/B2xX0z
         dLQzkTktcX8/pdwEXdRtDaRcdN7M3daYA1+mVCSJNunolpzknA/9QAd0TRjNcIkV1WgM
         hQTx8xOgynZ8Lx97Xm35uDd/upwu2ln4k0OyMJhVlWkj1eNv8bKkVq4B5MP0o4RK1g+o
         CTF+UK+VE//lS6CnsKSpOLZpXT/qqtiTuOOzDPOMv367VdszCPXrHjFsi0xaZ1X9hySV
         zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657734; x=1729262534;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRcv7osLv8GG3JVgJNSN589Vr5QBk9sct5/iG33DVrI=;
        b=lmZWh4k2p6rMU8WgT//HeD2j/147p8UP1JGsF5IaQmqW5xQYUia19jsdsPWkoJy6Vl
         WU13GjtBACC90Xb1ydxC1SZ2vMDqGchyCQJjHQkUaRzCq+G9/ofsVAJuEnFgexBCl4JB
         FP1FgFLXR2AEYAAvDHIytOK/QpirSTI4mLRgGhgLhoO4SmwsDhnya52FRU3ScpywBb3a
         FevQgTsIIQf501ZlDe5gLCCrpmjmudDjDsog1oR/TxpPMjQAJO013u+4In7tWBuICQHB
         qNoSeYmdvMn1m8MbmIaiN3d93VVLuupAlbBJoyVDWr7O1NpqHb12Wz0uKwywuCK4oAzJ
         f5bg==
X-Gm-Message-State: AOJu0Yz3rcPAcH3PGxkz3r1zhk+uAxLLWn0r2HlTppAzLObJeyNNwmsT
	AkxhlrxbUlwXWLmNwhwjYXShFQWxwiUapYnvqA+jEGYsFAOEGOmPpJpYoBLTqVip1Rv+kIpws5a
	6YuI=
X-Google-Smtp-Source: AGHT+IG71AiRlqJcDr+aY8i4N4cnOUSmc1QP+oxc3bghWEOkwz5jrBpe8NQXk1gZrJmH/8VNZ8dlnw==
X-Received: by 2002:a05:600c:5248:b0:42f:7ed4:4c26 with SMTP id 5b1f17b1804b1-4311ded3f1cmr22103015e9.12.1728657734246;
        Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:42:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
References: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
Subject: Re: [PATCH v2] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
Message-Id: <172865773344.2734796.5228507096974795702.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 14:42:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2444

Hi,

On Wed, 09 Oct 2024 10:01:56 +0200, Neil Armstrong wrote:
> If the regulator is already enabled, this happens if the regulator
> is set in regulator-always-on, regulator_set_enable() return -EALREADY.
> 
> Ignore the -EALREADY return since it's not an error.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] video: meson: dw-hdmi: do not fail probe if HDMI regulator is already enabled
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c472742f5c25fd4098e034a7f292cc4e26bd25d

-- 
Neil


