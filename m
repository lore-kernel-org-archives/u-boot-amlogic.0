Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E60C2BBCA
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.141208.1719237103266796776
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Jun 2024 06:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=gk1Oo2Dz;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F2F3B87DEA;
	Mon, 24 Jun 2024 15:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719237101;
	bh=UqWzXppHTe+IrjlFPQfv71D8qyQ1LDhJX1LZ9DsgHH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gk1Oo2DzDLV310wzw/UewCG5B47M+b07XbjfTn87FMRqPrSffLkq6iEn3lgrB4Co+
	 ibv6Yu/rALI6Jse+ktf25ERH50e/8AiSqOpLseLsVGtMq59HZzwfiJlpNUOosSPlqV
	 Qyo63Ie1DJ2xxRARHKKCOepp2GnWI8ExevfUEUUh7p3pfg2xrSZenyeAlO1jdtOlMD
	 PjAN/IuRYSXjxi0S43yzNAf9p+ujxk0RjgJi4ytM50lBtNE1t1y0cLMxVdyexPBvBi
	 nHQzqq6xMzP7WogN/wAziXqPHbDCG/3c3Fl9P+aFs1K3K3IJFJ4kcH17znPVfBAb4n
	 uAJCM7APV0d7Q==
Message-ID: <2f48e858-116f-4dc7-a3ac-b640725fbe90@denx.de>
Date: Mon, 24 Jun 2024 14:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other cleanup
To: neil.armstrong@linaro.org
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2327

On 6/24/24 11:11 AM, Neil Armstrong wrote:
> Hi Marek,

Hi,

> On 20/06/2024 09:42, Neil Armstrong wrote:
>> Switch to set_mode callback now it's available and in the same
>> time make public functions static and drop useless mach-meson
>> headers that are no more needed.
> 
> Thanks for the review, is it ok to apply it via my tree ?

Yes please

