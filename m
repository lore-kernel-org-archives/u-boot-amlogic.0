Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC2AC47DA9
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.77734.1703583417536783882
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 01:36:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gkZIFBAe;
 spf=pass (domain: linaro.org, ip: 209.85.222.175, mailfrom: sumit.garg@linaro.org)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f70206016so388850585a.0
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703583416; x=1704188216; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ocy0jk44TeJKODgJIZSPWBXIqR4Y28AwTSEyhInmIg=;
        b=gkZIFBAe9/BGCmQf1OvZhxixQGnSFM92Bq/NCr7dfE5Rhb85hEFCqUrJcuTU6YBBdt
         ukPyXTUyGOi1ndEwBzzF+sf0DBun4UYCK907kPYLNaEMVko6UNG4XsQVNsmSlfPcOLsB
         Ai7BG4kwTLyuDI3hebsHijDagIfTdKz7zKL67aEuM55u8Ul72LJjy9Jxm9Evpnha1v6u
         hrRalgqVp0KBd+tL0ghDEMdCrWsstgYchBDCVjKMnvhDj77FLEUv6PlXWDRJNKWBbRHF
         gURoRdMBvYeViCvbx8hzJsJU6q/2o/oaShhZMMi/Cm0Cu8J47qzGmgP6H12ztLbLhIDN
         CoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703583416; x=1704188216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ocy0jk44TeJKODgJIZSPWBXIqR4Y28AwTSEyhInmIg=;
        b=dvjMMhT894W1nF8Fz62PzhvDtAPSG1/ct5aBbdgIOvzTLZQlYMG110DcG955pNVv4+
         Hs11eLpKivj6cMoPkhwm6PT4+cEf6mIZ2Ar0NiLeR6YNLN6gGWGZpDLf0Sx5WGriL7FZ
         U2J7tOoMSN4kKuV7Ltz9XlKpli5zGFCnFcPln9wBLE51X58ap9U6PIHsLVurn3b5gLs2
         fK0MkbfEbG0tlFy6LwodRg7e79Yoi0tFOVTsJxdhDl6udFZLazYIz+nReatW1gYAEEM/
         12sq7KZqi0rxi70sJeXZ9sj3DeMhEo4Z5xC/SWxwzykGjdavjp4UCxktlwwlc8WarD0a
         NF1A==
X-Gm-Message-State: AOJu0Yy8DsL+rBd1FUCS/2nijIHfL9W+BUmfwm2vUyk6LmNsfW8fAg72
	vfXHeHb3KYLzRYzfRHu+KZW9jtF2N8VR1/xGG+6NSE5tTcYCbw==
X-Google-Smtp-Source: AGHT+IHSECvLu4RlyEjGkHO499Q28pOP6MvBb0iN/g8sTJNphMLJ1qXsCvSyb05H9viZBW6D32Xm86ZaHVnwwElNkcU=
X-Received: by 2002:a05:620a:15aa:b0:781:11e1:5705 with SMTP id
 f10-20020a05620a15aa00b0078111e15705mr8832112qkk.136.1703583416502; Tue, 26
 Dec 2023 01:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org> <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org> <20231222-whole-canola-81240881c2e7@spud>
 <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org> <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
 <23752cd4-d443-4a35-ab9d-bc637e1dbb56@linaro.org>
In-Reply-To: <23752cd4-d443-4a35-ab9d-bc637e1dbb56@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:06:44 +0530
Message-ID: <CAFA6WYMstaPyar-ZzSZUMorhHALyhNhEunYOOoY8AG9feSVCLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within U-Boot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, trini@konsulko.com, 
	sjg@chromium.org, krzysztof.kozlowski+dt@linaro.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1967

On Tue, 26 Dec 2023 at 14:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/12/2023 08:53, Sumit Garg wrote:
> >>
> >> The problem I want to solve is the kernel maintainers to be aware.
> >>
> >
> > Although Tom has already expressed in the other thread that U-Boot has
> > been a long time user of upstream DT but if we want to make it more
> > formal from an enforcement point of view then I liked Conor's idea. If
>
> What did I write in my first email?
>
> "Maybe create a subsystem profile and include it to
> maintainer entries of such affected platforms?"

Apologies, it was a miss on my part. I really thought it was about
U-Boot maintainer awareness. I will propose this once this series
lands in U-Boot.

-Sumit

