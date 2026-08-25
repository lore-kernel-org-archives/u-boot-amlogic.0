Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA64C61DD2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21943.1787665615802910599
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Aug 2026 06:46:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pZsrH2vT;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: clamor95@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f432ac553fso4578483a34.3
        for <u-boot-amlogic@groups.io>; Tue, 25 Aug 2026 06:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665615; cv=none;
        d=google.com; s=arc-20260327;
        b=MA+ukSEWND7b9OW1cbbXcKWVyZm5Uj03Tz010l72bPWqk5sbt6j0qT+yQvffd9xHqw
         A8Ib4gnbYcZpInal4Yc2M6TMgnqi0QNfjQxOXHOCwgYGM2Y1dCUeXzdeieEKK8D0U0ah
         021LGFvsUV1nZ5B23G2pRzfXM/yDeh/VwMQxJeSkGpoZAv/A3HhvF8e3sEcKtxWHsnEu
         4AZ6cEbLzc/UNwv81J9LZdCEZOHc1QISHR50cVcIUI4e/4kb41kWiccpQnmH2XVCYpOz
         B0qPq/R6nMpc/YB5+oe8qCqvZaYtD9ZEqDMkRl6T6cMiuIfanUXAA3odIq6A9z14DvCl
         BV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
        fh=ovuU++2QVepIXKVKxDiwYb/jxlk29hOwfIq9rWeS6b8=;
        b=ex148h1GT92alHq5r95hnXSinosnmikWZO9jzCUtWgRe8QEfjAct63ZfqUyU+yJHDZ
         UkvYN8glRRSoccLqa/DmK5VKdZV8mrQTs4VxFf63MlxfhD+V37IObky6IbPRryfW3Yd3
         FKr8mGHW737PseFg7fTUwKKDTCzAHY0q7dSaEygXtaLZ40YkCp0G/0BnrEYau5kWwe1s
         6lG0FXU5pcEouc1YjsZNVEumHAlxtnMADPE3q0xkGM3c1C96/gYgDGTTHoMLTByszBxr
         BodjQx5SX46K1JBhdg4IVb5+NhmjvVTC2HkqS9z8dVampl1W4CRG+bSlObDL7nioJDNX
         gQYg==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787665615; x=1788270415; darn=groups.io;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
        b=pZsrH2vT1xoTyNesKtlgbKsTnFU8BeWaujFZwTEraig4WaUGoekEoRnoX7kLMjAGVi
         FzcwQfqSGcpYFVMJmfiYdZisJ9hbFqsRlTro9+wwYMzihTordHm6LCpqLRukPk6QmK6a
         1pYFOwefUTc3RMoCV22yLZuML07cmSGjX+n806T3Puy1afeMWd0RNjTdQMT5hkZWp+fS
         JsBXx1rajfIEsi/gBBurvqg7Z0/a7xTyJ7HV00fA4spSo6GiVHKA10Z9hLM/CMyrCQtj
         nBRN/fx6BqjdHa0kaccqMUdMMsrWvCq2pWobZnUw+K4uL65WkAweqcZ4u4H/jrQRhV1e
         F8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665615; x=1788270415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0iDncQNXsfnBMlwP36HRTNcxHB7ijq8ZtgtcGgFKNU=;
        b=ZqfQT9zEugrm6VanfDUamcLvHaz5B9NnxTIMG5nZjsGdNlj+vjNTJCz8yS+ZYo2+kv
         8yXM1TW8RcDu8+lCbODUxs13Ru9j2BOv6tRwqDBbO3/vY6hxjw3G4fdK+wygsaGZaozl
         9Paz52HJhCxMacWhdgv1rk1fWnr/NrGWhCujzBM3lpwxTtefrakpF6QRQQQpJxGdGEuE
         1nZFpPLINHq3K1V+E8BjJALYgEfr9tv60NWXf2zkgJFjuTm0BYt+2hX1Mivxt8tNdsYy
         qqT33/7wryYxdzFWKFVzOVZdT3oaD5dpQzdqu2M4VcPf3boDOcN0dOl+DLUG9wWfGvbz
         sYww==
X-Forwarded-Encrypted: i=1; AHgh+RqHJD8+kirU/zvi3qXBjsk7gbMD3s+wQB85UouqlBHhnbQT+uQ5VejnApuZiAcIbqTsdcy9A5u4iiFzcFRR/w==@groups.io
X-Gm-Message-State: AFuF++nWYwZPr20BOt0ORpuTpg9BFgXhXRxlzGTJLHt8TY8GUNNibKmw
	EkGrCiyx1EE4j70+wLU2imVyYndrd8xAkfx9TFuI95BIqPhQElnDeCHEMBH74HFSjg7kqyc/etp
	6C/TEiA1CAJkRFbBpVcp/irzJGzwrF5LogieQ
