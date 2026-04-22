Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDEF55811
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 08:14:31 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75659.1776845666308557862
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 01:14:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=EIB3k1rZ;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891b0786beso27798695e9.1
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776845664; x=1777450464; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58rO0BHCmcNKdyW0hYjR2hZXXpALkLzaUfe2KGPbU68=;
        b=EIB3k1rZvirR/QRZF56N1lE56Di9jl4xOTDArUIGKadAnUeH8TZvk8b7mMgzLEYYy9
         +CKYfQEKWHOOEkVX3edHztTwsBYZNOHt9VMQF12lp/tUXAkiGoQsO/chCpQ6wWp7kcbi
         tSDEl+FhacNPEzPhgG9tnWoH8mbNuRTEdhmpVfjYxX5RSJ4lNr8f9/fg7WKahW9XXYog
         GFROGsUnvu8UnLgGs7g6wd7l9SxtaCkx4bjzYKvi9OyOMxjwl9oUBs4ZQF58NkFyvGU8
         S7wlti7OUTXWoBOYdGEz24YrWCATVcwAxzQsB6/61BlwvuQdrlWqlNhNYlLv09e+qIU3
         xkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845664; x=1777450464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=58rO0BHCmcNKdyW0hYjR2hZXXpALkLzaUfe2KGPbU68=;
        b=p3wd0+BTNs1Ui+o3tAkVnXzTxx3wsd8LdjTeO3VaLEvsmKoCYDiUDSVFeWz4ayae5G
         x1EcEpmRzJPgfEbaDyicS4LZg3NCvqt3I26LvG/VEcGiZmRbUV/107V/2Zg0zGzNf9F/
         8sd1XLqCP8vJn+7X+Ll7IeK+jQS+6V2iHJ86+eeEdqX/Pda+Ud6t8DcQhT352DBXGKO8
         13KLyLM8cO0qmQa1gQZBqHh+99erpWPXJR/SBlkpDdN4GlWjP0VNFnY+rAHI4LY0Rsra
         hLTaF7ymmz3DqSl7wk0GFzRrgxSWFm/E/AyFhTQA6RvJsQ4pVM8VWBCghIxF3hw33veW
         rRVg==
X-Gm-Message-State: AOJu0YweQwODuABKlCtd79ct6bW7yrUSPUh8VGk00VSTTk/RA/W/+4Nn
	TG5Tns9nvBwfN3kZs4eGgUvwOE+QGY7ggu5S1YExMZIKhM+ovkTqxgOEYT/HpYo4QXk=
X-Gm-Gg: AeBDietFqK4fX7A7NoNYD1MDW6ORfXmHkkObD31M6iKpO0J/spFhEw0Tqmz7lGmjYYB
	Jzi4R/7pmnlBOeH4n6kr36zQ59JD3dbTjUcHGBB83F9JOC428YmXsoOatqrCDZ+bQanPizhEsmo
	zJEOEftGJOGtjZz/cHE070aFG374QD1q/sUswXGtq561KSEkOSnNoELZjAeHK1Zv8oWL6m8rJ2B
	kO0nR8slD2fWBV1U5bNQSga48XoPLNs5vX/xGOJ9+C1nUBgZBsObpcwXZokrdb3yuqKR30NbZsD
	CDJUPCia/6OgPIZvkspZft1mvYAemBLp7HFg8HE+FLeqbVGN+h/ctTdUHczX2FusPkU/e5bNPcs
	bPnTTd26yCAvZsZpTAYZ4098lGn9Itvh21MYfvRHpiUwGS8zh3GJ6C5m8bR30iOu+nk9w+ZvbWb
	CbWtiPWrqYjtUWJ6e1z2/XBOBANuvuQCxSDAIsdhrUC50g1mMwAeGU56W5OkbyuHRyrA==
X-Received: by 2002:a05:600c:8183:b0:488:ab26:8fe0 with SMTP id 5b1f17b1804b1-488fb765b1dmr250407915e9.15.1776845664319;
        Wed, 22 Apr 2026 01:14:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm122016285e9.0.2026.04.22.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:14:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Message-Id: <177684566365.2679545.5969910941110488483.b4-ty@b4>
Date: Wed, 22 Apr 2026 10:14:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 08:14:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2964

Hi,

On Wed, 08 Apr 2026 20:30:11 +0000, Ferass El Hafidi wrote:
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

[1/4] arm: mach-meson: move reset_cpu to spl only
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a6f2d59191a6afb603927e821ab0077fdac970ab
[2/4] arm: meson: enable SYSRESET_PSCI
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2cd6e8b143eec0f490c4797f2d18112c57cfc557
[3/4] configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/61a7cae07230cba2e8ac502c851ed36073081a81
[4/4] configs: libretech-cc_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b075c1d247113da582d61cc7192affb918cfae02

-- 
Neil


