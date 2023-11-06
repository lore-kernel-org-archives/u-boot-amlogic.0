Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EDC4332F
	for <webhook@archiver.kernel.org>; Mon,  6 Nov 2023 08:47:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.50208.1699260420268209899
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Nov 2023 00:47:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uaSULWAv;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4083f613275so31401765e9.2
        for <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 00:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699260419; x=1699865219; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iHMBMQe24ZRisUd1uPFxpSVdGqw2WtE6BHmcrCsx2s=;
        b=uaSULWAvTo+nittZcmsl8CcANZy4Z7vnaZz1gPxMEwAFanhEVzhNVHfo+Amqi00HeR
         BEiiKhmnkXpOnJVqKNbb6QnaBLWd/3LWOBfdPGrxP7JSFDbMTV7uBfDfVHN44REN1MPD
         IxzKue9+N1p9wds+7xGuQ6jNdx02hfa9sZ53lzUdHPURMkPq/Wkf/sFRJkEIf1Y/qsHr
         k10R6wyyJB4+M+YPYaXZMzZgsmOruHt8wW0rE38VAcHCuuiGTgPlb9gSTWgVsUylJfKO
         v5OrGJhX5f/G6BDug2utIUs6laC+UW98Dk/zAncW1xBkALlzsr5AbeHoaWalwkwIrkwN
         xp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260419; x=1699865219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iHMBMQe24ZRisUd1uPFxpSVdGqw2WtE6BHmcrCsx2s=;
        b=l9raQg7viRxzFhBar731i12MAmACLLgyjtPLDYLtibKK8NOwNNS1thacvsdJYNbuDW
         Yf72AmSW8S6MW1a5TuMqMKoFX7CWIVvJE5uFa2vEo5FT5DLjep9X7MWVfaWKx6FKYJJ7
         ai91nt7NtYMuW16ChRhnOlKxlpXa9cV5FmonjXBdZXxs+N0WKdK7Ql0Fx6C089eruPOj
         6i0mK40cxEF2wTeZHNHpjiYAGRlL8ok+zI+Cg8Ue6PlGTgPFH626ryYkArwqlb4sirY+
         7Uqk2X+vm7oj8zYgNs8HY37/oW2SZHvyS9NNQ4XJAljczOfuQlR/fcw7RHUedhImvSK7
         wzFw==
X-Gm-Message-State: AOJu0YwI+w51ih8ZrEALtObLBDPHxDmVwDDHhLDxflc4GsAhCL448ump
	iqA0+XynQKXKVRANOi+IdcLW3w==
X-Google-Smtp-Source: AGHT+IFCGqmvGOU3ee8vR3ebaaD2vRmONAeqrKP8nLRS0O2PQetswUbv6QhunsnFELMurpwADmJOgw==
X-Received: by 2002:a5d:6d81:0:b0:32f:811f:5046 with SMTP id l1-20020a5d6d81000000b0032f811f5046mr21822248wrs.11.1699260418680;
        Mon, 06 Nov 2023 00:46:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600004d000b0032dbf99bf4fsm8937827wri.89.2023.11.06.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:46:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
In-Reply-To: <20231101140500.9025-1-avromanov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v1 0/2] Meson A1: fix USB and NAND stack
Message-Id: <169926041799.983914.17615678438055862098.b4-ty@linaro.org>
Date: Mon, 06 Nov 2023 09:46:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 08:47:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1842

Hi,

On Wed, 01 Nov 2023 17:04:55 +0300, Alexey Romanov wrote:
> After a recent sync device tree with the Linux Kernel,
> some drivers broke. These patchset will fix that.
> 
> Alexey Romanov (1):
>   clk: a1: add new clocks for USB stack
> 
> Dmitry Rokosov (1):
>   drivers: sm: bind child sm devices in the device tree
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] clk: a1: add new clocks for USB stack
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8ec790399aa88bb8d0a02282e411f34584c74950
[2/2] drivers: sm: bind child sm devices in the device tree
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e9f4f7789cdcda342b2f7edb82a6141f82f4c7c2

-- 
Neil


