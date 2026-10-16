Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BCACCF2DB
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 07:36:14 +0000 (UTC)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21654.1792156992692076890
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Oct 2026 06:23:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=M4Afrvyh;
 spf=pass (domain: 0leil.net, ip: 84.16.66.175, mailfrom: u-boot@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5lnQ56HszGqn;
	Fri, 16 Oct 2026 15:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1792156570;
	bh=3DAlPEsgdKXErbdrwAwNpRc/8JPpXzduXyRqU2zjPGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M4AfrvyhMmSVLiJUZ5oK5K4lrr8ut81DQGpySz8NX/ZaCFS9gbRj1EvSC7bfwrn9Z
	 7kOu11vRVmNkJzVu+OUmf2ShLsaC6+57jyvxS/m8GVhLPuJ0IV+ryd+L3u0Y8VGEwC
	 MfTHsyGRBogoqrZsSIHr1Z8Dixgf6y5a7gn5Im6Pm2qGguoYYAmzIFrjrUNVj4oEa1
	 JAK2KveAcoG0LRLay2uKQyKvC8indd9EGJeHrP3jQhwXsTO3MHz5DRbcu+tMLpEf7j
	 b3YGhVj7h3YpD6oWFTwrOEP2oXe9ZAozJ4Ynf77OhN6NfbIhxjiwdZHkn0B4TeO8ND
	 vWM7GHI/4cOGQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j5lnN2ZK9z9LB;
	Fri, 16 Oct 2026 15:16:07 +0200 (CEST)
Message-ID: <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
Date: Fri, 16 Oct 2026 15:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: meson-g12b-odroid-go-ultra-u-boot: set vddio_c to 3.3V
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-3-y-asai.0816@docomonet.jp>
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261010013237.2269021-3-y-asai.0816@docomonet.jp>
X-Infomaniak-Routing: alpha
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Oct 2026 07:36:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3135

Hi Shigeaki Asai,

On 10/10/26 3:32 AM, Shigeaki Asai wrote:
> vddio_c (RK818 LDO9) is the vqmmc supply of the SD card. Linux picks
> 3.0V for it, the lowest value in the allowed 3.0V-3.3V range, and the
> value is kept across a warm reboot. U-Boot then finds the card at
> 3.0V: it initializes, but data reads at 40 MHz fail on some cards (a
> SanDisk Ultra A1 64GB here), so the kernel cannot be loaded and the
> board drops to the U-Boot prompt. A cold boot works since the PMIC
> starts from its 3.3V default.
> 
> Changing the kernel would not help the kernels already in use, so set
> vddio_c to 3.3V when U-Boot probes the regulator, which happens on
> every boot.
> 

I'll let Neil decide since he's the maintainer of that code, but I don't 
think this is necessarily correct? The spec specifically allows 
2.7-3.6V, c.f. https://www.sdcard.org/developers/sd-standard-overview/.

Moreover, RK3399 Puma has 1.8-3.0V only, and it's been working fine for 
years now (though I haven't checked with that SD card specifically).

What happens if you do NOT use the SD in U-Boot at all and boot straight 
to the Linux kernel, is it also broken in the Linux kernel then? If not, 
then your issue is probably not what your tool output and we may have an 
issue elsewhere (possibly in the MMC subsystem for example).

Cheers,
Quentin

