Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545FC4167B
	for <webhook@archiver.kernel.org>; Mon,  6 Nov 2023 08:47:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.50209.1699260420816677381
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Nov 2023 00:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qpqBuSEH;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4083f613272so37096095e9.1
        for <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 00:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699260419; x=1699865219; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSusEc+mx0fyJT4POwsV/GeE5If486jXOVrfD/bvFCk=;
        b=qpqBuSEHvAAf3NZf2cFFujGTIqV3getJSC0yKpxc+eyP1J0Gb3JVud5l2+/5xo8wJI
         a4I0ymgy7pHB4DLBG8cUvmwgWIGzx8lXs0u3E2liIbLZL9TOP4yL4yj5kUnjKI8x1t26
         ik6RT++EOYGkV8dAJHotpbNH7GUTz/4TUAjAitPK3NTduowKzR8v+PAYAlh7zWkd57ai
         F8LCmXZZVHVbr5z86dfZC4dqMdo4SmWaJqanID0ZPMttXzCbYtBmFMHHH2J+tM2GtiXw
         H+PBPOMRSxT4oyuXm3HO3UbH1hOXXsqlA72nh8HY70LcJfSgFf90GdClxeXc/yyF0+yn
         +M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260419; x=1699865219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSusEc+mx0fyJT4POwsV/GeE5If486jXOVrfD/bvFCk=;
        b=fBwCEWtyXxOH8S0TApxvmnTeD3Dnb37P6A8DQQJIQ4ms0oppgLzdChOUA+EGC303f7
         Dk3EoXyuEt4DZt9Xd8iiF82L1XArIdKcP+JNfHknr3JJIireHCHf/xERqhJCZ/EsuEnE
         bq4U3DLLUUABYGq4p/GZ+xAtT5UwL5QN6+X+FYHMqtOpSG9iibIzQy0B3xdWxSmwBmP9
         UCdaXZoBOGiC8FK7iHms+vQ2QEdfHBPT/wVpAbxqtlCUv+1Xi0Kc0VE3P/iPYGHsNj6i
         QpdPu7MWhDCvY8T7B5qBgJh8tFok5lecZnhqWGcz2RNuTYPWr/HDlRnvO3Cz9di8+2gT
         O5gg==
X-Gm-Message-State: AOJu0YyHKIYg0c6jjVuctpGmyn20BiyK28JH0qumSGBAlBrCjkZo7r6Y
	vwGZof+ZJxzlG2gJqZB0r44M7w==
X-Google-Smtp-Source: AGHT+IH4oBwB2GMU2ZEWUDiwnC0sE6KNZLOy/RcR9PI2fGgqaquVMeWbV0EEJJEZnCjCQ9PALZWE+A==
X-Received: by 2002:a05:6000:18a9:b0:32f:a5af:99ca with SMTP id b9-20020a05600018a900b0032fa5af99camr13394643wri.69.1699260419324;
        Mon, 06 Nov 2023 00:46:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600004d000b0032dbf99bf4fsm8937827wri.89.2023.11.06.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:46:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
References: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
Subject: Re: [PATCH] ARM: configs: libretech-ac: enable USB_DFU like in
 meson64.h
Message-Id: <169926041874.983914.10761301521289002030.b4-ty@linaro.org>
Date: Mon, 06 Nov 2023 09:46:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 08:47:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1843

Hi,

On Thu, 02 Nov 2023 14:49:58 +0100, Neil Armstrong wrote:
> USB_DFU was added in meson64.h but is missing in libretech-ac.h,
> fix this to enable DFU RAM boot for libretech-ac.
> 
> Fixes 4aa027b3f8 ("configs: meson64: add alternate USB DFU boot target")
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] ARM: configs: libretech-ac: enable USB_DFU like in meson64.h
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/c550e81171940932664a85bda315a6a073aae23c

-- 
Neil


