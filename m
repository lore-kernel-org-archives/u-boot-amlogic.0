Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DADCCF2E0
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 07:36:14 +0000 (UTC)
Received: from ocn-dfr-mts-118c1.ocn.ad.jp (ocn-dfr-mts-118c1.ocn.ad.jp [153.128.190.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1259.1792213636287030280
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Oct 2026 22:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@docomonet.jp header.s=20240125 header.b=j91kzGWj;
 spf=pass (domain: docomonet.jp, ip: 153.128.190.140, mailfrom: y-asai.0816@docomonet.jp)
Received: from ocn-ckd-mts-118c31.ocn.ad.jp (ocn-ckd-mts-118c31.ocn.ad.jp [122.28.129.96])
	by ocn-dfr-mts-118c1.ocn.ad.jp (Postfix) with ESMTP id 9936318F
	for <u-boot-amlogic@groups.io>; Sat, 17 Oct 2026 14:01:47 +0900 (JST)
Received: from ocn-spm-mts-107c1.ocn.ad.jp (ocn-spm-mts-107c1.ocn.ad.jp [153.128.190.238])
	by ocn-ckd-mts-118c31.ocn.ad.jp (Postfix) with ESMTP id DC1154C0067E2;
	Sat, 17 Oct 2026 14:01:42 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
	s=20240125; t=1792213302;
	bh=BjAA/43We5TqdIijW3xSxA/znQy2v21D5Zxp2DlvnAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j91kzGWj5wH1q9lL5RCxyI6OibiWYqqdkt0bH+JhXK/TXsA/BHB7Xtra8ZIwhyor7
	 vfsgY0NKfHCdti+TVR1zqRAwcWJG/aGlamuJ9kDuoTpVjvGiKTmsbBAVAX0cEIuAxZ
	 gBVl8oXtxWBdAAeIyPCjjcaQDX50icIx2gsW7MQM=
Received: from ocn-vc-mts-109c1.ocn.ad.jp ([153.149.236.232])
 by ocn-spm-mts-107c1 with ngmta
 id 03dcc95e-18df3880dc5eccbc; Sat, 17 Oct 2026 14:01:42 +0900
Received: from ocn-sdpx-mts-109c1.ocn.ad.jp ([153.128.117.199])
 by ocn-vc-mts-109c1 with ngmta
 id 2b9e6cd3-18df3880a7f4fd29; Sat, 17 Oct 2026 14:01:42 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
	by ocn-sdpx-mts-109c1.ocn.ad.jp (Postfix) with ESMTPA;
	Sat, 17 Oct 2026 14:01:41 +0900 (JST)
From: "Asai, Shigeaki" <y-asai.0816@docomonet.jp>
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
Date: Sat, 17 Oct 2026 14:01:41 +0900
MIME-Version: 1.0
X-Mailer: HidemaruMail 7.42 (WinNT,A00)
In-Reply-To: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp> <20261010013237.2269021-2-y-asai.0816@docomonet.jp> <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Message-Id: <CDD5DF499196292F3006A@docomonet.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 19 Oct 2026 07:36:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3137


Hi Quentin,

Thank you for the review.

On 10/16/26, Quentin Schulz wrote:
> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>> +	{ 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, REG_BOOST_LDO9_SLP_VSEL, NA,
>> +	  RK818_LDO_VSEL_MASK, },
>
> Please stay consistent with the rest of the file where we have
> everything on the same line.

OK, I will put it on one line in v2.

>> +		if (priv->variant == RK818_ID && ldo == 8) {
>> +			mask = RK818_LDO9_EN_MASK;
>> +			ret = pmic_reg_read(pmic, REG_DCDC_EN);
>> +		} else {
>> +			mask = 1 << ldo;
>> +			ret = pmic_reg_read(pmic, REG_LDO_EN);
>> +		}
>
> This is not great, I would prefer to have some additional configuration
> in rk8xx_reg_info instead, but since we do it for many other cases
> already, nothing for you to do on this issue in this patch.

I understand, thank you.

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thank you. I will keep your Reviewed-by in v2.

I will drop patch 2/2 (see my reply there), so I plan to send v2 of
this patch alone, after waiting a few days for other comments.

Best regards,
Shigeaki Asai

(This reply was written with the help of Claude.)

