Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71FC47073
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web10.76916.1703577218363901283
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Dec 2023 23:53:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=V+Z/rs0z;
 spf=pass (domain: linaro.org, ip: 209.85.222.41, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cbe98278f8so1073966241.1
        for <u-boot-amlogic@groups.io>; Mon, 25 Dec 2023 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703577217; x=1704182017; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAxbftN0aN036HsMgXe5QrB4b6ULu6pXVWLHsE9HVNw=;
        b=V+Z/rs0zE11kyc7LN/DXu3b2oxmM6UyTfbv8GLgvBqs/pbR7noqD/e+xWjz8BCFWCv
         b8x69gyOTVZg6JXkFZ7hNkhTQJAWh1AnrhUbr7ROlA5hyI2zuX7sQnZSecTFElAHKM2S
         cqOSD7fAgu0Ye0DgnK+LFsMiPO8das6uNvO5aufQ73vUtXPkfAnpqY560aXoqM18NkEn
         cd156ghxmWcpzwSg1L8/jDUAGpvGfrwG5e2WqCIYlnhhJiMJ0fkpp7EtCwsFClUeNZQi
         4er5PYPM+ikXdYOcZmHWhIjz8L3T51jwSd+jCB4sZy2G7Gf+jjRA9MSuQxL360HEpzi7
         IhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703577217; x=1704182017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAxbftN0aN036HsMgXe5QrB4b6ULu6pXVWLHsE9HVNw=;
        b=q5lr6mavUQvi1V+i6yFMJwWFNYQtnjGp+Ri1iednbp4KcauDdjnnXRBbWFp2kRLFGc
         J1IdizjUkVvT84laEnFiz8pODmmzcrWlF1zfDCzQYnrGH+ePpWDpOL26hPLP6q5NQWuv
         txymW53RnDKfijZgT9E95Mh6v9icG6EsrUG3ZZdg0oe/pLVhzy8DHT/SPjF43KzE8UW3
         MSEr0pX/AuNeF2k4x4gUCu3Kv2Or3Y5akGRtcxf/WUrIwjMnByTAIttV8/ANSUhY0Xnj
         KiOpcohzr1gIget8Z5serlkOFkoOevAcrH4Fv+W8zA7JEUSzgFX+Bp1ZupUmcW0omyPL
         GyPA==
X-Gm-Message-State: AOJu0YwprC7hRj5DnonBmNCRc775sXfabFzPoOys0FIcBj4LUPchtjKg
	QL9HgYaWHQe73RQaE8RHpWG4zBB2wAsqxq1O3T1RSZhkmM0T8w==
X-Google-Smtp-Source: AGHT+IHAnJ3V6OtZXnmSKou/aW0fWVJXyihV/0ciysZ5EpmVI6INg0ZohlvD/54R+QqfFiRFOH/Mr685sZ7fewY/Skc=
X-Received: by 2002:a05:6122:2317:b0:4b6:e6b6:7f4f with SMTP id
 bq23-20020a056122231700b004b6e6b67f4fmr1625514vkb.15.1703577217348; Mon, 25
 Dec 2023 23:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org> <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org> <20231222-whole-canola-81240881c2e7@spud>
 <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
In-Reply-To: <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 13:23:25 +0530
Message-ID: <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within U-Boot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org, 
	caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1965

On Fri, 22 Dec 2023 at 21:23, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/12/2023 16:45, Conor Dooley wrote:
> >>>
> >>> I suppose we have to relay information to kernel sub-arch maintainers
> >>> who aren't the same as maintaining U-Boot counterparts. How about
> >>> adding U-Boot ML to CC for whichever DT change gets submitted in the
> >>
> >> And every other project? Just setup lei filters.
> >>
> >>> kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> >>> corresponding kernel DT changes works too if that's acceptable.
> >>
> >> You just entirely ignored my proposal without addressing it... ok let it
> >> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
> >> want kernel maintainers and contributors to be aware.
> >
> > I don't think that adding U-Boot platform maintainers as reviewers for
> > the platforms in the kernel is a terrible idea. Certainly kernel
> > platform maintainers for which U-Boot platform maintainers are added to
> > the MAINTAINERS entry will be aware. That said, something like your
>
> The point is it does not solve my concern here. I did not express
> problem that U-Boot maintainers are not aware. They can easily be aware
> by setting simple lei filters.

I thought your major concern was how we can enforce DTS backward and
forward compatibility although the DT ABI stability is already
documented here [1]. My suggestion was really based on recognising
people who really care about DT ABI for particular platforms. I think
adding people from other projects would certainly help with DT ABI
stability since the kernel is the single point of contribution. There
will be DT contributors from other projects too like you may have
already seen people contributing bootloader (U-Boot) specific
bindings/DTS changes.

[1] https://docs.kernel.org/process/maintainer-soc.html#devicetree-abi-stability

>
> The problem I want to solve is the kernel maintainers to be aware.
>

Although Tom has already expressed in the other thread that U-Boot has
been a long time user of upstream DT but if we want to make it more
formal from an enforcement point of view then I liked Conor's idea. If
you agree then I can create maintainer profile entry as per following
example for Amlogic platforms to start with:

ARM/Amlogic Meson SoC support
M:      Neil Armstrong <neil.armstrong@linaro.org>
M:      Kevin Hilman <khilman@baylibre.com>
R:      Jerome Brunet <jbrunet@baylibre.com>
R:      Martin Blumenstingl <martin.blumenstingl@googlemail.com>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L:      linux-amlogic@lists.infradead.org
S:      Maintained
P:      Documentation/process/maintainer-soc-u-boot-dt-abi.rst
W:      http://linux-meson.com/
F:      Documentation/devicetree/bindings/phy/amlogic*
F:      arch/arm/boot/dts/amlogic/
F:      arch/arm/mach-meson/
F:      arch/arm64/boot/dts/amlogic/
F:      drivers/pmdomain/amlogic/
F:      drivers/mmc/host/meson*
F:      drivers/phy/amlogic/
F:      drivers/pinctrl/meson/
F:      drivers/rtc/rtc-meson*
F:      drivers/soc/amlogic/
N:      meson

-Sumit

