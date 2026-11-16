Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33255.1794850689576018482
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Nov 2026 09:38:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=dVccOX3Q;
 spf=pass (domain: brivo.com, ip: 209.85.160.181, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55d3563e50eso19729201cf.0
        for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2026 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1794850688; x=1795455488; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
        b=dVccOX3QQ0+Me1eCcYo8NPGM+NUbJhBUDXQ34+bm2TJ8wHoQQQa/i/KyEZDSXw44vp
         aU1TuiqpruRHZO6KvKIys2K6FaKklSAdY79cqoWiUN7+fPbnVT40TeI3yM/lV39dpZNN
         Zf+BUOLYFyKUI+OOrKNjc3qdlm0NHhj73uEapWvszjXmNlhLNtNbITRzRFRcQM4yrOvw
         3Z2V5Ae2j7bGpBOMoF+PSIXpnGQSrfEPAynDkLdfZibmDTXrmpL8198coxXv3uR3vsbX
         0bYJ0gq78O0jPBqUQnHnuhFr9m5CrNOCNkZV41qWsfIdb8mdrxNew76JeKRs/u3qu9J/
         vyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850688; x=1795455488;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWrWC3lzaF8CJDmn/jBFTNALT8i6GCyPPmYIVsgcP7Q=;
        b=TirXQ8iB4s+SQ5d8kC691fwCzR2E9M7NTJZmml4F/sqUFLXAHitpirQLA9a9qcbOjY
         hLtSw8XFMLRAsQ0OyesNnPzSc5KFjR3Ohfn3gF/U1927WS+6t4RxbF4xtq1HQAX4WXO+
         hU6Bs/gKFwER8NMb7HalH9rE3PUv2IfpENDhvBSPsOI3q8TRtHRu+SgZgOOncDOb06li
         JEs3EsrqlrifbBNfJhZQV8yTwxQsrD6C95RIg87xN6YxZiVAFHzuvZKadVvI7y7Fev5u
         D61SgtG+NuxceKhATLpfy7x6kV9pCTUqDkaH8nvYHJwp8WI4QTcF2M0SFFCw6Ab2eNai
         C5Xg==
X-Forwarded-Encrypted: i=1; AL+hErG1Q5NfLFkTSaMnfXBAUQGJmGJiVwT0KoarZ+LtXt3WEJoxoFF4YxNhB/ekKCbMAwLnEqM45714nNIq2Vtbjw==@groups.io
X-Gm-Message-State: APuU4Z/xyrdlbEPCo/SLsQB0fOHnEqv3aYPURB5xqP8V1Y+zvuj+2NPN
	sTf9U8suhal9jszBSULE3qfocSkeprMc2FpFkbpNYV+fmpuGSlzpIgIl48Nyl+zEyB09Zn89OpU
	zDfut3geRQ2u2jIztkuhqpTVWsF8eF2af8PkMdwDdgG679XFwwy33bA==
X-Gm-Gg: AYBFou0iA/eXBlvWHbVYArdxskdNY1TZz2SH69yKA8TrzGEhidgcT7PI23ovvi7sdDl
	R+xiejch9SfDlyl8cMosUCfuKk3J4XPQU17tR68PDoLZRG6EIE+AbRtiVtlPLJ9ofyRzQ6jT87S
	BdgoiPjb8NzrFYVTX22y3VcHThbfnzBuQukWf+48rUhX220X6FBKs+McxWuDJT8jQtRvhcXjsB7
	uHmglu82BN1LcYoHJotr1daZ9aucN28Aj6JGlouhltVYlbcatWosgF/MM5tlesTAkaQLnTv9yiP
	saBCI5Yq1kOVtobv4/+7WBGP/HKailcRIyyi72BOvS8rX8oyDwxCU+hAVFzQE4YonzhBOk5BzPy
	uKuFGxYetoRyJfBlnYTu/AOj78TtWu7E4/WoMjgeqjjlvlPIxrblJfGES1ex5PU24yM2or0brgr
	eFPxoxFxg1hJYcA4dVGH+frhISPeEMAOmax4NN/blq+VEmq9KBVcVIJ2Ju37OAcfSi4d3YWnBTT
	eslotaLOte3cjyTq0GtrCKVo8aKBfphGe8iBfrQu97HI39hgy7JktB8xFpd9jiAGx2EwOsSMsjI
	v2lPC23tBjPp6eBgLNdznaiZDckak6MtoDNv
X-Received: by 2002:a05:622a:410c:b0:538:684:448b with SMTP id d75a77b69052e-55aca76a647mr187231811cf.60.1794850688108;
        Mon, 16 Nov 2026 09:38:08 -0800 (PST)
Return-Path: <sanderson@brivo.com>
Received: from [10.200.233.210] ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d459c6sm91704356d6.14.2026.11.16.09.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 09:38:07 -0800 (PST)
Message-ID: <7beaba3e-14e5-4e6d-bdd4-9f082d261d68@brivo.com>
Date: Mon, 16 Nov 2026 12:38:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] clk: meson: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <20261116173546.3487841-7-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <20261116173546.3487841-7-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2026 17:38:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3151