X-Gm-Gg: AR+sD105dR2ymgeheF5WF+w4OaNg2vkv0gRTuEan7mdLXUt33/5zbEMABOluqeREj7h
	WNqK9ln1gAzz/2P2mwyHxhoYrtF9nW6ylyW+UP8HqB7LfVA4dBgN+91/Ms2LlJSqYEYp5FHVjlj
	uQFO369ymlgRKj7Xing0Ws1m6IxZa5N6u182TZ9uppV0aa9CZd736pILaMP+qbw6Vbdwsa38Xnz
	DmywyEkP1MrDf9p820B2cXCyqFy30VCEEr2Ygc/j/9E7zIip4PYe8gafy69eh0LtmbfnU3mLhMf
	Ktxd1u0JxdmVXWgvOFX846BBjbH5TmRYBMHXR25fxSv5FqJltrsb/5O935Hk3Wb7vuH3GvMMO/D
	vxQ==
X-Received: by 2002:a05:6820:1891:b0:6b1:63d8:261d with SMTP id
 006d021491bc7-6b163d8278cmr29050456eaf.17.1787665268359; Tue, 25 Aug 2026
 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787555916.git.michal.simek@amd.com> <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Aug 2026 16:40:56 +0300
X-Gm-Features: AcwNN1UdfeduB0orbaE0RBZahpO5HjMzpaNM-zPZDPVYe4CiSL7Bfv5OQnbb6Xo
Message-ID: <CAPVz0n1Bxi-zp0X9Jh3D02B2LtQnBV0OHLXWw0fyG4eO+hVegg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
	Tom Rini <trini@konsulko.com>, Aaron Williams <awilliams@marvell.com>, 
	Adam Ford <aford173@gmail.com>, Alban Bedel <alban.bedel@avionic-design.de>, 
	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Allen Martin <amartin@nvidia.com>, 
	Andre Przywara <andre.przywara@arm.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, 
	Bryan Brattlof <bb@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
	Chee Hong Ang <chee.hong.ang@intel.com>, Chee Tien Fong <tien.fong.chee@intel.com>, 
	Chin-Liang See <chin.liang.see@intel.com>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	"Cogent Embedded, Inc." <source@cogentembedded.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinh.nguyen@intel.com>, Dominik Haller <d.haller@phytec.de>, 
	Dzmitry Sankouski <dsankouski@gmail.com>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, 
	Eugen Hristev <ehristev@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
	Garrett Giordano <ggiordano@phytec.com>, Gilles Talis <gilles.talis@gmail.com>, 
	Green Wan <green.wan@sifive.com>, Hans de Goede <hdegoede@redhat.com>, 
	Heiko Schocher <hs@nabladev.com>, Holger Brunck <holger.brunck@hitachienergy.com>, 
	Ian Ray <ian.ray@gehealthcare.com>, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Le Jin <le.jin@siemens.com>, 
	Ley Foon Tan <ley.foon.tan@intel.com>, Lim Siew Chin <elly.siew.chin.lim@intel.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Marek Vasut <marek.vasut+socfpga@mailbox.org>, Martyn Welch <martyn.welch@collabora.com>, 
	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>, Mathew McBride <matt@traverse.com.au>, 
	Matthias Winker <matthias.winker@de.bosch.com>, 
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
	Oliver Graute <oliver.graute@kococonnector.com>, 
	Parthiban Nallathambi <parthiban@linumiz.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Peng Fan <peng.fan@nxp.com>, Peter Geis <pgwipeout@gmail.com>, 
	Peter Robinson <pbrobinson@gmail.com>, 
	"maintainer:TK1-SOM BOARD" <Peter.Chubb@data61.csiro.au>, Philip Oberfichtner <pro@denx.de>, 
	Pramod Kumar <pramod.kumar_1@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
	Quentin Schulz <u-boot@0leil.net>, Randolph <randolph@andestech.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Sam Day <me@samcday.com>, 
	Sam Shih <sam.shih@mediatek.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, 
	Simon Glass <sjg@chromium.org>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
	Simon Guinot <simon.guinot@sequanux.org>, Sinan Akman <sinan@writeme.com>, 
	Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@nabladev.com>, 
	Stelian Pop <stelian@popies.net>, Stephan Gerhold <stephan@gerhold.net>, 
	Sumit Garg <sumit.garg@kernel.org>, Teresa Remmet <t.remmet@phytec.de>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, Tim Harvey <tharvey@gateworks.com>, 
	Tom Warren <twarren@nvidia.com>, Tony Dinh <mibodhi@gmail.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Wasim Khan <wasim.khan@nxp.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, "open list:P212" <u-boot-amlogic@groups.io>, 
	"open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>, 
	"open list:phyCORE-AM62ax" <upstream@lists.phytec.de>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3069

