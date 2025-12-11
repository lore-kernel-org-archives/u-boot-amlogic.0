Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7ED41D65
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 16:24:23 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13634.1765470261299205100
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 08:24:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=ok/xoyjA;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.171, mailfrom: funderscore@postmarketos.org)
Date: Thu, 11 Dec 2025 16:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765470258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r38he97nVLah3gLlVfTA5b99WZvv8SPkZkeQ+8s+8Kw=;
	b=ok/xoyjAhiLkFSECpJ1D05WZTNAjIdpFUyk7HcOWnjgvH4KZUr+wbNzVTO900IsuMrExFP
	mdYONU6H95u1929bILVbfYlDzSHnJTbyKqa7UMFzFsPKbFBZ/G4lrK2Z2+hhNuHLc/Fmo9
	KjM0fAA06cuQYepU4TF2gExTTsXCernihgf3GhL9e/SqmeNBy9A60+NiNPUaEpz1oxbFaK
	+/f4liTOTAIeDCeyUFj6hjObOof4/KklPUQSEwuodV9f3qaWsei8J8i4aNxEKGvw7TkQR0
	c+qjocZEh3kGZjEGAlui9ezAiUGFShK4cGzHfevLKJFdr5gtRXBIdLP2qr6cqQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, Ferass El Hafidi <funderscore@tauchgang.dev>, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 1/2] arm: meson: add support for EFI capsule updates
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org> <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org> <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
In-Reply-To: <7a30f8de-c87b-46e3-83e9-6d61484b2ecb@linaro.org>
Message-ID: <t745kf.c5gbun7uixd9@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 16:24:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2877

On Thu, 11 Dec 2025 15:44, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:
<snip>
>Wait this means all boards uses the same GUID ?

The GUID is generated at runtime based on the devicetree compatible
string and the fw_image name.
(https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#dynamic-firmwar=
e-update-guids)

So this means each board should get a unique GUID, based on the
compatible, and in addition, based on which storage device it is
booted from, as the fw_image name is different depending on the
boot device.

Best regards,
Ferass

