Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA9C636F2
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web10.25867.1700533043952929037
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Nov 2023 18:17:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=HtmVXOEs;
 spf=pass (domain: google.com, ip: 209.85.128.182, mailfrom: sjg@google.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5caf515ca1eso12139137b3.3
        for <u-boot-amlogic@groups.io>; Mon, 20 Nov 2023 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700533043; x=1701137843; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fv3mYhjDSzdmxJyMG5tjNXFES5UfYKl3ZJ3N4qfRjig=;
        b=HtmVXOEs3LewFcirG2ZvtzxoGHTNSFPc9sGQ3EJGnQIItPe9b4Ch5ZTRbBjFMFT72X
         UPm6bKzDGoMW00SLcjer/6qFoqeH/IOuIZdd5XRrzdB5I4WZuesZ+3xMhVqEWP3aKmrr
         5evm7Cu7VOMr1SveJYf1dNsZy3bhWNkWtqtcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700533043; x=1701137843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv3mYhjDSzdmxJyMG5tjNXFES5UfYKl3ZJ3N4qfRjig=;
        b=Fps+830CBafVbk0TPSmFCd+W/RxsXFzwyKfqaCO3hrywWq3cxcC2WNM8RZlHPbdLl1
         qry1McjH7gVGCWduaRVJtxRPeYohlOjum49lUazayWfTjg4ICAW+2ySijT126FSjCRde
         i7S0/XCoUr+h+i0pRCSrM4NCMVI0mra41BpS5tC16NGaudNkPKQN0hu5Pwqhlelmxiyy
         xgBREpQgTbhz5GCNAJ0nPL/XW93h9uqzjzjxocN9kaKnqs4zCFpMvPLPnHaASAlFpsGD
         8g7zhejV+h2w60f2WANYf0tdVLmxxgRBm8N/Na5jluTbgLqYLiqTLFSdtuhARS/d14Gu
         iFrw==
X-Gm-Message-State: AOJu0YyemnaWe7E4xz53bOTNCxlmqFe9hLYwci/NhK83GyC2UcwWmVJj
	Et3ZEpcmCEazzxOX+4R06ks3quA583iegtdS0ZmNS3HDmLnObsvhDiw=
X-Google-Smtp-Source: AGHT+IF9VUCQUKCzXSUE1jNQnxhwhU/P4bnOBHvVoHAV+SDyb8YDUOPAInlX9yfnujDh/ot9dVpLEYMop7xejmHVZ0w=
X-Received: by 2002:a81:bc4b:0:b0:5cb:23:d28f with SMTP id b11-20020a81bc4b000000b005cb0023d28fmr3232780ywl.14.1700533042946;
 Mon, 20 Nov 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com>
In-Reply-To: <20231120201609.619598-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:06 -0700
Message-ID: <CAPnjgZ3mHpFXEsEENT348SynV2FfZ3ckXHoyFQBfknPC6+HPCg@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
	u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1884

On Mon, 20 Nov 2023 at 13:16, Tom Rini <trini@konsulko.com> wrote:
>
> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> eventually display this information
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Posting this as this was the easiest platform for me to test some SMBIOS
> related patches on and I needed to populate the nodes so I could check
> things in dmidecode once Linux was up.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>  .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
>  configs/libretech-cc_defconfig                |  2 ++
>  2 files changed, 25 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

