Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F86C47DD8
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web11.12714.1704265056856512814
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 22:57:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=W0UQ3BoD;
 spf=pass (domain: linaro.org, ip: 209.85.217.49, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4670b3554ccso1178294137.1
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 22:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704265056; x=1704869856; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgJFm4Um3PEf73Z4AZDUS14+UdEI1LHfnLwZFGcRY84=;
        b=W0UQ3BoDWUTjnA2dwOQCO9MDEFFNJGpFRAcBQppNCuNxY2sONom3JiPFdTrWWRWrKO
         W4Qr9cOTKB8A7U8v8SdcASIdzrqHqD9CEQC3lmHcAaHPIx+YOlAB8vfSX67Flxl/Y5rT
         hu8jCXwRepj0pJsBzk2sW/XbWVhjYBPvIDCCEJhJYEt3dv4kDOB8xw4RNm078uc/JMtH
         rlgsM5KaEerhm83Y/lSDDGU8tBSb4RMV3RTLAx9D8UXUGtaG6KQwA24gyJl787k/hK6I
         7K2+hp3k6uSAnPttepxeevD2qhkz+/tl/M9KeNjJBwgrszY6g96wG8qfRxh0HtOCxv/6
         8Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704265056; x=1704869856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgJFm4Um3PEf73Z4AZDUS14+UdEI1LHfnLwZFGcRY84=;
        b=DD7qKOs4VkDUiuyRkJF/sf3VVbeKp3JcSVGi+otb9DvBkvg0xe7gjcnnTE1F0M0goc
         xsl5C64pRnRIHs3zgBjIB2Ztcy5ZvtFKGTcTrYfNxYGScQpmxnC3bbHVKAzo7+brve0k
         RSZruAx/i8DjNM8tbaiCJTZtEb4i7pDfqaZub355E99aagKwFDkgiCt4BXzJ8uiwcZJO
         fEi4KVSQLRdhzpZkRmddqeVPK98+ROuUQyVl40mALfWb1Of6P8VJ5tbY4c65aoZIeE1g
         Pn4Vw0abgrqO2Q457z4o6xplJKgE+yPqBQKi1REffU2IPOb1Z3jkAcJYCAPZgl4kx9MQ
         OW+w==
X-Gm-Message-State: AOJu0Yzebtgc8iXPs9pdPsYHatRYbVR5sfZzi69AnsSDQ/nhacASuuUx
	DJaXuvIi+ACmwV1kFP9m6SBJ44jg2fKhTKykL+VUbcvLpCZbMg==
X-Google-Smtp-Source: AGHT+IFAXcyRZL8XSxIcbu4nGOcqPdCs7pG3KUN99aX65ATCtCGdMio9//f0JP3e8lV+wTLouXdzLLqfMYD6AD0+g74=
X-Received: by 2002:a05:6102:55a3:b0:464:89f2:801e with SMTP id
 dc35-20020a05610255a300b0046489f2801emr10508375vsb.29.1704265055877; Tue, 02
 Jan 2024 22:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20231228155428.GI2652760@bill-the-cat> <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat> <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat> <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com> <20240102180643.GA1610741@bill-the-cat>
In-Reply-To: <20240102180643.GA1610741@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 3 Jan 2024 12:27:24 +0530
Message-ID: <CAFA6WYPfey+Si29eGAyaUaiacCBwGBR+f3+o8hjFRSU_j504Wg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2026

Hi Tom,

On Tue, 2 Jan 2024 at 23:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 02, 2024 at 09:07:48PM +0530, Sumit Garg wrote:
> > On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
> [snip]
> > > 2. Choose a directory target for devicetree-rebasing. I see that
> > > 'barebox' uses 'dts' which seems better to me than
> > > 'devicetree-rebasing/src/'.
> >
> > Actually as part of this patch-set we try to reuse the U-Boot 'dts'
> > directory (via dts/arch/arm64/<vendor> soft links) since it was
> > already taken for U-Boot specific DT Makefile. However, I am open to
> > renaming 'devicetree-rebasing' but to me that sounds more clear that
> > we maintain a specific subtree within U-Boot.
>
> Looking at what little is in dts/ here today could we just use subtree
> and pop the contents under there, and basically ignore the
> project-provided Makefile? Or is that not really worth it?
>

If we really want to avoid soft links then I did try to add the subree
with the prefix as dts/upstream here [1]. It works well with the
downside that we will pollute the subtree source code with U-Boot
specific Makefiles [2]. However, the subtree pull works fine still. If
this sounds better to you and Simon then let me know I will use this
approach for v4.

[1] https://github.com/b49020/u-boot/commits/use_dts_dir/
[2] https://github.com/b49020/u-boot/commit/90eabe614e77bc30a437e7d5559c1ac414ac07b3

-Sumit

> --
> Tom

