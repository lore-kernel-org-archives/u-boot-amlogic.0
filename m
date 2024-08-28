Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D1C5AE5A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:06:15 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.14158.1724853965028510226
 for <u-boot-amlogic@groups.io>;
 Wed, 28 Aug 2024 07:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=B3PvPog+;
 spf=pass (domain: linaro.org, ip: 209.85.167.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533461323cdso7862507e87.2
        for <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724853963; x=1725458763; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2WZQT3AXcVKhPpQoXVPmoz/yd7VwysOAd22GPJxSIA=;
        b=B3PvPog+EtvTdGniY1WDaAam5O3YY19SaqJ6whCtq0Sr4+e2Y73p+7cAMfpNhsHaMW
         XuwewVBdUixIA0OaMANoBG/T/oDAFDMQId5iptRV0XmqIQ9lMEszl8wWjKOG/qdOzUve
         yAOsI56PafKHbFryuvikwxBz3jt/PBKMymJ8OOG19mer0s3hRiaKk+9Iy1anWxQ1c3eW
         QOXXia09beBrw0oNa9eyOJoYo2+7UsIEbIBT0x3mc/KDijiTTlhIo9eL6tRxxYCCgc7J
         oTZKiYQ9ORRX7DWWIGfX7lXUScoYwJxmcBq7CCRCBciSStVTjGj5DcZeST6mKI8g2nP0
         ouKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853963; x=1725458763;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2WZQT3AXcVKhPpQoXVPmoz/yd7VwysOAd22GPJxSIA=;
        b=M0nZDXt6LoXmqqqWz0dwpQWtIoIUH9VmOYgqrh1iiUNUROs5mcDq8hcFIM0XIDAu5S
         wUoUvR4gU+H6/QDHucIRDXaS1Nb2KqOD+wpgWcGEjwqLPfLMsqIWm7MDUnd4mixQqu7X
         8HWntzHHmnCzQ5jViPirBAsInocFFTSPDxQyjxxDZXaXEkEHk6esj3ve0v/5KHTxbeGh
         t/rqLnxbMIk6nRVbvj5nlUK4o1ZR6lrb0Gg8+4tQeHyIuXGwmV0SYmUK14zMyRHJgiu4
         +CKUGVV9d4VVtt+V7j+PnPxhE2LLWerTwnqW7+IAvvzkVCByJ/ksniQr5kO/MSwsqaYu
         oQsg==
X-Forwarded-Encrypted: i=1; AJvYcCXD2t36uJV9BuZEK2XXoZMwMkbXyp2uRH5jXCEb/m2MSAInye3Q7eb4BmqnWd5Yq1j8E/MXciQ+j/VVN75ETA==@groups.io
X-Gm-Message-State: AOJu0Ywh8NaHuwR2oTAowAck7ztwPmL1agwKpc2e2JAJ9XrYTyCROHPf
	/LrsAysNrIXsrqbhC52aASieb/Lcs9V+oN/Bh9drktGF1vSam7nXMXxHtv8rvYo=
X-Google-Smtp-Source: AGHT+IFAjEGV4kYgRkr8+xQrjb+sKKUHazckpraQydnuVwGqrTATptXuilR3EEaaSlfsZVLG7pXCjg==
X-Received: by 2002:a05:6512:39c2:b0:52c:e047:5c38 with SMTP id 2adb3069b0e04-53438831da3mr11369770e87.15.1724853962169;
        Wed, 28 Aug 2024 07:06:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d458sm22620095e9.14.2024.08.28.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:06:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru, 
 oxffffaa@gmail.com
In-Reply-To: <20240826131710.29746-1-avkrasnov@salutedevices.com>
References: <20240826131710.29746-1-avkrasnov@salutedevices.com>
Subject: Re: [PATCH v3 0/3] Meson: R/W support for pages used by boot ROM
Message-Id: <172485396131.2557931.12598907666272642815.b4-ty@linaro.org>
Date: Wed, 28 Aug 2024 16:06:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:06:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2382

Hi,

On Mon, 26 Aug 2024 16:17:07 +0300, Arseniy Krasnov wrote:
> Patchset is based on patchset for Linux (today merged to nand-next):
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
> 
> Here is description from it:
> 
>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>  >  1) Contain some metadata about hardware.
>  >  2) Located with some interval starting from 0 offset, until some
>  >     specified offset. Interval and second offset are set in the
>  >     device tree.
>  >
>  >  This patchset adds R/W support for such pages. To enable it we can setup
>  >  it in dts:
>  >
>  >      nand-is-boot-medium;
>  >      amlogic,boot-pages = <1024>;
>  >      amlogic,boot-page-step = <128>;
>  >
>  >  It means that each 128th page in range 0 to 1024 pages will be accessed
>  >  in special mode ("short" ECC + scrambling). In practice this feature is
>  >  needed when we want to update first block of NAND - driver will enable
>  >  required mode by itself using value from device tree.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9905e77edaa9b4a43285e587317c600ffa7be7ca
[2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/33acfbf41819d06e13bcccf1ffdf7d01160f4b1e
[3/3] mtd: rawnand: meson: read/write access for boot ROM pages
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/35ff967a99e97b523732096628bdbc78758922f6

-- 
Neil


