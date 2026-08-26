Return-Path: <v@baodeep.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14710C61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:00:03 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7550.1787731192539181314
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Aug 2026 00:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@baodeep.com header.s=dkim header.b=pgXiCytQ;
 spf=pass (domain: baodeep.com, ip: 185.250.0.168, mailfrom: v@baodeep.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 183545F1EE;
	Wed, 26 Aug 2026 10:59:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
	t=1787731188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zcfonYc9M4Dkdj7ZylbclR+HgWl+ToRre9quSXy/vJM=;
	b=pgXiCytQOK8qRz3Ss1qjOlhBODR23k6NFBan9/Cr0dl5nQFf7HMXk+lDiTanMV9zTH6Uaf
	W1V34LT+BX6YUnJLl7JXBLP4TfPQxtnZLjkll3zecMT8ONZLHhEZk/x6XUN/2Xtx3UH6Fz
	HOvZX6PmFywOSeJ86dAZ6UM4pyree+2UIw0q4cgQFnTgRhLsSTUGpDdKe+oJMBiGHTqmqZ
	WjEPMywm0jR+EZJhxNNvCJvjoYLCDprJoVzECicD5vmJYlLrxSIy7EGk0Sh0TdUs/8Lz5o
	qvjS8w77kd6HrGGKeJel7Jh8EzMeFqCsMH+5aEiipIsJYVaV/cojXJPEJHQLMg==
Message-ID: <c6a38536-b1af-440b-83ab-f0ca05975637@baodeep.com>
Date: Wed, 26 Aug 2026 10:59:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 12/45] doc: board/amlogic: jethub-j100: update
 product page
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Soeren Moch <smoch@web.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-12-ee7573fe3a4a@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20260825-linkcheck-v1-12-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 08:00:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3061

Hi!

25.08.2026 19:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The original link is 404, replace with one I believe to be correct based
> on the info on the product page.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j100.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index cbf1ea761077..053d5aa57ec7 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J100/J110 (A113X)
>   ===================================
>   
> -JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
> +JetHome Jethub D1/D1+ (https://jethome.com/d1p/) is a home automation controller device
>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> 

Reviewed-by: Viacheslav Bocharov <v@baodeep.com>

