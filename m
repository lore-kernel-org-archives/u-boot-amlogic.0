Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C083D2F35B
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 18:14:04 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.66020.1768328037827822703
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Jan 2026 10:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=RjjWKhDy;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.177, mailfrom: funderscore@postmarketos.org)
Date: Tue, 13 Jan 2026 18:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1768328035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU8sOCfnWtqpDtJSRxpUWwY6K6qC1CHSpfEcPstIdxA=;
	b=RjjWKhDyZbLu0dN9Qtipv9dvhS7gJDoyycB9JfUPOgcf5JIKWCo0q+/yixrXbi/u8GTjzL
	iiFbsRlcmRUzYpbSLYWv9iv2PZeC34zlNQDhav6x/xRXsLXyxktbAevmAYMm37TKmyPl6F
	Y+byEUSRMSr6MV47bjmcczxBPkb3RKGDpSTIcEY1KQyq5Q67xnX7oIAx3ZJRPOKfqPzO69
	vWOvvfOgpnY9Kji/qEZU6eoKnFc4wliCwojrj7DO+dXRkq6UaGPlNAOrL1cgbAAuQSi3C9
	NrMDrBXmmEzBMjxxwcUrquAID1BJ3iNyQQWKwXgJkGa17WvAYzVBPIC4rsvLkQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Robert Marko <robert.marko@sartura.hr>, neil.armstrong@linaro.org, trini@konsulko.com, jonas@kwiboo.se, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH] tools: amlimage: include <inttypes.h>
References: <20260113110806.648534-1-robert.marko@sartura.hr>
In-Reply-To: <20260113110806.648534-1-robert.marko@sartura.hr>
Message-ID: <t8temk.1sj20mnghi4uk@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 13 Jan 2026 18:14:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2882

On Tue, 13 Jan 2026 11:07, Robert Marko <robert.marko@sartura.hr> wrote:
>PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
>included errors like:
>tools/amlimage.c:124:38: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98PRIu8=E2=80=99
>tools/amlimage.c:126:31: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98PRIu32=E2=80=99
>
>Can be hit depending on the host compiler and HOSTCFLAGS.
>
>Fixes: 18c1654567dc ("tools: mkimage: Add Amlogic Boot Image type")
>Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>---
> tools/amlimage.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/amlimage.c b/tools/amlimage.c
>index ecb06bc535b..bc6e19b9c24 100644
>--- a/tools/amlimage.c
>+++ b/tools/amlimage.c
>@@ -2,6 +2,7 @@
> // Copyright Contributors to the U-Boot project.
>=20
> #include "imagetool.h"
>+#include <inttypes.h>
> #include <u-boot/sha256.h>
>=20
> /*
>--=20
>2.52.0
>

Looks good to me, thanks!

Reviewed-by: Ferass El Hafidi <funderscore@postmarketos.org>

Best regards,
Ferass

