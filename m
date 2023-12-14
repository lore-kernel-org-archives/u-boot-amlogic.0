Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42407C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:54:09 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web11.24060.1702565199214244442
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 06:46:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BVtzhQ5N;
 spf=pass (domain: linaro.org, ip: 209.85.222.53, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7caff8105dcso1420635241.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702565198; x=1703169998; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JeIl+XkY0bGHqZqk+14oYTG+6WPOBC/t5scVWQtixzM=;
        b=BVtzhQ5NneP+SoOj9/QSlAu1p2FJnWQCwDB6NrwuQmsfX7//RkyGYkugBaEzBhyWml
         cUnaSKgCZ9cKYveAuThBwTl6AKD5XszYsqiobLrVc5I3DqWuv2CoQOPEkBjhuiUG2J9k
         w1Zjfi7I0L7zPcOHFarEBO8iZI6bi0otmR09hVzbPsG7sqIbAFgUQ4tLomdOvYzkEaN4
         gK0b1U1LhnIVx228VwcQFAKlsK5rqS32JIpGNFRZ0k+zhVecXCMzhMAfEshT7qicNynE
         RIPDdayQLEDL1GCRQJH2VJdvSQcBirH8kOg3aRM1KU96+b6u5vnSoWzjJrOth5nOcWnj
         CbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565198; x=1703169998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeIl+XkY0bGHqZqk+14oYTG+6WPOBC/t5scVWQtixzM=;
        b=Pdj1tp1bpNDug0fAP2IT+tfZ9QwfE1yL0F9DUXOn1eoGkXCyLuT/APYlPOiDzzEvXT
         Wq0/Wnncyl0EqvFfcAQ62UZ64TXANt3YIorrNTsAUeUPwLDPYsyu+DjbHqOQoTzBhxrD
         /xXSfCCiD1bVuRrtCJrw9wWPr91FCbSZNqOc8WthRTurMFfxZtfIV2CJyVLp+IqfqR+T
         h/iJg/B/vH4B9vwpXEjdFbJ/aJc5lgquqvkYVzM9766gKOCQRIuaZyAhOpLD4HFaR5Ji
         qrKxhVDSxkM2c2TgxIfVA3H8qQ+eN/g5a0MD7HSHivqzjVq0Ud3HjX/dPBHa2foeNJUp
         +ilQ==
X-Gm-Message-State: AOJu0YyFAP9UDraCYeVC6EZ7rMYwrFnEMZd04FmA/rxR23HYW+i6DzG3
	KfmkfTbD/yZdfTwCMvE1jwzSbLpA0aTqngfbX6hOSQ==
X-Google-Smtp-Source: AGHT+IEpzEwZyYXVyGldN3Fh82UVtz5TH/o9Oqo9fIuf65mXdAK3NuzEZZbDoIy4IokrUV1Qu/o90YftZebrV02Vz+A=
X-Received: by 2002:a05:6102:3a0d:b0:464:4f99:67cd with SMTP id
 b13-20020a0561023a0d00b004644f9967cdmr8261477vsu.25.1702565198207; Thu, 14
 Dec 2023 06:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org> <20231214142713.GZ2513409@bill-the-cat>
In-Reply-To: <20231214142713.GZ2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Dec 2023 20:16:27 +0530
Message-ID: <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
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
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:54:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1927

On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  .azure-pipelines.yml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index d6f3fa423c6..f100c4493e6 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -65,7 +65,8 @@ stages:
> >        # have no matches.
> >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > +                  exit 1 || exit 0
> >
> >    - job: docs
> >      displayName: 'Build documentation'
>
> The GitLab tests needs an equivalent change.
>

Sure I will do that in the next spin of this patch-set, thanks for catching it.

-Sumit

> --
> Tom

