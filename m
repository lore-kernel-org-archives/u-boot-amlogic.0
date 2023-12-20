Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA42C46CD2
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.15314.1703047654220721839
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Dec 2023 20:47:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=maCxStb4;
 spf=pass (domain: google.com, ip: 209.85.208.54, mailfrom: sjg@google.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-552ff8d681aso641879a12.1
        for <u-boot-amlogic@groups.io>; Tue, 19 Dec 2023 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047652; x=1703652452; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hG8sMVI/wdZ9EHHXo86q9ig2COrLrf7M/uzPy/hBW1s=;
        b=maCxStb4QqdADM5kLqyeINXay6dKEeMqbsHz7BK0FrCHrU4V6/568/5Z4beLZtUTzV
         a9tMEO+dv2sqijqd3o9HdPGvb74R+WPWNoFps2lmJIlx7HFy562wttOvzaQ0w05U8hnJ
         ONuwiQzJTPpXQFlUPw0W8jSffUSAYztq4IHy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047652; x=1703652452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG8sMVI/wdZ9EHHXo86q9ig2COrLrf7M/uzPy/hBW1s=;
        b=ZUZV6lVxI4MR5uGQ2O9BKACS+yp5cJOgfwTD4z307Po7GlabbNTAFmPHPwOz2sC5go
         de4jl855lGlvR3AyyaiHxTmUqgrW6jfjMCirXNDspQdO7gUcPn8d3/zAszu8zYtksaA/
         NhFbXhywHvTtrDWxQHvhlS07WBsAm+MA8yZmgi0obXAh2vAdd3yD2V+7EN/fPgX3ug4j
         glG2LzdLh5NKmmrQ7nYSU55cGkxNZHhMcEZNjr1o7dJFZry3R7rxT9VDIT/2enu/Pdft
         Ylc9RRxzO6kZdOsYQM2Z+akXydgY/wFtzU7fK4AjxAz9vA63j6AJJZof0l8LqqJUWDkA
         cpBw==
X-Gm-Message-State: AOJu0YwqP28O+Jt5Abh7iUJ76dNfKSu0myD/3w1mTjN+oubT5R4IlVGz
	eUZuvNnelj5IP3/3kW27a7zvRyiA7QGqc50jXj/4QsVK8H7t
X-Google-Smtp-Source: AGHT+IFOMoRnR0hdj977q053KH7ahcLOhq38ncIR8qu8M7KdteRl/xBMSHyXTvFNJKyAdPVBvKetgXn43zG+tcIRxc0=
X-Received: by 2002:a17:907:a2cd:b0:a23:75fa:c16c with SMTP id
 re13-20020a170907a2cd00b00a2375fac16cmr2420702ejc.34.1703047652706; Tue, 19
 Dec 2023 20:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org> <20231214135103.1606605-7-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-7-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:20 -0700
Message-ID: <CAPnjgZ2d4P4gtAFVYqAhuuZyt5+ryqadpHHxjEbpyxGaCKiGLA@mail.gmail.com>
Subject: Re: [PATCH 6/8] MAINTAINERS: Add myself as devicetree-rebasing maintainer
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1952

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 969514468cb..253092c345c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -951,6 +951,12 @@ F: cmd/cyclic.c
>  F:     common/cyclic.c
>  F:     include/cyclic.h
>
> +DEVICETREE REBASING SUBTREE
> +M:     Sumit Garg <sumit.garg@linaro.org>
> +S:     Maintained
> +F:     devicetree-rebasing/
> +F:     dts/arch/
> +
>  DFU
>  M:     Lukasz Majewski <lukma@denx.de>
>  M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
> --
> 2.34.1
>

Reviewed-by: Simon Glass <sjg@chromium.org>

