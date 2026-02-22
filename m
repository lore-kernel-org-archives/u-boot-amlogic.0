Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20AEB3627
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 17:42:46 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6319.1771724131574108426
 for <u-boot-amlogic@groups.io>;
 Sat, 21 Feb 2026 17:35:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PayDYgl5;
 spf=pass (domain: gmail.com, ip: 209.85.222.41, mailfrom: davidzangcs@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso1898610241.0
        for <u-boot-amlogic@groups.io>; Sat, 21 Feb 2026 17:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771724130; cv=none;
        d=google.com; s=arc-20240605;
        b=EoY2Nh0k8lck/rPzyiesyFuvaf/vUmafeyD/xjhfIB7yLMwgOTUwWmFGS2GOYJsq1M
         ujKryO4J5r/dfhsrZyiPFtGO4tqjaLHeqoxBGfYw/OG+2HKVVIxr1fHi1tYnLVHJ1sSg
         TsCmn0J1/yUW2mfjlsYUF8j2cfqRA0PUFIoxL0TGzRyDLAWRi/hURQIRHp0MVbe+5KVq
         G75g94RBVmhBKQ8Dk+BJSakAoFB4vObLS5cEbRXgNoaOd4dO2p/Sb+RvgR7qUUOyJild
         d5JrR1kyHNaq1w8tRWcrr5sq3xZFfT3GXUfM46yrDP902UhSrTQe28FHWaMfHgliaz7t
         oohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
        fh=Pp0kuRypBFN1zScBqom1agvj3MUWQf/HC/jFU2QMkRU=;
        b=Q/BtMn58OQAobEIeB8icP3+exSjsyJhdViQEm98fyP8pVxiH0VAiKS35l26u5385TW
         5Zs1E3PX7hamFkb+6G7EA2XDWCGUe4j5iCAu09puRvJwFaGtZ88I8R+NrR3fD6BLveJV
         Idm96Il8kldBn27Yobeu4RZ9v1+q8BiI7UnEliUHWDMLqpSWupm9uP/oLCV8SQzVDflr
         /fG4ivp17QprRlYIPbXJkBrMnhaj2DkQH91jxoAYMPSi5LotrDZFayRcqBeY2xAGdG+s
         Y8pqhRii+VnLPJsTnEUG2LXldkf/ytDlftpo6Z+yRhCblj1iWW55iVhfIzDonXIIU3nB
         yT+w==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771724130; x=1772328930; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
        b=PayDYgl5Bn9tMU8LQFyaLWe+NTSyg9DuMu2LlWoginYUjkYjh9cBCjAwUTW23LYGw3
         ZnsUgd74mh9INMvRIRyp1oY1luHFLQHmQo+OE0SWZKigrOJM3JjFiUqH4Y1E+WufcKEF
         XRlsARv65U1R5lE7XYYpiMZteCrY45tAzeWSJai3p4nvjB8lltOwFTcWfv8NlbGtNquc
         QDsVA7M5NwBDxy36J8ywiEzE44U39j1OL1l0tnjfqtF7RKi8L2B1WqnoGqp/f723L6ee
         MbsSvcSO1crsGPIaVVo/1v7b9VIJraPxUAB5RdsmPrAWOYOYdYxDb1A/dUVJ9mp7mlFe
         S0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771724130; x=1772328930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
        b=k+4DkTUwjtAAjbopGjptQpmLUSX0s1xkUWiDNpFE393Vg3PeK39RBuFn80jSkjvyKO
         5Q8U76SC5Fy5rnJfemWINK0nsnZQjcsOMnVJxUxuVKKmB9Bu5GhXblKqsBvtQTMxWhqZ
         ZbWYm+7IABGcxEknsGZYswx07akmGiHf4ri/8DE7wNxBGKYAOl1YZUnTfumb1MOcRm0s
         qWgQfHo/2cOu8ZYb40JB19NVLsu1zzXbeW1zw8nUDNeZQfAeRcIWggahUFSngfhptijK
         Y9SuhQH5ThnOziVd8EyRIdDOOkU3UViULEty3eKOKR+bGvIxUGUY6Z3sotR2zZT4TOV9
         C4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWjeoaRKcQHnXCNMWyqKhqGjAeuaBkhwAlPFy5nBZsE2iWHk5S8cq3L6r/LbiBFEZ6N0nP4t0eoNRIb92Jctg==@groups.io
X-Gm-Message-State: AOJu0YyAnwPe/HEKxi6zSDCAwt6u1JfeU62vs7x7tDT5wQh5/AzRmSH+
	POZFlAtlcUQeNBSNh/gonS8Fm2uCjsbsU/Op7NudsOJkGQBlmuojbZ0/3Jg8ksTeSY3LijVfswn
	3nOb0K/GUUhBgDDsChhGu6DiKkhaiIybF9LhqQgw=
X-Gm-Gg: AZuq6aI9qVHk1p5mAHKWq9+FBVlj1Mz1XaAZKLiv7pfTxegZGMcXOzfyDSkGGiADj7g
	d1W5ySi/lQbTOR3oKLzdJ92HDUZiMVMX/powzneBxx3/ixfMprRApkIRbX9RTap2geIku0gDgyq
	lNATMCyuqedtr1AX1fSA2wQW/i1pSmcrv2aIvj+bnGEvXzNt7U91N8/pjyudRGft+D9GDl4dbYK
	tfu977NHd0qhXW5OQyK4Izj5OnCybiyxOvHXHZTMgckpeJX7eINiTJbnEygXcfiDLCPcy5MCq+x
	3KsNoQc=
X-Received: by 2002:a05:6a20:d527:b0:393:74ed:7dd5 with SMTP id
 adf61e73a8af0-39545f49d08mr3731480637.43.1771723672402; Sat, 21 Feb 2026
 17:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com> <20260203-cleanup-v1-5-4221c13e7558@nxp.com>
In-Reply-To: <20260203-cleanup-v1-5-4221c13e7558@nxp.com>
From: David Zang <davidzangcs@gmail.com>
Date: Sat, 21 Feb 2026 19:27:40 -0600
X-Gm-Features: AaiRm52fDpyyR2JBtvDrL4e_nxNMA9cikGT6QKNd5bMGIHNmFzL5II4XhCoiKzM
Message-ID: <CACwB3C9qsVasyMAq2Fw5Ly8RSuFL-k5xTAAEMP0+EdwWbC7=Zw@mail.gmail.com>
Subject: Re: [PATCH 05/14] test: log_filter: Include vsprintf.h
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Christoph Stoidner <c.stoidner@phytec.de>, kernel@puri.sm, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
	u-boot@dh-electronics.com, upstream@lists.phytec.de, u-boot-qcom@groups.io, 
	uboot-stm32@st-md-mailman.stormreply.com, adsp-linux@analog.com, 
	Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
	Anton Moryakov <ant.v.moryakov@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
	Rasmus Villemoes <ravi@prevas.dk>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Jerome Forissier <jerome@forissier.org>, Simon Glass <sjg@chromium.org>, 
	Max Filippov <jcmvbkbc@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Vitor Soares <vitor.soares@toradex.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Stefano Babic <sbabic@nabladev.com>, 
	Alexey Brodkin <alexey.brodkin@synopsys.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Stefan Bosch <stefan_b@posteo.net>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, 
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, 
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Michal Simek <michal.simek@amd.com>, 
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Aaron Williams <awilliams@marvell.com>, 
	Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
	Yao Zi <me@ziyao.cc>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Bin Meng <bmeng.cn@gmail.com>, 
	Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
	"Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, Oliver Graute <oliver.graute@kococonnector.com>, 
	Randolph <randolph@andestech.com>, David Feng <fenghua@phytium.com.cn>, 
	Linus Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
	Liviu Dudau <liviu.dudau@foss.arm.com>, Nishanth Menon <nm@ti.com>, 
	Robert Nelson <robertcnelson@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Gilles Talis <gilles.talis@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Matteo Lisi <matteo.lisi@engicam.com>, 
	Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, Mario Six <mario.six@gdsys.cc>, 
	Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
	Heiko Thiery <heiko.thiery@gmail.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
	Patrick Wildt <patrick@blueri.se>, Martyn Welch <martyn.welch@collabora.com>, 
	Ian Ray <ian.ray@gehealthcare.com>, Teresa Remmet <t.remmet@phytec.de>, 
	Mathieu Othacehe <m.othacehe@gmail.com>, Angus Ainslie <angus@akkea.ca>, 
	Stephan Gerhold <stephan@gerhold.net>, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
	Ilko Iliev <iliev@ronetix.at>, Kamil Lulko <kamil.lulko@gmail.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Dillon Min <dillon.minfei@gmail.com>, 
	Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Lukasz Majewski <lukma@denx.de>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
	Heiko Schocher <hs@nabladev.com>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>, 
	Ramon Fried <rfried.dev@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Stefan Roese <stefan.roese@mailbox.org>, 
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa <malysagreg@gmail.com>, 
	Ian Roberts <ian.roberts@timesys.com>, 
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
	Arturs Artamonovs <arturs.artamonovs@analog.com>, Anastasiia Lukianenko <vicooodin@gmail.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
	Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Anatolij Gustschin <ag.dev.uboot@gmail.com>, Brian Sune <briansune@gmail.com>, 
	Tingting Meng <tingting.meng@altera.com>, Mahesh Rao <mahesh.rao@altera.com>, Ye Li <ye.li@nxp.com>, 
	Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
	Jeremy Compostella <jeremy.compostella@intel.com>, 
	Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
	Debbie Horsfall <debbie.horsfall@arm.com>, Harrison Mutai <harrison.mutai@arm.com>, 
	Jonathan Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
	Francesco Valla <francesco@valla.it>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Yannic Moog <y.moog@phytec.de>, 
	Benjamin Hahn <B.Hahn@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, 
	Hai Pham <hai.pham.ud@renesas.com>, 
	"Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Neha Malcom Francis <n-francis@ti.com>, Keerthy <j-keerthy@ti.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Maxim Moskalets <maximmosk4@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Adriano Cordova <adrianox@gmail.com>, 
	Mark Kettenis <kettenis@openbsd.org>, Osama Abdelkader <osama.abdelkader@gmail.com>, 
	Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Joseph Chen <chenjh@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Viorel Suman <viorel.suman@nxp.com>, 
	Sky Huang <SkyLake.Huang@mediatek.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Christoph Fritz <chf.fritz@googlemail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>, E Shattow <e@freeshell.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Paul Geurts <paul.geurts@prodrive-technologies.com>, =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Eoin Dickson <eoin.dickson@microchip.com>, 
	Brian Ruley <brian.ruley@gehealthcare.com>, Swamil Jain <s-jain1@ti.com>, 
	Zixun LI <admin@hifiphile.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	Sughosh Ganu <sughosh.ganu@linaro.org>, Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
	=?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Alexander Graf <agraf@csgraf.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
	Leonard Anderweit <l.anderweit@phytec.de>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Ferass El Hafidi <funderscore@postmarketos.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 02 Mar 2026 17:42:46 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2921

On Tue, Feb 3, 2026 at 4:44=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> snprintf is used, need to include vsprintf.h. Otherwise there will
> be build error after asm/global_data.h is removed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  test/log/log_filter.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Reviewed-by: David Zang <davidzangcs@gmail.com>

David

