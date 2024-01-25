Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44706C47258
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 13:22:05 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.6822.1706148379652561967
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Jan 2024 18:06:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=auWPMu+c;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7024687BF2;
	Thu, 25 Jan 2024 03:06:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706148376;
	bh=n2jX889G5KVMa+pn8O5r+fwbdzI32uOyoz7+ooSaM2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auWPMu+cArBV57w+hymASStVJJwfWObm99lu17r4bIIpxHNfN/HapDJkv5qtwwXje
	 HaixDWoA/Qu/9WLiOnpzmp1U5iz/Q/nQhAST2Xq3ETC/wzX+Oldy/W73M3aoqqkvKd
	 323sDA2ks1sdrZ3OKFyt67po68txg4uHU06kBKlSN9dmxAQvsnTksOx0ZujDtQ7Ctd
	 nH5qwQReoqFovBATuxXbk7AxVtx1gpbiupw8Nd00+UkoOtPYlIgIAloBMe0evF7wZg
	 rw9qJv5DyG+P/eBHDchDHJSIqFiMCdjlF9080Y706FEWupxntKLVX6qTZIZQWyIDyg
	 GkSVuS/VSf5Xw==
Message-ID: <48125705-e78e-438f-90ac-2816432cd747@denx.de>
Date: Thu, 25 Jan 2024 03:03:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
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
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 25 Jan 2024 13:22:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2085

On 1/24/24 09:16, Sumit Garg wrote:

Hi,

>>>> How do you propose to handle fixes to DTs which are applied to
>>>> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which
>>>> has some defect that is fixed in 6.6.1, how will that fix get into
>>>> U-Boot DTs ?
>>>
>>> This fix would also be in the latest Linux tags, so I think it would
>>> find its way here - as I understand it patches aren't accepted into
>>> Linux stable unless they land in torvalds tree.
>>
>> See the devicetree-rebasing.git:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/refs/
>>
>> That only contains refs for release versions (v6.6-dts, v6.7-dts etc),
>> not any follow-up updates from linux-stable (like current 6.6.13 etc).
>>
> 
> Here we should only consider fixes which are critical to U-Boot. I
> think -u-boot.dtsi files would be suitable to carry those fixes until
> next uprev. However, if there is a fix affecting many platforms than
> we can consider pulling that standalone too.

That would mean extra duplicate work -- the critical fixes have already 
been selected into linux-stable, that work is already done, I don't 
think it makes sense to re-do it again.

Furthermore, I do not like the new necessity to start porting those 
fixes from linux-stable and converting them to adjustments to 
*-u-boot.dtsi files, this is tedious and error prone, so it would have 
to be automated.

But I still think it is much better to simply take the fixes directly 
from linux-stable as-is instead.

>> Would this require syncing in -rc versions of Linux DTs to get the
>> latest fixes in ?
> 
> Syncing -rc versions makes U-Boot more prone to DT ABI breakages. So
> its a chicken and egg problem as per your comments below. However, we
> can revisit our syncing strategy based on how the current one pans
> out.
> 
>>
>>>> Assume that there is some large breaking change in Linux 6.(n+1),
>>>> something which would be problematic for specific U-Boot platform
>>>> (e.g. i.MX) or would require a lot of work to sort out, will there be
>>>> a way to temporarily pin DTs for specific platform to older DT version
>>>> until that is resolved (e.g. pin to 6.n) ?
>>>
>>> (Upstream) devicetree has to be forwards and backwards compatible, were
>>> such a breaking change to get merged without prior discussion with DT
>>> users (i.e. U-Boot) then I think the correct course of action would be
>>> to revert it.
>>
>> Not really, this could be a perfectly valid change, and would work for
>> Linux just fine, it might simply be pulling in something which is not
>> supported by U-Boot just yet and therefore syncing the DTs into U-Boot
>> would break U-Boot on that platform . Using older version of DTs for a
>> platform could work as a stopgap measure until the functionality is
>> implemented. Is this possible ?
> 
> For this particular reason we want to pull once during beginning on
> U-Boot next window and allow sufficient time for platform maintainers
> to adapt to it. However, OF_UPSTREAM=n can be an alternative for a
> stopgap solution.

That pull would break other peoples platforms. It would be no different 
than adding broken patch into the code base. What I think would be an 
option is that there is a pull (as in patch) and people should be able 
to test it before it is applied. If one platform is severely affected 
while other platforms are fine, the one platform should be able to use 
the current working version of DTs, while the other platforms should not 
be blocked by it. Is that what OF_UPSTREAM=n does ?

As far as I understand OF_UPSTREAM=n, it would require re-importing DTs 
into the codebase ?

>>> On a tangential note: as I understand it, DTs built from dt-rebasing are
>>> still subject to U-Boot customisations via the "-u-boot.dtsi" include
>>> files, this allows for dealing with incompatibilities due to missing
>>> features in U-Boot.
>>
>> Would it be possible to auto-update those -u-boot.dtsi files during
>> sync, to minimize the resulting DT blob delta before/after update, and
>> thus also minimize the likelihood of causing breakage ?
> 
> In the long run the DT community would like to avoid any DT ABI
> breakages at all. Rob is already working on a DT ABI check tool and
> seeking inputs for what could be an ABI break [1] from U-Boot
> perspective too. Feel free to provide your inputs.
> 
> Along with that we wouldn't need -u-boot.dtsi files once we make
> U-Boot fully compliant with DT bindings. Until that point U-Boot
> platform maintainers have to keep their -u-boot.dtsi files updated
> corresponding to latest DT rebasing releases.

I think upstreaming the bootph* properties would still take a while, but 
is not relevant to the aforementioned question.

Assume there is a sync, would the current in-tree -u-boot.dtsi files get 
updated to work correctly with the newly synced DTs ?

