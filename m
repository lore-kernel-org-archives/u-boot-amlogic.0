Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE2CC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 07:54:20 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.1468.1713814569819311662
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Apr 2024 12:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ztt6JEdQ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4375ddb9eaeso28731311cf.3
        for <u-boot-amlogic@groups.io>; Mon, 22 Apr 2024 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713814569; x=1714419369; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L21Ma6lwh0kQWeK64WUAdv5y8b5n+0KVnewRokhfak8=;
        b=Ztt6JEdQ0kcZc38j7rLdya95FRiPBUJVD/wiG/XHRe2uMvigSeQl7/GSBX5eA7i7AA
         f8Cdynx9ekxq/EB86SoIES0OBslXSGE2zK0sR75UJRtdpjA28XGgzE29WL+2a1CL28ok
         cJZGXn4qiJBB/IPA2HRNFJMnQP80uwWfW27VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814569; x=1714419369;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L21Ma6lwh0kQWeK64WUAdv5y8b5n+0KVnewRokhfak8=;
        b=d+b1rp/PmqyXk1FEUbNhxOFG+GRUUwT5OJ+x0Ammzs6PXnA1Jkp+POqJh5WQ97eoC9
         4AQdfdMW3h3/CQbgkvJrU9N9CSPn6HK7u/dvLuvnI2ZYfexfLoCWwO8UTq3lg+45queZ
         wfRNLG2OVVM8AR0TxF+UlknUNRHGqlgZOVED/5t8JE4CeohEDb7vheFYKS6qSsgTTUZf
         rTO9jfgxb58g+9iyCW8H1/vH7LALEeFekgNAXUxGERFV3VNCoL3yRsqtTfczjezAYNa/
         GyGfl26wK1yZxwuviOWr6r+llEYKSTXZr/kXxQgzTWipgJeCwkeFPcxLsjhi7zStAGkB
         zVxA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTc+y+9+upgHMMz0p7VW6robatsozI6P7QxBCCeOx9uSkCkd+7wNzYiEgXuH4OEXOuRtqZqrioNR8RRGWhU4zbyjsDunlsfQ=
X-Gm-Message-State: AOJu0YxmxNkHtszRkLX0+nAayzrCrDotaUPb/eSN9nImEIQ0sbBjqFA4
	JDhAkfJGBtJsaqUrMRVn/v66+oKX9bTkSjZI7sEp8mi9mNk4dv6GWgdwx5LZI9I=
X-Google-Smtp-Source: AGHT+IGjga4KZKogIyZM1p0irH2LmXlKumpkIhr3LkiiUBMFN9CN5JkF/ZXsUs9LfKSlBuFF6LNkCQ==
X-Received: by 2002:ac8:7d05:0:b0:435:2351:75c6 with SMTP id g5-20020ac87d05000000b00435235175c6mr14232949qtb.46.1713814568681;
        Mon, 22 Apr 2024 12:36:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216])
        by smtp.gmail.com with ESMTPSA id kk3-20020a05622a2c0300b00436b2135b51sm4492448qtb.64.2024.04.22.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:36:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, 
 Michal Simek <michal.simek@amd.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Anastasiia Lukianenko <vicooodin@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Bin Meng <bmeng@tinylab.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Doug Zobel <douglas.zobel@climate.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eddie James <eajames@linux.ibm.com>, Elon Zhang <zhangzj@rock-chips.com>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Grzegorz Szymaszek <gszymaszek@short.pl>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jagan Teki <jagan@edgeble.ai>, 
 Johan Jonker <jbx6244@gmail.com>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Matthias Winker <matthias.winker@de.bosch.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Oliver Graute <oliver.graute@kococonnector.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 =?utf-8?q?Pawe=C5=82_Jarosz?= <paweljarosz3691@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philip Oberfichtner <pro@denx.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Lunn <tim@feathertop.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Viacheslav Bocharov <adeep@lexina.in>, Vignesh R <vigneshr@ti.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 "open list:VIM3" <u-boot-amlogic@groups.io>, 
 "moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
Subject: Re: [PATCH v2 0/5] Kconfig: some cleanups
Message-Id: <171381456119.1909236.8049238331801273262.b4-ty@konsulko.com>
Date: Mon, 22 Apr 2024 13:36:01 -0600
MIME-Version: 1.0
X-Mailer: b4 0.13.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 23 Apr 2024 07:54:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2277

On Tue, 16 Apr 2024 08:55:14 +0200, Michal Simek wrote:

> I looked as cleaning up some dependencies and I found that qconfig is
> reporting some issues. This series is fixing some of them. But there are
> still some other pending. That's why please go and fix them if they are
> related to your board.
> 
> UTF-8: I am using uni2ascii -B < file to do conversion. When you run it in
> a loop you will find some other issue with copyright chars or some issues
> in files taken from the Linux kernel like DTs. They should be likely fixed
> in the kernel first.
> Based on discussion I am ignoring names too.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



