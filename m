Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F4D41D5F
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:34:43 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12134.1765467275443714615
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:34:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@postmarketos.org header.s=key1 header.b=AZAED0ZX;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.172, mailfrom: funderscore@postmarketos.org)
Date: Thu, 11 Dec 2025 15:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765467273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka+v9Zc8pwgDc2H1UBovhafwgdE6y987hzE5H0asePg=;
	b=AZAED0ZX1um68THoMttT97xX9M+1LSEYV5ctFQFTFDtDk6iAj6YcRWA6MXFm40HHlgps3p
	R+g8wJv2xwLjGH2ruoGlDEmQ2hzLO5rdcht49ZOlkDw2DxYlVtdqlwO1g1XZpdFmfDIGHr
	cNpnnU5qkPn4UV7jKpetPVtCndCbs27AQPZCCNQ9IFw/6lowW90M8gtoHYQN+dz4vCOr18
	TQF/QJ6kbI9DyRD0pThiIRAfFTIQLNVB/4UKRAQyZZlF0QtnyH8pVlKZJuoqNt4XZficzd
	VWxV4I6aczU/2CBhG3vT0s/e4vXoi1JoZ+ONulNiTVktfR6dVRSFLxXBkY93mw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, Ferass El Hafidi <funderscore@tauchgang.dev>, ~postmarketos/upstreaming@lists.sr.ht, Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v3 0/2] Support EFI capsule updates across Amlogic boards
References: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
Message-ID: <t7439h.127clgxv5zbcz@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:34:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2872

Hello, please ignore this patch, accidentally sent it without R-b tags.

Sorry for the noise.

Best regards,
Ferass

