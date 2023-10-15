Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F8C41513
	for <webhook@archiver.kernel.org>; Sun, 15 Oct 2023 10:31:35 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.89452.1697365885922665317
 for <u-boot-amlogic@groups.io>;
 Sun, 15 Oct 2023 03:31:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=XZUfFJ89;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40651a726acso33142025e9.1
        for <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697365884; x=1697970684; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6bllY5ZfW6e2qBlt9RZnRPLPH/FnoMwRDhXc/SGUEs=;
        b=XZUfFJ89sw/m1mbpmHKcIfZxR4vztciKd9TFuu6xK5WlYKaQVAM0H+55f8XoPBuICV
         opYPM4GHXi6cclDV1WbXDkzB28nOO5SC/HpAqDdf4p/LTBZp5/ppCZZF+JDP5h5Nk0Jk
         nhBfojXLTgohSpoDiUHAbld8PHZe5vjvcprcWxbJmqb0/BR2XdqvrOIKOePJsPr07G60
         c0eG9feY1AY43MzM79EJqzToVeicgOMD98bdwbHMyjesBzw/UlQzib4syNdl6qJ1s6tZ
         oWrswKIJZNqPtLceYU+t9UvWzZWK4THN27CYUN7zu2am+Nztnp4jWi57lFZN3L9xdAxe
         wtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697365884; x=1697970684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6bllY5ZfW6e2qBlt9RZnRPLPH/FnoMwRDhXc/SGUEs=;
        b=XVfmUxf2ZAMxK25LHETjNP5G/UhTDKQ/oZLJK35S7Jm4s9uaN7V+KD3mKeYcOX0wOM
         T8IYZu0pbXKqL86sAvSak6fQrHHT4X33cmbqb1R3ZANql0orXx5QmPoyymIqmCUd5fVk
         tzbklOl22coeIBSxkIsFWB48XQK5uo8OCIGoFLrPj2EGWE8UCDCGmHCW/UExwa8TB4SQ
         GRO9I7eLaY/rGcnm1LDjiQSYp5SmBHZKoe9Zy5TgqoKmjiU67TXrVCWp3uE5SS28EWF8
         O4dDHSs2cOwlQ1K0DuBvHQ3xPIygCfMOl3zFNB1mhxUnlQm3WXJXY4VreRIUhTw9A49q
         i5MQ==
X-Gm-Message-State: AOJu0YxaeMZpMuqzPI4D2Oqfxo5FS4UtSxArcOtaSRKcK6VOgh6Gd3kh
	Qa81TzLt24bVNr/5xC/PFDbNaA==
X-Google-Smtp-Source: AGHT+IF4JRdcUhXfWq3JgFDxuSvHZU6YO6EAGmyyieHhnJUtwT7tDZ/EG9DyPQiipAJqdDqAMQTAmg==
X-Received: by 2002:a7b:ca59:0:b0:402:bbe3:827c with SMTP id m25-20020a7bca59000000b00402bbe3827cmr26517496wml.31.1697365884341;
        Sun, 15 Oct 2023 03:31:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6109000000b0031f3ad17b2csm5820598wrt.52.2023.10.15.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 03:31:23 -0700 (PDT)
From: neil.armstrong@linaro.org
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	kernel@sberdevices.ru
Subject: Re: [PATCH v2 0/2] Meson A1: add HW RNG and AO Secure nodes
Date: Sun, 15 Oct 2023 12:31:20 +0200
Message-Id: <169736585436.4181364.2812477812180681189.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010100623.74475-1-avromanov@salutedevices.com>
References: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 10:31:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1756

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Tue, 10 Oct 2023 13:06:15 +0300, Alexey Romanov wrote:
> This patchest adds HW RNG and AO Secure definition
> in device tree for Amlogic A1-series.
> 
> V2:
> 
> - Rebased over latest amlogic U-Boot branch.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] meson-a1: dts: add hw rng node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/87dfb37d54e59f89b61d43970861ad81d66f38ca
[2/2] meson-a1: dts: add ao secure node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b4116f8f78f73906da59cbc93c7874948323e4b

-- 
Neil

