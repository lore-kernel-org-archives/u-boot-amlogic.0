Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9204ED31A3C
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:15:23 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.57662.1768306916090665492
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Jan 2026 04:21:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@xs4all.nl header.s=xs4all01 header.b=PzOu9Ge3;
 spf=pass (domain: xs4all.nl, ip: 195.121.94.184, mailfrom: mark.kettenis@xs4all.nl)
X-KPN-MessageId: e6bbda80-f078-11f0-af3f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e6bbda80-f078-11f0-af3f-005056994fde;
	Tue, 13 Jan 2026 13:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:to:from:message-id:date;
	bh=63KWQmxdUzKy1KsEcpKOanno/wD/xixyE2ZLTrBPLSU=;
	b=PzOu9Ge3aiuZPs2kkpM0uIEMEhH/btao2nY7mL8eKPM4Xc2RhaUuY8YjeUUxnVO/AxOkAjVzd9iue
	 HODdm2Ht+DTswmuMGubixUpoe9i0ijB5CZixfkbfsstBQDI15ULAV5RHSJWeELL+AyfxmmnXmpleZA
	 UsYone0gKBp5V3RYhjBKWQVg1hCK4Q8fi7tO05D/UhTN1lHo+bk+0/Po9HLVkUIhG34WItEcyq6oqO
	 tlakT3GBhispU4oYVCzCLQ5tGAAfypmruY+rdhznFQ4si0IOZguz5TO+XLDyHsil9TMwZ4fHJd2YWx
	 p9khIMaxwHYvqpatIEqaJpG97VNju/w==
X-KPN-MID: 33|UR7220K2SuXH7wbqrrxEEofgrKiiKJi3RsM/zsCZufZ4KADUyNZnFnIUIVT0Jif
 rChQz6gB+NJZisWRWXy/8It32BtLeu2fUP+zfgbOb8zk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9Q2xw47jkEPjW7CX2lo7c9Df4DT084ewGx21A5pvssE04nzlO0rXd0g8uJOUFgR
 mSfYjMBAMvTBPcEgoQmzZvQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e52b1b1e-f078-11f0-8d40-00505699b758;
	Tue, 13 Jan 2026 13:10:48 +0100 (CET)
Date: Tue, 13 Jan 2026 13:10:47 +0100
Message-Id: <87cy3d90hk.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Robert Marko <robert.marko@sartura.hr>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, jonas@kwiboo.se,
	funderscore@postmarketos.org, u-boot-amlogic@groups.io,
	u-boot@lists.denx.de, luka.perkov@sartura.hr,
	robert.marko@sartura.hr
In-Reply-To: <20260113110806.648534-1-robert.marko@sartura.hr> (message from
	Robert Marko on Tue, 13 Jan 2026 12:07:38 +0100)
Subject: Re: [PATCH] tools: amlimage: include <inttypes.h>
References: <20260113110806.648534-1-robert.marko@sartura.hr>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Jan 2026 10:15:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2885

> From: Robert Marko <robert.marko@sartura.hr>
> Date: Tue, 13 Jan 2026 12:07:38 +0100
> 
> PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
> included errors like:
> tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
> tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’
> 
> Can be hit depending on the host compiler and HOSTCFLAGS.
> 
> Fixes: 18c1654567dc ("tools: mkimage: Add Amlogic Boot Image type")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  tools/amlimage.c | 1 +
>  1 file changed, 1 insertion(+)

Hit this myself the other day on one of my systems (and then couldn't
reproduce it on another system probably because the header was pulled
in through some othet dependency).

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/tools/amlimage.c b/tools/amlimage.c
> index ecb06bc535b..bc6e19b9c24 100644
> --- a/tools/amlimage.c
> +++ b/tools/amlimage.c
> @@ -2,6 +2,7 @@
>  // Copyright Contributors to the U-Boot project.
>  
>  #include "imagetool.h"
> +#include <inttypes.h>
>  #include <u-boot/sha256.h>
>  
>  /*
> -- 
> 2.52.0
> 
> 

