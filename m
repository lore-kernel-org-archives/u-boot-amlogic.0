Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA4C41513
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:39:09 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.89599.1718724618373130205
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 08:30:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=M6fNbCu3;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9AE798838E;
	Tue, 18 Jun 2024 17:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724617;
	bh=bnXSq4qgYCeDiG2el3QtpR29POX0rdfR6AvVfB7SxT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M6fNbCu3XgdMVPnc9P74vm88g6WAe69OE/3joYNIFLV+zfBNakExeX25bvbEIPq5X
	 5+7Vrcus2173zxvH4OxhP0Bn6YsAv8Hw4MF+aUMrpgsvxlAiprdU/kFU/0K3umEVF+
	 lHivB+4FSNomwpw6+aFONIHFUnxifWyQvzX7rfjT7Bbpfjm4LSrLl3rD8u2YcR2R6l
	 LtAdTlfFbHEzbTY0npyW96a0FEUGUIJDXCdf/pztPX9p7ycebEcEq5kJfjIy2SgraP
	 h0pwgo5iKZqbu5KoJAsyMitKSCB7g/zjfiJpsQ6PJavXKVxv+1512fOl3vSFHPFV8d
	 PBms30EO2TMWA==
Message-ID: <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
Date: Tue, 18 Jun 2024 16:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:39:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2304

On 6/18/24 9:55 AM, Neil Armstrong wrote:

[...]

> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>   struct phy_ops meson_gxl_usb2_phy_ops = {
>   	.power_on = phy_meson_gxl_usb2_power_on,
>   	.power_off = phy_meson_gxl_usb2_power_off,
> -	.set_mode = _phy_meson_gxl_usb2_set_mode,
> +	.set_mode = phy_meson_gxl_usb2_set_mode,

Oh, I see you did rename it here, so please ignore my comment on 1/5 . 
Maybe just mention in the 1/5 commit message that the rename is 
happening in follow up patch , if you are doing V2 at all .