=D0=BF=D0=BD, 24 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 10:1=
9 Michal Simek <michal.simek@amd.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>  board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>  board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>  board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>  board/Marvell/octeontx/MAINTAINERS                |  2 --
>  board/Marvell/octeontx2/MAINTAINERS               |  2 --
>  board/Synology/ds116/MAINTAINERS                  |  1 -
>  board/acer/picasso/MAINTAINERS                    |  1 -
>  board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>  board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>  board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>  board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>  board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>  board/amlogic/p212/MAINTAINERS                    |  1 -
>  board/amlogic/q200/MAINTAINERS                    |  1 -
>  board/amlogic/s400/MAINTAINERS                    |  1 -
>  board/andestech/voyager/MAINTAINERS               |  1 -
>  board/asus/grouper/MAINTAINERS                    |  1 -
>  board/asus/transformer-t114/MAINTAINERS           |  1 -
>  board/asus/transformer-t20/MAINTAINERS            |  1 -
>  board/asus/transformer-t30/MAINTAINERS            |  1 -
>  board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>  board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>  board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>  board/avionic-design/plutux/MAINTAINERS           |  1 -
>  board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>  board/avionic-design/tec/MAINTAINERS              |  1 -
>  board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>  board/bosch/acc/MAINTAINERS                       |  1 -
>  board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>  board/compal/paz00/MAINTAINERS                    |  1 -
>  board/compulab/trimslice/MAINTAINERS              |  1 -
>  board/comtrend/vr3032u/MAINTAINERS                |  1 -
>  board/comtrend/wap5813n/MAINTAINERS               |  1 -
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>  board/davinci/da8xxevm/MAINTAINERS                |  1 -
>  board/embest/mx6boards/MAINTAINERS                |  1 -
>  board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>  board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>  board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>  board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>  board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>  board/ge/bx50v3/MAINTAINERS                       |  3 ---
>  board/htc/endeavoru/MAINTAINERS                   |  1 -
>  board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>  board/intel/agilex-socdk/MAINTAINERS              |  1 -
>  board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>  board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>  board/keymile/km83xx/MAINTAINERS                  |  2 --
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>  board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>  board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>  board/lg/x3-t30/MAINTAINERS                       |  1 -
>  board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>  board/mediatek/mt7981/MAINTAINERS                 |  2 --
>  board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>  board/microsoft/surface-rt/MAINTAINERS            |  1 -
>  board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>  board/nvidia/beaver/MAINTAINERS                   |  1 -
>  board/nvidia/cardhu/MAINTAINERS                   |  1 -
>  board/nvidia/dalmore/MAINTAINERS                  |  1 -
>  board/nvidia/harmony/MAINTAINERS                  |  1 -
>  board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>  board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>  board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>  board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>  board/nvidia/p2571/MAINTAINERS                    |  1 -
>  board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>  board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>  board/nvidia/seaboard/MAINTAINERS                 |  1 -
>  board/nvidia/tegratab/MAINTAINERS                 |  1 -
>  board/nvidia/venice2/MAINTAINERS                  |  1 -
>  board/nvidia/ventana/MAINTAINERS                  |  1 -
>  board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>  board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>  board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>  board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>  board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>  board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>  board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>  board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>  board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>  board/nxp/lx2160a/MAINTAINERS                     |  2 --
>  board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>  board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>  board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>  board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>  board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>  board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>  board/ouya/ouya/MAINTAINERS                       |  1 -
>  board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>  board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>  board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>  board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>  board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>  board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>  board/renesas/blanche/MAINTAINERS                 |  1 -
>  board/renesas/eagle/MAINTAINERS                   |  1 -
>  board/renesas/grpeach/MAINTAINERS                 |  1 -
>  board/renesas/v3msk/MAINTAINERS                   |  1 -
>  board/samsung/starqltechn/MAINTAINERS             |  2 --
>  board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>  board/siemens/iot2050/MAINTAINERS                 |  1 -
>  board/sifive/unmatched/MAINTAINERS                |  1 -
>  board/sunxi/MAINTAINERS                           |  2 --
>  board/ti/am62ax/MAINTAINERS                       |  1 -
>  board/ti/am62dx/MAINTAINERS                       |  1 -
>  board/ti/am62px/MAINTAINERS                       |  1 -
>  board/ti/j7200/MAINTAINERS                        |  1 -
>  board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>  board/toradex/apalis_t30/MAINTAINERS              |  2 --
>  board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>  board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>  board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>  board/toradex/colibri_t20/MAINTAINERS             |  2 --
>  board/toradex/colibri_t30/MAINTAINERS             |  2 --
>  board/toradex/colibri_vf/MAINTAINERS              |  1 -
>  board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>  board/traverse/ten64/MAINTAINERS                  |  1 -
>  board/wandboard/MAINTAINERS                       |  1 -
>  board/wexler/qc750/MAINTAINERS                    |  1 -
>  board/xiaomi/mocha/MAINTAINERS                    |  1 -
>  board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>  board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>  board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>  134 files changed, 241 deletions(-)
>

LGTM.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra

Thanks!

