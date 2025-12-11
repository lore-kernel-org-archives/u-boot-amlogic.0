Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1FD41C1E
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:22 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6652.1765449981197103491
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 02:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=hStttYPT;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso8253405e9.3
        for <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765449979; x=1766054779; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/87YDKiYcZLzVS3pkKiOBEkpdlzdNDZH+w+dUxdDFo=;
        b=hStttYPTvQ0fV+z7GU5MTBTBff74mB+QdTioghgJO8eYTs7DXLJABWtU4scqpiM1Sb
         CQk/UEABNPA/mEuNoWZtGYLZFzkAagePjIxjGc1skcRKVLc8zWRNhF/276Jr9aH9giN+
         Qi7kSKP13l2QHJHZUaeJYUK3duQILbDpIMIyVeC8t240KnLSIdC5HO73seTtA+NCz7uY
         7+dJp/yHRppNvb1by5l+5YwewgNSetNXcsLCL5uJvvoIZ9SmH8sbutBbuksHSQAY8fUj
         gULSLSGllKfSciyr3Ae5y1HPazMtYXd2AfLvqKoV8b6uFm7yPC+203r5WdLHubelw1HU
         +M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449979; x=1766054779;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/87YDKiYcZLzVS3pkKiOBEkpdlzdNDZH+w+dUxdDFo=;
        b=lwD6MnKa5Mexg3xl0nWrr3vbqAqpEH3T26AuKq/w9RHWNJuaUOA46WwDYQ3PK7VgUy
         AQ0BtEWAGPqgdFnuBjc4ADVo/Y8BMk31I6YTDfOWpFX/0SaMUsaKgZiR+SIJF5NKNLna
         Ljai6b2FdMq8X7lxQvcrmpNBkiRLaliqvz2Dr3l5UJ//M0/Uhb916BmC3Tq2PiEG7dS7
         inKWjfhFWQ+8BbcGW3Gf1bPcM4+/tWU51mEH9o94aYczd3sjpQTseGkAH3l05wfbp28I
         4l8hYWHE2Qb+wchBaPxlUZji3KOZ29F0o6txiHiCNyPD3Qd8FIEa65PjsSku/PYgrA0j
         PYJg==
X-Forwarded-Encrypted: i=1; AJvYcCV3x4KpYzB9WX0o40jtQDf+fo7jsFeOWkccr1FUkaxsr/yzMNntOZykkjqcO5/MwedFtE1V+85H1pE3b+8G/Q==@groups.io
X-Gm-Message-State: AOJu0YzC3wSCO6ANT971PegpS6sbhoUDC7Sdb41ah1aKLGZ0Rz9/jN1t
	8hK0cSlV88/KTjMYPOvmD1uj3Z7D1YyuwPpm8YCk9o6S0wuqXITjEXVio6Hs0YCBiLg=
X-Gm-Gg: AY/fxX4JPAVUNkXEYYNZ2eovy8DpYPIg3C1UBzVWD7ZpSOnMZm9NLNbAeswJvGzJhC4
	xiX2ITicU47vbc8c47wh1Ubae+qOL3eOizEpmdWl0gnh8i7C2g26KMl5YEneQnt7930mm4YnlFF
	pMU80v930upJR8tp1NKghkUmewdgekM+OtOc2azFrV9FvFkeiXeniY0Tb3SmELNTTdUZZCsQGDc
	0UV33B1ASUIIP7E5OWvOK2lZ6vjq95jEYTJtj8UqmBOOwveGykcSZ7i2nRPO5SdQuKHGq8RFaRl
	EEfUSX8hVUisQ6PL3pkvAQMNYczIWw07JQaWnZ2OE7JGXO5JIm19PI+QNDhiwWcGj3cusYHHRGg
	ThNI0ZQiUy7ymflwUxaLZngZb9uKAuHfPtNW1eYAvfvdkzqf1cxp96gRy3VYrovv1m03j4avOQJ
	a3Mw77qbZ/cp8Zqg6TA6J5bxBpQUWA5lE=
X-Google-Smtp-Source: AGHT+IF2R0OcWaBdtvvIkWRs/nyPiCdnUkGAyED17wHYfWERLWeKkDaSwO3vyu+LHaEDK0r+QfbQHA==
X-Received: by 2002:a05:600c:3b13:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-47a837925e3mr48878695e9.23.1765449979352;
        Thu, 11 Dec 2025 02:46:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:46:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
Subject: Re: [PATCH v5 00/10] initial U-Boot SPL support on Amlogic GX SoCs
Message-Id: <176544997866.2550755.6380353806583614603.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 10:46:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2866

Hi,

On Wed, 26 Nov 2025 12:17:02 +0000, Ferass El Hafidi wrote:
> This patch series adds support for U-Boot SPL booting on Amlogic GX SoCs,
> replacing the "bl2.bin" binary blob running as TF-A BL2 on these boards.
> 
> Boards tested:
>  - Libre Computer LePotato (S905X, 1 GB)
>  - Videostrong KII Pro (S905)
>  - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
>  - ODROID-C2 (S905)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[01/10] tools: mkimage: Add Amlogic Boot Image type
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/18c1654567dca70d848a4da1af93ea86632a45ba
[02/10] mmc: meson_gx_mmc: add minimal non-DM driver
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3eee9c1f61fc4ec0b7823477fbdac31d136fc729
[03/10] serial: serial_meson: add minimal non-DM driver
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ec958be7cc76b4f305fd78d55a20502d7c8b35b3
[04/10] arm: meson: initial u-boot SPL support for GX SoCs
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f39f6eeaa8c19053405788479b61a1e3b17ec150
[05/10] arm: meson: spl: add support for SPL DRAM init
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/17d80a3b326ea94cab687236cfeac5fc7c2bca2e
[06/10] arm: dts: meson: add meson-gxbb-u-boot.dtsi
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3d0a06aaecc7b380e2588072bf6cfc3bf1ae8832
[07/10] arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/236e4b1cc4eb491dea31e112cf4e880ebcce05f5
[08/10] board: amlogic: add kconfig fragments for SPL
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/773aaf8f8cc94a882a89373920f7986a9669f0e7
[09/10] spl: meson: set SPL max size for GX SoCs
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dcf8a2738b0e00a7caaf193a6cc69d3cf0ec3999
[10/10] doc: board: amlogic: add u-boot-spl documentation
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8f2169faf6e4ae1d0506779c6630104dfff7feea

-- 
Neil