On 11/16/26 12:34 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sean Anderson <sanderson@brivo.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot@lists.u-boot-project.org
> ---
>   drivers/clk/meson/a1.c          | 2 +-
>   drivers/clk/meson/axg-ao.c      | 2 +-
>   drivers/clk/meson/axg.c         | 2 +-
>   drivers/clk/meson/clk-measure.c | 2 +-
>   drivers/clk/meson/g12a-ao.c     | 2 +-
>   drivers/clk/meson/g12a.c        | 2 +-
>   drivers/clk/meson/gxbb.c        | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index b6d1887c98a..01f364f8a8e 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -224,7 +224,7 @@ static const struct udevice_id meson_clk_ids[] = {
>   	{ }
>   };
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_clk_disable,
>   	.enable		= meson_clk_enable,
>   	.get_rate	= meson_clk_get_rate,
> diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
> index 5f897d89e9b..e72eb839cfe 100644
> --- a/drivers/clk/meson/axg-ao.c
> +++ b/drivers/clk/meson/axg-ao.c
> @@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_axg_ao_clk_disable,
>   	.enable		= meson_axg_ao_clk_enable,
>   	.request	= meson_clk_request,
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 3b5f4af9f4c..8aa3d18eb9b 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -300,7 +300,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_axg_clk_disable,
>   	.enable		= meson_axg_clk_enable,
>   	.get_rate	= meson_axg_clk_get_rate,
> diff --git a/drivers/clk/meson/clk-measure.c b/drivers/clk/meson/clk-measure.c
> index f653fc63552..743fe6f310b 100644
> --- a/drivers/clk/meson/clk-measure.c
> +++ b/drivers/clk/meson/clk-measure.c
> @@ -591,7 +591,7 @@ static int meson_clk_msr_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_msr_ops = {
> +static const struct clk_ops meson_clk_msr_ops = {
>   	.of_xlate = meson_clk_msr_xlate,
>   	.dump = meson_clk_msr_dump,
>   };
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index d9425f900f3..c0f11ce6928 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_g12a_ao_clk_disable,
>   	.enable		= meson_g12a_ao_clk_enable,
>   	.request	= meson_clk_request,
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index b1ba5881904..1ac2b39c417 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -995,7 +995,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_g12a_clk_disable,
>   	.enable		= meson_g12a_clk_enable,
>   	.get_rate	= meson_g12a_clk_get_rate,
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 62c1e0eed4f..5c2601e79d5 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -949,7 +949,7 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> +static const struct clk_ops meson_clk_ops = {
>   	.disable	= meson_gxbb_clk_disable,
>   	.enable		= meson_gxbb_clk_enable,
>   	.get_rate	= meson_gxbb_clk_get_rate,

Reviewed-by: Sean Anderson <sanderson@brivo.com>
