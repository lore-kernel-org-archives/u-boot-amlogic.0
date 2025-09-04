Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF67CA1016
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:39 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.35203.1756979856426458398
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 02:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Do5jEauR;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so5760405e9.2
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756979855; x=1757584655; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW9GR1OXI/HYSnp0eAHqnGmVpsFbE+gHYYFWS03EpO8=;
        b=Do5jEauRY1vu9uHze6zvurVoN+IAaF83zdpjzG4bGcAnq5aYWOHsMafTInMrM59q7F
         VWuPzzaYKzEzLxWYITSLtaftXr0K6oJrLNXTMZhEy72ijbjScEYA4zriWyNeZ5QAeCje
         XoNvebLfyXdaR3I7ZJ7XRYLk2dZeJkIQ2WKRhdiQ/NH7C5k2HbKusxCnX4aMOCzbaKxB
         mNAnYWAGcnrolVAnCxa9wIDMllV1tg+ucpcoj4zxMvW3zBQbs1dUnqr1Ec91fcikKZrn
         35R9nw2valI+XNQ1NR9IsS3pWVGxiMiOPEzr1EvwHGyP6aB5rW4E4X4zpPFRyTwfvRuU
         ArzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979855; x=1757584655;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW9GR1OXI/HYSnp0eAHqnGmVpsFbE+gHYYFWS03EpO8=;
        b=Eh82oJJPD0noxKhbFxNPckW1sfb/2cBursQSVbziygCXHQRA4JmDtgWehdZHzpnoW5
         gzjNx8j0i8lCblRWSIj6XWCEBAc4o/FfgfMCPVGL/9FfK5ESCiv8w9UCHIk4iBRty0AY
         GdB2TPT9+raDjT8bxIFYVA9aqklbFrHI+quwileOPhMHhWxlIXCTYIvkfRuPSRJY91Z7
         kJuEVQQvdoHJpw9EEfM1ZHOWe3x73H3nVuAGifSBMAQbtW0jDaLsvFwF9qUdAcEWRKNN
         V1/ZitqLdt2QqAGFjWzUoI43bGK8kxMeCFteMVQGWYk19Wkgkte8PRdPzRmdRzamhVBL
         Oyog==
X-Gm-Message-State: AOJu0YwIaQ922UufjqSNV2FIajhT4vP1/mBiscSjtoDQWSUnKTVoLXje
	snHmLfrbSl9NdAg80jdU20PcTbePEcGsTWWpNalZqPXbkmDJQNV6BAx1o/0Nr+mxzwQ=
X-Gm-Gg: ASbGnctpdMpcV5bhK9Y6Lp7dIzENXyXIOs35rxfGCYCRADN0WAIf7iRb9FlYPPSUqFx
	/ISc6j9f4BYTeLn7CNmN84m+GBE5+wbh2mBtDp7k9IfpZiNPinCBVOaBjuEr++818tLXWzt0ex6
	Z7CubCHl+8y/rXJi5iGrzKT1fTeaJ4PdHKqtxHXIAQSr+x1YBpfQhgoJhnIFYyn4/ZWxeDiwebi
	qGBn7TKwvmLQF+TBwRs6cSrhTDzd5ZNMUEGmuRokXzSNDMdW839YPMbBgB/FU4+opw9dH/7Vk+j
	bd3m0+qT77oLi0+G61FSoxY4UsnR5b5ZLSXatLIYefNsoT4eaSjHplhzjJsbHdjg8j02h49VQL9
	UkAlgSECpKsrz0bY1GuULaupdCLrlLEU8DT/vp6MoXJo=
X-Google-Smtp-Source: AGHT+IFYbAixbM1wVWTJlgcR6aO0Ycb4yKRrBUZ/Kil6ZJ83vUgQccd90ULtifC08XYCmtQ2ihxX9A==
X-Received: by 2002:a05:600c:4514:b0:45b:7cad:7ac7 with SMTP id 5b1f17b1804b1-45b85525dc1mr142140075e9.2.1756979854764;
        Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
Subject: Re: [PATCH] clk: meson: Remove unreachable code
Message-Id: <175697985412.2904655.13465537088051195075.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 09:57:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2741

Hi,

On Wed, 23 Jul 2025 17:37:24 +0100, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] clk: meson: Remove unreachable code
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09887c69c1745829b6c004518265df4519a9f6a3

-- 
Neil


