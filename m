Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.499.1794240154339376910
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2026 08:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@baodeep.com header.s=dkim header.b=DqiB4M36;
 spf=pass (domain: baodeep.com, ip: 185.250.0.168, mailfrom: v@baodeep.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1436A33EC8;
	Mon, 09 Nov 2026 19:02:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
	t=1794240150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0+TsU8RcF40B0MjbzqTGoI0K+wCZQ91px5Jrfv/6NMc=;
	b=DqiB4M36AXezp8KRlHEcGwYwSXcFERlIcXq8ycKoCTOlgvg6WX4BY6eYW+Q8IHKjHW2a5p
	+ajW3wLfRfj2/pgO2wZUKtl82oFsJhnrA3urdFw/KDk5FQfndNmpVUODgR7YG4lz665Eff
	z8iRcWm/EBC8J7GbB6m/0iemBHd1Bj87jqSteJrSlBSFQaiB8/JtKBIBXEZeCH37yhRpy0
	ose+fgdKRLt76fKRCLftc0AQmKlGWrU4TJOPu53a+CiaIryV3tCFhCh9v7UKF7Qc1P+h5I
	obRi8Arg+2wI4js0eHzGc04deuYn22+nViD6S2Hr1B9mcdnImX/an7ePPScC5w==
Message-ID: <1478d4f1-e07a-4abe-b539-c8c703a9e05a@baodeep.com>
Date: Mon, 9 Nov 2026 19:02:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: board/amlogic: jethub-j80: update shop link to
 .com
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Viacheslav Bocharov <v@baodeep.com>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
 <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2026 16:02:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3149



09.11.2026 17:43, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Use .com domain as suggested by Viacheslav.
> 
> Fixes: 1a33ee41ecd2 ("doc: board/amlogic: jethub-j80: use redirect link directly")
> Suggested-by: Viacheslav Bocharov <v@baodeep.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j80.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
> index c3800f9588aa..2e8b9a5dddb8 100644
> --- a/doc/board/amlogic/jethub-j80.rst
> +++ b/doc/board/amlogic/jethub-j80.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J80 (S905W)
>   =============================
>   
> -JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device
> +JetHome Jethub H1 (https://jethome.com/h1) is a home automation controller device
>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> 

Reviewed-by: Viacheslav Bocharov <v@baodeep.com>

Thanks,
Viacheslav
