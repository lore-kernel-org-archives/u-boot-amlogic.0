Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD8ACDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:46:35 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.276876.1697615192480174575
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ykyyuGPz;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-407da05f05aso11138945e9.3
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697615191; x=1698219991; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2iaCkNz5PyTYLLeWze69XDFEBNEFZ6jMXPxx/Wiyh8=;
        b=ykyyuGPz48hXu+LJQ0skPPwT4q9sVlu+OAus73Ly0BfwJ4F3hcuICggb3bPZgxsQpH
         sXXJRP78/yolyzFGYVdIYN/pc2HbN8Or4S/JJdpXf+RKKeXyT3VfQipnZumn1W4kGG06
         7nZWeJntQAQIFtjChhDclJrMHZKoWkeNDCy8DInKmZncYSbbF5w9uN5y905oX2eDADSx
         J4StqvT4yUvybeypB8xtg29NuNtFFuHlxNzuOMKf4i7PwqYsEtgh8A4s+1g+nrQtUm43
         8e6IkBui2zdJJfb73+zxehFtGLi3Z5xsxKl8BTaiz0DOr4+ccN5doS+d9WQtmqxhJOug
         BYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615191; x=1698219991;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2iaCkNz5PyTYLLeWze69XDFEBNEFZ6jMXPxx/Wiyh8=;
        b=Ifur4AVjjWTxyAquLRS0M2YXjif2fymvHlaNYfS4JP+gwcc5rGaBEAIcnZqcfLVDye
         dWAwxCi5ed8/4rIbBP2o7MiooX3+Kqn9+aepsyjHwvGA8wVxrQKLm3kxptXPYBjUXXy0
         FVfzV4xy67GQxjXPwIbMSku4zdGN2NEpVFJuytkjWQ436qiBgbUskgSKMc44FjQlmjuQ
         OPQvKSax9uVIHe6OnN+JEWsyfk0MeJM7iTd/9IXZ8SA/NqWGNM6h8ZHT3OsgyEh3trlv
         jRVkW4U0FTDujXzNrbBVkhoI3IfwaLywcepcphHrTFchXA9Qe4cpM4c9uP2POD7sjM2y
         oUWw==
X-Gm-Message-State: AOJu0YxxEXDIzGg8pd+PK/uUAA5XyPWTaod0v9t/KlujAK+VshWegdu8
	8s+vq/MP6b0KyVEjuuVpYKsxOA==
X-Google-Smtp-Source: AGHT+IFu/3ySnVnBP8TWrRm1sgT9tTbJk7Lga39yOQfAQGkW2Y5NsfKHxYWSXt94bW36iTbxv6PfxA==
X-Received: by 2002:a05:600c:1383:b0:407:859c:a1b2 with SMTP id u3-20020a05600c138300b00407859ca1b2mr3328613wmf.14.1697615190796;
        Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b00407efbc4361sm941509wme.9.2023.10.18.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20231017213211.121550-1-ivprusov@salutedevices.com>
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH v1 0/2] arm: dts: meson-a1 Sync DT with Linux
Message-Id: <169761519014.2954297.493814791807948421.b4-ty@linaro.org>
Date: Wed, 18 Oct 2023 09:46:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:46:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1784

Hi,

On Wed, 18 Oct 2023 00:32:09 +0300, Igor Prusov wrote:
> This series syncs Device Tree for Amlogic A1 with Linux. Currently
> DTS in Linix has different compatible string for serial devices, which
> is not recognized by serial_meson driver, so new compatible is added to
> driver as well. Additional driver changes are not required because new
> compatible only differentiates between ttyAML and ttyS names for serial
> console devices.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] serial: amlogic: Add UART compatible for A1 board
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/43a0b2cb9be2320615aa1cfc5318857ebce3b488
[2/2] arm: meson-a1: dts: Sync DT with Linux
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/14a21f1a80afc58d52dc72e35f27d3a47d36c082

-- 
Neil


