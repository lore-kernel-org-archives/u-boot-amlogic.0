Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D50D41D68
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 16:27:33 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13724.1765470452659322209
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 08:27:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WkuSIIPp;
 spf=pass (domain: linaro.org, ip: 209.85.221.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso163922f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765470451; x=1766075251; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQwYtVauKLbeyoqSg/f0IBtDSm0J4Au2GIrCQ1YM/mg=;
        b=WkuSIIPpeH9Zfp0Kjhd8mLAoRKN5tp3Ngk/VowcNPjQLzdXmGSp/A0G0ClTffidBEU
         dxuGnqm7kpkdMQDNFiKBggodhZliZO7NDEE3DjAK2jI6ElBVfnVMOhHRKghHx1QjJkFC
         PZWKqLDgd+/FFctfwQBZDT0nfUjAQe8WVmMirggOpaAxClyefm7vsCFzzqOAlWMmpxzI
         JwyYO4zqe4tioRTWMjuyC9dwkROB2sa2N14zzyjI6y1Q3plsCq+o/8NY4ecT+cm0ijuK
         NrkW9wt4+O6yVvX6RAznG+U2IIhLgcfTwkGeuVyVxQ2amBUOHxmk+4BdPkDwMc3j3W7s
         sRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765470451; x=1766075251;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQwYtVauKLbeyoqSg/f0IBtDSm0J4Au2GIrCQ1YM/mg=;
        b=ON39CxFKajvmItbj6eMEd3/z/WOP0aU1YByEWjr1T9SuUKAlJrHkdVDHih8OIUsZ9s
         Ouswi7Bdpx2Xe+b2p/KFBC9RxqpJDEjKaC7IYYhnDQAbfkdihIorIkxWV7sLD+6lwOLw
         RvU5BzU2xbJKi5t02gWEBU/u+jNAK7U5qiruaGiHP+0H3s5jRwArgXknlqCa0Ntlvjwa
         LiYh4sdp8gdHQ35vwpHJe6Lblvkfg10SZR1z13g3atigdTmdGgf2Z9xByS8msPEtMm8v
         Qwf8pXOfLkeVeto7hrMLy8myLGFwaJAYGY99mfbX+WZDSIECUWO0jqYlo5NmDzRQ9xiR
         VjSQ==
X-Gm-Message-State: AOJu0YyY/ZfpLOKxdaEvezMcalvW1a6Keuvt5JWGHZMHmqRCviHWX7co
	VYxwxqoOjs63FPvGeOHh4Eh4nMTCG6/AzMN6OtrvLeeNW7N4w+zViZZ18hm1pFLWWS+zH2/0yrS
	5kCQV
X-Gm-Gg: AY/fxX5sorp68K+1Bigv8FC29KUJOGoADaTWJOsaR9q7WZ1/qj5aW2sffP8jqnL//uh
	yvzYo2E4SVsDp98ZYBbsr618cfq0aq8p6GOUlPWYenNbtd1eQwOvfOzWk5LgS5lCNN2vQKY9Ngy
	hn6W+m1mGy8CnkvvMevF+NenAoLN7Q2SSrd8XOhGGkUoXypWfg7NacstvmbUa8a+FiFNgJ4OaHe
	Pb3JM+ZrAxGG2Iz3/UPthIc7abYUaft4mEKT7MHq2/ymmmlSEuRsTW230Oq4LpFb95AUNMx6Tp1
	xX0BTyRHAh2M5NpA7civV1kpmgV6ArTQElOBl+0MZ0s0QRpe5FEe9uWlHPA9KBqNMauZ1XYIFwI
	IUumkrU/Ya0elNvXoF0Bf8NFZbRSJaiXKNBvJfK6vj2jiyLdklZC65dttJGQV8RajMnjD5kiPvC
	0QwD6audFvWQFAXfESX/CtS9Tozb4kMeaRXs80HVpICQ==
X-Google-Smtp-Source: AGHT+IF12nHvAdLntGJPxxraDO4j0b5MOWL6ZLfeqFv+RmiZ1Zqu/GtxjdeWVVJDp61Ox8pg2M0N2g==
X-Received: by 2002:a05:6000:2212:b0:42f:9faa:50c8 with SMTP id ffacd0b85a97d-42fa39d22f6mr7205296f8f.20.1765470450895;
        Thu, 11 Dec 2025 08:27:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a6671asm7190325f8f.1.2025.12.11.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 08:27:30 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
Subject: Re: [PATCH v4 0/2] Support EFI capsule updates across Amlogic
 boards
Message-Id: <176547045026.3578357.8412051397714751321.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 17:27:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 16:27:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2878

Hi,

On Thu, 11 Dec 2025 15:36:59 +0000, Ferass El Hafidi wrote:
> Currently EFI capsule updates are only supported on the following
> Amlogic-based boards:
> 
>  - Libre Computer AML-S805X-AC
>  - Libre Computer AML-A311D-CC
>  - Libre Computer AML-S905D3-CC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] arm: meson: add support for EFI capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1bb973b4db6c07b7765b92e93e596907e8b8b469
[2/2] board: libre-computer: use common Amlogic EFI capsule support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/6e844dd4df6765e5e772b5606a675c16fe98d9ac

-- 
Neil


