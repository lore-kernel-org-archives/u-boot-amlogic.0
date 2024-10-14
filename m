Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05369CFC501
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:06:43 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.48878.1728889601481006568
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 00:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=SHfVYdcv;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4305724c12eso29398675e9.1
        for <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728889600; x=1729494400; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGDnbekTYr1IlDqRQwHt3elA/uiJ4kbc33l1N3YM5EQ=;
        b=SHfVYdcvy+a+Aoqq8O6SBCBQ+hcMWOP9bgcdW+VCf54F7P8FTp3p0ZQ02/FmpgdG10
         qWsLZDwmrfJ6rbycwI002P1gNlh+kNmQCBLGNv3R4uWeUhOXCO0CzPVVxaTY1HWsRoTR
         kHNu97Wf/RQRXNggP7ed6tF4dL1z8EPJx2XG+RxFMKbOimeMmkwmAdX1O0y5koWl0ZGd
         uYYWMUNv2Xq0c8x9UIJtA44A6j5pMf1xVzAKrp3NrzH2mCWoqv1JJdUq95SzHc6cjoGQ
         2cdGNNc0x/I3CYmpQA/e8u8izUSWOItEap+KPEPeG7E8wPCibK6NwkFh5WeDPFkGu9ZR
         qJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889600; x=1729494400;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGDnbekTYr1IlDqRQwHt3elA/uiJ4kbc33l1N3YM5EQ=;
        b=E2JnjDqksLQHpdxg6OauLZTL0y5rgziLmB9hBmVcxF9SzMvVzE2tETjYEN20kakRsK
         Zzf20F3lLBnHVu6cwV7YZ7whCPHdZj8Mq7jsL8nzRxKKbt8GjzY+XZlQ20vpPgxsxD7A
         TNmBNd1CSkPOW/G9LIOHumESbfgJBshwb1tyeVPz6/GCvAVFvt3F1HUqWa7skl02jmR6
         e5xW+eL8qLtF56LBTKVrTtdTYohoL0ouNejjRhrRw2X9B+UXZdRgta8PAbFTqBTtcg9L
         1LzuGJkswmZGy6azJhL+CS57u1nlPqAy0Y+3EuC0cO+g71zK8utn7YxmPAJDB4oJ8m5m
         66dw==
X-Gm-Message-State: AOJu0YxWVynmyaWYAe85LWV6DV2XRjd7gZJsOGc6XEMPQqn5e6A07qdq
	WvPjiPzu5qbPWKZQXPkcOx2tnIJLTM2Gd/gqWrfd68tcEh1+kIPHo/KiKsYD4Jj54CFcOr2nYeM
	YZcY=
X-Google-Smtp-Source: AGHT+IEdGDqLzEbjmQp7XCRuUNq0kA6FdR8nJHdgegWwhaR+p64y3n/w7JrbrtIRy7Jar9hJFqdr+w==
X-Received: by 2002:a05:600c:3acd:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-43125619c33mr55512075e9.31.1728889599765;
        Mon, 14 Oct 2024 00:06:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43118362232sm112355015e9.48.2024.10.14.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:06:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, Callum Parsey <callum@neoninteger.au>
In-Reply-To: <20241012080340.2596-1-callum@neoninteger.au>
References: <20241012080340.2596-1-callum@neoninteger.au>
Subject: Re: [PATCH] configs: meson64: Ensure commands for boot targets are
 available
Message-Id: <172888959899.206113.11446890438202555187.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 09:06:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:06:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2481

Hi,

On Sat, 12 Oct 2024 08:03:51 +0000, Callum Parsey wrote:
> When populating BOOT_TARGET_DEVICES on Amlogic Meson platforms, verify
> that the shell commands for accessing the relevant media have been
> enabled in the build configuration.
> 
> This was already being done for USB, NVME and SCSI devices, but not
> for MMC devices or network boot. This meant that configuring U-Boot
> without the networking or MMC subsystems/drivers would cause an error
> to be thrown during preprocessing.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] configs: meson64: Ensure commands for boot targets are available
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/315cad97a5ae09b1b975fff2413ce785b3b8592a

-- 
Neil


