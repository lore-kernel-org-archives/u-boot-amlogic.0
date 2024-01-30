Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A6C47DA9
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 08:36:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.13834.1706603780750944599
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Jan 2024 00:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=GEYVZs0A;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eac352733so43491765e9.0
        for <u-boot-amlogic@groups.io>; Tue, 30 Jan 2024 00:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706603779; x=1707208579; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G/9gPb36hARfgLfZlAOvqoJL4XCWUO1fPWYyKzP6T4=;
        b=GEYVZs0AtZo1xPWG97/USVtMVM4KTVeQRHPhUu4Vd6tlF+btoJpFkGE08UGZC76T+b
         QMwZ2YdR+a6vimQ0t1k/pyf8mEhDJvYeSgl4bzSVNV5DAh2YLGToSw3aC+5rICCq3dvF
         Y6hpShmpbZ2CpYBDejDnP+JPLyZTLh0yzKcsguNFagwQOStN30rAf5L4+yBM3GG+jm+/
         YRXXjkoP+qqazUlEAQlXQI2iC+TLQQOnJMVAJ+3SgSnVph96GAecps3Dgoous5ei5Us1
         lsdxHtPnn7mLhQU/w5SB2qJwMHqH6N6V6iMa4Y4feZkATO8J34VRJEUApbFDwxcF0VUi
         H73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603779; x=1707208579;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G/9gPb36hARfgLfZlAOvqoJL4XCWUO1fPWYyKzP6T4=;
        b=PDJZN/FIzgl3hraTD2JgGGbgF+3MjowvLpl5Fze/z2SZyv5HlfrA/0UcpSAMTR440j
         n87Gmjuc1jCnOx6nL031OnfDNb07FPIE5t+ERQJ5DkXD0hLCXjEZUuV/IAUrvjf1t9C8
         uwTBw1sibSDTf4kEeWTkJMxaFPRv9Mr5bKN9jFPDaimxJu5verlXruZgEAIQLUXQphoj
         xBcZiynHgZn+ZcKwHDRWQF+6l327bN5x64+mdko7n0qp8FUb9WeQL4n9WkqpvidD57Aa
         wNdA5plIbPjiAs9MVpB3f1pNSsuLjAlhzGFFJrNb+x9yQ3sApRpMQQNfMAMpGFJYHFID
         wauw==
X-Gm-Message-State: AOJu0Yz1CIe6VxXuUqRagLQpJHIza9n2tRzRvHBcInSV5Kit7SXj1ilr
	r5G+qpPa/yydF3lRJvX7MhFjQ+IGDz+DYgD7l99ssrt575jSLId3G5omYOAntqI=
X-Google-Smtp-Source: AGHT+IGQPLEkUgtTIP7g1JTl6y4HMUQvAZiT3N1VkbXGjaTX9FWk/JeI8GqdbTmD6LOJ+GW8Q053tA==
X-Received: by 2002:a05:600c:35d1:b0:40e:6238:e9e8 with SMTP id r17-20020a05600c35d100b0040e6238e9e8mr7307095wmq.1.1706603778910;
        Tue, 30 Jan 2024 00:36:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o34-20020a05600c512200b0040ef6aa8870sm5564733wms.24.2024.01.30.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:36:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
References: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
Subject: Re: [PATCH] ARM: meson: stop printing board model after sysinfo
 update
Message-Id: <170660377823.1669123.4283726180918846122.b4-ty@linaro.org>
Date: Tue, 30 Jan 2024 09:36:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 30 Jan 2024 08:36:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2093

Hi,

On Wed, 24 Jan 2024 13:47:25 +0100, Neil Armstrong wrote:
> After the sysinfo update, Model is printed twice, remove
> the now duplicate Model print from mach-meson/board-info.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] ARM: meson: stop printing board model after sysinfo update
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/076529725f16f07a5cb2d5feba25d62b5f5a5872

-- 
Neil


