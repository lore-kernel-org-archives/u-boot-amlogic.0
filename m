Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2868CC6B27
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:26 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8859.1791902617975163972
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Oct 2026 07:43:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BGNHySPL;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53506b44151so41096641cf.0
        for <u-boot-amlogic@groups.io>; Tue, 13 Oct 2026 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1791902617; x=1792507417; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
        b=BGNHySPL4p07SJy03gNCzZVDf4ow+D1nuBJtlvHiRLsk5b/7qvU7Ttd+N2RuZnR0R7
         gsQLK28jnrl7HRoFDYW84yi6awLLPOXyieg36mYVqfVAigS7T6WvJD92YzHgQqNKyOTE
         kNICwI/blWe7EvLYO4eyiM9V6HIPLEiKU6cA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902617; x=1792507417;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
        b=u+3+UbMqDiWvnH8td8Too/px5fzFfjOqZ3acXIbGFTTqc+/DR/DW4hwrEmbG3pxu+B
         XhvChCpH5QdM6GfLpQpFec8TPD8Cn6ZJ/lNGrD+eWeP5+gu/cefcPTT3d8ZfnsFeFoeu
         ffK8YtazqjPc/gCxXkds1t4+FDb6lrar7EnlqrzVmbBfwDMzOXjHlTbsUJ4An3Wvqg75
         UPADL86+yz5a8EmqEPblrlQvhCriBw2klK+hW3fOZwvEiZFveq8VSbUlLAKTam8Q1tQe
         GpaIimV0hYWkzc8Se4qRPLt19t74q1Z6osYAuZ2iORmtv+hLX6iKZ3xUXzf2GuHcahaH
         sciw==
X-Gm-Message-State: AFq9FYIIew0Lfefpr2G5uLGpyLFrrEdMhz/BEL8JVliUGgBnGuaFc69m
	LqaekSwcM777dGeqqfdd3PFz4JPWATr3s+w92+BrKiT6qzbwCdEWaQVEqQO8iyxxtyCrrwIkqy1
	yWtslS38RDO95
X-Gm-Gg: AYBFou2VLv321Z9RyymvZZWIYtzkLcIdZ+84qpbht8JgI6Uq1MJX72cedyJSqQa5s54
	VPhezzrbZBkQVhGzaiyKuVPkSjMwOEViaGmFFJhDJSVbOTmgPD4MoVANvJ5420HHCw1ZUjJ9Foh
	xBYtolAjFyktLS4YeJkxeg3mZXaNOyheH86ESUoIlmXlDHWuAOyFh1+kLyb9hbA3y5IfWjyEMbi
	aYO268qv6/d4kQXrLrwdHZnCeXFndjrmOWXqBG/E1W+yEE5LQoqZ57DcR50Mf7Gvt2bFi3rQWuA
	ljpmmJTfMZI142SUqNROe+TVABV2J/QL2Bj+oZdezSbdR7YHG5ASz5DwxBW5XN6A7ov2CMCnl6h
	4VCDlKy9LkldiJ6S1iEkT/W9joUyFPDFAUreQCY5d+Lo1RvxU8LASyIjJHA96FffuuF5fMlvdOR
	UGlTpczEJsenFM3cR5Usft2+G2zqpGcvbIrkJGb6DE23S+EZKgI/DF60GfJWz0iZbk9s6Mgw2KV
	PPJBYYo4BkgO3eUEugpoPpgdvP5aX7U1SfbtYka9NfoJNqJRAW/KO+QtVAK/ZClQuP/Mb3NCSly
	ckN+yNXhfFbB1OcKPg==
X-Received: by 2002:a05:6830:4c16:b0:7f4:eaa0:1d14 with SMTP id 46e09a7af769-8309610ba27mr12321733a34.9.1791902262740;
        Tue, 13 Oct 2026 07:37:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e016sm12363996a34.17.2026.10.13.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:37:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
References: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20261012
Message-Id: <179190226198.4042530.4565446612423486493.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 08:37:41 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Oct 2026 09:20:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3130

On Mon, 12 Oct 2026 17:44:21 +0200, Neil Armstrong wrote:

> Here's a set of Amlogic changes which enabled basic Amlogic S4 support for Khadas VIM1S,
> plus cleanup & update for Android support.
> 
> Thanks,
> Neil
> 
> The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom



