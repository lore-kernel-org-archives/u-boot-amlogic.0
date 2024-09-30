Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C8CEACE6
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 16:07:10 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web10.53873.1727701675195927602
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Sep 2024 06:07:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=d24VTt0u;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.128.179, mailfrom: dario.binacchi@amarulasolutions.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e20a8141c7so39842597b3.0
        for <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727701674; x=1728306474; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I07UDFo2c3AKz30udHA706rmDftWknYWG6Tamh7HJ70=;
        b=d24VTt0uI/cwfEDqsmiNFesavYqv9WcDXwd5TH84NW1RLIYe65CIYFzvnZd2QL3WyR
         yiBJcWoSmuZ2JH1cdSs/dJGkRANS2RLKMN2JsBZcxcGrngsobUlCJibhuDchtmN2WIi/
         MUOcjDTi5qIMQKX26aGWLnyW0GwZOEKPJMK6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701674; x=1728306474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I07UDFo2c3AKz30udHA706rmDftWknYWG6Tamh7HJ70=;
        b=pTPGzuORkhchGcfmP/xRPG7gCLDefso1KB0di8F+PKYuR/RqgK0BtTsNnYP2Y2+cml
         QGqTBNMMkBnHGp4FqWy6egR4BTfXKwFJz77GfPDKhZrJ8hX/+n5Yuebc2P/wBkjy5Mim
         ihTsfh0KAm/AOz/Jhb+tEfSAWBx87AJtFtzuXMf2oexWgzmU5Wug6NQsyPrv11G+r8ID
         S3k3kv0GhKMec+MHAK2ilPSW0N65f/ReBYkR4WCuprNZ33doMAq0K/BovhBP/MyTDWrK
         TPAqBgYUKmm2ro5eHQshj05Inh2DA5G93Dyvqb/SMbuW22NobvGeb3qjqpFI6CvSsQO5
         DsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHhPE4RF18WzccRk5WooVsgZbBe00+IsaKF6DlMtSThgCzw7epjGxnQoaB/vmdoEcoLfOfCI7C4/6Ay1FINA==@groups.io
X-Gm-Message-State: AOJu0YwziFHvuuVexIm5Wak+kPHm3pMDsqWwEQw07g0SX6COT15DGqmN
	RnvgwwlK6dd4pHBr/dZhO2Z1t0Rzu5+CbM1knyGbhD46MXd2/cGjdA6WA5V8mMnBIm2RV7GqIjs
	Vwq+XBRb7kC0x+1l/K6i/hL3jf6PGc+SRASbvbg==
X-Google-Smtp-Source: AGHT+IHw2/Q8ksjFGnypQOBC/C8iwHFm00NOCjspvi00Cs4y+DxvtZ4oypo69D/InSZpLUWBwYD/ga+ugxy0VkQ7y4g=
X-Received: by 2002:a05:690c:6788:b0:6dc:97d6:bf7d with SMTP id
 00721157ae682-6e24754dfa9mr95018177b3.10.1727701674303; Mon, 30 Sep 2024
 06:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com> <20240930114314.30b9e1f5@xps-13>
In-Reply-To: <20240930114314.30b9e1f5@xps-13>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 30 Sep 2024 15:07:43 +0200
Message-ID: <CABGWkvo24fJnyQMau1y2K543mfwFmRdzt2OwTSvbTjv==Pa_OA@mail.gmail.com>
Subject: Re: [PATCH 00/26] Support display (and even more) on the BSH SMM S2/PRO boards
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
	linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
	AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
	Anatolij Gustschin <agust@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Anton Bambura <jenneron@protonmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Prusov <ivprusov@salutedevices.com>, 
	Igor Prusov <ivprusov@sberdevices.ru>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joe Hershberger <joe.hershberger@ni.com>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Julien Masson <jmasson@baylibre.com>, Liu Ying <victor.liu@nxp.com>, 
	Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>, 
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
	Martyn Welch <martyn.welch@collabora.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, 
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Nicolas Heemeryck <nicolas.heemeryck@devialet.com>, Nikhil M Jain <n-jain1@ti.com>, 
	Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
	Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefano Babic <sbabic@denx.de>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, 
	=?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
	Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
	Vinod Koul <vkoul@kernel.org>, Yang Xiwen <forbidden405@outlook.com>, Ye Li <ye.li@nxp.com>, 
	u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 01 Oct 2024 16:07:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2428

Hi Miquel,

On Mon, Sep 30, 2024 at 11:43=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Dario,
>
> dario.binacchi@amarulasolutions.com wrote on Fri, 13 Sep 2024 11:55:42
> +0200:
>
> > This series was created out of the need to supportsimple-framebuffer fo=
r
> > BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was necessary
> > to develop additional code and/or drivers for all the required componen=
ts
> > (i. e. clock, power domain, video, etc.). This series has a Linux
> > counterpart that will also be submitted upstream as soon as possible.
> > Furthermore, given the overlap in topics with the recent series [1], we
> > are open to collaborate on the common parts to ensure proper developmen=
t.
> >
> > [1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@b=
ootlin.com/T/#mb7cd440abc6fcc0de205f577eb3225e1c1c76823
>
> I received a bit of feedback on this U-Boot series, I can take the
> feedback into account and send a v2. Then, if you are still okay, you
> can stack your patches on top of mine and do the required adaptations
> (on both sides).

Sure, go ahead with version 2.

Thanks and regards,
Dario
>
> Thanks,
> Miqu=C3=A8l



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

