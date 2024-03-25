Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CE0CD11DD
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:20 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.46875.1711354692921848654
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 01:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=j/7Sxm/U;
 spf=pass (domain: linaro.org, ip: 209.85.167.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso4340367e87.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354691; x=1711959491; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y+BCQ+IezcAM6J9++TSwV2woiCiuaXVxZ2JRbW4Hm0=;
        b=j/7Sxm/ULbIjG30Se/s7yULdHBYB2fPB8Hb5xAC2YKj84vca83nRE4QcQFxXU8+47D
         lSD0INCd7WJv8KIrgxg0syMqPk3la3jN4LOxS4SeffDVS7wQHXCxcYk1ji2fZZHcb3db
         +sOuksC2CXtqjK8OLWGC+s8SJLY5wDRWLXvYuzqiU6Dso31GZb8/JhMm43oES4ctzrUy
         YexE2S3En3BYEf/CIMVTuz7QoVnBG/0EJv/mhuUpJNGfoc35ZDNdBbGqZRHcAGIR/LR7
         FIfHQdTBJk9w44/l4PcrZJvWkUM+FtC9dnIxJ/W4tGBYcFJCDE9sb+FSi3fScG7kt3ON
         CJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354691; x=1711959491;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y+BCQ+IezcAM6J9++TSwV2woiCiuaXVxZ2JRbW4Hm0=;
        b=pacyQZM/ejUEo4FGN1Zv1MAqI9KS7d2e2twZFDk6qeiHCbOYKTa6LePUD1SMwuhnKB
         rFkgrqAPXPOsx6ejCzECPE9EgZrSmSsjgYE7QGJClNMxQKLQVqfcgYdi8aRXMfhwSHmW
         qXOhtb0V0k/krYOVTWvauE+SNqCPZ3l1TvW5/aDA+RgcJ1x8ikO4VGm7u7TRfFIAxDL3
         OD55Lnrer0rjX97lMv3yqhXra6TUzm7fpvxZep5aLnG41TGkjAdwCeLe9pEVJdFqWVn7
         i3OgQWFJHC7ADC5bjXA4VfEfttSt/IciIG4u6IxH4ivwb7QvRCslr3N2rhEdtOdtji8+
         tSuw==
X-Gm-Message-State: AOJu0YxsdFiSWbpxLkdV7P9hosVmPkfd0KA/nAm4VQzyLoHRSAPY0uGi
	NCdIby6oG+54pUd1qyMVh6UG1YYedPArbhB9hd+W+0SPtl4FftCLHZ24kG4jkKs=
X-Google-Smtp-Source: AGHT+IFgTObAQNj8o+xWIbdNOtB5CeJcnuOh2lY3hl3ZM37N3Lio3dRWfP0YABeuGETGy1CKvxvbTw==
X-Received: by 2002:a19:9149:0:b0:513:dd23:7a02 with SMTP id y9-20020a199149000000b00513dd237a02mr4035607lfj.26.1711354690964;
        Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004146750314csm7686212wms.3.2024.03.25.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
References: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
Subject: Re: [PATCH v2] board: amlogic: fix buffler overflow in seria, mac
 & usid read
Message-Id: <171135469018.4116391.8263371182698704176.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 08:18:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2244

Hi,

On Wed, 20 Mar 2024 09:46:11 +0100, Neil Armstrong wrote:
> While meson_sm_read_efuse() doesn't overflow, the string is not
> zero terminated and env_set*() will buffer overflow and add random
> characters to environment.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] board: amlogic: fix buffler overflow in seria, mac & usid read
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d54f87f09a36ac20154955297b7c999b368b0443

-- 
Neil


