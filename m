Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D0108E1FF
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:27 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8479.1773996800946155543
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Mar 2026 01:53:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d3j0UbJk;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: clamor95@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6687be9791cso2310065a12.0
        for <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 01:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773996799; cv=none;
        d=google.com; s=arc-20240605;
        b=SYq35r8rUUPGJHgOEiB3HzqQJDG+hvFp2orHkNrlKNECYyJmssjvEdTC3QGUKPBMee
         O1FGU91azwvn3Rhovycj+SOlUxM2v42/ttWrBrbLxWlgOHDVzg5j4PM41HstEoGB/vKE
         S5vJgO2MpnSSQh7MaKS8a7Kg7B6EkDcAKQ8K31ZskV2QJqtpKNeLR/1vgK1oLyEHdjDU
         7bje7WmsdYMA68zeTPyPcsILaRUFhfSBi+VfEO0pKIoV4IoZ0YpQ1/Yb6T50XvvSrMbG
         EbqY8mtZIqJBYk7gW/+OeYq6TJKw8RXHBe7ahDyDNKi/X0YiBSgK34DKIflW4ft5smKo
         iVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
        fh=HQuulqgRxDFhYXC2KW+dhbZxt1w0T0YnWmuyXo3Ir/k=;
        b=GwHn4Ydv6F7+T5GeDR6GnAchZKJCkrsvDVjZz659Ly7vys1u+WPPK6QFOeWzCrCSOo
         AAmGfiyRSziKzIDLYQsC+smmOD7ovPJNuMqLvy4mefsSGu6fxfqoZesVpdJW8Q4LhZkQ
         zXtKkohD+xQaXjxZnVCr8j5++wX1G7FYQAegxpnMdMJKl/MLxRVm+ePAk1YZ1Tf++3QJ
         yZE/s+OZEbK31eEpuux+2cGoKeoz/vDbBdr4c0dfdpbLB79HMQU5er5+R4cEb1soLCIA
         EDq/9bAEDmV8/2dBVNuxJ7ZXSw4lYaeTqKFRfPkHptpt1qY9mYq9GHqM04+ddWn8GQTh
         X0BA==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773996799; x=1774601599; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
        b=d3j0UbJkrcwZqujr6W/eZx369B7//yrgkhsfOegqagUyZMqPOekmPM9oFZXZYGwknd
         chDo2tq+pbwLS5rOeRf7pTRlp2ssZjgBUiHjLHMmk3ZeLWw8BlZptQEaGxNrR/PFLnZn
         RMiyTSCFnNc3bko7/HMWMfFjpKZLTOi0ilLvRVGnEnTseK9A4TC3u6kcaa4qeg8asLsf
         JilPwNVsDfduvN/BSz+/bYY2G98Csy0rO0zf6DuCxhL6EcNpBcIcoDajHpXKPMNCcgzm
         YMZFBRWUTt1e49vOexZnJyTFJMHuyZn1W7CBUr6z887Q2OW94BtYJz43Vc1sihKHf012
         H0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996799; x=1774601599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
        b=bIz9io6yTx/n2TQOoJf5SRb7Ae5pfHMnhrzZap1xv2TRxIPjUut11sagrrDkwoWtTC
         hPQEf1r1noHCyYafJ1KIEACRlGpRhvX91asY+Bgyu9Il5eNkRMp/n13fi8Cw5e1zgFrf
         204JBRSkJwZab3E9UV48V7AGECvw07+GoHCDXAW9dIwwFfzpR8hhCrLtT0hAHHhNrW8b
         wQvRwS+pzSZSxMIR0mLOGJPsxpO29qLQy+kqcsT2jR6rKCvNdosci0/MMVEVKJwZdEGC
         piqnyGIMTavbitFvPD8vm3dZKuDQOvPYdI98J1jykMufbeo/HFnY1C/9WyCdxW2XcptS
         77NA==
