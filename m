Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E63CEACE5
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 16:07:10 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web10.82761.1727792797974651715
 for <u-boot-amlogic@groups.io>;
 Tue, 01 Oct 2024 07:26:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UbJAnwHo;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4583083d019so37084151cf.3
        for <u-boot-amlogic@groups.io>; Tue, 01 Oct 2024 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1727792797; x=1728397597; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUs7seA3ZKvlwzncV7ZzeBRhe+CiXMo3Ri/ChJePYXw=;
        b=UbJAnwHoQT9vF6gwmkBMPqCvT1Hc82qgiCE+wUUC1Hsb7DgSmenLzdqvMaLhjit5XW
         LJGWdBv9pKcXrmiYrTsX8iN7b9fgBWzCx9g9E57oRYShBIF+h5EZvniuEbudGLiG/4K8
         2UILBpO+RS7Nnae7YeoPkdW2gnKbLgLfWe7B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792797; x=1728397597;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUs7seA3ZKvlwzncV7ZzeBRhe+CiXMo3Ri/ChJePYXw=;
        b=FwMHElLRzAKGGz9U54L2UpExAdsRs2+UmGbCx+wIFmtQvNGIZDi8/qdYz/U3ij4XCe
         K9Cjb5YHpCshw39OVkmwpjmunGGsLSKzoak0UQ2+ejElOdIs6/MHWCwNA7Fv6UjY5c8j
         nfIoh4u/FJZ9YqpUHtqt6C7minGAjMqlaL53M4YkOcoPYz+RLYXNSK0E8ETSewxC6YLk
         /altFx25eCuSIMZGb8YhVVab04LDY6M4i7VHqKjYVTR/MGUXo669Txe5ydYIGVMILzQx
         iy5mq5nVTYf+BK6XUmahDVPscRpM/LxMAEgtK2LyvGTvvyJL+NFTDmj8zqhwucpcHgMl
         zhQg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ie3W19B3PS2pTR0GItes98l4mJzgUW/b0ZMRgeTTO2W28ueQ/jFz7Vr02LJRsXfNvBL7WzEUX8WS+MiavQ==@groups.io
X-Gm-Message-State: AOJu0YyQdMN9TttaGcLY8hXbjw+rNqYEG4gJI1UC9KQ1+PsF9EAeQv0b
	hsNksdWQHyby8CXLBXRSp7HYsXGioO/NqL/v6PEWiAedP3LvCJRWO8OF5E/oUmY=
X-Google-Smtp-Source: AGHT+IGwcIDJfPGAE7sDAYQ0QA/zf6cPHjY3vkeOK4j3hCDZHoQPzPRRcvw/kCHUiCDZwu9Ch6Jiow==
X-Received: by 2002:ac8:5885:0:b0:458:34df:1e65 with SMTP id d75a77b69052e-45c9f270fbbmr191931881cf.44.1727792796898;
        Tue, 01 Oct 2024 07:26:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2dff74sm46058441cf.47.2024.10.01.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:26:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Kostya Porotchkin <kostap@marvell.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20240926231457.2933914-1-marex@denx.de>
References: <20240926231457.2933914-1-marex@denx.de>
Subject: Re: [PATCH v3 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
Message-Id: <172779279069.133202.868540972759905145.b4-ty@konsulko.com>
Date: Tue, 01 Oct 2024 08:26:30 -0600
MIME-Version: 1.0
X-Mailer: b4 0.13.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 01 Oct 2024 16:07:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2429

On Fri, 27 Sep 2024 01:14:12 +0200, Marek Vasut wrote:

> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> property, make sure the regulator gets correctly configured by U-Boot on start
> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> for introduction of .regulator_post_probe() which would trigger the regulator
> configuration.
> 
> Parsing of regulator-always-on and regulator-boot-on DT property has been
> moved to regulator_post_bind() as the information is required early, the
> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> slowing down the boot process.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



