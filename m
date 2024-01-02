Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5FC4828E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.29366.1704204404065182234
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 06:06:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=XN41DPw2;
 spf=pass (domain: chromium.org, ip: 209.85.222.178, mailfrom: sjg@chromium.org)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781599b8f3cso482577385a.0
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 06:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704204403; x=1704809203; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmdoAo6dmjYw4joKajxKRaTRjUBjT8AZB0O7XUxkYs0=;
        b=XN41DPw21y2kPi8GJ8zQOXVPkpDZqp10c9QL1hU083T+XoSeypYU5b2QR4DeMh6Xuj
         DnH+HN6ExHiEZ65tm+7U85kyYEBggqPDxwmXa3YD8hChQ8xmHxAtX+Al1Z7s2kniP64t
         UOYQczvadBVoebc4Qzy/byTk4o5eLawQVUDdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204403; x=1704809203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmdoAo6dmjYw4joKajxKRaTRjUBjT8AZB0O7XUxkYs0=;
        b=iMilRjqJahaTIGEi0xKtlKnZdDjV5t45Rz1DTOz9EkUz4bxQ+tdZpKuAyX9dnhZyxu
         CM3iFF64/8h5EBvM61eyTAIeOMNgCYvvsL0WFtY5jOV3nZOgzLyugEoLa9xAf7/+be5M
         xbipGT+ONY0TxDDYExHYj3V+Puif4F8PZbJrlScZyd1QCaNkILaYj/2HL/pa9+iR8z1w
         nvh7+DbUa2Mix/mniKVUkikK8FEkmg2zAOyXmF+/0gb8eUNTxI6lA/vkt1uNEl7I5DZ7
         VPPv9+ICWvfP13euVcPAPTYJRBd4h7GhigMIedkmuMJRWsZuHKN28akttFzoiikzEDiN
         rwWg==
X-Gm-Message-State: AOJu0YzLRedXRF13GlUsp3bPHQo7pEq7rCWGG4iuV66sqIvd/s569J+5
	2szRD1Hc6diR5KIF1PElxmCoqI+HjFjasHTBUVfybs5tMYnB
X-Google-Smtp-Source: AGHT+IHby67AYBwvpEgYCsSMb+cWARlW8Qe5f/SRGQkp3NvWu/Dc7xKUYLUANlnUenEPSaTnLfVzTvm9kHN2yCRVVJQ=
X-Received: by 2002:a05:6214:2308:b0:67f:4926:60cd with SMTP id
 gc8-20020a056214230800b0067f492660cdmr25302344qvb.83.1704204403112; Tue, 02
 Jan 2024 06:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org> <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat> <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com> <a2393800-ea34-48f4-9300-5a2821cec7e7@linaro.org>
In-Reply-To: <a2393800-ea34-48f4-9300-5a2821cec7e7@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jan 2024 07:06:32 -0700
Message-ID: <CAFLszTgL90qVQ7RFoYuOW-YMXPeN=gjW4D-w0-zYKi3ynyvkJQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>, sumit.garg@linaro.org, 
	u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2019

Hi Caleb,

On Tue, Jan 2, 2024 at 5:51=E2=80=AFAM Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
>
> [snip]
> >>>
> >>>>> However, I am very much in favour of having a generalized U-Boot
> >>>>> image. This might become true in some cases like U-Boot acts as a
> >>>>> second stage bootloader for a particular SoC which is a unified ima=
ge
> >>>>> where the prior stage passes the DT to it. The Qcom effort in this
> >>>>> direction can be an example here.
> >>>>
> >>>> Not relevant to the topic at hand, perhaps, but Qualcomm uses a
> >>>> closed-source blob to jump to U-Boot and is certainly not an example
> >>>> we should emulate. But yes, passing a DT to U-Boot proper can be
> >>>> useful.
>
> Just to chime in here, this limitation is true for production Qualcomm
> devices where all of the bootloader blobs are signed by the OEM (true
> for most phones). But for development platforms we can do better. I
> expect this is a topic we will keep on coming back to, so I'd like to
> just take the time to explain some of the technical details on Qualcomm
> platforms, as there is a lot more nuance than you might be aware of.
>
> The modern Qualcomm boot chain is (roughly) PBL (bootrom) -> TZ/el3 ->
> sbl1 (secondary bootloader) -> hypervisor -> XBL_Core (UEFI impl) -> ABL
> (LinuxLoader.efi app) -> Linux
>
> On production devices the best we can do is replace "Linux" with U-Boot,
> and if we're lucky then we can leverage features of ABL to simplify
> things like DTB selection (it supports picking from a bunch of
> concatenated DTBs, but we can just as easily implement some similar
> feature in U-Boot ourselves).
>
> On a development board I have been successful in replacing the
> hypervisor with a stub and replacing XBL_Core with U-Boot - giving us
> EL2 and removing the entire proprietary UEFI stack. There is no reason
> that we can't go further than this.
>
> The Qualcomm Chromebooks all run Coreboot, for sure on those it would be
> possible to use U-Boot much earlier (although there is still the
> proprietary XBL_Sec TZ blob).
>
> The Dragonboard410c (and MSM8916 SoC overall) has been pretty much
> entirely ripped open thanks to Stephan Gerhold and the msm8916-mainline
> project. On these devices it is easily possible to run U-Boot as a
> first-stage bootloader (at least to the same extent one can on the more
> open ARM platforms, or even more open if you wish). Although the
> bootloader of choice for most of these devices is a home-grown fork of lk=
.
>
> For new SoCs, with the number of Qualcomm devices out there, and
> communities like postmarketOS enabling support on so many of them... My
> hope is that we will quickly see phones being the most common Qualcomm
> devices supported by U-Boot. While it is indeed extremely unfortunate
> that we can't replace the bootloader entirely, using U-Boot as a fresh
> slate is still extremely liberating (EFI! Firmware updates! No need for
> distro hacks to update the kernel! Multi-boot! etc...). I wish we could
> focus more on how U-Boot will make supporting Linux on these devices SO
> SO much easier, and less on how broken the (usually impossible to
> modify) bootloader they shipped with is.
>
> While almost all of the boot chain I explained above is proprietary, the
> ABL source code is publicly available (although most device vendors
> don't publish their modified production version, I suppose for fear of
> embarrassment). The statement "Qualcomm uses a closed-source blob to
> jump to U-Boot" is at the very least an oversimplification.
>
> To be contrarian, here is an example of a phone vendor who do publish
> their ABL source code, here is the code that runs Linux (or U-Boot in
> our case).
>
> https://github.com/SHIFTPHONES/android_bootable_bootloader_edk2/blob/sos-=
3.x/QcomModulePkg/Library/BootLib/BootLinux.c#L1039
>
> My point is, there is a lot of nuance and complexity here, and we need
> to be careful about what exactly we're referring to.

Thank you very much for the information, it is a great read. Yes my
comment was wide of the mark and I am pleased to hear it.

BTW, I would very much like to see Linaro ensuring that new 96boards
have open source firmware before they are released. Before release
seems to be the only time that the vendor can devote time to it.

Regards,
Simon

