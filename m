Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB585C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:39:47 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.74141.1698334778069358868
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Oct 2023 08:39:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Q99g9L8w;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32deb2809daso669932f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698334776; x=1698939576; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0cANZcb1MpvaSnp9U9HyFtmMtizrWrl9ghLQcJ93X8=;
        b=Q99g9L8wGK5ciI62M8g1PjmiNr9nSKWftkTHqKEoRtmvSWlUnQF28YMH4v2oja5NED
         F2WBN0YcKhm7txraX3wwFQLiDuJSLLXSO0zIv9r9rDgbYZAAEyLvNmScStZlP2ChI57g
         ZfdDr4UwD/vehhRUTpR8dtcTGrAVEWg9CsZ79G/e8pu6I1Nvyl4xWjCT/FWoS6qHZzj4
         T0OJ4qY71V049KI26WqlSQkFL9aYfI0rvJeIAW9xfWPQF19QLUeo5LbXL+bTlcJ10bjB
         5F552tZPGtpqS+ecESTaydL28WQvQc9wK2LSyOLd03GPpLZTCl3GpO2VRNQuNfsaSg1e
         Vy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334776; x=1698939576;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0cANZcb1MpvaSnp9U9HyFtmMtizrWrl9ghLQcJ93X8=;
        b=nqIc6KQ73cr05/icDtawzNqJ9AW3LR3vJWrI6Yyr49PrwTpVE4VttCpUal7eOL/dtz
         +Vo6AX+QLZtvyNWobidOcNKR8HMu00/Hz1Mp8KC+8VfwYSaPd8xdeM+q45PFKrJJNlpu
         Rt69vPFxTOMw6yfRtQbdSmugbNd2W3Xxl8MbH1Dk1FXQemWMt66zRhMpC7zXuYdTAJLF
         9V7aTIIuROfuVK1zOuLrahfgBZNHLV6Ki96cdoOzeW4Kkyt1okdg//yTl74bt0WtE0q7
         bLxHpr4x0b3Hv7C+mXj66c4Zw3SdWmzxUkFIuyxKz6ADdR9bhuHGE+F4w7LjjakRLGUP
         3Emw==
X-Gm-Message-State: AOJu0YxaqVXKDpc17+uwQtSizgyydg+ABNNf7gBfiItpe6qr0aXkryY6
	Tntd0kOYe0JOF8KecjkhgBMrku3qz28/CDt6VgqIoJBb
X-Google-Smtp-Source: AGHT+IHSGcQlYQZ20xS7sbx58R58yuGZhTynFt7/wNbzP9aQeaV1jicOKZHAMyR/kymnrTKrLZ57rQ==
X-Received: by 2002:a5d:4708:0:b0:32d:89b5:7fd9 with SMTP id y8-20020a5d4708000000b0032d89b57fd9mr14600941wrq.56.1698334776462;
        Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w5-20020adfee45000000b00317a04131c5sm14495883wro.57.2023.10.26.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
References: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix environment saving
Message-Id: <169833477579.2656704.6983830809763111011.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:39:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 15:39:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1802

Hi,

On Thu, 26 Oct 2023 15:41:31 +0200, Mattijs Korpershoek wrote:
> The environment is used to configure some additional boot features such as:
> * extra boot arguments
> * enable AVB (Android Verified Boot) verification
> 
> Right now, we cannot store it in eMMC:
> 
>   Loading Environment from nowhere... OK
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: khadas-vim3*_android: fix environment saving
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a08092ddba82e18e8ed1ef84580aff00b419fbb

-- 
Neil


