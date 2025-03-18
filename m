Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC31C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:23:10 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.3814.1742325117802213231
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Mar 2025 12:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RLO7y5uK;
 spf=pass (domain: konsulko.com, ip: 209.85.214.175, mailfrom: trini@konsulko.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225e3002dffso67551405ad.1
        for <u-boot-amlogic@groups.io>; Tue, 18 Mar 2025 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1742325117; x=1742929917; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9AdQ/iZQiEybKKt2D+WifV6k+bYnDJmJ8WmY5ZlY6k=;
        b=RLO7y5uKApBdSrLA9ZeJYjLvhLgBd8NAykDSg+NOizMbXAp3itb+NhsgdZmThAwi24
         wyGHk9ptyqMPacQjMT1CMS/SQ0fveRbGRe+xWNvIcZJzN3e2THtBIlhxjNoR/34Fvk45
         4vMl4CUO25E3u8/TFbOZUOKTnGLIffp3p8o3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325117; x=1742929917;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9AdQ/iZQiEybKKt2D+WifV6k+bYnDJmJ8WmY5ZlY6k=;
        b=u1QEUGZovmdNOsrxO5YNEKxCTAF79/LW04dVndeKx9r8Z3v1wXVLrZtwljyCUN44yu
         Oehy7CESy90T78Vmwvs9E1Z0HHf3S7UmR6y3K3qQ4C8jRkuljDas4CzM1u0kAKmSiD/u
         sX1hW9hfZpcdP1oYBvz7I7JVikUnrdsPTr5h9dych6VH1me9ELsIcTr4HtfdqYmRtl//
         I3NZY4D8mZBvCpuGRSYhGaXvW4uKqzINOtg2YnSqmOCTzdhVrFhIM//ipbJjWMO82WOR
         KN2GYIcG2FKJKASuZCmx4IRh9N75VdbRoLaegIh0p2TRlcdHWQGLrD5zuEHyImtPRDrg
         oGdg==
X-Gm-Message-State: AOJu0YwS5HqRU75PUvheFryTi37KpqqZwuV2ajZyGvgMbOPqIRZWW9gO
	Qk8UEEl+Ky2Y0QqOsXztuilNU57k5AbFNPe9Hn8wN+1RHWq9gBfzqn1S8CicMTDFTZl9dUSUuq6
	G
X-Gm-Gg: ASbGnctjjNEAi2p/K75DdWIWPsRSvQzjNSaTK5UsZzrL7WhlHZzu7zDpAYEGyMZhHeF
	7PYm3wlZK4SA8MmJG17EBNNbbjxu38Z5XICelGCahp5pQM51kSMpJpteCdVoQJK0E01CmvaGBsq
	ECHzabxRvutQU30MhF0WkJ3ZHfZh411s6zEwgNiQI9LdKSR5qhbsNSTGIJlHCr8/xudNio7jjQA
	wXBXulrRYoL6KAiphpBhkxsmSH77iYHNaXT9LoY3Id4pYN+24tRtMdn6G99Nf3oGwyqvfNw/OdK
	TTvMil0kYXNjw/a8XAktUgPBa9rOr4Y4w0zqgIhj4mfv
X-Google-Smtp-Source: AGHT+IFN4oOlYTemewjK4U02gZSfSFDuLdJWGqrqdGs0uMMEx7wIQQMfTTM9v6Jw8bW/OHS7Mmtl4Q==
X-Received: by 2002:a17:902:da87:b0:220:cd9f:a180 with SMTP id d9443c01a7336-2262c625001mr61732925ad.53.1742325117253;
        Tue, 18 Mar 2025 12:11:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688866asm98989985ad.50.2025.03.18.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:11:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
References: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20250318 into next
Message-Id: <174232511609.1770758.3649930286570115403.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 13:11:56 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 19 Mar 2025 09:23:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2633

On Tue, 18 Mar 2025 17:06:18 +0100, Neil Armstrong wrote:

> Here's a small set of changes for Amlogic SoC support.
> 
> Thanks,
> Neil
> 
> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:
> 
>    Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom



