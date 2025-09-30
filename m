Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B819CCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 07:26:40 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.4358.1759276309043165933
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Sep 2025 16:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AlQNdujy;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-86be8a110f5so16975436d6.3
        for <u-boot-amlogic@groups.io>; Tue, 30 Sep 2025 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1759276308; x=1759881108; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cGy3Ot/y9Q0RtuR0zk3118IIuFNcfc67ZYLvFOMpY=;
        b=AlQNdujybrYTTQoTHvM1Y8uFCZhButLkAaJ7Bg1yF+h0JrXH05JaTrGky1+4IAiZw8
         V8+0O75KkGzkjBTZtPgCYg9eGWHXEDCMTOgiOL6p1Jxvf/TRMPu4+QruPK/zgIVm5pzM
         RUQmtYFHqk9hUAIBqawXSTK5rdGXiffG1BXNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276308; x=1759881108;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8cGy3Ot/y9Q0RtuR0zk3118IIuFNcfc67ZYLvFOMpY=;
        b=wlq7Q83YxqvvpLd8b7jZLzr7mqhj//IGTbZqBpgERTyekFuJxY5SDoJat93kQuKG2V
         j0wCwfIQb6mlLh0EUIvID2rHgw7fHFbr0LtHJbe7TershtAbiXz2mtOh5MCJvk8jQ+fa
         o3CqgT7MDs1IXljvBJ3cK8yIOhI/Yh7ILsy6AKdt7+xcdKLTDhINPHj+Nv1wSMmaOYnX
         PL0Oh1rl5+gEcIUtmeN7XYPeIWKgtg9OAW3IIV/zfbZO1Lx2NTsjNOIQ5DrEXFTc5Rf0
         8oDn5oYtOVLv7cN6jXkb+1Mq5Sze2eqsais/pjK38gKFBp7H5l5f9oaKFlYEuZnPLy26
         i16w==
X-Gm-Message-State: AOJu0YzhpKVNN6BDnzYNtOyVbQfZ6CqWHnIiOf0VboqZoWc4IHmmeLP2
	0SAhn7VhAV2ep37/ukIc+POz4RJcrQsyDVyKX8GmRk0ToRrVYmJ7p7oGtM+QxgPdyQzHXXSQBvc
	CrxfVnAE=
X-Gm-Gg: ASbGnct3rGkgHM4+/x86KhouOLxRz1Z6axxa6coY5vCxlVDmWWFnk8FiaXdC6lbc8UH
	NTc3YgpjCZHgzOPruyQvnVDZTdQSvnn9Uac84Vpe9jBC8mQ7F1A7Jtq05wM4gdjsGPUV/z7nvlo
	uSE72yiG8wLpkhyWDwXpqzWp7e8DTtLV84rDWnSEMYXWfpFuymPtGxmiO5we2iTo82Du1poNkB4
	zOD2L9yeS2orTVY0SdyB5CK5wIkfuoIWI0jNXKFcGxR2uceBSxX6xUW7oZyJMvLVycGimYPZMaG
	NiKyi7TZjywcbrmMw9XVTtuDx0mgZvQ2p281fhAfWeQvvdiVzwHdATBxeB1l1pKR9dFmVCmqETI
	qIG/QelDgDeyhpJr1y5m96+A3/krDlEQ4EL/gytPLdMKcU12rbAZd5GqFBONSjAuzKzW+aUseBk
	61/3Q=
X-Google-Smtp-Source: AGHT+IF7Hf+/EwLfA1uww6S4CfeauQq7e6RO88WV1GrngihI8TPEqYI2DEYDR8T1EQicdW0XoMcIzQ==
X-Received: by 2002:a05:6602:134b:b0:920:865c:a8a9 with SMTP id ca18e2360f4ac-937ae5ef022mr249761739f.14.1759275916119;
        Tue, 30 Sep 2025 16:45:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-903f6ea358bsm572665339f.2.2025.09.30.16.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:45:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
References: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20250930
Message-Id: <175927591465.2084249.6656043500733474934.b4-ty@konsulko.com>
Date: Tue, 30 Sep 2025 17:45:14 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Oct 2025 07:26:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2787

On Tue, 30 Sep 2025 20:37:07 +0200, Neil Armstrong wrote:

> Here's a small set of Amlogic changes for the next release.
> 
> Thanks,
> Neil
> 
> The following changes since commit 9710d98e8942151fc0c62d54100d9d27e8263d04:
> 
>    Merge tag 'doc-next-2025-09-27' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-09-27 09:49:01 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom



