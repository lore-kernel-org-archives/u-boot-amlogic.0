Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB6C48277
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.78822.1703584046297154366
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 01:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=PT5s5QzO;
 spf=pass (domain: chromium.org, ip: 209.85.161.54, mailfrom: sjg@chromium.org)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5943a178d57so1833298eaf.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703584045; x=1704188845; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCcOk3avGBoxUXMcLDtiiSpaj81G/YGPh648fwpZ87Y=;
        b=PT5s5QzOCFCpWwAiV2MAtu1uUGKhRXRFZu83j9OV1LJmHPMiAS2rxe3FMJ66IoirXo
         73KGpq3cDBHf7gnTKOcQVsTidzc4Xu5AoFo5FUoTxHSPp63yzm1PLZNQr0C0JKuiapc/
         KT6XCnLllD9wdFSxthQ7eb2e+ktKbVKX988G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703584045; x=1704188845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCcOk3avGBoxUXMcLDtiiSpaj81G/YGPh648fwpZ87Y=;
        b=b+SNAUb1ZECHN8OMVy120+Wk6J+J8wjgjchfPe/8TexfTOa3ebXNJR940MV1AkOwRS
         wOvPDzTlXd/QxnU+n2s0hq7paU151iahHuBgj49c5MwaRQlDa5grcVfhRTexysvd83NU
         uZ7+pobXAuLONDAqvcK8ga0zdhm4W445aikJGU+fAQ3c9pnHEsx2W/PLY4QB/DbonbQX
         mI8ufqDajinPirVaRFLZ0kbpw5ckMd+F1xRXBSsuEhzrl96jSPaTwZOLqH1zyegBSS/v
         W/TQ5fzQq5Ijcgy2UKkVdezk4IOxHXGlir1PJLn0gY/1sCjh4hhiwlSdL8dTNTbUGUrr
         C0uA==
X-Gm-Message-State: AOJu0Yz5cp3y8K6dxTlnwse2krjqD6PF+mZc+lDGeBkjDk9uHW952g4L
	Bo1w9J+N+wQHAraRy2UbZL/yXwNJa9CpdtjF8KUa0d3inhyYbrUHxRTiOIdp7Q==
X-Google-Smtp-Source: AGHT+IGEGtAGDpw834xiENy2zwwciEIqHsLgUDOhZ1XF2wvf5VvUcUp/hwFsW9RAY8EfAomtBTfLFk36bxg10UM/Nok=
X-Received: by 2002:a05:6358:7e8d:b0:172:a4c6:124e with SMTP id
 o13-20020a0563587e8d00b00172a4c6124emr4163888rwn.14.1703584045591; Tue, 26
 Dec 2023 01:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org> <20231222061208.3009970-4-sumit.garg@linaro.org>
In-Reply-To: <20231222061208.3009970-4-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:51 +0000
Message-ID: <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
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
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1969

Hi Sumit,

On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Allow u-boot to build DTB from a different directory tree such that
> *-u-boot.dtsi files can be included from a common location. Currently
> that location is arch/$(ARCH)/dts/, so statically define that common
> location.
>
> This is needed for platform owners to start building DTB files from
> devicetree-rebasing directory but still being able to include
> *-u-boot.dtsi files.
>

This is a v2 patch but I don't see a change log?

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  scripts/Makefile.lib | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

