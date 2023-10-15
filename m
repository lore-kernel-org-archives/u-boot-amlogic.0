Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F4CDB47E
	for <webhook@archiver.kernel.org>; Sun, 15 Oct 2023 10:31:35 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.89480.1697365889348454292
 for <u-boot-amlogic@groups.io>;
 Sun, 15 Oct 2023 03:31:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fwf7yEte;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so3116832f8f.2
        for <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697365888; x=1697970688; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksqc97RrvA//9JSdIWQdCwkwNxbdnSEeDi9p0bEPXJE=;
        b=fwf7yEteaQNOpKWbZAzaUxTTcvH7CaZaG+akPq7oL9ZH8jtlt30k35dRBerOkVsVPY
         Eo3hodNiJL8Kf0MRQ/6+bXuKlJN/xBO0VKzHW5ji/t0Ytq/d6HjSGGcQWVSMcBwZIobT
         HQayeEwSPEacpycFdmrXhWIysTTgLzeMYIMW09dfd+p4QbFURx4tOsvuz9n8EjuBtxx9
         V1r1q84LmvsNqwQqygPR6VdA1I2b8jxdsB6E6rUy4WC11fzxoSNL2aC4F+A3un07T6KU
         CVlGE1NgtchGIGHtY4zFE41mLXkU4y8vHfX6yKLg0krS4rI09cbSrI0mpeDnhb66J2FT
         jNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697365888; x=1697970688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksqc97RrvA//9JSdIWQdCwkwNxbdnSEeDi9p0bEPXJE=;
        b=Pm7c+y7j/Ev2T1GGvGaUljAaMc1vOH/q+jVbBpO3ImNlrSaTSsMB7DzsZ18G7hV/e9
         sWO8Zskl1E3jE7p+keL706ySljdAuBwN4cLfiEAFYcJtmI2VusLIWRCLVU9XeuLwd8Xk
         JBqUm2vU/0/GEiixpCc5rXBmmRDQ5pa878nKCqD4z11UIQECJlETGz2Ld4bgDCocxgG/
         Hd4EzY+rPtm0jn6CyFsQGjr3avs7VA+M1JsBP/tmnxK7JEpNPPTM32lr9xEhOkXSm7yd
         KI9Jtc5Gp3X1TUfecm8/lad2UL76LVtKTn9WKAIqCS4Xt5wuqr/CBugVoS+LO347gf7z
         dvfg==
X-Gm-Message-State: AOJu0Yxq40Y/e1rkSJVBBUTgJCh9O+RanY3cHzAzvBLi6nxHeuPDdUzR
	CsZFKApv2g5NpmFk8DWybeVC2Q==
X-Google-Smtp-Source: AGHT+IFtUCymwK6lX4GLZ+oqA/8/baJmwSEr1Rbtb+18gD3piSQWpU6XJsrBKGzQLXzIRNzaxFQlFA==
X-Received: by 2002:a5d:5b0d:0:b0:32d:8401:404a with SMTP id bx13-20020a5d5b0d000000b0032d8401404amr11571241wrb.10.1697365887687;
        Sun, 15 Oct 2023 03:31:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6109000000b0031f3ad17b2csm5820598wrt.52.2023.10.15.03.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 03:31:27 -0700 (PDT)
From: neil.armstrong@linaro.org
To: sughosh.ganu@linaro.org,
	xypron.glpk@gmx.de,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	kernel@sberdevices.ru
Subject: Re: [PATCH v3 0/1] hwrng: meson - add support for S4
Date: Sun, 15 Oct 2023 12:31:21 +0200
Message-Id: <169736585436.4181364.7854441987940465829.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012075828.22685-1-avromanov@salutedevices.com>
References: <20231012075828.22685-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 10:31:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1757

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Thu, 12 Oct 2023 10:58:24 +0300, Alexey Romanov wrote:
> This patch adds support for Meson S4 series
> hardware number generator using new algo.
> 
> V2:
> 
> - Sync with Linux version.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] drivers: rng: add support for Meson S4
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a92345610ed3596bc25de08b17cb29c86b508e6c

-- 
Neil

