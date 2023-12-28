Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D0AC47DAF
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.122626.1703770660823424674
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=GeD6wWwP;
 spf=pass (domain: chromium.org, ip: 209.85.167.181, mailfrom: sjg@chromium.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbc648bed4so1096232b6e.3
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770660; x=1704375460; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQPieDva8iHY9uEqpW2B+Z/FOTOBqm9XKG4CWlnJXyk=;
        b=GeD6wWwPST9vv+U+a4LrnZyRKYLecpCZKC9wAaPLIGa95aCienBdZaCJDqXmhyhChH
         IB/XLCSwjtB7gR5+L62kGGGLHLyb0pJmzYWGejvbrwDIlDo3/2qxkyIQNT6OxIq2oGEl
         incJDZP2QO7jwvctnp5S5mAohC1EaR1kMNQI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770660; x=1704375460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQPieDva8iHY9uEqpW2B+Z/FOTOBqm9XKG4CWlnJXyk=;
        b=hL4FY0RjgnuqLf0vk+AhbI744QGZ9KbgCFQUFNE26aZ3xhW/XnxhuaitXsLj7Rzh4L
         bsKnYryMBMUjnrjuyiar1k3gU+cfN7gr+qXlVXAwW9wJl2OGNNbjjJDr1FW7J7Vc+ZDR
         RH+YgubvEoJvvo1JnYpeuUgqsqTabtcdgrj8epWJrKmjs0S2GkF9/RDscuKW2MBRNmu9
         uOia9P9bvOiIo49qVnxwVVOlQl7/1P72Hf6lrP2y003bWw+fzbL+MbRhmnwv4y2cY1FJ
         A9Bku57b9SQeZ3gwfhMUXwcbm5SNgiZwyCIbmzU2lE4qMYpXkpvtmcoyd8IopzabdCw4
         QhMA==
X-Gm-Message-State: AOJu0YyrewApJ3Mct9rEz/yjG5Wl0Wcui4hG9wy4iPUE6jBCjLdgveMF
	Oz0rvPRSveIFgU0Id1bWMfHRjZrL/9H+bKKQ/Ybc5kgll0Ny
X-Google-Smtp-Source: AGHT+IFEDtbt//4uEDrgAl7NnvTRSyG649sV3g+y82UoCAPwgoh6jnW6gWJinzbCm2OE+bUrwEMFgBER7k/gt7YILXY=
X-Received: by 2002:a05:6358:71cd:b0:172:e3d3:4906 with SMTP id
 u13-20020a05635871cd00b00172e3d34906mr8762159rwu.34.1703770660074; Thu, 28
 Dec 2023 05:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-2-sumit.garg@linaro.org> <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
In-Reply-To: <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:08 +0000
Message-ID: <CAFLszTgLDtunJxmwVTQ9NJXH48=dHeiyXghKmGbDDzw3fbZhTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG checks
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1993

On Thu, Dec 28, 2023 at 12:03=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 28 Dec 2023 at 13:58, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Since devicetree-rebasing is an external repo with its own coding style=
,
> > exclude it from Azure and gitlab CI CONFIG checks.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v3:
> > --------------
> > - Picked up review tag
> >
> > Changes in v2:
> > --------------
> > - Excluded gitab CI config check and added commit description.
> >
> >  .azure-pipelines.yml | 3 ++-
> >  .gitlab-ci.yml       | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

