Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142BC2D0CE
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.45853.1718884730321689302
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=Fy91tRw8;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6251D8834D;
	Thu, 20 Jun 2024 13:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884728;
	bh=cNiuJ0m4Y5kWc2Q6wg4C4PvMNedJOjawfurM7Q5uLqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fy91tRw8yaeJ86tuqlVpHu9sLKedrNK5ZMTUHW74gPQEfHbb4xtouqtyi0Vxc5RlG
	 Tcd1X1OFg1UNowpJUOidKaGptCnlkcMgg+mM6tvqAUGAsX82PVClKGz6Hc5Dhi3BZ4
	 4dOjJz8GndMwNCSTaIZg6GGB2jhLk6FhW/s3Z3OHkJIeZLGnPlGUVHE5N8eB7UJEOf
	 fM+myEnXukKVl4gk7R/qV0hpv3Pxnu6aPSMBtZ0rgzXlekRrspbh6udcx6DsdVv8LQ
	 ZzEjYpAZTPgyuYNlgrHEgtXbQ7kU6CNaCXNFNKnEpu/5SL8OS4QTUImxornBHOQTbP
	 giEufnxgOwA3Q==
Message-ID: <522a0d5f-1fb8-4900-87a4-395ccdc81088@denx.de>
Date: Thu, 20 Jun 2024 13:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] phy: meson-gxl-usb2: add set_mode callback
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2314

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Implement set_mode callback by calling the current public
> function, use a temporary function name that will be removed
> when the public phy_meson_gxl_usb2_set_mode is finally removed
> in a following change.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

