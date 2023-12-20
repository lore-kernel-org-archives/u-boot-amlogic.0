Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA06C3DA6E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.15135.1703047646176629850
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 20:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=klpA/YyA;
 spf=pass (domain: google.com, ip: 209.85.167.54, mailfrom: sjg@google.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e270639d9so5164613e87.3
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 20:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047644; x=1703652444; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rP08qD9+EA9kq7SDwDSp8r7VtD4RdP6qR3cbsU0sEYo=;
        b=klpA/YyAudGyCim8PgxmyU5hiKRFkD9v7naxTVln0U6vaDi+T8pzr2lwitvPKSIG9z
         /eq9O4QOZvW6cEKwBmaZ2tBI8vCpJBf0QVWCfRqTUajibufGHzvuqKr+zhQZLdhFZTWJ
         fzoO9D/EApBUGfmZbQOfP78uXugi1A4ExIEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047644; x=1703652444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP08qD9+EA9kq7SDwDSp8r7VtD4RdP6qR3cbsU0sEYo=;
        b=b+C+8+suaeXSi/jXd7uDeZ8bDlmeqgBx4Sqy19YfJD0otYYOX6xQzjCoXhihiV0wpP
         B7Vp0D9J3k+c2pTsUdYJgJilo7BVeXqUz1weSS1WZtnqNQvvao5UGE9KvQ6aBNPSaJx7
         noDGqFUk/4/AVtEOFoWxO/7NRYyBiw+X5AixFszC6klrPUccQmS2jrJCuwTldkFuFXBb
         dVy7jTEyLbq6BskqdPn1UXh7rEtKkT0EKUu7Payq3NuXIQWiYvWN+WFyHchbtU+5Q6Su
         EKLAzEc0dyTXIFbCR4s0zOcF1diZLugHwG2CXG9qHWSJlCuujjbNsfbsPP9LvEkhqF+k
         ynCA==
X-Gm-Message-State: AOJu0YxKMJY0/i/wzRwIdPecr9PmBskOGhTAGQAyGB8mnMM/4i6DBcd/
	U82mXE/jvBiwjOdhbtX0DToVdjgWaGhyY6WEP5CJTA==
X-Google-Smtp-Source: AGHT+IEf8EfUuibeWP7DuC5QCvwOcnzTSN6HCyWpZ1jGW1Q4E0LmD26wmfd8i0Ya/eoD4fBlqjTdU67ikpqBm+dIIRg=
X-Received: by 2002:a05:6512:220f:b0:50e:44a4:f7e3 with SMTP id
 h15-20020a056512220f00b0050e44a4f7e3mr1389613lfu.81.1703047643897; Tue, 19
 Dec 2023 20:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org> <20231214142713.GZ2513409@bill-the-cat>
 <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
In-Reply-To: <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:11 -0700
Message-ID: <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
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
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1948

Hi Sumit,

On Thu, 14 Dec 2023 at 07:46, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  .azure-pipelines.yml | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index d6f3fa423c6..f100c4493e6 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -65,7 +65,8 @@ stages:
> > >        # have no matches.
> > >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> > >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > > +                  exit 1 || exit 0
> > >
> > >    - job: docs
> > >      displayName: 'Build documentation'
> >
> > The GitLab tests needs an equivalent change.
> >
>
> Sure I will do that in the next spin of this patch-set, thanks for catching it.

Also, please add a commit message with that :-)

Regards,
Simon

