Return-Path: <v@baodeep.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70BC5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 09:11:21 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8540.1787735473773708247
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Aug 2026 02:11:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@baodeep.com header.s=dkim header.b=mPQGJyST;
 spf=pass (domain: baodeep.com, ip: 185.250.0.168, mailfrom: v@baodeep.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0867063DA0;
	Wed, 26 Aug 2026 12:11:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
	t=1787735469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YE7RpPz4p6yIUJsfP4ab1d3oVtE7ljukm2LMBUcwt1Q=;
	b=mPQGJyST+SmnMqref0qEqMXrnDqEXARlNIzjTaQ7jJtuI2EOzA7q+8JGbSLHMXiEosXIYC
	2QnXEk7UcJb4BcKtC+VefPgJ9PEag3njOl+t1rstng7vgMvirr3Rj77EB00T81RJOmJPKg
	r5/1inT0ZvxWRAo8g80Tyzjfq+zzukNlrThzkU5U12RXya6nqFHzJ4yZI3A7fSK+sj8B7Q
	wGbEqMq/GMJQ3kRMAizHcPyhPs7qx1y8YL/1ctmW90/LPx7NU/QDhjiWN9mX94HafiDpHI
	vjCi+66zRd8VtXVBQr1okPj1bftAUtaE2m/1VrZj7NO33dXAMRmilOBAt3/4+A==
Message-ID: <c87b16af-5c6f-4e65-86de-39e585b64616@baodeep.com>
Date: Wed, 26 Aug 2026 12:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 13/45] doc: board/amlogic: jethub-j80: use redirect
 link directly
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-13-ee7573fe3a4a@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20260825-linkcheck-v1-13-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 09:11:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3062

Hi!

25.08.2026 19:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The product page link redirects permanently to something else, so avoid
> the hop by pointing at that link instead.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j80.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
> index 9195df690502..c3800f9588aa 100644
> --- a/doc/board/amlogic/jethub-j80.rst
> +++ b/doc/board/amlogic/jethub-j80.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J80 (S905W)
>   =============================
>   
> -JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller device
> +JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device

Please, use https://jethome.com/h1/

>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> 


Thanks,

--

Viacheslav

