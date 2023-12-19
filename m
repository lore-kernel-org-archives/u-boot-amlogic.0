Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A4C46CCD
	for <webhook@archiver.kernel.org>; Tue, 19 Dec 2023 10:25:48 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.9274.1702981543399474316
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 02:25:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Pdq+UjLz;
 spf=pass (domain: linaro.org, ip: 209.85.167.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso3533999e87.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702981541; x=1703586341; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTmpIQ5uJ55fmw5WguGxSd/4pQH7vc/z7/S3eLSI5ew=;
        b=Pdq+UjLz2PMdKwb/ighhfX+2U3v2BzYclVQ5eOqHd0ft1aFccWZ57mF/CtPKAAV6DI
         QQeLYhDbyj8d2PoP64J4WMB/pMjBEPiiYa3NkXbfwmEqRMvuhsI78IQB2KB2X5NxdPuc
         zsX7p6n3JgJemeCuPHVSAyrHQk/v4EqhFkuHJ1t5MwbEf1l5VLGIhnrxicGMuAF70bsX
         XDxooxj2PHOPpMKpVSOroppKeLNJBNDkt1QKLDyJ77F0NgzOILz3HC/8IaJkw0qS0lux
         vxHYikgiKusuhsza7ciAKB1YuW0nyBWclSYLHrOajma79lEtgL1yp5qTaxl+00cMWNE6
         0zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981541; x=1703586341;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTmpIQ5uJ55fmw5WguGxSd/4pQH7vc/z7/S3eLSI5ew=;
        b=BXK4KTA4vxQtoKgN8tzEOqV8FXJAxkd7XThLmDPziWuhpuWm57/VRnN48JJqPLdLUB
         sGWgRmK4JoRUk8kYCoWFL26RqOeQSZe3PyC05lYsEhh9TNrdMOFb1S4NJT4DWs05oGCL
         8LpQ63RyexO42MP7B9kb4qsx3FjKEkDZ7bPGwKZkiKscgHW6s6sO/Ru+gtDOcKomLuxo
         Ijgd5dgE2aJX+Lj8AsMfsr8JX7aTWEF2/2JCnABgLTlbfRTuEeXfNw8NNqdIiBWSemfx
         9EgbLXTNjcwjhhTY5p7hXsUbOMj9A1F1qqZHmicMpqFr1IfumaSW/jUG+T1OIapGftEU
         R4qQ==
X-Gm-Message-State: AOJu0YwSoWCaxJV90Abo0zPzB5dnVOlMwtMo02UkM2l9J/9Teb4KctDR
	nl9mj7qBpJqecuzbZrIZVRK90A==
X-Google-Smtp-Source: AGHT+IGABhC7+tEvq0ldBvb+lw2+hWyyqprYxpLVUmJNqMV+Ssudq1GnQUzoIqEisREV/cB0mRtFdg==
X-Received: by 2002:a05:6512:60e:b0:50e:4abe:1458 with SMTP id b14-20020a056512060e00b0050e4abe1458mr210228lfe.58.1702981541424;
        Tue, 19 Dec 2023 02:25:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d44c6000000b00336641feb02sm6601552wrr.19.2023.12.19.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:25:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
In-Reply-To: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
References: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
Subject: Re: [PATCH v2 0/2] ARM: meson: introduce GXL MDIO mux driver and
 switch to Linux v6.4 DT
Message-Id: <170298154059.2696754.2520395230867810319.b4-ty@linaro.org>
Date: Tue, 19 Dec 2023 11:25:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 10:25:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1945

Hi,

On Wed, 13 Dec 2023 10:30:11 +0100, Neil Armstrong wrote:
> Linux v6.4 uses a new MDIO mux driver for GXL boards, let's port the driver
> to U-Boot and sync the GXBB/GXL/GXM DT to make use of this driver.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] net: Add Amlogic GXL MDIO Mux driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b4534ddefff07a083c84c11d944460ed528df435
[2/2] ARM: dts: sync Amlogic GX DT to Linux v6.4
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb

-- 
Neil


