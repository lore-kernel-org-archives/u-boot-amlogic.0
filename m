Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A0CCD1294
	for <webhook@archiver.kernel.org>; Tue,  2 Apr 2024 08:00:59 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6993.1712044851980278657
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Apr 2024 01:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=jEOzMkWj;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341cf28dff6so3597913f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712044850; x=1712649650; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhn7MtpEzT8Wye39fwymyb6B2TryfXy463znuDF8JmA=;
        b=jEOzMkWj26ANrcUPM7sReluh20q1AD/1oWjYpfPJXsrbJaiee8oBtVofGOAmzivkD4
         lEKnq+oLIGaoN6INuM51b0KZE/8A9wOgNHaiSZ7GgyHWu/jdx6U38nTc9g7JbZ++bMDt
         Q3sFQK7QSzmNWUXS82qhbnPN6eEPoYOwnmo66QRh895dU9MTJqNBfSnjhivm9vWpviqG
         u2DTMirjQnUw8hfo+MekoE4sQlf4rxtnWU4uFipGVKdsZUKneXskhYVl4lhCLePkcKMV
         1rcVe9JHHaDS5NkRliLcN2vkof5l5ZRUYvmGxVxI16bYQQMVBouKctFX5SsYfXCmRjTh
         sgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044850; x=1712649650;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhn7MtpEzT8Wye39fwymyb6B2TryfXy463znuDF8JmA=;
        b=VLG1Ib6IkZZPTY4mih1XDqLzpw5A60s+hOP7wx8HdRC/BokJ3DTOIPN1j8QNP9y4wO
         2/pMVsBnMulhPUzkec8CWsvwT6HEn8hbfAAGtm1zvODJSkGsV9CAeH/p6rq1B0JQasP3
         /j5/E8ZGlCUm5LbdZnII71OKRQzXCaEXKSRN37zTRwv+BKL+gn0/fywBJvyHdzwCRbum
         cGBpfdeZPD+mxRIxVlCrBiZdpWcbVSHxvWUwQL24R5fEs7wnlJZL+Bx+SBORJJBgS915
         TbhdiVpGkhWqMw/UzL8DaVWv3vMjE3AAvquyudpO/UPY8hTMgGdeDIN0kA7EXxF5QM9S
         mYMw==
X-Gm-Message-State: AOJu0YwGXgeUziUWbMDzSVYyXfMEN+1gmVNaVXZPApWLmSW0ka125YuW
	SCqtzNkElyX7IhEfnIkgto9W4YAFH9XE/vg7Ji97F6rNp2JMq0Rb0hLJn1lh9Ec=
X-Google-Smtp-Source: AGHT+IF3vBjximq+7A/HpvELSB0j1XEhwPlplQkUAnGJgbxxnYbY4cOMJdmDDpbbLtQxZDzUT7mhTg==
X-Received: by 2002:adf:f88b:0:b0:341:bffe:e5b8 with SMTP id u11-20020adff88b000000b00341bffee5b8mr7498891wrp.27.1712044849982;
        Tue, 02 Apr 2024 01:00:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id dn13-20020a0560000c0d00b00341b7d5054bsm13539642wrb.72.2024.04.02.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:00:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
Message-Id: <171204484927.3673856.73890042564486248.b4-ty@linaro.org>
Date: Tue, 02 Apr 2024 10:00:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 08:00:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2263

Hi,

On Tue, 19 Mar 2024 15:42:59 +0100, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] dts: meson: Switch GXL, GXM & AXG to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/227c586e80c77d8aaefe415c2abab11f58f41854
[2/4] dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e747bfc48cc74fd944a1e2a603cf089ec58f20cf
[3/4] dts: meson-g12a: Switch to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/01f661e46bf8a6837fa1801f09f1da79abda80bb
[4/4] dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b098c305e51086db906a07c5bdc983c8e9ae3f6

-- 
Neil


