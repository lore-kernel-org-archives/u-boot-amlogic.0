Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BEFC47DD3
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.61860.1705882650789740485
 for <u-boot-amlogic@groups.io>;
 Sun, 21 Jan 2024 16:17:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=bejvE0nE;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5FB6A8771B;
	Mon, 22 Jan 2024 01:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705882648;
	bh=moEFSlS/kmyAWmW0bixo+C7HpRihttrjc6ZtW7SM8u8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bejvE0nEtHOd/1V7x2cPJcTmXvKecB7h28RZgo4rLAFcrDdIPl9dtZ8JXW9vo8I2B
	 tpiq/Wzn4skCapJL/k6y2ZjaKMl6Dh1WpwwLq7E3QQYd3cVN2398r/C9rnjqP3jfEZ
	 fjyFMF1VdO3pbDp3agrsRvXK8xShzOxdWZ0s4c+zzVKwNtEfQhVxxtiSWOO80ysHlJ
	 1Owo1AlsK9PhXo+JgtMLi9Thb3Pyv2JEGxcjeeiMsqG/pOmZlprX1AGPYP7/w1Zszj
	 oqJ9XUZfK37dQoT/R8zC1g76a7s/mHKZUsgfEpIDNJKQDUB5DXD1442Scjv2mPT6u2
	 kTIyCl3VfZS0Q==
Message-ID: <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
Date: Mon, 22 Jan 2024 01:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jan 2024 11:44:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2077

On 1/21/24 23:41, Caleb Connolly wrote:

Hi,

[...]

>> How do you propose to handle fixes to DTs which are applied to 
>> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which 
>> has some defect that is fixed in 6.6.1, how will that fix get into 
>> U-Boot DTs ?
> 
> This fix would also be in the latest Linux tags, so I think it would 
> find its way here - as I understand it patches aren't accepted into 
> Linux stable unless they land in torvalds tree.

See the devicetree-rebasing.git:

https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/refs/

That only contains refs for release versions (v6.6-dts, v6.7-dts etc), 
not any follow-up updates from linux-stable (like current 6.6.13 etc).

Would this require syncing in -rc versions of Linux DTs to get the 
latest fixes in ?

>> Assume that there is some large breaking change in Linux 6.(n+1), 
>> something which would be problematic for specific U-Boot platform 
>> (e.g. i.MX) or would require a lot of work to sort out, will there be 
>> a way to temporarily pin DTs for specific platform to older DT version 
>> until that is resolved (e.g. pin to 6.n) ?
> 
> (Upstream) devicetree has to be forwards and backwards compatible, were 
> such a breaking change to get merged without prior discussion with DT 
> users (i.e. U-Boot) then I think the correct course of action would be 
> to revert it.

Not really, this could be a perfectly valid change, and would work for 
Linux just fine, it might simply be pulling in something which is not 
supported by U-Boot just yet and therefore syncing the DTs into U-Boot 
would break U-Boot on that platform . Using older version of DTs for a 
platform could work as a stopgap measure until the functionality is 
implemented. Is this possible ?

> On a tangential note: as I understand it, DTs built from dt-rebasing are 
> still subject to U-Boot customisations via the "-u-boot.dtsi" include 
> files, this allows for dealing with incompatibilities due to missing 
> features in U-Boot.

Would it be possible to auto-update those -u-boot.dtsi files during 
sync, to minimize the resulting DT blob delta before/after update, and 
thus also minimize the likelihood of causing breakage ?

