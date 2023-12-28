Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE82C47DB4
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.121736.1703765010595005469
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 04:03:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gW0uYVNt;
 spf=pass (domain: linaro.org, ip: 209.85.167.52, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e80d14404so1977802e87.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703765008; x=1704369808; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hedqUp2ogf8l6RLIdXQ6yk8zmoNyrw8t2xabdfAVsM4=;
        b=gW0uYVNtI4v1XVdYk/z19CPa1xjBN1ZUhRXJPm6RCO2uNgksQkVVrWtEVIF6nrb/Sc
         Rh4cBiCDm832ukkKsLwZVfl72vT7EwRBSkDKFszv6cgfM2FmEbpBJaI7tX+Ylx3NcXVd
         KbOu7+80uWxbnUSk1EbzPSqY1C76KbFionmbLXv8pLaZ4KOqjgQluvwdfnarbObC59t3
         uAVEVQyrpBJPgo4c21OxxUf0Po4E0KYKTGQ4txTIPQxcuQdSZ6Zd+LhgvD0GxiZcsKBB
         u5BLtTwrv7hQiBaRz4ynLh3zo7xIL87cQoeQfn9OURnTp3d55AERH6EgaymXexxr23Ud
         OI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703765008; x=1704369808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hedqUp2ogf8l6RLIdXQ6yk8zmoNyrw8t2xabdfAVsM4=;
        b=lZqdexR4cZ//HTH87IGgVk5FaZS2fPTrRdvJkUoKcmvuxgeZhl64AWSrtfQvtOl06K
         KuKsdpk4BJ7DNdQiCQupNGT8Ey0pTkqOkvJ53UY0pjvEB1HO+cARCIsqwxrlvLQJiSxM
         1/aiJNPY8VamC1WsbimsUNnLHUANyL66SlfXnFPC3/y/HG2x8fPkCNWeYwSHfcC/lQY5
         x9r8plaopkHNMb+eVSE8PPslpxoep8AlcJ425tyVbp25H5IeY6PjZzGEk1/prIMKF5e8
         mkLdJ5RouwxTmWNkyB/qddy/ppDdLiUEXUJyPxicZ2992cGD0UH13EOvgbCLBZjxxEsV
         KHZw==
X-Gm-Message-State: AOJu0Yy4RFzXF7eobmQrqucC7gUMnM1nIiE5Ro0AwDRZIKURfihCQHES
	K7CJ9ilW5GhmYTpEz4ixDbujV59qmqfUxIrj0ypunr0KVzS8ZA==
X-Google-Smtp-Source: AGHT+IErF2d+J8Xs176+dkns5eNkMPe2m7zXasK5RNInmjMdOs9GmKvcdwZtN1xfGagA7bEte/D0n7MhOze0qomUAR4=
X-Received: by 2002:ac2:4c8f:0:b0:50e:70b9:8600 with SMTP id
 d15-20020ac24c8f000000b0050e70b98600mr4197585lfl.0.1703765008599; Thu, 28 Dec
 2023 04:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-2-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-2-sumit.garg@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 14:02:52 +0200
Message-ID: <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG checks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1989

On Thu, 28 Dec 2023 at 13:58, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Since devicetree-rebasing is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Picked up review tag
>
> Changes in v2:
> --------------
> - Excluded gitab CI config check and added commit description.
>
>  .azure-pipelines.yml | 3 ++-
>  .gitlab-ci.yml       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d6f3fa423c6..f100c4493e6 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -65,7 +65,8 @@ stages:
>        # have no matches.
>        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> +                  exit 1 || exit 0
>
>    - job: docs
>      displayName: 'Build documentation'
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index fee165198ae..96ca9f72bbc 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
>      # have no matches.
>      - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
>          :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +        :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> +        exit 1 || exit 0
>
>  # build documentation
>  docs:
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

