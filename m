Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D7C47DB0
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web11.122621.1703770643669780935
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=hCx74aEH;
 spf=pass (domain: chromium.org, ip: 209.85.166.177, mailfrom: sjg@chromium.org)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35ffb15244dso28108585ab.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770643; x=1704375443; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naYq6txQt+TXBe6iYe9hRukySgIcUe32LFBMW26ugKo=;
        b=hCx74aEH8RFqeDXE2oEFTdjzQnalJFH2Ewrfl/sE+K9WTr3MHxiNLyoxexjw/aDT18
         Uw8drd37TvKsNgVO9ft7n7t2LDd6f28269c24Zyv1sQDk1stb+XxyuXSYFUmU/E6uU0g
         7Je0+xNDsDbPkPjI+UtG2FGKk03Q8ge3/tr94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770643; x=1704375443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naYq6txQt+TXBe6iYe9hRukySgIcUe32LFBMW26ugKo=;
        b=YinXJyLvhfVh1LdowjIuFw8ou37MS2pGbyXSYlZEWmT8x/L88ZlA5BB1uIJgCLsCRi
         1p+WR1tOZjVCPCix47/hG1ePWiboBnt6ojtlZFdAWaGquLFodkJNs/qKRnhw4sb1sTce
         ePquYIuXWKeCImz8stNizECtsWnzdf3qNdt+ui97ceDJay5cRoPhWMhB9GJAJ588PyJd
         dLMwgtxAuHt9XKhdR8tvPq7PQ8K2Jz0EHCOO/2FSr4lVvADbTWtu4W7XUQMMZUB7j/lz
         9KfEda8rYC3swT43SVDUgH7zAoptkYDo2hjz4cRtPYgzUf/1AN2yg/L912YOMdJlg7W3
         B5MA==
X-Gm-Message-State: AOJu0Yw0tBLxmTP2XWu3MgHhuNrETQ4XJmUksWsTsMCbiUWNSRwqqNG5
	hytAGzQO0Qsma1JvnGZYJsQHFYuSTrcefosb778lO+pjKZRU
X-Google-Smtp-Source: AGHT+IHMX+lmDMPX7B/CjwaJCv86iPyZJd3KPoNVBY59Npy80BmlTaWdVrMxfG6YFxvkjSbWVTJjoOOs0gh7B6uEr6U=
X-Received: by 2002:a92:c54d:0:b0:35f:ed80:9ce3 with SMTP id
 a13-20020a92c54d000000b0035fed809ce3mr13548329ilj.50.1703770642981; Thu, 28
 Dec 2023 05:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-3-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-3-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:10 +0000
Message-ID: <CAFLszTioYajRMo7DBhaVA_zJsB11bbsJQTSJFWaZDF+M76DO5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Makefile: Add support for DT bindings schema checks
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1991

On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> This adds the build infrastructure for checking DT binding schema
> documents and validating dtb files using the binding schema. Here we use
> devicetree-rebasing directory to provide the DT bindings.
>
> Dependency:
> -----------
>
> The DT schema project must be installed in order to validate the DT schem=
a
> binding documents and validate DTS files using the DT schema. The DT sche=
ma
> project can be installed with pip::
>
>     pip3 install dtschema
>
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems::
>
>     apt install swig python3-dev
>
> Testing:
> --------
>
> Build dts files and check using DT binding schema:
> $ make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Note, at this point dtbs_check is an optional build target as there are
> many warnings generated due to custom DT properties used by many
> platforms in u-boot. It is expected with these checks that compliance
> with DT bindings to take place. Once that's done it can be added to CI
> builds to remain compliant with DT bindings.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - None
>
> Changes in v2:
> --------------
> - None
>
>  Makefile             | 20 ++++++++++++++++++--
>  scripts/Makefile.lib | 17 +++++++++++++++--
>  2 files changed, 33 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>

