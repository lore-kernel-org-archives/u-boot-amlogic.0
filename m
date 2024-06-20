Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E30C3DA40
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.45559.1718884732037248935
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=tMiaeEei;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 31F9C88527;
	Thu, 20 Jun 2024 13:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884730;
	bh=hH8aQBQcnlODr0sOf6Oxhb7MYW/AvL3WaY0yAbZrzM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMiaeEeiXmQstoWoR2z4emgBjQw+KVA5oC743EJNRO58JlMos2AKLW1whQS7198tQ
	 XLZvApvlZkgAGKzphrtCDZ+ly/Chfs7WJ5gHq4/KKjm9m5nxiSJWpF7dvWWID56WKd
	 PDzFPL6jkH6uoCJI55fKL50NtWUVz791RRCJCcJs/jSjp8To95/65QqZQk+iDqst6b
	 n9kAc8NkK/nge47NYYmo2CUkIbNZfqNBgnn9XrLHXscogO1J+0wXstpZu03Jwzrvsy
	 Sc9SQc+VPI/J+sg2Jwhvh93Zvzd9YK0d9jqjEMD+fccR7uObtHNVKGtSorDCfwZ36C
	 hYobX//6H/jpw==
Message-ID: <b19fd3a2-65c3-4b8b-9474-b50b1d570b3e@denx.de>
Date: Thu, 20 Jun 2024 13:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-4-b81c027bc02c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2317

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Drop this useless usb-gx.h and now make dwc3_meson_gxl_force_mode
> static since only used in the dwc3-meson-gxl.c file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

