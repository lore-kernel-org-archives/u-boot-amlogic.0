Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D74CA600C
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:30 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14497.1791463582918438461
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xL5KDuTt;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1956008f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463581; x=1792068381; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
        b=xL5KDuTtIXfkwMnKbWiDzqsTZHrYqmHEqcmz5BQ1c7/PzvZozO2LKA8TgHfDotnKil
         Fth4EE9Y/2kdeE3KXgIAD+qjbXKOQaJu/UdXykDa9hQnfB15wv6Kvoy7sMX0sSe/0pfF
         asGypv8K6A3E1Q/xsFYTgVJqGK8uOb9WoNZA4cN505Je+scwNEe7dr69Tb7ID/9RYrBc
         oeBrKxm59oeiaGYlJdaQGV2ARsPPblHRDbAGtL4u4PhbIEsiaMGxZkYIP1w+N8C5T7Ct
         r/mQTWMgkJBEziiQduLIgl257+Tnc7D5XNVHwZMSITluo54q3O8QO/9s+wENP7sVI6bJ
         LWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463581; x=1792068381;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
        b=rIChpEpODYvRChYAVsC3zXsj566VdzCQRTxYB1sJ0O+aAfR1DUK9XVgL0bPRPmvpKg
         zPM3MhgXKnp+n9OFITi9or/ZXCvjBRoim5zYkF61TJazBB86RbdbMM07YTGPvQpznqX1
         wKs+iszbS6rTLlU0eXrCu3sjv+MSFwiEk1RWCKsC/R4AD8hq4XJDSgVYE+D/6tM88VKL
         gpGUEkdGQaZKMMMTBLUj0+y3H8Ob8uK8SAMX/ADQImhKA6L+BYWYKtKXRfR7ptQsiNuX
         yM0/NfAMOK+qOdEYmbyYl1Co61h6T5Uf/4lkyclP95IQ0hiVyV6Fd1NCVjRXgQNGCSIZ
         zUXw==
X-Gm-Message-State: AFq9FYLDUi5LAhvryRohuSQep9HyomXlqLhxiEmQtUWif322bNalEurl
	vFg/pa7OMjRqD4obVc9UWgliRT9wsMItRaVd1kZ4o1Zt8zyFEYB8CZj57bVww9P2LzI=
X-Gm-Gg: AYBFou2FDvhE9iiOQRWGViMSdtUJmzT9Z2aX9POyaj1713rJXU1GZXSdpgmPmpZlHWV
	toIVhrMwLrY9k4ZAvjqGnV2K33pds+gtKOJFSUlR4+6wx5DfIuSE8h7R/uhYeXMS0e3nWpPfNOc
	rKD91OYP9opUvy0j6edfUWRcTWVLx3qYTQQIwyO/krA1xK+6+98xG2IljZSG0TTU8HB0ymb/dMA
	ydAAg0TL5mmIgh1U6XowoJ1RxVs6wd+50SPRaRjObqOIUfNkdY3l2Q922+qArLxrIh3ZFjw/O1j
	co7eR6tYfnaTgWZ/Vra4wmt/RlTXzP+hZXnftDERF6QdyiwgE51Ex/pteNT4VFax1X2qRK+7ixQ
	qc9Vwj2W+amkh2kW1eLeu+5iI9SNLHgiufEaBltAiXBcD6XT8KfugwUT1EjHSdGz7YElEzpjEDd
	qThE6SJUM8e1MgFp+yBS3DacajO1UuXCFju5laMnMmTpCnpHcvZ+XgEjn4SUm4xRTsX3khotATO
	DtBjOLYV/iISIBuhdcRqmPCynmMS+g=
X-Received: by 2002:adf:f704:0:b0:48b:26b:7f8b with SMTP id ffacd0b85a97d-48c7288ad00mr8740599f8f.57.1791463579587;
        Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nick Xie <nick@khadas.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
Subject: Re: [PATCH v2 0/9] arm64: meson: Add s4 support
Message-Id: <179146357877.183177.5146930302645374090.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3124

Hi,

On Tue, 29 Sep 2026 14:06:22 -0400, Sean Anderson wrote:
> This series (along with several patches submitted separately) adds basic
> support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
> patches on it is at [1].
> 
> I developed this for a custom board, but I believe a better candidate
> for a defconfig is the publically-available Khadas VIM1S [2]. Khadas
> has kindly sent me a VIM1S so I was able to add some more features and
> fix a few bugs.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/9] arm64: meson: Add s4 SoC support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0f6e4a9f1b3ba2314c58bcd66a61a8941508b58
[2/9] clk: meson: a1: Eliminate separate id parameter
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/81b3945a2096fba2ba8421641dbdabb5ad73740b
[3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/99bd1d3f515842e8801d6c8cfd556077b9ba219b
[4/9] clk: meson: Use soc-specific naming for common functions
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f615257213246dc741416b3e92a4e9e76d76d5f
[5/9] clk: meson: Export a1 functions to common file
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5dadc8a09b07f2bfa9bbf0d151b660c0beb92a90
[6/9] clk: meson: Support fractional fixed-factor clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/538d95ef9ed6413dbd735ca799dfad2fe8c6e001
[7/9] clk: meson: Support power-of-two dividers
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/10176b815d013d8825fd243ae20892cae35c249f
[8/9] clk: meson: Add s4 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5363c69e08d0f96834f4d80dcf23e11d64cfd80a
[9/9] meson: Add Khadas VIM1S support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c048da44bed99311355450d70840bb0795e21f8

-- 
Neil


