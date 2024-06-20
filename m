Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21ACC2BB85
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.45854.1718884730861222765
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=pkmaquws;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 054F088378;
	Thu, 20 Jun 2024 13:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884729;
	bh=tFE3Dlvek9bM8MBrr+kk+8On0he68uNXmAi39Lu5rJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pkmaquwstn7qYTEFL1asmXbjWHXP2MZLkgqCX8Om+WpkxE5BUfVuO3P3EH90i51+K
	 WLrRtkEvc6BK9hvh96ZdYnRez+YYycWLUsE4jDmuA/a2HQrrWJb+CS6NL7JoG3VWqo
	 xDUfFrWwTPwrcHkC2bj1WguekUXKenHwGzvGadZCCdoWdXhq0dhUbDaicQLlu2YTNx
	 p0wwb58Q1myYBgMPTB5mHobvRAMMmVCmjbeFaLNcHqaMeWSP+X52Dt77Fsfy/8nhf5
	 XK5rB+5+n1s+rF+WcRezN2X0qxfoM4czMPksxkOub1BbS22XUvw1A8k1vwMJvcvND/
	 HtroIxz+mbzig==
Message-ID: <3287e60f-cf77-49e4-b715-559a0ea1a710@denx.de>
Date: Thu, 20 Jun 2024 13:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] usb: dwc3: meson-gxl: switch to generic_phy_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2315

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Use the PHY set_mode call instead of calling directly in the
> PHY shared function.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

