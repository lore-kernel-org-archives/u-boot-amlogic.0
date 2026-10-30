Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16921.1793381104585715917
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Oct 2026 10:25:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=Y7E8Mcg+;
 spf=pass (domain: 0leil.net, ip: 84.16.66.172, mailfrom: u-boot@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSTy2WZdz6gg;
	Fri, 30 Oct 2026 18:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1793380678;
	bh=0RLwoLhkubsMfpP2cOMR0F4RpznHPz8xW7/I6Pivb6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y7E8Mcg+bAFPQA/N8IemYEKg34yCboeFqezVwSiCmuMcVVl/Q8PNiYL9BKSKbf2YS
	 aFKQ92rZBy+PV+Zf8q94DqBswUiTZby01YTKqPNAuRPrL0C8/DcH7PnSRRGAFYTeAX
	 GZ6+iW3r/D51+FnkxD5UVJn6mzsku7NDaNN5Zq+7jakTYrwyCzSw9+gQYefqdSkqDr
	 GJ7VXJbVRxuQ7E3dR0hi3aK0eXT3KVbfX640SaAZ3Q5mh53E+Z/WGKTUCLSfn2I818
	 51HmhyxOEwS7fJgUr7XqghMEOfIg7qXeUyhIyuXE4c73rgBPyMR+ZyPS9KKw06FYZI
	 G69IMHBVpaJzw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jGSTw4tH3zZQ7;
	Fri, 30 Oct 2026 18:17:56 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: quentin.schulz@cherry.de, u-boot@lists.u-boot-project.org, 
 Shigeaki Asai <y-asai.0816@docomonet.jp>
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org, 
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com, 
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
In-Reply-To: <20261028020618.2844987-1-y-asai.0816@docomonet.jp>
References: <20261028020618.2844987-1-y-asai.0816@docomonet.jp>
Subject: Re: [PATCH v2] power: regulator: rk8xx: add RK818 LDO9 support
Message-Id: <179338067662.786412.9023930308177381461.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:17:56 +0100
MIME-Version: 1.0
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Tue, 03 Nov 2026 08:47:56 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3144

On Wed, 28 Oct 2026 11:06:18 +0900, Shigeaki Asai wrote:
> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
> LDO_REG9 indexes past the end of the table. Its voltage reads back as
> garbage and it cannot be enabled or set.
> 
> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
> registers (bit 5), and its voltage selector lives in
> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] power: regulator: rk8xx: add RK818 LDO9 support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/a7d8b31958518d93f425369c0c76e76109d3981f

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

