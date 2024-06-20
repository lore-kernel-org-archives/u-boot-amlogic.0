Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13FCC2BA1A
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.45855.1718884731406174835
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=y7uW0dH7;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 94BCB883A6;
	Thu, 20 Jun 2024 13:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884729;
	bh=Ckv938oyX0IOVxDn0bJFGF+At0up/fn1D3tp9a0koZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=y7uW0dH7u9Y4lR5lVOe/wahs3puyr5cESe9fc8b3VOaoDNMsoM1omI1d/6c8ZwsC1
	 f0fK9O2lncY3v68AV/QAX51kI6saQstvDVxm2iyMLTc9un/gH6DL4sH3xTmy6PSvYG
	 aXoPvBXzLKs5cvtp8ENqOrRSR0ilUoAkFGus/kg20ISaiJgOtwYaqcLjldmTF4IZ1T
	 2b7FacDG7KA1WoBX6f22lrZMDMl7c7PYkii//OIkq7dUDgyoxhiywlMGeAgrWXYO9X
	 pfY4z0/YXSF6GX8H7Rv5gbZtYvNGNO6p3+JYN9FxTKxHYnkYSl5MUDcHePUib5LX4B
	 5RnqXkMg0qepw==
Message-ID: <e4dc1747-d381-4ff1-9302-c1a0c171a6f1@denx.de>
Date: Thu, 20 Jun 2024 13:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-3-b81c027bc02c@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-3-b81c027bc02c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2316

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Remove the public phy_meson_gxl_usb2_set_mode and move
> the implementation in the the set_mode callback.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

> -static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> -{
> -	if (submode)
> -		return -EOPNOTSUPP;
> -
> -	switch (mode) {
> -	case PHY_MODE_USB_DEVICE:
> -		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
> -		break;
>   
>   	case PHY_MODE_USB_HOST:
>   	case PHY_MODE_USB_OTG:
> -		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
> +		val |= U2P_R0_DM_PULLDOWN;
> +		val |= U2P_R0_DP_PULLDOWN;

btw this could be a one-liner val |= macro1 | macro2 ;

