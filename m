Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD66C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:40:27 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.203708.1698334818080941616
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Oct 2023 08:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VSOBSDp3;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4083f613275so7954035e9.2
        for <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698334816; x=1698939616; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muSYw7lzaJcwm4ACVS22wbcZfBvffUQZYMjAC3WR6Js=;
        b=VSOBSDp3hRAdW8k9QAFS73n7ksOSKS9s7NIqV9T8WiLgwPW0jjNT4osUMZLvtmvgGv
         Oo/WP3QuuuEO38VEBqZiIvhOVooV8i4v/oW0d4awgFB7dZzZeqk16s6lVJE2HdWNWPkt
         ieXS50/mRpamccwQNdEazupwAfE829nhHB3VGQxiCSV3rivtdtm/axIJzIyN5wsVwYIa
         szXqEyIJvR8JHkofs6Vq1I4748ejW3dVuFg9q533QQReF5ginfMN4zNn1p7/w71hmmio
         N9VVMw9CgxgIs5C09sXFCym9XkqTaZhiWF9dGWdxUl10axC4mAQP/+hwGOgDL3sFTBn2
         UVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334816; x=1698939616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muSYw7lzaJcwm4ACVS22wbcZfBvffUQZYMjAC3WR6Js=;
        b=ZiS3ATyER+oSFhna2bW/V8AvqUR4jEbkSTomZdGOHQ7hUXWeQ+HA1OaTBThWH6PI8e
         buxcUV62CkwNIsAznLz7YZD59lIteejlMmyTOnGM7cyC3Z3xQLSmAI8gpFd5xvb0gDv1
         CzgQzgEaPdePZ33655RjHong1CbgzARSutzzLnYvn/Avf+fL6/RBCPef2kP5gmyP6Wq0
         TLXOV3snWQNBiYYzZQQMVei6dzkxTuFqUnB7+IXi/TGnjs2/5OvH380YuTEsBl2b2tjW
         zspBVRq5i+Jg5jFu65iBFGMWrJQBUhoeplzMu40fcvP0Q564Ylf6JVtmCWpjgytVXEg2
         Pv5A==
X-Gm-Message-State: AOJu0Yx2mUo0UkS2WD0eKbfLTUdw4LJK1+wsv5lzo0yznJoqd3XjyrHx
	nMPfc4dtEY2tlwdVEdPB5BtCzw==
X-Google-Smtp-Source: AGHT+IEfI3n/CBj9bCOvuCAdR77ymvg7U443RwwulXhb452bHI4Zbp6Coscre07W5CPB1WLRwbyW1A==
X-Received: by 2002:adf:ee82:0:b0:32d:a853:af6e with SMTP id b2-20020adfee82000000b0032da853af6emr6888wro.1.1698334816539;
        Thu, 26 Oct 2023 08:40:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f5-20020a056000128500b0032179c4a46dsm14407967wrx.100.2023.10.26.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:40:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Igor Prusov <ivprusov@sberdevices.ru>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, sjg@chromium.org
In-Reply-To: <20231024225140.366571-1-ivprusov@sberdevices.ru>
References: <20231024225140.366571-1-ivprusov@sberdevices.ru>
Subject: Re: [PATCH v2 0/2] ARM: amlogic: Add A1 SPIFC support
Message-Id: <169833481579.2657867.140379270621827287.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:40:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 15:40:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1804

Hi,

On Wed, 25 Oct 2023 01:51:38 +0300, Igor Prusov wrote:
> A1 family boards have new version of SPIFC controller, that is
> incompatible with meson_spifc driver. This series ports A1 SPIFC driver
> from Linux and enables it for ad401 board.
> 
> Changes in V2:
>  - more details in Kconfig help message
>  - removed unused field of struct amlogic_spifc_a1
>  - add missed check for NULL during probe
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] spi: add support for Amlogic A1 SPI Flash Controller
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bb6c1ebf99da01f2cdd2aaf751cc35723ed202e6
[2/2] ARM: amlogic: ad401: enable SPIFC
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f22373511ca75bb098c3195e47f91d2b1ee8bc53

-- 
Neil


