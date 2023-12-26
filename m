Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D04C47E49
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web10.79944.1703585381188461924
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 02:09:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=XxkFwhiP;
 spf=pass (domain: linaro.org, ip: 209.85.217.54, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4670adbd76aso107372137.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703585380; x=1704190180; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM1adoCyOq4ljhY5ce4+5eZzlBSxkIQeb/I/Pvs9lF0=;
        b=XxkFwhiP6OLRdJfKagPEl0AcGWONk7xA1eU1AY/KbtbtvkdJ5kmW2sjubbcXtzA3si
         odWRMqJppNqqNYRLWmOugNpCc7KH7bYmp8lrxsCCnRmCm5YwMBeJZxZwjzwPxiP9xbPz
         n7x7jTjbguQchfiFPI+DVdcIWtxh0eMcdnJ7Aq0dcbAIQEnXrUMmq4wnxLxLM7VwJMuO
         /VMvJECU2s28rh55EXHkjOoI/ePzuMUl3804I8LfdjbGBY4sMbgQHD6a8ULs9brkdUyh
         p4WLnckefIayc+bqGaqu3pkOLbCXAifL/6Eq946hz8aXB8hM2HCuVKgFafGT95/CbDxt
         QSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585380; x=1704190180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pM1adoCyOq4ljhY5ce4+5eZzlBSxkIQeb/I/Pvs9lF0=;
        b=fiXZmO+7JK9eY0U/ggD1B6uwVYx3vl3q4/FQCb8ni81kuVGDlzXrujRyrg5cuhT8YT
         xnxpvKpN7CthY/XBKoFAEBifMIitsYg9I54KIvDRqc7AVvVyBIm0D0CGEuoXR9Le9VZ+
         rmb9qQUFLrz5D9z5JUVlsRxPWuAMqwZaITXTYRkfxhWIGI1Z7gA9GfMyFPB7VUgebb5Q
         uoBb4m0rgsdZoXkwCyOg6G2PrAk2S1j25tUHRrrc7LYs/CB9RPzb5F/6+UGvVSYo3O/V
         05st16eg0L0Ej7n+N7MwGnV1AFv8kQ5pLXQO3RRoEC1FHLG2q+yVIOd07wZ8HVhWsk+s
         jS6Q==
X-Gm-Message-State: AOJu0Yx3BlExZTZtawfFBidKdgIyKAp8k9LehHKtiM5JRdtYq2qeKB4p
	0Anf1fWCnDl6B8WJH8sx/FvuI4RTKIaRAbmMggU4mpypC7zrLQ==
X-Google-Smtp-Source: AGHT+IE/UYcm/QEO3M+rUR7DbFRQP2Qoi23eeNOF23tiXaXRyBHalE9fOGAL8BmPaY8VAqlnwM0c++lDyC92ev4yvKw=
X-Received: by 2002:a05:6102:209b:b0:467:5c0:132c with SMTP id
 h27-20020a056102209b00b0046705c0132cmr410326vsr.5.1703585380236; Tue, 26 Dec
 2023 02:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org> <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
In-Reply-To: <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:39:29 +0530
Message-ID: <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1972

On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Allow u-boot to build DTB from a different directory tree such that
> > *-u-boot.dtsi files can be included from a common location. Currently
> > that location is arch/$(ARCH)/dts/, so statically define that common
> > location.
> >
> > This is needed for platform owners to start building DTB files from
> > devicetree-rebasing directory but still being able to include
> > *-u-boot.dtsi files.
> >
>
> This is a v2 patch but I don't see a change log?

I usually prefer to keep change logs in the cover letter [1].

[1] https://lore.kernel.org/all/20231222061208.3009970-1-sumit.garg@linaro.=
org/

>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>

Thanks.
-Sumit

> Regards,
> Simon

