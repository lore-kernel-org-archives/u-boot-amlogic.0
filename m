Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759ACE834C
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 14:27:22 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.56206.1727706440310738491
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Sep 2024 07:27:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sD1EQhLv;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so34509645e9.0
        for <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727706439; x=1728311239; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvw5KqLxLj1F5gegJYYVjZJm0uru/pqT1hBAosgRBe0=;
        b=sD1EQhLvxSd4RHEYDbOWUROsqShSCTh6cNiRFK5xtkQ4gViiVTdsbHln9ZjNt3ARDQ
         HGMG6EDD1f3QX1nHVaBuHcUFFk6yADKLdPUPkCQCVB38oWAx32iNb7kc46wrIlA2C4mD
         blgaUvc1X17H43+RTdLQ799+1izOuXk5nRHdxqg70vNTQZ3cqdpyvZBrndNSSuGAqXE4
         E4cg9cxFsillzcEQu6sixD4Ttb2fanvgeFLkdGQUsloD4mZtEnxVl3dfJWjWXdCCkXGV
         Kc8DpfK/PPKxP3lVqP523aFuDHMo3+Y0NwBlE1ahZledQ/icWDFdhFezZ86FNNNF20s4
         QKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706439; x=1728311239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvw5KqLxLj1F5gegJYYVjZJm0uru/pqT1hBAosgRBe0=;
        b=R6BYvVDxRbSbK2W5yVrkx1cbfYx4qSIJTB+RHA9PMk9hj+epXcmazMJgcMIWHv2adl
         fUMIa6vpopg3db2X9hrvf5a40NnG9Cfrd/myLFOgZLpumQobjZFGHGwghk6LHD8JJgR3
         mCP0E6pEx+UDOOQVhhty+NJfNd9Xhdr9efYMqjfiGJQXEOARiKfNyQ2pMX1MctmVYulP
         3f9yk/K2uEw0Oq/Imu/uWMMVGevYwqwiPO1RPfAj/eA/RJWPal5IZ77QPbU8IX8Lpa38
         aw+XyxHwHYmzqluhzB0Dan+nlYurucmHylPgh/gJsgThpTAVf2aNH+NExg+3eGlv/He4
         54gQ==
X-Gm-Message-State: AOJu0YzxbsDeubr0sYpgagUGJZc9h80DbUst6S593nkvRp9RBVb1+gIA
	PQnjaUXqWUB5OO31aZ42cWRZmJiH8KL5aLlDYFmfaJPUn0JC5lQHBFReAon5qH3ktxohqFXmSul
	A
X-Google-Smtp-Source: AGHT+IHhiYsNkXlX5g4IUoMh0HORNQHbGXHCfjgU5EU1KIVllNY9lq9Dv9QYHatl7s+K306KvyOjJQ==
X-Received: by 2002:a5d:410a:0:b0:37c:cfeb:e612 with SMTP id ffacd0b85a97d-37cd5a6923bmr8365122f8f.1.1727706438717;
        Mon, 30 Sep 2024 07:27:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm9303200f8f.18.2024.09.30.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:27:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, da@libre.computer, 
 ilias.apalodimas@linaro.org
In-Reply-To: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
References: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
Subject: Re: [PATCH 0/2] board: libre-computer: Add support for Libre
 Computer aml-a311d-cc & aml-s905d3-cc boards
Message-Id: <172770643803.753773.10093460884732350284.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 16:27:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 14:27:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2427

Hi,

On Fri, 20 Sep 2024 15:33:32 +0200, Neil Armstrong wrote:
> Add support for the Libre Computer aml-a311d-cc "Alta" & aml-s905d3-cc
> "Solitude" boards:
> https://libre.computer/products/aml-a311d-cc/
> https://libre.computer/products/aml-s905d3-cc/
> 
> The Alta & Solitude boards have a Credit Card form factor, similar to the
> the previous "Le Potato" card, but with the Amlogic A311D or S903D3 SoCS,
> MIPI DSI and CSI connectors. PoE header and a single USB2 Type-C
> connector replacing the microUSB one for power and USB 2.0.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] ARM: meson: add support for Libre Computer aml-a311d-cc
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0ace48fc0990381450a4dfc75275eeade202a8ed
[2/2] ARM: meson: add support for Libre Computer aml-s905d3-cc
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/aae228b1a590e840ae15f84c97b5b66da7cd4a2d

-- 
Neil


