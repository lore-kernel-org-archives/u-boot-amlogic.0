Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEADC88E77
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 09:56:25 +0000 (UTC)
Received: from mail-qk2-f34.google.com (mail-qk2-f34.google.com [74.125.230.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.138.1789504842984937774
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Sep 2026 13:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eMeDuiGT;
 spf=pass (domain: konsulko.com, ip: 74.125.230.226, mailfrom: trini@konsulko.com)
Received: by mail-qk2-f34.google.com with SMTP id af79cd13be357-939109f067eso18674585a.0
        for <u-boot-amlogic@groups.io>; Tue, 15 Sep 2026 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789504842; x=1790109642; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
        b=eMeDuiGTCVTldtmAFtYztascbqFC6Z5YT/+aXdK+5lnJmxkic1Wk6I98c0CGZb6ZXo
         SOYknhxZpRkJmofDLM8bbhcL0tXqOeh1UTslGae2l6RmR8PdUjTu4RKb82Yt7DEzTaUk
         YnkreGNvRDj0axH/7HG27dKi6y3S1JoR12pMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504842; x=1790109642;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
        b=jqy/ktnA1hcu8HBjgbrOcgL8CWCLBhKeknXqetdFFMdpvDRnUkFxLXPXjIeyN82hc/
         VZuj54nF+YWbXFcbEDpX/laGRul/hu+GqHz29kiA+fkRwp2KmeqZWobOFUtZ0MJ3Y/sO
         hgdPRtJrVSik7d7mG2kzeXonSeZc4yZkt89pnccRRSaNT+11SI8dIrN/5tCgg0oFkJf8
         AzCpxvt34sRtFNOusmEZV8ctvLVIXtJ5/lfv86HTFcBApfPTenISRDWQFETJpK9cKVvC
         F28w7SMXo525vnVHwuJXvq5eJ3dbrIbbzJjWrUII8rUzdjBGMba9UMgyc4mBighdyAle
         NKMg==
X-Gm-Message-State: AFuF++nL7fdZFcAk5elRwfcwFEFumwImzpd2jbQ8Cjs4DeVKmZlXsEMF
	MDZyEIIVK/JL/pPiruEG1BISYeLS0dMIoY5tnRm6UczsKIDWl8PJ66Rt1MY96TvemIJq64fe91a
	2J41a0xItqJ0x
X-Gm-Gg: AYBFou0om+BPPxPxxU7hV7ilYQQ+XPztQv7ba0UDhenYnyhjrC1doh05boHFi+Ih/Sh
	ehM4kMiiTrrRH6Mj4r3Xma9Mqd1RnQaAtVq2E0muz64WrLdvoKg2I/lGmGYsASMT3tun2RTS1LU
	QC6Pms1xAOqPfrL/NnDol5ptfnSdRcD+P99jpq0uiGZGCwhJ21+RdyMTOSX+pv4rJ7O7gcjOQOs
	/UKfeDWHWEZt2WX7S/flAfEF/AuKZm+aAHwAZlUUW5VpdHtLqIe0KlGdoMHAj2e37mU0I5H9MkU
	a9R5DmNWAfuE/8HQoQDA543hqleuYYSxyEqDK2GDNaI1/50vJrEQplg9k1CdKagMJmYXe9Vvr84
	I9ffR73NymPe3qYNx6s9Hk0vNhpOOPu3JcEy3WRP9iaoYCj61IZcOTFl2pGn6vd1hHzThGQqyjF
	E2gZEcgpL3+/w9sEDt9KHftZ2+NbX8ZqyeFjA+dqXjZV+7hwiS8NHbZRR/djIg0W+3ZQEqk19gX
	Toh0G+ax6yf95534OIvP/epHbp3EGZf92oNzeHa9MhviEmzWGL7DaHS6bwQZW5/3AgujOPFjrJe
	hXfdGb+fsIaVFQ2QB7TWRdd1VAdV/g==
X-Received: by 2002:a05:6808:1706:b0:4c1:2512:ee84 with SMTP id 5614622812f47-4ca4be66e81mr40054b6e.23.1789504528641;
        Tue, 15 Sep 2026 13:35:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 13:35:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20260901-typo-v1-1-89ea773a9a05@arm.com>
References: <20260901-typo-v1-1-89ea773a9a05@arm.com>
Subject: Re: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
Message-Id: <178950452760.931545.2900926416498852770.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:27 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 16 Sep 2026 09:56:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3094

On Tue, 01 Sep 2026 18:20:44 +0200, Vincent Stehlé wrote:

> The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using the
> following command:
> 
>   find '(' -type d -name .git -prune ')' -o -type f -print |\
>     xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'
> 
> This can be verified by pre-processing, for example with the following
> commands:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: rename DISABLE_ALL_EXECPTIONS
      commit: a12ef680c0f19662090f2e28ed8e2a89bb17d947
-- 
Tom



