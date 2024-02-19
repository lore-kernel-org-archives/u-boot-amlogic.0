Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CEC54764
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 11:16:41 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web11.36327.1708324839783367894
 for <u-boot-amlogic@groups.io>;
 Sun, 18 Feb 2024 22:40:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Tf4xAZmA;
 spf=pass (domain: linaro.org, ip: 209.85.222.49, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so2003472241.0
        for <u-boot-amlogic@groups.io>; Sun, 18 Feb 2024 22:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708324839; x=1708929639; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gih0GO6lxYA6Qn9nK+gMlgd30RbeaRC9NNOqdPxy/iQ=;
        b=Tf4xAZmAXZIjGioCyXZszrztLel084ON83+cbLM+TBz1LdI0G675+n05tXXjEkjwiQ
         01hR+lGx13BPN6T6EyB1JFnSybHmgTX4+RqHIDPvM/thWo5hempFqr+aLrmp+nP+AB7r
         KHu0dXcXJvLaS0CR+I/t5d0KaWvpS856k/9lOsm2cjIwPccMSuBk0D+qMkfQNGPmSoRL
         lI/em4tw0NS4uu9RKWJKzlvJvK8nbyDkU6MGGX84MXaAaYjMID/aRi+nJVCwsMCh2YBm
         2aJs3mYEovWY+0oE+A7+eI+25nSedDQairhS4tPR6ACc3x2nLKy6Lx6BRMON0/d/1uch
         0Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324839; x=1708929639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gih0GO6lxYA6Qn9nK+gMlgd30RbeaRC9NNOqdPxy/iQ=;
        b=TpHfumlgyzB37yrbB/EtktxOu7TBvuCFnFNEjV5KwFyVduYFx8D6F/BdxXFmK72FME
         xo1fW7ePf+yypuClVh+CBrTDq78tijrnkqVu1q42LGPE6h8wHmfB/EC22YQc2tMBQegg
         +UW8z+KimhZayTn27wtzAnY/PNiGuJ2JGkphXQj5YLxvZEwZaPeZ/csJjn0NG9Q83XMC
         1b6qFrPFINgWR9Iu0YgtFh04SaHR1nYNz00QN6zcD2EXIWAdfvWsqESf8EsiLEiCyLa/
         MxiNohxTs+N15weqauvpq9SmxptHneQvtJtb43HrqhwL+rl8QQB6FjSLJyLNnqI8iDgo
         6OFg==
X-Forwarded-Encrypted: i=1; AJvYcCUVliXrl0u/yjyPfwYseEekZir1jbr26m6HWMlfWU4xt2tYxpsRCGtF+lSEC4vhzyWYmWnumG0SpibSUdeK0WC4u1NttzAgzG4=
X-Gm-Message-State: AOJu0Yy0eg9Z0lJKFgh1rmJSk5uz7pBJYnhn/QeeNU4CE/nYh+fO3XUu
	87qWIgfHGyyCO7V10v4orKpEbAPN0b1IMKmCcX2qmAO+ER21aWHfoDGfOaaPKfPo//GuDSydSd/
	Y7z1hnLid0cguqr73xJ+gTIXth51eTn/hmgFFhQ==
X-Google-Smtp-Source: AGHT+IGi1d5njPRfh80AHzWM6rl0/WwblY3nEx9D98J0ZLsJ/bK1l2mMIlm4YHSwMVp6ywOg9B0iuJaSLe3nrUbbDKc=
X-Received: by 2002:a05:6102:90:b0:470:5edf:42f1 with SMTP id
 t16-20020a056102009000b004705edf42f1mr746234vsp.15.1708324838374; Sun, 18 Feb
 2024 22:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org> <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
 <CAFA6WYOdYK4vAibGEQ9SnNCGMv00AKYkzZu+capfW9E4y=cFHA@mail.gmail.com> <e5eec82e-359d-45ad-a01d-6d852fe78d99@bp.renesas.com>
In-Reply-To: <e5eec82e-359d-45ad-a01d-6d852fe78d99@bp.renesas.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 19 Feb 2024 12:10:27 +0530
Message-ID: <CAFA6WYPYSj4Am1jZMyAM-4VpxoqMbBiSOTSVMsjF2MabA-UeXQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing subtree
To: Paul Barker <paul.barker.ct@bp.renesas.com>, robh+dt@kernel.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Feb 2024 11:16:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2128

On Fri, 16 Feb 2024 at 16:17, Paul Barker <paul.barker.ct@bp.renesas.com> w=
rote:
>
> On 14/02/2024 13:32, Sumit Garg wrote:
> > On Wed, 14 Feb 2024 at 03:01, Paul Barker <paul.barker.ct@bp.renesas.co=
m> wrote:
> >> On 02/02/2024 13:05, Sumit Garg wrote:
> >>> +Dependencies
> >>> +~~~~~~~~~~~~
> >>> +
> >>> +The DT schema project must be installed in order to validate the DT =
schema
> >>> +binding documents and validate DTS files using the DT schema. The DT=
 schema
> >>> +project can be installed with pip::
> >>> +
> >>> +    pip3 install dtschema
> >>
> >> Unfortunately this won't work on recent distro versions, e.g. on Debia=
n
> >> 12 I get:
> >>
> >>     error: externally-managed-environment
> >>
> >>     =C3=97 This environment is externally managed
> >>     =E2=95=B0=E2=94=80> To install Python packages system-wide, try ap=
t install
> >>         python3-xyz, where xyz is the package you are trying to
> >>         install.
> >>
> >>         If you wish to install a non-Debian-packaged Python package,
> >>         create a virtual environment using python3 -m venv path/to/ven=
v.
> >>         Then use path/to/venv/bin/python and path/to/venv/bin/pip. Mak=
e
> >>         sure you have python3-full installed.
> >>
> >>         If you wish to install a non-Debian packaged Python applicatio=
n,
> >>         it may be easiest to use pipx install xyz, which will manage a
> >>         virtual environment for you. Make sure you have pipx installed=
.
> >>
> >>         See /usr/share/doc/python3.11/README.venv for more information=
.
> >>
> >>     note: If you believe this is a mistake, please contact your Python
> >>     installation or OS distribution provider. You can override this, a=
t the
> >>     risk of breaking your Python installation or OS, by passing
> >>     --break-system-packages.
> >>     hint: See PEP 668 for the detailed specification.
> >>
> >> I don't have a good solution to recommend here - there's no consensus =
on
> >> how to install Python tools for use in development. You could use
> >> `pipx`, you could create a virtualenv, and I'm sure there are other
> >> options as well. Perhaps we just need to leave it up to the reader to
> >> find out how to install dtschema on their system.
> >
> > I suppose you haven't installed python3-pip package [1] on your Debian
> > 12. BTW, `pip3` is being used as the common way to install dtschema
> > [2]. Also, every user may not be aware about python virtual
> > environments. So it's better to provide the commonly used pip3 option
> > for installation.
>
> The python3-pip package is installed, it's the pip3 program that is
> printing the error message I saw. This is the new behaviour in Debian
> 12, also seen in rolling distributions like Arch Linux and OpenSuSE
> Tumbleweed since the middle of last year. There is a good guide to this
> from Python=3D>Speed [1] and more detail in the Python packaging spec [2]=
.
> Sadly it's something we now have to live with in recent Linux distro
> releases, and I expect all distros will enable this in upcoming
> releases.

Okay I see, thanks for bringing it up. I hope Rob will take note of
this and update dtschema installation instructions [1] accordingly.

As part of v6, I will rather guide users towards the dtschema github
page in order to get installation instructions.

[1] https://github.com/devicetree-org/dt-schema/tree/main?tab=3Dreadme-ov-f=
ile#installing

-Sumit

>
> [1]: https://pythonspeed.com/articles/externally-managed-environment-pep-=
668/
> [2]: https://packaging.python.org/en/latest/specifications/externally-man=
aged-environments/#externally-managed-environments
>
> Thanks,
>
> --
> Paul Barker

