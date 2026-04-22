Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F211FA1FC2
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:41:43 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85721.1776872502597596486
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:41:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=ix3VW4dB;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.172, mailfrom: funderscore@postmarketos.org)
Date: Wed, 22 Apr 2026 15:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJVUpaNEp9JEnByoavGdkQ7NXindEcv9mIFPsPqD2qQ=;
	b=ix3VW4dBs7yHQGorvBfoSFv7tEJwG7agR1S5TeirOD7OLMiGKz8qq3ooYjEEoRX9b4wqUe
	90jWCYGLxxxDFe4lhY7Q6yuKhbTwq9UhDwlHfEdgbRsiSkd1ZeNKHMPHIOWhtMswJ8mVgo
	xIulaV5FuDhzyzYsC1b9H99KnuljrhnNSwV1XCdn4SiioosrEMMAm+CImOcR4WjgrzGSsM
	jsJWdjqm2lzL61a09PtNXexBgrNYQuzYzgmeKS9QjOBP3ZHqphuTwIrveEkkAvEQY2uqgc
	HqoaFHku59Qdc6D4RQhIavj3CNY/E/y0vllrIdUldNbJgAyVgZK89Aj39br4cA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Evgeny Bachinin <EABachinin@salutedevices.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v2 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato & LaFrite
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
Message-ID: <tdwjl7.i3gvyhcbegcm@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:41:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2972

Hello, ignore this patch series. Didn't mean to send it in this state.

Sorry for the noise

On Wed, 22 Apr 2026 15:39, Ferass El Hafidi <funderscore@postmarketos.org=
> wrote:
>Mostly everything is already in place to enable EFI capsules and in part=
icular
>EFI capsule on disk.
>
>First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
>functionality expects sysreset to be present. As the current reset_cpu()
>function in board-common.c is basically only doing PSCI reset on U-Boot
>proper, we can replace it with sysreset's PSCI support, which works just
>fine for that purpose provided BL31 is running (SPL stays on an
>SoC-specific reset_cpu() which does for(;;);, as the overhead for
>sysreset is too high and we don't have PSCI yet at that point).
>
>Then we can enable capsule on disk. LaFrite has Capsule updates enabled
>already, so it is simply a matter of enabling CoD. LePotato does not
>have Capsule updates enabled by default, however it can be easily enable=
d
>and setup to update u-boot on eMMC/SD.
>
>With Capsule on Disk setup, it becomes possible to update U-Boot directl=
y
>from Linux, without having to worry about manually using `flashprog`
>(for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
>can be handled by `fwupd` and applied upon next EFI boot.

--
Best regards,
Ferass

