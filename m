Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A03C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:39:47 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.74142.1698334779279718109
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Oct 2023 08:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Wa7vCqwl;
 spf=pass (domain: linaro.org, ip: 209.85.208.180, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c5720a321aso14060271fa.1
        for <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698334777; x=1698939577; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arqpWE2KMmUYEmrqoaHtRhCK6GJjAWtzZr8k9Gd3y+I=;
        b=Wa7vCqwlUsP8RmAzzhG8YRCz2sq+ZgfxpHc6QkdADLxeWzJtj7fqentDYinK2daAEE
         AhCmMWOSJeQoXOnkfdMa/swJ9Zd6CBAPYhu4yZIbbR1WsMdZsl8Ma6Bfg5oMVTpqdKPJ
         E8BvWqr6xTl5dfCnD4NwgpOw4AuZ/5uJlFnjHaxYqqIuoJi62dQye/vtkctt1fWmq5m+
         PtRne3Gvi23ZQr2sIfgBJaZfOrTTkcdrakx6yDJyTPashvrbMdO81isJNiCQVbtcebG0
         l6s1T28XguJ0sO3/y1w+9TMWVP0OXu7/WZ4GV4UspWekjnLDaoLy/P0J943n4+uHgzKm
         p9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334777; x=1698939577;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arqpWE2KMmUYEmrqoaHtRhCK6GJjAWtzZr8k9Gd3y+I=;
        b=f68il+PR74Du2g3qHGzK5hh7VZY+B4ccsMvCxZDIjmrByGgtF5EwN60ZsBHzlSuV3N
         tExSnPpsHMSfAvkSlbiKSwIsb4WwFvZuMX4ee8dlBouoemAXpM23pdTonva3LshHF5WD
         PLNRXjuQOhzYivefoyJy4jvpTJiPpM5oBqkO+nU23pQ+6Oqp22h22DXN4g1ucNVfeuho
         DJTsokblaAMlfociuBS7T6LWMdNIkiAUXcjwXjGGJIRMTXOsnsJKQL0xH80j4kSu3lT4
         2cyRHj9oE8dKaDxzVWCn/5TwYN72Ng9khooN9iDoBEtG9YqlW2GNOjmyGZoi1mQiRLis
         LGyw==
X-Gm-Message-State: AOJu0YwOtmikDArASdGw7T1oEdG+06HBPkb47dbtLGkBXCZFz07cwITV
	mqmw4G/qpD96Qt6tIHY/0IoNyl5RFDwiIZHK2sp9iDFt
X-Google-Smtp-Source: AGHT+IEiMeIBInXc3gxSQtVnO6ZewFuVC0zCbQmDiesN+1di/WGnDAIGYRbP9Lxlhm5GLD54O+G4KA==
X-Received: by 2002:a2e:a4cd:0:b0:2ba:34d0:fa5f with SMTP id p13-20020a2ea4cd000000b002ba34d0fa5fmr12149557ljm.37.1698334777304;
        Thu, 26 Oct 2023 08:39:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w5-20020adfee45000000b00317a04131c5sm14495883wro.57.2023.10.26.08.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot
 step
Message-Id: <169833477660.2656704.15194374053051948359.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:39:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 15:39:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1803

Hi,

On Mon, 23 Oct 2023 14:41:33 +0200, Neil Armstrong wrote:
> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
> 
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
> 
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/4] ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/50ad9d01b6124b9730de957e1901d177094748f6
[2/4] configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/72f63d85fefebed59921456bb29138fbd9f73bb7
[3/4] configs: meson64: add alternate USB DFU boot target
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4aa027b3f8c1b018ab50570ccf337587cc6178f8
[4/4] ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/07057ad9be7d400d9d9f02f3c1507fe2d8071c19

-- 
Neil


