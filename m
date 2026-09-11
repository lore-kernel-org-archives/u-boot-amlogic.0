Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E5C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 07:43:38 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37786.1789127539984888548
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Sep 2026 04:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=ij/q1SAr;
 spf=pass (domain: chromium.org, ip: 209.85.167.45, mailfrom: sjg@chromium.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso886697e87.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Sep 2026 04:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127538; cv=none;
        d=google.com; s=arc-20260327;
        b=BT3YkhHzoCUlbmAHFrun6ChdLbqM263flSAUeiReU7DytLFyQNU5CvjjlRS6ef3BZ8
         glf7DQ+TMxCgSa8jElMC12WWWhostGKuSBKmt/a4/fSNh7AFPBcDPJ+DEPhuGxMI1Irg
         l8icoIHthrNozR000mQ4lmAOlXYnMtuUHWyIbAoFhgbDK7JQdZcZmp9kkd5QKQ9c1w2f
         xnEKxOYwrpSj5iQuEAbtbRRmCjzDKYS0ah9mKfle8SwcoA/h/dwcnLAoS7Elzg90v1/q
         ZxkDS7iswQqR5IeyeoeChOGpo+lWQO2Bd/psVNGTBuE5X4s5hgPHUFJwvKeJTYXKbMGk
         bBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
        fh=bPGGFCR2bPl1s9lxWC+GgBxK6s1ZPirx7TH1EJq+Vkc=;
        b=fp8W92EcoCUgubH99ULe9TTRBiKV3HCJyPr2GcGBWfhxJkWmXFd8/0XsM4gsnsegqI
         76Z+iJMNXecePWdHCCOJA8Zk9ySM9f+vCMEW3Tvoxfeh/B9AsX17CcxSY4r+PHggAqkV
         cVvrUEaA5ccKjOWkYnVC/9wnNLHax8pnZUaK16NKuxe8emPraOZGI/NN8fb1eQtxAtq5
         kSN/qdIm4jGWPdcZU2nju2zp+6pvrbDqDjuMKcfCzFGXD26KihZvux6B4FCrzW1M/4Xh
         fSjpCURXSd6G6h+bbhVT/oCqQkYKXvK/zkBQNFH6hh1UvODW9oRbvfMc7+b7lNrzh7jg
         hqhA==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789127538; x=1789732338; darn=groups.io;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
        b=ij/q1SArX0frAaw2oVkZqQu77b8F3bXhSUoeKU3oVm72LPJX4FF0NVWM4CgAJUrvWo
         sWNvN60nVDz94byxDsd8uYZSquSvCvYiRzKToGs/Nb/2yKwZrWLX9PEyPksV1t1nCHe9
         0049HdyqzPI3PzkEfA3XN1j2jBQGYbMbqsU0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127538; x=1789732338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8NvTMGofefYPzvnYIFv4vxrX4CzLZhL9aXdqHE6onxw=;
        b=oUKLW7qr+GW8bDP6U+n7MhMVc5+7GFLKTJVXiv5wBZDqw6P4rtWBjuaOehQmY7nO+1
         GvZyTGnUHT0rmNiUDcIZxjoTmVYru8FS16bT+qT+A+XXeg6rY0TXarnu8zFAO4WQLxAQ
         jWIyvtpKj/rAKjGm6GDBH7fL5FFcEtlyftPZUzdg9DVIG/jM74xgw1kH6jjh+jWjZgKo
         VWWxvpR0bGOxVONsz/h/F+V24NkycBW58r3a+XSJL+dNavhyrW/bWu96vQWWxvlwYrZE
         TIjzsnlI6Tj+yzoblFeSqF7a3WCRoNc3g4ghQ8vO4XytaMxYOFULgeH8rqIZGU7tEP9c
         1IjA==
X-Forwarded-Encrypted: i=1; AKwUvBzM5J0ACmIlJHgu1VMfdi4/FmtYreXpwcIfUgKRxJSEYCnR7R1p8PmNBLLFGJI9HP37mNdpaP9ZauTM4jBflg==@groups.io
X-Gm-Message-State: AFuF++kaR4mcxD72oi5ae82PcyE7pEHBHOxRTzCzDvFlO/OqZ8yhCKu/
	K88y38xdx2u03wWtvG5N18nFW9JQrNi5U78X77P2HYOuq+2J9zZaSAbCNGQftA0NQnoENMN2W4C
	S4HkhEFbBprFbUnI/ukt4P5Vsyi4GoBbETiBUjvwrBZ/v4wf5dCrZ3pht
X-Gm-Gg: AYBFou0maWG7L7DmWvC5BTaFVESYIeRRmdjv83onv1iCCH5zK2qg3JeFIbH38CJpTDd
	A8PDz89BQS5b1q5rNFdaPgJjnc7JIBWt6K42oHFpfXXn0SViKJFSfi86/4/5OqCvf+eya/LWrWs
	BTACjKxOvsTjjpoW3qlwe1J6DYq4sba9VWTYvaWEUjeV0KW51DIaJfquQvFgWz7FYpPUXs44+TO
	vG86GjIrwk6h8hV2FYFMagSKq1paeZ51JewTa4J5NvyARkmxlxfT4BJAlWb3U0ISMF7G2n8K1tR
	+KDw9AO9WhY7Vyr5k48u1kCvRWyjY9zik6MWimdlBpvh8/hCxw+4PhE=
X-Received: by 2002:a05:6402:3259:b0:6a9:9833:2ecf with SMTP id
 4fb4d7f45d1cf-6a9b561d545mr1323232a12.10.1789127086438; Fri, 11 Sep 2026
 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de> <20260828210003.823954-2-foss+uboot@0leil.net>
In-Reply-To: <20260828210003.823954-2-foss+uboot@0leil.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:42:55 -0600
X-Gm-Features: AcwNN1WSqFAXmuRG4hpTxN_El2LNXTd9Hv8INRA_V0L5wmIWZ78w_gDf1PUfTRo
Message-ID: <CAFLszThBsKoFcFyGgetiJR-0X0r97P9xwdRv77JEFWDF_vj2Mw@mail.gmail.com>
Subject: Re: [PATCH next 45/45] binman: gbb: update link
To: foss+uboot@0leil.net
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
	uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org, 
	neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org, 
	xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in, 
	sbabic@nabladev.com, festevam@gmail.com, smoch@web.de, 
	alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com, 
	iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com, 
	bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org, 
	Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 15 Sep 2026 07:43:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3093

On 2026-08-25T16:49:42, Quentin Schulz <foss+uboot@0leil.net> wrote:
> binman: gbb: update link
>
> The current link results in a 404. Looking at the Wayback Machine[1], I
> found a similar page currently being served. It's probably very outdated
> by now but at least it's not a 404 anymore.
>
> [1] https://web.archive.org/web/20230520044331/https://www.chromium.org/chromium-os/firmware-porting-guide/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/binman/etype/gbb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

