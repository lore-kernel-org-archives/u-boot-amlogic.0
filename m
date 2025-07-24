Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B1C87FCD
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 08:18:14 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.5269.1753393006919851523
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Jul 2025 14:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CMjbgXv0;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab6416496dso19065881cf.1
        for <u-boot-amlogic@groups.io>; Thu, 24 Jul 2025 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753393006; x=1753997806; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPxVMYbbKVbjD1LnqDvMp6mdQbbSwvqoiCWolQ08/gE=;
        b=CMjbgXv0eCc3p5gsfa3eQqk7A1qs/DcbrXnBkdTn7ZkCF3kmiVM/iE2ZKPpmrcVzYo
         6r06HAdS/I/ou25v61e/bRWODMKdEEZFRwtLDa/SqXQ4hraUT3k0AtQXKaUCir+KuahI
         P27CkEUphVfLOiw7jtSQDCzLwNOi+2BX4ka3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753393006; x=1753997806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPxVMYbbKVbjD1LnqDvMp6mdQbbSwvqoiCWolQ08/gE=;
        b=Bo5IzEjH9BlA02sJKUNlVz5+yVZk6Ky+TX8EJdbFkJMPfHNVvSr9KX//nxytaEa4Et
         qYAH4GFGMdfI81vF8pIGfwK45XqWUB5GXYb65o/S8cnToDCDGyBci9J95PmOdiam2g31
         HR+Ub+zmugcvI2DFKaKtE12Ii2hOgoip2FEAbOxIxr+5xhkwsUoblm4ynI/e9ALtML8/
         y6lCr/9OhhKA/UR9ywnqLCqfRK7rO4ShQvAD+CBvMZyfIq2Qr5wQs/kiDLbtjia4qdRh
         pkpj9nPHL72n7EacllX24IgZSIdzNwojVwvypVn5EOFkvToQRzJo1U/ueJ40WavQMPUW
         F/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWxcC9T1LzYgkOD3qwDX1Wqb4dgp1Fyq4I5RnbJ9+gnhE+TtVBf8BIfLuMR1fpSiIHHxq8OOvOuf1kZRUvo2Q==@groups.io
X-Gm-Message-State: AOJu0Yxh4eSHoAAesTJqmJbReSMpMqfNrN4jrgIVO6bb2nLlwc61VT7z
	qBoCGoauvoz/3wekZB3WXwU8AxgtU7S50T2M/C9BV9g6XVT0Mtq9s+eRs4OATDx10UFGP0gHY4q
	dyXLx74E=
X-Gm-Gg: ASbGncsaVcW5Yndiqe4EIhZsXUROE4/eRIQF2P6O3SQwGMxFFHEaFkaivRL9zhffr0P
	WWdAU4yJ7DaI/eagfLJir831veFwkGylHSYoAkoiA3TJOSMIUjed6jMXHhlrtfCubtmDajb/F9h
	73fRVN4LykPBZbLbGA1cXlMeD55U21CgcSZBL+H2Sth9o6dZ8UyZzUv39rZX+KjPnYHCtKLJ63E
	MUbCRZvAeI8DrlDDNWnh2nhC9/Pw/LEik5bSWIJpVhJ3r0o5/tLe+Liv/RCBhkKJQ/1iskiqN1k
	QVtsb97TrImkjaTYIT1yRZECE3BclQavyPdb6paoLCiRaPKzPn2sRGqfRgbk7wU7YN3m4qsDbIj
	mWuE2fSUTn885rUxemGCSnFVq/htquu1EBIBYEoi1I3DRjiyIUefeHmhixV7YJQOMyg==
X-Google-Smtp-Source: AGHT+IG0FY2EDvYGbb64jrHdiWUQWKS88Y8wn2wbX8Iy1WYMr5QZ7j5xiKwzKDoUxQj8GpweL8iRng==
X-Received: by 2002:a05:6870:6f0c:b0:303:5cb:4296 with SMTP id 586e51a60fabf-306c728975emr6224526fac.30.1753392632210;
        Thu, 24 Jul 2025 14:30:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:30:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Aaron Williams <awilliams@marvell.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Ben Horgan <ben.horgan@arm.com>, Adam Ford <aford173@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Sergey Temerkhanov <s.temerkhanov@gmail.com>, Marek Vasut <marex@denx.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Eric Nelson <eric@nelint.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Michael Walle <michael@walle.cc>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Fabien Parent <fparent@baylibre.com>, 
 Stanley Chu <yschu@nuvoton.com>, Jim Liu <JJLIU0@nuvoton.com>, 
 Tianrui Wei <tianrui-wei@outlook.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>, 
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>, 
 lixinde <lixinde@phytium.com.cn>, 
 weichangzheng <weichangzheng@phytium.com.cn>, 
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, 
 Paul Barker <paul@pbarker.dev>, Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Sean Anderson <seanga2@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dillon Min <dillon.minfei@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20250717024426.26953-1-semen.protsenko@linaro.org>
References: <20250717024426.26953-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] treewide: Remove empty board_init() function from all boards
Message-Id: <175339262777.1899261.14751318047956466864.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:27 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Jul 2025 08:18:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2732

On Wed, 16 Jul 2025 21:44:26 -0500, Sam Protsenko wrote:

> Commit 86acdce2ba88 ("common: add config for board_init() call")
> introduced CONFIG_BOARD_INIT option. This option can be disabled for the
> boards where board_init() function is not needed. Remove empty
> board_init() calls for all boards where it's possible, and disable
> CONFIG_BOARD_INIT in all related defconfigs.
> 
> This cleanup was made semi-automatically using these scripts: [1].
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] treewide: Remove empty board_init() function from all boards
      commit: 70a4d1fa1ddb2f5f8f9a27442563f182549abbb5
-- 
Tom



