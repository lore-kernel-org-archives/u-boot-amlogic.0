Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05798CFC500
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:06:43 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.48877.1728889600807578815
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 00:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KS9MyPgg;
 spf=pass (domain: linaro.org, ip: 209.85.167.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389917ef34so4309482e87.2
        for <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728889599; x=1729494399; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U3GuIXHY3cSD5k4kQqUQIyL9BkhSt16J0D5pni9fsk=;
        b=KS9MyPggoSnoJUjEjM+gLzEPW4a63Hyp0L3dr56wKLxEiQ1sNiEQqgSZDJ4dXTfOr9
         u2Py8e4kJ/QQlTpb7vXdCsC49DG4tp2aYmYnU+FAK+pqHFg/zUcoJRCafsXJCkmA5TqB
         L3v4b7UNUjsJwTgNWbBy4VEYzovMhSIHP/lvplj5kYYW04tYepMkhIOZ2cCV2eNR98cT
         tyiLpIQv6GAOZ0irsPW9MRsV1Fo1kakHkAIPja/3wZVKCHxjvHnws5pC9icKDuBBR80n
         kOW+skGmilNM/+oLoy2wVyit/xWlTbowtsGAozkXqYuj+TQZNSpmRWjnft3bg3HI1prY
         qx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889599; x=1729494399;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U3GuIXHY3cSD5k4kQqUQIyL9BkhSt16J0D5pni9fsk=;
        b=SoDXwCCC6nQMuRXqSR73QbAibaopcgmbEXdLif3BpmD9khV0EIPKN6RSq9+zXhLyUA
         aVIJ9vbP/EXqmzMlKierod525RmOFbQO4PCrwXdOcGPBLNpQ4ANIvLW1GTE8jGPY+ChS
         DWwz2A3p4UvkcCl+NBajQl1nuulY3On48Cfmb4pS62/Th3rR1KggA1c4y9gi7EYRVJaC
         wcx0MQG4iKatntoa2ZOl6CV4mG0/PH7VKBoB60I9lNvMS8pX/t9FjwO9s4sTE5wuspOq
         zrL9i7b+WK7JmNcGSjjS+3Q6pXrKDGFdPR//BYR7edDYgwoxgZBNW9w6Y5CnU1EXV0R/
         5M1g==
X-Forwarded-Encrypted: i=1; AJvYcCV46mcgwWBIAhfzFgL/zvRGj9d+6e5OocADVPJdNwjdCng2Sfz8hQAXSXtY+pMSszSm7HlPOeQ20+xrV2LpVA==@groups.io
X-Gm-Message-State: AOJu0Yz8vkYfrpXBkoH1rxDEfyn9zXYVMH0SBaLKU8tZaJ0JTyZMyN9q
	bjUcG0Vk3ZVfa9PQQX1sLcvDE3BCndYxARBT/kyH1Phs32vNe5/hOeV/BUT8RZ4=
X-Google-Smtp-Source: AGHT+IHZL3ShY6Vdeefe7PxDPwaAPFS/6O+Gpq3oyUKG4S/D4WluxJ/c3CuAetBE3+YU6rRrCa6M+w==
X-Received: by 2002:a05:6512:3e15:b0:538:9efb:dbe4 with SMTP id 2adb3069b0e04-539e5732139mr2017561e87.46.1728889598865;
        Mon, 14 Oct 2024 00:06:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43118362232sm112355015e9.48.2024.10.14.00.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:06:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Subject: Re: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
Message-Id: <172888959800.206113.1581753403828595952.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 09:06:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:06:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2480

Hi,

On Fri, 11 Oct 2024 17:51:01 +0200, Mattijs Korpershoek wrote:
> Recently, some effort has been made to use the
> upstream android-mainline kernel on these boards [1].
> 
> To use android-mainline kernel, we should:
> * Increase the boot/recovery partition sizes (so that it fits)
> * Drop dtbo support, since these are not part of android-mainline
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] configs: khadas-vim3{l}: Increase boot/recovery partition size
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ce138d9742bfa15f48462c22f25424e0fcbfbb24
[2/2] configs: meson64_android: Remove dtbo support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0b063d66406e5bc0f367dd735216abe6a6543271

-- 
Neil


