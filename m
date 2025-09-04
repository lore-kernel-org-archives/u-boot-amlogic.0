Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80442CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:39 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.35200.1756979854325455216
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 02:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AVkAgxU/;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so4079055e9.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756979853; x=1757584653; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qriw3O9jv6SzmswlG3TH2WS4BvvX0d0naBUrpjbGrRs=;
        b=AVkAgxU/Aus2CtIe9VkJurje+433os/t8HYTBrg3w5VYPWZvw+AC9sq+LLEujRrsZn
         2lQHGYsuKgELLKJPUMwruIh9fzw3zzl8x23KPH9lZPm3clp5XmHKmQSPQYSfY+suhWbJ
         fU9MKoGsh96hPpykE3AAL7v8OpjAxOWF4u284mnCadaGH8sAqJ4/dWQbnwV1OBtd3bcb
         S2dAZLsoq25hiA4WMgPeyjCW3xyv3zXIvwF8dLnZI/MzAenl5NiIJ9nWY5ardTJITbnF
         gb7b6WN1QR9uW6BXJX+MvVysEp+3Xp1/lkXOlThhlGIr63QC28vUia5HLVpH7vuVo4rk
         RD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979853; x=1757584653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qriw3O9jv6SzmswlG3TH2WS4BvvX0d0naBUrpjbGrRs=;
        b=bMk3tJER0cT/ACTeYAlvYF0W5AbOOLRrM+Z+dc0Z7b0OFOMsBQmnhRrYxp/arbwnk9
         qpj5uma+5ogGYK935xsPptp0JXC9w04iZef3pVdHT/+wC8tOROCAu9MVZg4wYx3YLqba
         WuR0zbRiJgA4nG/ElXYxKxAYj4p/r9CikHWuwvrr/O3MkU3JPEz8zEcXrabxHNdLiPY3
         wnouYacpzv+ppIh04wrvs02ItmTsGOKkKkh/INTJwL4zfMrJ3ZckCAKUO+nzvAogmL4C
         sb8zWiPyNBRsDnk9/H/rCHNb8MqKezJA1NFEDaTJRq3ixFGxuMuNIlD8FP0vInWShnQW
         19sQ==
X-Gm-Message-State: AOJu0Yz3Zp8e0wdsO0wHwzkCuUg2OpRT9XsjDzEhYTQOLT2g1dkaUaeB
	l7fOSLOz118fHdR7oThmCCW+hJH6X0PPubaCXOjugIPAz3TIS1Bo7lkHwhaBiMUI1ASTBG9sKnC
	Tlx2Mb1u3eA==
X-Gm-Gg: ASbGncscJ6z43mImQDRaKo6tAOhrttBcItEVb9oQWej74bZOLbLFZOpE+r+ma4eib4G
	nzj87mE/TV1ZbD1HoYuhFd7yDtuazNhVWMCKpBea4fmtz9Nbo5HFjQ6QRqSu4KZC7RfDtRRHD2g
	VuI2VNioBreROc8p9VIFZxzAVEzoLsk9WoUpeePt6Wjo5DMohNBlhRVnyU8iDQ/DjMwC9KkI+P4
	tHkuhzpcTZMSYA7imm0oTUhi0FK4sjpBM3pUcAUeTuntJ9XcO08HH5WDI8FwQtbtuUSCBNtwvtu
	RLzerdGCBc9eD0kUzZ5Au00qIO9Ed7QknT5Yp9AbiyBZznC8klzXiV57f7ferByGODNMJFSK+rM
	faGM6liFlPhLiSMy9BMG8RAE8EmkY7EyJjywv11GEfzmpAIVlvCub/A==
X-Google-Smtp-Source: AGHT+IF2oG0zSMsVL4egB1hpvh/hVmUPz+hah20E9sacYPeBHTU0yUS2aXu6TWdj2kNJcl/z04xqDw==
X-Received: by 2002:a05:600c:4f08:b0:45b:8866:510e with SMTP id 5b1f17b1804b1-45b886652abmr131776455e9.25.1756979852730;
        Thu, 04 Sep 2025 02:57:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:57:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Da Xue <da@libre.computer>
In-Reply-To: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
References: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
Subject: Re: [PATCH] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
Message-Id: <175697985196.2904655.5277786859587885672.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 09:57:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2738

Hi,

On Fri, 02 May 2025 08:51:45 +0200, Neil Armstrong wrote:
> This bit is necessary to receive packets from the internal PHY.
> Without this bit set, no activity occurs on the interface.
> 
> Normally u-boot sets this bit, but if u-boot is compiled without
> net support, the interface will be up but without any activity.
> 
> The vendor SDK sets this bit along with the PHY_ID bits.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] net: mdio: mux-meson-gxl: set reversed bit when using internal phy
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/92a2699789a8a9e093e2b10db0476d202c1bcad2

-- 
Neil


