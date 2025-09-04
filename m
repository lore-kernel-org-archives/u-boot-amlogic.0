Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA3ECA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:39 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.35204.1756979856938505825
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 02:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Ix+0RhDk;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso13712955e9.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756979855; x=1757584655; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH9lIj4KRAqS5ZvNAtgqdZC1DHLKUcfxSY8W3+02R1Q=;
        b=Ix+0RhDkpsGSOVUqF9kTi4PUiTmW7/zwtgcBSfPua4jmfjXcJOPaIKivMZStPH3UBb
         0AoKCI6cu/JNKlFD/r6a+NvNwrb0JONqvrdVU9GG1E7NMrmIICESAhFe+Dz7ZakgFoJb
         yA7icX6vLfB5FgSj0vg7HpaS2/W0tjrt6Vxy+AaT/hQ7iJZFKy8oK4dDNhe5hUj3yTsD
         RFnqai2Ja8ry6GG/wKwpilGxtpURD2w7Lv52dBqELRdwyYwcs7Ol5J7B1E+vlT1t7Vbd
         Q6eZHEVMg/5GGvyf/br1u4i4/8LR8J8wMQGvb9mKod4kTmrHPfwomkrrvMGFQXPjn0HB
         RiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979855; x=1757584655;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH9lIj4KRAqS5ZvNAtgqdZC1DHLKUcfxSY8W3+02R1Q=;
        b=M0GiO7pf3VLbfwEA3ai379QdN8mch/2xI81zQAzE7riMpQe68+AQkdhGp1+YKLj767
         dOC3RNWyxsnHOxSp9TiGQyTbAtFig00WFbO0ituHjcQMo9f+uzpY1vgtVsv6vz6XIrlE
         gi47qXS0teVMrRehVjgusZhjv0qmJWONHzgW3Yung0mgztFykz9lDjgS7ieag0EaAaIf
         0QvihriKEMpElpmY3EDKJc1dTpZNmH9BruoK8cM1miYLgYIZbgkDJZg9vX9Tqw9fg4nO
         zgJHyLYIUtPNQnbKhjY1dr/GxGKw0aJ/YzF//Wc1ux9RDJCRkEW2JXNP1IhPjwj4K9Ek
         E3/g==
X-Gm-Message-State: AOJu0Yx9EX1QlvJDxXUXOQP663wDfCCX6BXx+wO2nC7kTO5ojrkZRpq/
	sNdaPx9QEi1Hm/zHDM6dyvZfOgbmBSKR5L7UyOvEuG5JmoMz8hv/NU+rBKc9j/7IiC/AQAZzkql
	GXotdk2vzyg==
X-Gm-Gg: ASbGnctw5EdYvxg4TbyRQgCdv0a4yW018tdfBNnMq4Vn28am6DfrdgUKdlhTjd3/P8H
	xYAc+LwPpfTcsq6n924junwqUPCBKRGoKgPnM0yPMpP5rm3swof8RTG8AVGxTqc0naJinXKLWaM
	usN1yYGQo92IYTxiYUW0G7IyudMe9QDQCEYZCLmd0JbR70zNXu7T/RyVRALN4WcTdw3NgMP2pEm
	PHo1YKp/j+PNODq/icRIm/pINkfTfshOEbLPw1bKKmRRoAzyZF2ZE8InEj3n0mJihCq5xUEIDC1
	zOPSsaI2kjzPEtXes4vV6qsOtRbEkudUj4LyxpSmU11eEJ1zqcVPpLLuSniGRlPj+vfD7bx+/Hq
	Mka83DcN8Rib0gjCiO4ziZetrCToWPUGYHx9Gckyjt77DJ3M93C0BYpjZVvvt3t/0
X-Google-Smtp-Source: AGHT+IFIk6M2M5TKdRkOb/L9hpPVHuyMbk0VSo4H8rCXu1yZelD4gDeFgiNyU7Vn57/zD0V39TXQtg==
X-Received: by 2002:a05:600c:a45:b0:456:2139:456a with SMTP id 5b1f17b1804b1-45b85599135mr158530685e9.15.1756979855330;
        Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
References: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
Subject: Re: [PATCH] pwm: meson: Stop premature exit from for loop
Message-Id: <175697985489.2904655.1249756606342116521.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 09:57:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2742

Hi,

On Fri, 08 Aug 2025 10:34:43 +0100, Andrew Goodbody wrote:
> In meson_pwm_probe the for loop attempts to get the name of a clock but
> the following if..else statements only perform useful work if -ENODATA
> is returned from clk_get_by_name. If clk_get_by_name simply succeeds
> then this results in a premature exit from the for loop and the
> following code can never be reached. Make the else clause only apply for
> an error return from clk_get_by_name.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] pwm: meson: Stop premature exit from for loop
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dfa8b39a6addc09697399c5204766958eb0dfb51

-- 
Neil


