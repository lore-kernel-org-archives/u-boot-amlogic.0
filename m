Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC5CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:43 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
 by mx.groups.io with SMTP id smtpd.web10.26437.1757528201804307283
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 11:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=eRUu53Q8;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.178, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757528199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ktDaQ0zEOqqj0mfKFlDKjRwTrApHE4GRhwsRilOv1A=;
	b=eRUu53Q8GJlP01iTB1bZmcTNbtuMVP02IkAqqAxGy34CxQNp8ZYiZsqYkf99Pq5/6ali7z
	vOCgMSE0F/SY80bcRCrYLVIy2hWrahd1haAuPhWrG+qxgSUPTaBHDFHGS5S9doZq2XWlOP
	YZynJy0IDlJfSvEXcwMkVyGYrcvhLPNf0esa/HDClJTnT/zS8fyDzI051ofxm2So1V/m1O
	l2HIJymZj/x+G3Cc0OVVxl7Mq1am7BJ8sXw7ApJFfMP2gThJW2aOJnMJ4pSIYmMCPxrtMF
	KxBJ2onpOp7KalLytay+/TIJ06TLTr7d8nC9gy+m0DaOuvlINoe2w8XD53+Uww==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 18:16:36 +0000
Message-Id: <DCPBQZ6RDQXO.3QXVYRR2IMJGT@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC 0/9] initial U-Boot SPL support on Amlogic GX SoCs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Ferass El Hafidi" <funderscore@postmarketos.org>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng
 Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 18:16:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2773

Hi,

On Sun Sep 7, 2025 at 2:36 PM UTC, Ferass El Hafidi wrote:
> This RFC/RFT patch series adds support for U-Boot SPL booting on Amlogic
> GX SoCs, replacing the historical "bl2.bin" binary that runs as BL2 on
> these boards.

Superseded by v2: https://lore.kernel.org/all/20250910-spl-gx-v2-0-8f52aac4=
7e04@postmarketos.org/T/#t

Thanks.

