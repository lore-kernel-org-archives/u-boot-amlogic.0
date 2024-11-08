Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16961D5E151
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 10:11:54 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.9548.1731060709512225668
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Nov 2024 02:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=igQ9gXvI;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so1227917f8f.0
        for <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731060708; x=1731665508; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ0bgWeCbSkHzCltvI98cTC1Sr3lNHUXnvOtT/tVHic=;
        b=igQ9gXvIuaJoNvvb5Zk/Y5RhlAstaDMGkBY8sU74VRsybMLsaDMdr4yHGTdfcrVm6V
         C32c1S3vwr9xbGT3WP6jLvFdr24rLD5Ep79yN78BV78GdQETjFjNZN7v9SXXB643UqbB
         KEbeefFAA6dVlx2B0XSEuDAWVzIXeGtRzlXZkVOTSVuevWyQ7we9KZXIFQwmOtE0vWJG
         J3jjhG0lZUZMQfW7GKKtGE5lQrYKsmvsFxT/pQot1O+5kTtuUl7bsjyiGhpUr2UDVuTE
         Zy9k1Z6G6LPjwx2024zApDv2Cw2eppsAGs4JMqgflteKYnfC4QMWcn5k92NzxtoySgus
         x0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060708; x=1731665508;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ0bgWeCbSkHzCltvI98cTC1Sr3lNHUXnvOtT/tVHic=;
        b=rRlyF2qw6CHebdcl71Ym3ETQWOKsFPJXs8aKuUfZyrsmUU95d5H4Quj1klmZNviE3B
         d17namL79cDIGCzi0mxqLk+8xmA+XgQ44qjVvNCgut2t/Y2sTtY8dV26S0j4RVQYIlAz
         DmkPjauwQBSpPemHKxFAdrE2rHogr+oa6E0XQZ0nhFSmHPyC5E5IqJfbb74FsjaahHEt
         I/cEzxjSfUtxTpdOrdEYBWfkwiTAF7QdCuuHHhNf2MFH6kr+n+9CyiFhgD3OFBPSH6pI
         mjG0U0ljVhqwqnDi7n/WhiJh8OEK4yCRrEipISHrMuYPBtDWpruOgbeASy7nXxMWcYvE
         9ipw==
X-Forwarded-Encrypted: i=1; AJvYcCXroV0z0BCJokDYsgK7mZuMjGVsv5JMvievTd652PUshrItpDy3AxOauftvFsSE9DZ1ppCBFm8Oz2aycFlsoQ==@groups.io
X-Gm-Message-State: AOJu0YzbygWC8CEH13vX8ZaCy5va8XHQqy7AazCQa907rDI0OtSHwL6r
	YOdgqbh0+xhvqnqSGV9nbGxj0Az20E3r26lCZeqqXoEiH2gya3mxx/mQWdGRCGk=
X-Google-Smtp-Source: AGHT+IE0N9MPCcPv2JgPP3p+yFAfb0Q4OdWnBmU2iH0Oq1rGcrkcDojwHAeZYQnUTy24HL7ER+SkaA==
X-Received: by 2002:a5d:6d06:0:b0:37d:354e:946a with SMTP id ffacd0b85a97d-381f183524cmr2032727f8f.50.1731060707837;
        Fri, 08 Nov 2024 02:11:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm4152566f8f.88.2024.11.08.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:11:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
Subject: Re: (subset) [PATCH 0/6] Add support of Android Boot Image version
 2 and non-AB image
Message-Id: <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 11:11:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 10:11:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2539

Hi,

On Thu, 17 Oct 2024 18:10:24 +0200, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[3/6] configs: khadas-vim3{l}: fix userdata size
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/895b54998e57a5d099c09915341dd9312e0ad7a7

-- 
Neil


