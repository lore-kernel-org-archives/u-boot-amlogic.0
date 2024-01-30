Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FAC47DDF
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 08:58:26 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.11688.1706589459038593169
 for <u-boot-amlogic@groups.io>;
 Mon, 29 Jan 2024 20:37:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AcyqI8op;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: seanga2@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783ced0216aso257563085a.1
        for <u-boot-amlogic@groups.io>; Mon, 29 Jan 2024 20:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706589458; x=1707194258; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XIzZ1gT1xffukuXnwslTYmCWc3Ss0ZcYGFNfGhlew4=;
        b=AcyqI8opJlcKflH3uJy71I0SVeDEHWKx/GVOLy4W2Y207eHQbeL1NBinw6fEU2aQVp
         6J39i3nA8ScGFchOiSps5XiFkz1lEgF+p5/LJfC9F21oh/6+tKUujtGYiWdjwz77ch6+
         cgv6yGjnbponFxrCBx6ZNpY3AV/FBQx3fXeeZ6g8QbG+iKWHh6qycfxUTCHTAXA+UuVp
         XBoT0l/xH9hUsGDyOo8BvRImR8ySy9zL6/uIAX/E5yO85wd933DOzOUHb90dabQsEbPT
         weRXB8/NeYz2zeE/FGdk6yvGEj5BqnbYx3XvUAmn14fHWHpfbsv0wd+oGKH4pJwodjT/
         v1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706589458; x=1707194258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XIzZ1gT1xffukuXnwslTYmCWc3Ss0ZcYGFNfGhlew4=;
        b=LRK5Y0SNVcd57uqvwlmIErs//ICiV5d+XWaYzsND8O4AfadqCsiNLsyLIt+OhaMJzV
         ugcnjCtH8A8IZKFqXvj5s/WmJzZhW0NoDKPry9Ee+tHCSeRD0ZnCE4sC09Nk6wj6lKP8
         B/aEFybSHYewFk7kdVhyu9bf/z/siQsuMPYcbmLEc6Lgud6UO7nancA+titu6jS+J06X
         o33UZco/Ebd918VqF6g40xVGxDHechOyjky9Rrxoax802jjpEJjtQYLUp0kGfak5gAbG
         EvgPHWTUx/+OU9I6mvIV5ApfGF0veq9irRc06QkoYC/uE0FjKkmdPAl/pk1lhUDOTsaf
         jMWA==
X-Gm-Message-State: AOJu0YxsB3vuG1jdatrLvlXXmvjp5uOPVxtuS8SjbHdF7ljbdVXrgGR9
	253l1Phb7RQAoWjAQoEpncVoExr59F1w1Ce1ymYPuxOQwRAsWvGs
X-Google-Smtp-Source: AGHT+IGazJXx/uU89mvLrEIUbKw65IbqFggaabT5eaFT6mA1gZX0oLuR7MN3h0yH5Eh0Qtct9FJ67g==
X-Received: by 2002:a05:6214:4008:b0:686:abd6:b3f4 with SMTP id kd8-20020a056214400800b00686abd6b3f4mr7285032qvb.50.1706589457975;
        Mon, 29 Jan 2024 20:37:37 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with UTF8SMTPSA id pj2-20020a0562144b0200b0068c445b747bsm2650683qvb.59.2024.01.29.20.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 20:37:37 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: neil.armstrong@linaro.org,
	Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Date: Mon, 29 Jan 2024 23:37:32 -0500
Message-Id: <170658777076.694990.4714326241904351501.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231218-uboot-meson-clk-msr-v3-1-acf4d90ccfee@linaro.org>
References: <20231218-uboot-meson-clk-msr-v3-1-acf4d90ccfee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 31 Jan 2024 08:58:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2094

On Mon, 18 Dec 2023 10:47:55 +0100, Neil Armstrong wrote:
> Amlogic SoCs embeds an hardware clock measure block, port it
> from Linux and implement it as a UCLK_CLK with only the dump
> op and fail-only xlate.
> 
> Based on the Linux driver introduced in [1].
> 
> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
> 
> [...]

Applied, thanks!

[1/1] clk: meson: add Hardware Clock measure driver
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/2da1331d20b3

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>

