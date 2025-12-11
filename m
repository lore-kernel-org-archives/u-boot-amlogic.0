Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6038D41D69
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 16:30:33 +0000 (UTC)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13747.1765470630660056994
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 08:30:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=CePeQE4a;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.177, mailfrom: funderscore@postmarketos.org)
Date: Thu, 11 Dec 2025 16:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765470628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1Eh4qZoFLssrsRpeUBaY9MUELW0UbJ/FSCDrggX3I8=;
	b=CePeQE4aEDPjg2hdu/uoP/UBS/p7oOwQMFSOcnRp4ueg+k34AsSkhVSll4syucQmZnel1W
	DJsuC6ahm8MasZ9mW2ZFwl+BByZM+4aJnEDnvomYe6mVOQPJ2eD1X6GQwzkoFG8bDlPkZR
	Gmqo1QLSXkwPQMsRbi4gaoXswLfBDaUwuwv3EQXW02jJDzrRJBzDziH+XwCFc274+tVRW8
	fcPtnHd6lzeqzh9+lKq+9zDgS+9Wa7oBl/YIBTBgX5XoDZOs5wquLAmbFmhPqp/sdIHy86
	JC+7UTpXluNXZwtue7hrbBcolXCAph0rP1lsPzW7st9+EQrB0f/8qtaKQqn8uQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, Ferass El Hafidi <funderscore@tauchgang.dev>, ~postmarketos/upstreaming@lists.sr.ht, Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
Message-ID: <t745um.2alld5fym9h3f@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 16:30:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2879

Hello,

Superseded by v4: https://lore.kernel.org/u-boot/20251211-meson-capsule-v=
4-0-59f126ba4115@postmarketos.org/T/

Thanks for all your reviews!

Best regards,
Ferass