X-Forwarded-Encrypted: i=1; AJvYcCXFF3Fq2UL1lLhaZTEi/N8FzPtBY+Be0QbCs4EJKJF8KbYqWBb5ZsTUy/VkCDSu7SDQ+oTmonyYijGzgL5AWQ==@groups.io
X-Gm-Message-State: AOJu0Yxar/D0ZaQZsQzHo3yRwaeL2dBNGnzEnTf7IYN1qtENFb/AJ4em
	oOZh/0LWEHQeCf3+Ep2wDuOlypw4FoMFlOrUgWCvLkYyptqYEcrPn/uqwIDvXXQWD9uNnwHixtx
	ak8ymJXUZzF1+ZLP38Amo82TbGmYsoAThUUXV
X-Gm-Gg: ATEYQzz7saL3k2vXQfxR6wI2PvGK8a+cnbOQp5EaMtlPKDRjjYk1b8T8iRqrGiXlBI4
	qIJXPMm2BU/JkK1YPcIKeR6Tsq7Y/THCS/9Ah2S8av0kZFT3DMPsDp+NZccO+lCXNZ8YVoNqcmu
	azdVfDZ9Jz+qXIXe9yYXOluLgx1nKoApVLHEOqjZjuqO34m78V6YXcs+9n8QYSPbx7ysMuiICvc
	EqTItcXSQ44hnvniAU/1pEW6Z6aS8DMP4YvnMGOCuq3R6/wxxQ84U67zcicTKxPP0IHVgDG9Xzf
	6DmJq049
X-Received: by 2002:a05:6000:1a8f:b0:43b:43ae:8c25 with SMTP id
 ffacd0b85a97d-43b64291eabmr3603207f8f.52.1773996365312; Fri, 20 Mar 2026
 01:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Mar 2026 10:45:52 +0200
X-Gm-Features: AaiRm51Mwbxlj-hl5Dpc9uqfgwctj4ALzZG2MKiLKqmxjj9fG2skgTxP_eci6f0
Message-ID: <CAPVz0n2zRSTj7iNDCA_ExnRtcf5s0fDkzu5KdNjDjyr8mDZbkg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to U-Boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, u-boot-qcom@groups.io, 
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Paul Barker <paul@pbarker.dev>, 
	Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, uboot-snps-arc@synopsys.com, 
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
	Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Stephen Boyd <swboyd@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Glass <sjg@chromium.org>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Raymond Mao <raymondmaoca@gmail.com>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
	Leo Yu-Chi Liang <ycliang@andestech.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, 
	Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
	Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
	Arturs Artamonovs <arturs.artamonovs@analog.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Sean Anderson <seanga2@gmail.com>, 
	Liviu Dudau <liviu.dudau@foss.arm.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
	Stefan Roese <stefan.roese@mailbox.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
	Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Philip Molloy <philip.molloy@analog.com>, 
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Ryan Wanner <Ryan.Wanner@microchip.com>, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, 
	Manikandan Muralidharan <manikandan.m@microchip.com>, 
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	Jens Reidel <adrian@mainlining.org>, David Wronek <david.wronek@mainlining.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, 
	Nishanth Menon <nm@ti.com>, Alice Guo <alice.guo@nxp.com>, 
	Valentin Caron <valentin.caron@foss.st.com>, 
	Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
	Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Padmarao Begari <padmarao.begari@amd.com>, 
	Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Sam Day <me@samcday.com>, Rui Miguel Silva <rui.silva@linaro.org>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, Shmuel Leib Melamud <smelamud@redhat.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Heiko Schocher <hs@nabladev.com>, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
	Dinesh Maniyam <dinesh.maniyam@altera.com>, Paul Sajna <sajattack@postmarketos.org>, 
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2927

=D1=87=D1=82, 19 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 22:56 Case=
y Connolly <casey.connolly@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This RFC provides a proof of concept for using the full Linux CCF in
> U-Boot and consequently porting full Linux clock drivers with extremely
> minimal changes.
>

Hello Casey,

Patchset is incomplete (32 patches only). Split it up into smaller chunks.

