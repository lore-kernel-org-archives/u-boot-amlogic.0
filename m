Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C7D0D7AC
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.13550.1728657735056689086
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:42:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=P3PEEAB8;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so18394805e9.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728657733; x=1729262533; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St0+KCR8ADle3WrgLbtS/B7LfB9Uyf2ehRhy5pA8oO4=;
        b=P3PEEAB8RkCBf4DZEdwHslqUyBNBkinRhH3tBjNGzJPx+F53LLukM02AQKpc8Ed5+S
         EwwUpDXNyen8HHNSoD14esP4SIRoJI/gPY/d/sD9HMka9xldCOZapWKNKaBwDkNec5te
         uzOeKxbDRs1rONqh+AvCNvf21j1bvFKcVE2RSNLG7mfWixstuMUuWMRFr86/rUh/aKoX
         Y9dUTuBdrbkAcXIZVTB2kUKx8SHBOtiqbK2h0WESe+CXMxrIXlxyovnW97GnahJUDhB6
         7ABePw55urk/UGtYWSuFIDPPLk96YPzI/7cWcoJJSWDlK46Bzx38KwopaaCHyFsfV9UN
         6zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657733; x=1729262533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St0+KCR8ADle3WrgLbtS/B7LfB9Uyf2ehRhy5pA8oO4=;
        b=l9idjvC9VF8XicLnWoXXvMOek0A8tgSoTMoHq3RdEk2wYI/SSTihKUuydo9uWRGGi8
         ddkGRn8HVpM3o8lAOrx3M5stMyq5kPK6VjcuCtg/uEZwxZVBcEsI2Ul9SK5RVdtxHR1R
         2XAq2Oechf8wd7LJczq7Yl2y/yyXTuvg/W8xi9Cutx1MDwkWms49GjUUaOK8XnzbYbWc
         lWY9vunBS5oh7ACfo5lVnNv2uWbdoTFsWMuG57yNsxAWfiMgtRih4OA16xKb0wUQ5QB/
         WTyKOHLxjTCzSF93Cz9s1XhZO0cWHfd3mLPZuV7z7M/yJI4p9uwpFsgCQli+95uP++pi
         Yt3Q==
X-Gm-Message-State: AOJu0YwBoS5rvs7VsK7CbwUsDhLBuwGCy+VJvW9vkVqzXjoeyhuQuzT8
	XO+okJmgXZyd4e2bzPVu1VAQm5URiiGDpSpSFNeHuWuof4LeFhcXL2s3M5nKNMM2x8zZ4Lll70x
	T0YA=
X-Google-Smtp-Source: AGHT+IHAEa45lyzdrJPpQSvv5B3hRcoo5cQ+AQEmonuvgFm0+ymMwDgK5x5meT0Kuk/HyaHuN+bMyw==
X-Received: by 2002:a05:600c:c0d:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-4311ddfe1admr24385215e9.0.1728657733340;
        Fri, 11 Oct 2024 07:42:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:42:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
References: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
Subject: Re: [PATCH] dts: meson-g12-common-u-boot: do not disable canvas
Message-Id: <172865773247.2734796.15355801164336792382.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 14:42:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2443

Hi,

On Tue, 08 Oct 2024 18:23:42 +0200, Neil Armstrong wrote:
> We were disabling canvas, which causes meson vpu probe failure,
> just stop and leave canvas alone.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] dts: meson-g12-common-u-boot: do not disable canvas
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bc1eba9aa2a5a4cbfe3b2d38a66888e6ce370620

-- 
Neil


