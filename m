Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF4CA101F
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:39 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.35201.1756979855122224660
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 02:57:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=h/0VAk4z;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3db9641b725so742239f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756979853; x=1757584653; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2UswoCgddvlGcR9+Xfr5ukOpj5bLKzFXFzWUra3lT0=;
        b=h/0VAk4zeYnU48KUKDBZGT83ZTnY/w0w+Dxgm+PtzBTIUR6zQbcvFK05s3CtFtDBOp
         FasaR7ww5iv2o5xMvGlY+bKSwrxucPhIgcGySl/OfoOrLArK3adnsvYdUcKjc2gLTw5t
         JfjPSq6xjYduFGu3vfUILPOmm7he4776gug8doPLsTfJln8UatG1VYVXV4fqkCUhakAE
         ExEgBA8SKEUkUd8pzBH5RKAUKnZIPR53nCXIaC6jiA0YUYLipDcnNwTBjsX4AaB+Yiki
         kWN7XQSkDPnRxa0vH76SB5MnSPwXBwz+km8SCro47PYv9aqNmtl5qKByZQXnoH7SOXPt
         L0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979853; x=1757584653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2UswoCgddvlGcR9+Xfr5ukOpj5bLKzFXFzWUra3lT0=;
        b=wxFQFmWA0BxoiTUdvGLDPXZ8rtlmDmg32LKeauE+jcayy2wYneFn66ZdxYWzPjGuNN
         tbPzYW13u3I55P4ABmYkpuyRK8kY9wpfuH7pKcvVe8vlkcV9zxnM4LKkVQ/dLMpwL1r3
         Zihu611dJS67S5fOj3rskbvaDDG+VkYWvLgpCuL1bktCH0CaOnY/mby1xCakthXQ9k0I
         LBfn+kUHPP5vpK391erZMuay014RcsenzJps96yZBe9pehCsjZfqAhbUJ8MjQ0MJjkI/
         ek2mTAntcuHWggAYUr0ZjN2FXtDmlo371zu3Vl5GPu6ujEKQIM+jRxeqdAS0NaYqzUut
         tvhQ==
X-Gm-Message-State: AOJu0YwDwpqZhUwY7tqeBOq/TOqYznHHqQhR1MeYGFJi1PWq8fiqJG6d
	HSV1C3KEvFOdLFJLLDXW8rODj/60KmBUlnPUP0KHVPKgYHM6T9fB3OKY6cmeYzlQSeI=
X-Gm-Gg: ASbGnctesZRUY8JGlomFh/3NEZNWXmWLbv2bTg8bX951dTLYjyAawmeUrrpXAxWnXLA
	o1E4aj4OqVcCt04AiyDanvQ0DvQf6nbu9w9YVs06EMx0pxgR/5ehPAWXk9pZkF42hvOwPQlKPBv
	5cjfEKpDJoJ7kxFT8dhmPoXzhcoKkB84E/ATaUivs/KHcIWeG/oPCOLD7x8aJ6uz5W3Cpes8EwR
	MHLKXE4bwOaChbsQ5tnv1b+noeiwwv0IbzRU5QU8EKHz0y7wogXsoBwOi0isbfSe6UnVjxJMl9T
	id7LKiS8lj7aMdxAbaNR99pCyzQ23mvMXHA8RvZmTBOSRRzl9iZCX4RpMKTTVOqgziAZIic4fTx
	bXIvRGCF08rQDb4vXyK4iHaODaPp61sefQIRz+PVyApCdHJrQhbuR3Q==
X-Google-Smtp-Source: AGHT+IHPEY54lbfVYVFgJjUQFyGmOaplufleuH58d+hZfQ1VzD4iDODmJ8BUOIvxwiUdhj1jqC2E6Q==
X-Received: by 2002:a05:6000:2185:b0:3d1:e1b1:9645 with SMTP id ffacd0b85a97d-3d1e1b19cd7mr12386791f8f.43.1756979853412;
        Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Yang Xiwen <forbidden405@outlook.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
References: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
Subject: Re: [PATCH v3] pinctrl: meson: support gpio toggle command
Message-Id: <175697985281.2904655.15316444778435911414.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 09:57:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2739

Hi,

On Tue, 17 Jun 2025 01:01:17 +0800, Yang Xiwen wrote:
> meson_gpio_get() always assumes gpio is configured to input mode. This
> is incorrect and breaks `gpio toggle` command:
> 
> gpio: pin aobus-banks2 (gpio 2) value is 0
>    Warning: value of pin is still 1
> 
> Fix it by adding the logic to handle both input and output mode.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] pinctrl: meson: support gpio toggle command
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/879cde9383621ea05f73d1103e4e0eaa8346a562

-- 
Neil


