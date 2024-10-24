Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01820D0BB6B
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 07:47:06 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.9227.1729756023042667965
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Oct 2024 00:47:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=rNyXZ6UI;
 spf=pass (domain: baylibre.com, ip: 209.85.128.43, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315eac969aso3756385e9.1
        for <u-boot-amlogic@groups.io>; Thu, 24 Oct 2024 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729756021; x=1730360821; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXN1BqHS434dJDr7yRXybt/0IbX9GOU84fRRJ6iYtpU=;
        b=rNyXZ6UIDzCuJubAAiQUy/eKJVWCzlsAuC/rCw8sb24QSN6gPyGgdIFL8iaZkSdYbk
         +QKH5AYdDDTn5hYDBD6I9m1dTL1cTh8H8x7f88ZzADHGLJLDxhcFAJfiGoyzTDAzhhJM
         WUZpKz+UsFwJEY0VbcGljZFWwEntZfNAIQoFi4XVD57FOJqB8MRBBlH8EIgUGtldzdrG
         pF7w/O2Rvfu8pR55NiWzWncJtrm6dQb9DCAlrMFgH5BG+qxqGtl4qQjZpc7thJ2v1URb
         2LXr6QiZK39sjyKN2Din8/DROkjPeDeoO18R5rV40w5lPIghu9WeQEgJNEDCimWuAtIP
         X3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756021; x=1730360821;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXN1BqHS434dJDr7yRXybt/0IbX9GOU84fRRJ6iYtpU=;
        b=j6lFvy9G9AOVdwQqBERBiF/egOogjrob0RmoYLkOfLf/6V05X101+M/L+ob8ERp7k0
         3y3Rli9pMczLNOW4FfUz21UxSh5a3O1NR0OMi+wp7plTIseba66jXXoQbil2k1FMAYKg
         Myr7BPI/Cv1B77SHWqRISJwHoujCPB7cTT8LNo80XNPjVEK91xik8ZVxRNsPE4B3rxLT
         Kd9TLsJ2cX+0pnFOElcleOZv3MNcNxyhQ6RYnbkS39bC7LtMvU8HsgxPXT9JcCyVi165
         aal19N5uhBOmXcMiTamUXIfG4u6Y7ihnEwRBJSnDNBmvFpJq+RAlbeNmFt46TaPjMjl6
         RJiA==
X-Forwarded-Encrypted: i=1; AJvYcCVxdBmrPjxlk8lYpuNwbAfR1DkZdxxJkQjY5u95ihXDqsuKPX+fv/qkNRlP69FqiWBagkiZd+lgWQoXfWoflg==@groups.io
X-Gm-Message-State: AOJu0YzTFLJ2uIHFXXVc5L3pvMk6m8C/zyXETah30qsEbwAnZO7qb/tw
	/pflwp+IsoznEKLkhQ3KtHQwiDAc+WcycDGisetQk2TiVxh4fGiNiAD4iQ4GCHo=
X-Google-Smtp-Source: AGHT+IEIzLhJ77vCp0/QuTV552cPpCGmlRHcdaDFMvdHcqbY8nfwWp3B3gAbH96x7UqoCDjeLjGFHg==
X-Received: by 2002:a05:600c:13d3:b0:431:5475:3cd1 with SMTP id 5b1f17b1804b1-4318bc96684mr6172155e9.17.1729756021212;
        Thu, 24 Oct 2024 00:47:01 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm9454765e9.19.2024.10.24.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:47:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
 kernel@salutedevices.com, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
Subject: Re: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and
 provide several bcb fixes
Message-Id: <172975602033.461875.1463841357229333439.b4-ty@baylibre.com>
Date: Thu, 24 Oct 2024 09:47:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 24 Oct 2024 07:47:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2530

Hi,

On Thu, 17 Oct 2024 17:12:05 +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - redesign 'bcb' command to U_BOOT_LONGHELP approach
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/6] include/android_ab: move ab_select_slot() documentation to @ notation
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/01874ac7c06b8c657e7c3fda5ac555f821ef5b36
[2/6] cmd: bcb: rework the command to U_BOOT_LONGHELP approach
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a8ca7d46ea744381185c0bf70cbdf4db7dc734b7
[3/6] treewide: bcb: move ab_select command to bcb subcommands
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b523b4d2c32f07ca0793bb0f926b02ecb0556cc6
[4/6] cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b1bc9a2fc93da8ed25dfc4078e76220ac26eb6b0
[5/6] cmd: bcb: introduce 'ab_dump' command to print BCB block content
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a995084beb6682748002878ccb4b8c4de9fc0136
[6/6] common: android_ab: fix slot suffix for abc block
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/55c876c6f9b787488c7a9f9c678398c48d13db6f

--
Mattijs

