Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70067C47422
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.10432.1704889876835196899
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 04:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NcSKJ6wW;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: festevam@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b93b04446so924079a91.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704889876; x=1705494676; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T36dLWCiyrx+sSpiXUNNFdckMW3PfF6G27hpmvrNOUs=;
        b=NcSKJ6wWwgkZiKjSpzocMS4LFtpQmuOszyfsVy8r6acR0U6ybJoEgnLOQV3l+SE9J7
         UAGlRK5asZPBq2CoXjpcT/nCsTkMMD37L78k19fbM7suaQO63CDq9XcDtxeN1gKbfg7B
         R1bpZhdfak6iO0xty4iKrFMsOq9pWhsFkRmYafTGf6mAlvAYhYu3GkRjaTN3JZGrI+fU
         QSE2JPaP1UoxOnly9KQElrj15qQEchyyMcHvQWKys7X0MwGZ095n/L9ehgEuQcNuDhFd
         ai2NWW95rb1t+X6yw5EkxyldIJTChcKnoq6ccw1EVMXMQfiV7GasokMSiLiPK+pGHfj/
         K5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704889876; x=1705494676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T36dLWCiyrx+sSpiXUNNFdckMW3PfF6G27hpmvrNOUs=;
        b=XSCGI67nYr1IXXc2sXvMRY8JEJih4y6Fq1ZEUd5nPyBQ5W48U3Itx/N8WLMRv57Xgk
         DQbb47Keetn9y6pZrJdYzjvXcvwnGp1qQ1J1gp11SxyHIigI4dbe/fn2xrNCnsvca9zq
         NW3AE4F/yqVKyu6IZAsywQsHd+jzBs605hspowzenOwuK/eA/lvWGQhcKvpVPIv3QX6+
         S7rhq7cIjow3QS4WdN2FSElibICPY9E0DTNNNVSWN6nMnXlDwLnxmNL/7oyGRe+jRWEj
         9ZxRrr3Q1HWB4f6/fc3ex3pNItlrN1KekdP/qbNUyem4imm2W001QHw15TqsuwAzdj9Y
         lXQw==
X-Gm-Message-State: AOJu0YwHxdiGQDreddmHsr+9bZ4ZpWYuCrmU1E+OV/VJBjYDeGfIqtxT
	JXl3EmmF+sNAXE4xYHXDVCykQ8jQesz1UTUw7h8=
X-Google-Smtp-Source: AGHT+IH7KVVFV0dTh/AF6R8FHwDmdB9tPTI5Is8JonGKIDgDmJSK5YLFwPJhwSTyR7hJH9RtSt05dF07wgOMnUVcOy8=
X-Received: by 2002:a17:90a:e396:b0:28c:ee93:7575 with SMTP id
 b22-20020a17090ae39600b0028cee937575mr1476644pjz.1.1704889876204; Wed, 10 Jan
 2024 04:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org> <20240110103547.719757-8-sumit.garg@linaro.org>
In-Reply-To: <20240110103547.719757-8-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jan 2024 09:31:05 -0300
Message-ID: <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] doc: devicetree: Align documentation to use Kconfig options
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
	mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2069

On Wed, Jan 10, 2024 at 7:37=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:

>  History
>  -------
>
> -U-Boot configuration was previous done using CONFIG options in the board
> +U-Boot configuration was previous done using Kconfig options in the boar=
d
>  config file. This eventually got out of hand with nearly 10,000 options.

It seems that the original text should be preserved here.

