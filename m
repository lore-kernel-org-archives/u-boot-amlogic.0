Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
 by mx.groups.io with SMTP id smtpd.web10.11119.1695899302308065467
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 04:08:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1695899299; x=1696158499;
	bh=jSDOgdU52fjwuwNmZN7XJFZsRYTVdapfUrqf2bS1K7o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CQqCi57DfgMYC5aqMqDSaohc3jT7NjlcHttnhGwaYlQeFu6NBKP3fwTMxCKw0V1Js
	 1jz8Gd7sdsSalIfR4gogmhoV5uKiUeKJZCWzwFhpilVjBo7m+2kwgYj302GcRrZzc4
	 ByIrrzNTxlYHgpJqgjvk9oLT8LetxHYKyYeSedOut2hV3shr9LfiMYMnJxfKcPCTH6
	 lfPSiVkxrG30IDOaoUVdPg/L8LPwCGB7XmoEddm0oj6+ffInVRB8o2fVCkGKSOc80T
	 +RNs1KZppwUMn4S6m3Hua6DJdNaRT7uGCYh3yJahvGgtya944sowWJyTPywjjGMCBG
	 LU8Flf4beGGKQ==
Date: Thu, 28 Sep 2023 11:08:11 +0000
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: Re: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building SPL
Message-ID: <CVUI3MZ0E9QQ.3RDSILF3MHWN8@flaptop>
In-Reply-To: <20230925215516.1528643-1-jonas@kwiboo.se>
References: <20230925215516.1528643-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Mon Sep 25, 2023 at 11:55 PM CEST, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meso=
n_mmc_probe':
>   drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_powe=
r'
>
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
>
> Also add depends on DM_GPIO to fix following link issue:
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pw=
rseq_set_power':
>   drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_na=
me'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined refere=
nce to `dm_gpio_set_value'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined refere=
nce to `dm_gpio_set_value'
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

This issue was discovered while working on SPL support for Amlogic
devices (not upstream yet), which is why the errors are related to
the `meson_gx_mmc.c` file. It doesn't seem to be an issue specific to
meson_gx_mmc though.

Cheers.

