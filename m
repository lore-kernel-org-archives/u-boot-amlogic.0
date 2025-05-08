Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE06BC3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 16:19:15 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.248.1746721154315348890
 for <u-boot-amlogic@groups.io>;
 Thu, 08 May 2025 09:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lexina.in header.s=dkim header.b=Q2OCt9Zh;
 spf=pass (domain: lexina.in, ip: 185.250.0.168, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38E671A07C8;
	Thu,  8 May 2025 19:18:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1746721149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Pj02wZoYyvks9dwufqjVpolSrUoYci36iRZm5QsYDyI=;
	b=Q2OCt9Zhdddpp4pAde2ov6Py049aLOmXs+X1LKpE+KunFKHkJyMDKlhiFNCwhE5N5HoPJa
	iUgD4jcrE1hb23Y0mtUUFXKDjN29rEisah7VvD+/SBp5ymhEUqG/FXuxMwHD2ghSbDCHXL
	koyBOXVBpVO68xW6kmPlWbQOo9OyPnzIKfN4RtdXsiziJb3pdd0SLqAnIQ4nn4IJmemDCw
	X0zaaN3hv/IggchSSdvKlhQxeFnQrJkp71Ud90CABeNkC+Me+lsUQzw6lRpzOq/95RRgS2
	hjmZDeiRURyCy4UFIMfayN8IQQEeUfRakmeQM/W/5/4vjm/I/rCtxCyi1wy09g==
Message-ID: <4e993fa2-b882-4f76-a3f6-4f8beb8821df@lexina.in>
Date: Thu, 8 May 2025 19:18:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] amlogic: Include env.h to permit reading the
 environment
To: u-boot-amlogic@groups.io, sjg@chromium.org,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-13-sjg@chromium.org>
Content-Language: ru
From: Viacheslav <adeep@lexina.in>
In-Reply-To: <20250501010456.3930701-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 May 2025 16:19:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2673



01/05/2025 04.04, Simon Glass via groups.io wrote:
> This file reads from the environment but does not include the correct
> header. Update it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   board/amlogic/jethub-j100/jethub-j100.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
> index b770a1f8c53..9e87fb9f9d7 100644
> --- a/board/amlogic/jethub-j100/jethub-j100.c
> +++ b/board/amlogic/jethub-j100/jethub-j100.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <dm.h>
> +#include <env.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/io.h>

Reviewed-by: Viacheslav Bocharov <adeep@lexina.in>

