Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02525C41513
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 09:43:58 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.22042.1719395031954155341
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Jun 2024 02:43:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AMzfpBrR;
 spf=pass (domain: linaro.org, ip: 209.85.208.178, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so6612401fa.1
        for <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395030; x=1719999830; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9yXouYFFVoeh+wzgUNghZOG6eQE4xLISuuG/NrBTh4=;
        b=AMzfpBrRhGgGBmsQxAYuA5sRLM6R3l9Plg01Y57Aqzrm3Wdcqvt/DhDuE2wuhEiZiG
         Nz62Y8XBEMjR6Y6RW0/Nva/ZZkOA3RY9qzADINqOvDf6onQ4VQ4jhvC+hJVK711Jwd4L
         kw1HUfoHtgg3Vxx/1WKOhyDSOoEXIQTj3dT3DOxybq5hegMGtCCtRZxzGQy8xRzkvoA1
         MIh9lOfHUOEniF48TqQh0Q30E4B8QpzwoBu+Dj4/7a127LxgYy5SgjZeSMD/Ns7RpYqb
         rS+0Kl1yGbo2t3gj1y3lOcQkRU5cZpKyebWbMMTC46FnCpoVj8FgbIGGz79y6K8dUIQw
         TM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395030; x=1719999830;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9yXouYFFVoeh+wzgUNghZOG6eQE4xLISuuG/NrBTh4=;
        b=GW3M6UiNnnYnXDsAWBGMGOmI/2j39mjJmBIdatS9j9IkAkilrc2/O2+FkGwtcgkqk5
         4fOeDtov/81OakLTmRm+Unnj8Qc6G3dlKwoopvaSIU4OJHGeWoqPNt4eHg3qqoGkiTuw
         gazncvzXm13PV6gJPX+3Cwl+FO08vHvXc3gk26qhz7wVOAWTgrEBSjT1k+FtWzxlUusV
         74du+WmBcsLDgLISUnw+SJqobAT5DS3ru8DnYXlvym2/UR1R70ppAY0AYLEymLXBholn
         VG1PKBAZipey+IU8dTYrcworwBsv/J7H/A4iuGqQi8VQBlR13L1M7ea7RUkx5BmLJ6gj
         km1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbonpJktptzuL6KkDtzqrg2dWRGj+ClRpC5QeWKUaMafqG6JSFm0V+5oUWdCMHmx9GTuQ5Mk+OejKoU7UOb0mu76ISPQwzPo0=
X-Gm-Message-State: AOJu0Yw5dRS1Hy5hYVVjmYNDyaD41hrqss5VqUJrevKb+Cymr82YG38M
	5NXgfLKInRxqHVrN2HlvsTIHUvbJ717cqz9PRZc7zydNZUEvwH+xDTKWxA7fjc8=
X-Google-Smtp-Source: AGHT+IHysr8Tgc5ey5jrgRUt5Qg2zyfxJ/YAUp2E2EN6PHVL/ZhhgxHZGrHQoak+XPgNwj8vKXUiGg==
X-Received: by 2002:a05:651c:1a1e:b0:2ec:59b6:ad71 with SMTP id 38308e7fff4ca-2ec59b6ae47mr75393621fa.40.1719395029661;
        Wed, 26 Jun 2024 02:43:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:43:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, 
 Allen Martin <amartin@nvidia.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/42] labgrid: Provide an integration with
 Labgrid
Message-Id: <171939502804.2754394.6148007977344212026.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 09:43:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2328

Hi,

On Tue, 11 Jun 2024 14:01:14 -0600, Simon Glass wrote:
> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
> 
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[18/42] meson: Correct driver declaration for meson_axg_gpio
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/96e1a156e90a0674b21c56e7121b17a9211176ec

-- 
Neil


