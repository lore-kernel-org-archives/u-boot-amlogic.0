Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC7CCCF2D3
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 07:36:14 +0000 (UTC)
Received: from ocn-dfr-mts-118c1.ocn.ad.jp (ocn-dfr-mts-118c1.ocn.ad.jp [153.128.190.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1258.1792213636286881297
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Oct 2026 22:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@docomonet.jp header.s=20240125 header.b=jpWJhOxq;
 spf=pass (domain: docomonet.jp, ip: 153.128.190.140, mailfrom: y-asai.0816@docomonet.jp)
Received: from ocn-ckd-mts-121c38.ocn.ad.jp (ocn-ckd-mts-121c38.ocn.ad.jp [180.55.181.103])
	by ocn-dfr-mts-118c1.ocn.ad.jp (Postfix) with ESMTP id B96FB190
	for <u-boot-amlogic@groups.io>; Sat, 17 Oct 2026 14:01:57 +0900 (JST)
Received: from ocn-spm-mts-103c1.ocn.ad.jp (ocn-spm-mts-103c1.ocn.ad.jp [153.128.190.230])
	by ocn-ckd-mts-121c38.ocn.ad.jp (Postfix) with ESMTP id 164A61C0007C8;
	Sat, 17 Oct 2026 14:01:54 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
	s=20240125; t=1792213314;
	bh=8FY8OPrcbKHszmn2Bylyp47ZbL+PHHVuIpFuYCdET0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpWJhOxqw8kWCVZOsr9U5imuTD1yryGrAyiXcF2eJjgO/ts0IrlQ8Ga0EqTa9nwH8
	 tR7ImoI/gdH6qQdjNkfT2/BHxijypMV1bQr6sJvmucUFUECNfvPWDoRYxIbTARYpPj
	 n+6uMlMu/LPwiPry8CoEB45WQUjKYrRNk5bYP6OQ=
Received: from ocn-vc-mts-112c1.ocn.ad.jp ([153.149.236.166])
 by ocn-spm-mts-103c1 with ngmta
 id a753f171-18df388376ffdffb; Sat, 17 Oct 2026 14:01:54 +0900
Received: from ocn-sdpx-mts-111c1.ocn.ad.jp ([153.128.117.205])
 by ocn-vc-mts-112c1 with ngmta
 id aabe4ed6-18df38832f430fa2; Sat, 17 Oct 2026 14:01:53 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
	by ocn-sdpx-mts-111c1.ocn.ad.jp (Postfix) with ESMTPA;
	Sat, 17 Oct 2026 14:01:52 +0900 (JST)
From: "Asai, Shigeaki" <y-asai.0816@docomonet.jp>
To: Quentin Schulz <u-boot@0leil.net>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
 neil.armstrong@linaro.org,
 jh80.chung@samsung.com,
 peng.fan@nxp.com,
 kever.yang@rock-chips.com,
 sjg@chromium.org,
 trini@konsulko.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 2/2] arm: dts: meson-g12b-odroid-go-ultra-u-boot: set vddio_c to 3.3V
Date: Sat, 17 Oct 2026 14:01:52 +0900
MIME-Version: 1.0
X-Mailer: HidemaruMail 7.42 (WinNT,A00)
In-Reply-To: <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp> <20261010013237.2269021-3-y-asai.0816@docomonet.jp> <69377c9e-b4a1-462a-b82d-66e13b465626@0leil.net>
Message-Id: <DDD5DF49FC35692F3006A@docomonet.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Oct 2026 07:36:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3136


Hi Quentin,

Thank you for the review.

On 10/16/26, Quentin Schulz wrote:
> I'll let Neil decide since he's the maintainer of that code, but I don't
> think this is necessarily correct? The spec specifically allows
> 2.7-3.6V, c.f. https://www.sdcard.org/developers/sd-standard-overview/.
>
> Moreover, RK3399 Puma has 1.8-3.0V only, and it's been working fine for
> years now (though I haven't checked with that SD card specifically).
>
> What happens if you do NOT use the SD in U-Boot at all and boot straight
> to the Linux kernel, is it also broken in the Linux kernel then? If not,
> then your issue is probably not what your tool output and we may have an
> issue elsewhere (possibly in the MMC subsystem for example).

Linux is fine with this card at 3.0V. Linux itself sets vddio_c to
3.0V, and the system runs from the same card (SD high speed, 50MHz)
with no errors in dmesg.

Following your comments, I tested again without this patch, and I can
no longer reproduce the problem. I tried U-Boot 2025.07, 2026.07 and
2026.10, with and without patch 1/2, and three SD cards, including the
one in the commit message. In about 35 reboots from Linux, U-Boot always
read the card and booted the kernel. At the U-Boot prompt after a
reboot, vddio_c was 3.0V and the SD card ran at 40MHz, so the
conditions were the same as in my original report. I do not know what
was different when I saw the failure.

So I agree that 3.0V is probably not the cause, and I will drop this
patch. If I can reproduce the problem again, I will look at it again,
including the MMC side as you suggested.

Neil, sorry for the noise.

Best regards,
Shigeaki Asai

(This reply was written with the help of Claude.)

