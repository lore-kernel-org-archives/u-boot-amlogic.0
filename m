Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE30AC41513
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.45561.1718884732709653877
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=OmGDnSjB;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C578687EBD;
	Thu, 20 Jun 2024 13:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884731;
	bh=iMYZ7AyvnAjnmK4jFlPoEiQ3G4HC+zPhuy1Mpmz4D9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OmGDnSjBVV7HxdG60D3H75yScObu1m/NXahI1S6aXD+kaxLAqoYqt8MXiMaMLfKnC
	 h5q3aIFLeaSPM3oL8Z7cD8eL+rDJGvpjDRigsX8s5ZAP2icurjzW9AAMwrhfBHF8bL
	 ScZMvQAUR853FApQQnxknEYUtCPvX5rA2js7z5Uh+vQhlFKrJQkbm0rnbeCnGm3vug
	 eOG0NVf3UgYmdCPPIkaPim5/IY0z44RXPmfnboXTzXI/Wu1pYZ1kYXUCjFMDrUv7mB
	 TRxk7oAquoTmq17KhtLUX429ncyC8Lza6XP16e+wbchJN5PIDPgJfmiD/UOcjYhJZT
	 4nZ9KtqH5iJ2A==
Message-ID: <d6a99eaa-d856-4806-a985-3daac32438d9@denx.de>
Date: Thu, 20 Jun 2024 13:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-5-b81c027bc02c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2318

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Drop this useless usb.h and now make dwc3_meson_g12a_force_mode
> static since only used in the dwc3-meson-g12a.c file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

