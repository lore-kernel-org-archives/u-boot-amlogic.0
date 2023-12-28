Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF6FC4725D
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.122627.1703770663770899206
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=XAvf24qc;
 spf=pass (domain: chromium.org, ip: 209.85.214.181, mailfrom: sjg@chromium.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d430bac207so24340495ad.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770663; x=1704375463; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy84thRsphcaIQxe/QfNnfX2G1q2+y/VW1q+OS51VcI=;
        b=XAvf24qc5jfqKJ/0MNrcjc8PvTtLzHe/QXBsUjJJ2M0X4Ibdu8tqU09LAoq/EHwkxB
         1cvU12m7ue7M6V2fg2fXnQuMwTa2pfO4zkIRSwwjEg3EMcepr0YJBcSvxYWfDqoqtWZj
         pJHrVTk424C7pTlan8zD5HYAeRQZ1AdPk2tO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770663; x=1704375463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy84thRsphcaIQxe/QfNnfX2G1q2+y/VW1q+OS51VcI=;
        b=lxvHnxw7o3D6TdRwv8e+ksX7xV35L6sBenLztqCWN+XPV/crhijLpK0DFML8FepBAO
         CZLqUwwaAiaoIEB2yy3Xzz3Yv04j2avKwUo7Nj2UaeDxdOcfe3fVuavv3nozD1sv0mbg
         7dKzYxXcO+d6z/cSDpjvnVKdbcud+23f4BCHygDJxLX+PEHwx/rJCi8ifMbvp6MCWXUN
         /p1mkVCKLUldXTPrqUoo9RkV0uvb9j2+sJBPOiTrEqqn3DtFtseztHG7YIoa2SD4lwVW
         mWSPiF5JxtEa3LeNCcg0R0zXB9GdUiO05nBJNVM9eAhPqLqUCQ+dBUJqghFtT5sB5MKn
         Oe/g==
X-Gm-Message-State: AOJu0YyC2bJhUiTSgQOwjbNcgvj2M6Yi5L/f9X+7whzLWFRVjCcsUBhA
	tLjcBgsZ1imlevisH0pp4/rvzG9zyspTiQWIRShIB0m7P0XJ
X-Google-Smtp-Source: AGHT+IFf1Vv8Be804vdB8DOuJBlD3TbwNqBsdpaZD2pEpVGoF03u+veiLHPfctGlB+7ADpPNfj48lYm7klQqcYO3dGA=
X-Received: by 2002:a17:90a:d2c4:b0:28c:3620:b5ee with SMTP id
 dj4-20020a17090ad2c400b0028c3620b5eemr9908325pjb.28.1703770663297; Thu, 28
 Dec 2023 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-7-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-7-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:11 +0000
Message-ID: <CAFLszTiLyy6GNOnvYa_8OsAC0mN1p63QWQtf2-toA0AJFhm3EA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] MAINTAINERS: Add myself as devicetree-rebasing maintainer
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1994

Hi Sumit,

On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>

Please can you add a commit message?

> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Picked up review tag

BTW 'patman status' does this for you.

>
> Changes in v2:
> --------------
> - Picked up review tag
>
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

Regards,
Simon

