Received: from ocn-dfr-mts-208c1.ocn.ad.jp (ocn-dfr-mts-208c1.ocn.ad.jp [210.145.249.208])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33754.1793149480425563832
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Oct 2026 18:04:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@docomonet.jp header.s=20240125 header.b=tyXQQr1e;
 spf=pass (domain: docomonet.jp, ip: 210.145.249.208, mailfrom: y-asai.0816@docomonet.jp)
Received: from ocn-ckd-mts-211c39.ocn.ad.jp (ocn-ckd-mts-211c39.ocn.ad.jp [210.163.245.40])
	by ocn-dfr-mts-208c1.ocn.ad.jp (Postfix) with ESMTP id 7D76E7000020C
	for <u-boot-amlogic@groups.io>; Wed, 28 Oct 2026 09:58:50 +0900 (JST)
Received: from ocn-spm-mts-205c1.ocn.ad.jp (ocn-spm-mts-205c1.ocn.ad.jp [210.145.246.230])
	by ocn-ckd-mts-211c39.ocn.ad.jp (Postfix) with ESMTP id 40B9620002E3C;
	Wed, 28 Oct 2026 09:58:45 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
	s=20240125; t=1793149125;
	bh=DlfN4F3QwYla2rxXts8khULYIia6QFD/yEbQ+/YYGfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyXQQr1e69DFgsSWJXX+dgNNa6J9HC2F9ZkkDlxfChk+iXYLeh1xzcFxX5eDWKpT+
	 FkweVsgyNhcBBghz3AWKzoGJwej2rdxxCgFfiLgsBEfy1LjJSDZll/YeXVGuB/9bOW
	 a6u60L3lwrhdAr+vSCnXNZN0rOS2tm4zqQ65nCg0=
Received: from ocn-vc-mts-210c1.ocn.ad.jp ([210.145.250.232])
 by ocn-spm-mts-205c1 with ngmta
 id be2382af-18e28ba0fd9f8720; Wed, 28 Oct 2026 09:58:45 +0900
Received: from ocn-sdpx-mts-202c1.ocn.ad.jp ([210.145.249.135])
 by ocn-vc-mts-210c1 with ngmta
 id 50dd90fe-18e28ba0c26bef2e; Wed, 28 Oct 2026 09:58:44 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
	by ocn-sdpx-mts-202c1.ocn.ad.jp (Postfix) with ESMTPA;
	Wed, 28 Oct 2026 09:58:44 +0900 (JST)
From: "Shigeaki Asai" <y-asai.0816@docomonet.jp>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
 neil.armstrong@linaro.org,
 jh80.chung@samsung.com,
 peng.fan@nxp.com,
 kever.yang@rock-chips.com,
 sjg@chromium.org,
 trini@konsulko.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
Date: Wed, 28 Oct 2026 09:58:43 +0900
MIME-Version: 1.0
X-Mailer: HidemaruMail 7.47 (WinNT,A00)
In-Reply-To: <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp> <20261010013237.2269021-2-y-asai.0816@docomonet.jp> <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de> <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
Message-Id: <4DD66777AE0BE92F3006A@docomonet.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 28 Oct 2026 15:27:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3142

Hi Quentin,

Thank you for your reply.
I think this was caused by my mail settings.

I will send v2 later (with the 1/2 patch only).

Thanks,
Shigeaki Asai

>Hi Shigeaki Asai,
>
>On 10/16/26 3:05 PM, Quentin Schulz wrote:
>> Hi Shigeaki Asai,
>> 
>> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>>> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
>>> LDO_REG9 indexes past the end of the table. Its voltage reads back as
>>> garbage and it cannot be enabled or set.
>>>
>>> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
>>> registers (bit 5), and its voltage selector lives in
>>> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
>>>
>>> Add the table entry and handle LDO9 in the enable and suspend enable
>>> helpers.
>>>
>>> This patch was written with the help of Claude (claude-opus-5-5).
>>>
>>> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
>
>The patch never made it to the mailing list, c.f. 
>https://lore.kernel.org/u-boot/ or 
>https://lists.u-boot-project.org/pipermail/u-boot/2026-October/thread.html, 
>can you please fix the consistency issue and send a v2 and make sure it 
>hits the mailing list? This is fixing a real issue, even though you 
>don't have a need for it anymore, so I would like to merge this but I 
>cannot if it's not on the mailing list.
>
>Thank you in advance!
>Cheers,
>Quentin
