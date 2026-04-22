Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47EFA1FD5
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 16:28:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86916.1776875315837641914
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 09:28:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=G4J/WkUg;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4890098abbaso40895065e9.0
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776875314; x=1777480114; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVXoYJszoYYeDIeEdirdEdZ0DE/tVE4lV1r3uPvG3L4=;
        b=G4J/WkUgsLK5lU7e71MCdh+M4GnYREcxnmvVnQFTGo5DaCjP7kcuUrE720EAWpTSOh
         2Xpewo5a0o80/WzQYw2980gFJVdCNusuSPvYDpQNbsvZIvYgEpk8LljgVwiVB1lhT8RJ
         GA88HI7PiH4vE62D/A3tu0VGKRolvQOymXvffTvsVb/G27QWeA7WzlRwSJxgWZuryEyx
         ca0y5EuYm2BQ7BN+M0IKKadZmvmRBf+j33W/aJW1OpObbYVh5Y8iDQQY8qTXa+F+j6bH
         o6+cUeqjP5ptQ1rh5u6xBBeR22sXCqegllgTcfbaAAHdk8oHEKeZAeEXvBMrn/HUcmzB
         mjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875314; x=1777480114;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVXoYJszoYYeDIeEdirdEdZ0DE/tVE4lV1r3uPvG3L4=;
        b=s4XFiSBcaXsiQJTUdTdHjQRbZqhg/HXLk1/m4dwtftbnGft/iF/TBpQzyhUhXy4FAJ
         2VOmViNRVXbfn225eHSo5uVAWJdeUGsaM8EUjKBcxJc4Mj8Z/x/exomzcIgVzwEWvkiH
         wi4Sk6Uw2NOW8yCMgWG2enSv4PhkMJ6PtIabQ2xCOezsD+z4vqKC/3s5ZYG3dd3ZSqQj
         3wdrZQ+Lfmbzk6i/fa7nQTiolQCnj+aEOai7k0I5dsDYgo/lHqgEepbtQnmtMsACeR1Q
         Y71GzPkMrIBMHZ/YRVhqDvWF8P2phFJprktQ1WdAzo1JwdFb/24B40e8fQtCqkgEF3hM
         7T2w==
X-Gm-Message-State: AOJu0YzX13bpDtLWRCiY/MgOOOni2aeFCGK678PSNPs7Y/iLwYes/NrL
	EzBQ+l8YUOgGeW4TfZ9jIfSny9NvRzT8smFonirsq2rdqB2VSTXqByepef02xW6xr9itaWDxz7v
	FJE3VV6M=
X-Gm-Gg: AeBDiesMhz3kzFU9mGX4Li/egFvbqJY/aN+onf6UG4VIk7oifbh1KXD+JdELDGxBBRq
	qIXqc6TIcS1dPtVIBq0YszvkqrPrjWwy6T7l/FwaMjqGqfk1VzWOFRNiB7AeZAbpS+HagG6Zz7g
	BnjiEhvivXpZjDmMVBULH06Oc71NRmhbloZcCV1e/cAskK8sAuRDuEr/98t9FM96tvNqvZAQBgh
	6iOZpV9J8r5LIpug7Z6EFc8HtH29VahHx+M6Sws+kRtMSk1GEukPOYsM/xfwXSyVvlBTGbXqJDR
	XPccI+wvrswNPURCKae2wMBmxcOGct80rhlpw/Vs9aXSxYjEfmCnH3PIGXtjVlvVKqCV12AI4ou
	8lSs7+S2ufmuM+n1zqHMtJsk3CDGJnrmukoITHSizO853mnYa5mymRfNH8Yev2GO3woj4z49kPg
	zuzNuzRBTJDa5OTl5RsLvZ5MV2KEiEOHJ6wlt/Kz2saY7EtqfAjRG2TDQ=
X-Received: by 2002:a05:600c:a30b:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488fb74dff1mr231656565e9.9.1776875314158;
        Wed, 22 Apr 2026 09:28:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm144898075e9.35.2026.04.22.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
Subject: Re: [PATCH v3 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Message-Id: <177687531359.2025915.13597925861310436957.b4-ty@b4>
Date: Wed, 22 Apr 2026 18:28:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 16:28:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2981

Hi,

On Wed, 22 Apr 2026 15:43:22 +0000, Ferass El Hafidi wrote:
> Mostly everything is already in place to enable EFI capsules and in particular
> EFI capsule on disk.
> 
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/93c13379a4446ea38f85c4e393d187b8de2159ab
[2/4] arm: meson: enable SYSRESET_PSCI
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/63a0b3e9abba4df4e6d560f317be2712862c6141
[3/4] configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/94deb742654ae2f8996e9db17158834261b8c05e
[4/4] configs: libretech-cc_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e07cc9e7fdcc35780f539ee1d452ffd3da0fbd1f

-- 
Neil


