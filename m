Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7519BCDB482
	for <webhook@archiver.kernel.org>; Sun, 15 Oct 2023 10:33:25 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.69830.1697307602494049041
 for <u-boot-amlogic@groups.io>;
 Sat, 14 Oct 2023 11:20:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@google.com header.s=20230601 header.b=3a4Cp4dt;
 spf=pass (domain: google.com, ip: 209.85.218.41, mailfrom: sjg@google.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso547466566b.2
        for <u-boot-amlogic@groups.io>; Sat, 14 Oct 2023 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697307601; x=1697912401; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww3JHLhyJZ4AnzCsx8RF2cOhvATK4y38QyVl99tfrFA=;
        b=3a4Cp4dtsg5PKqGN5CXgFsPqOHXTMMhm8Tsm11iai9LsAWRtgd2+UAzffZ9pYiV6sV
         rvQtKLK3/2Gv22wLYvNvLvl2tryvh1yLNtJhojEenhxN8W7cQLST6J+t1j7EG/xbMC5C
         86ComxninsuiNgXRfCdlh1kGmzeUuDBskb9amNmacdZhvj+UJ20wzh3qYJ/xp2IUproW
         5OojBGMTAZ2Ez05kHdmIhDln8WrgOwUaTnJw9rCDHYaL3HSjgtV9B1KYI5ePg8TIaRXE
         cHNltFk4td5iZ/Isex+Yyeta+8R0or4swZJL2IxiCm7aExqvUAswPHb7PsTb+wH3ue+5
         OOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307601; x=1697912401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww3JHLhyJZ4AnzCsx8RF2cOhvATK4y38QyVl99tfrFA=;
        b=fiDhaogkzAOPOgC/awsidHmO2pWwrd6wUAql0emxXWUBh4IFhVjNujsnBsuHpro0wW
         gfcUHlqS8uKx3pZQ9YcxzKm10LHunorKJdyE64leoZ3yRJ7rN2iIyaf7YQSWAczRxPqf
         yp+41zQQ6wmT9kf//UhFqj03fI28+QzZZXl98bW9QkEnawsv2PpUqOYQYM8/8+Dw+BTo
         MExAUvnPpGZWd465DjHFTxror1kKIovtg/A6Za9LZgyzToi0Dbi5DJY5YACKSOvtrEl/
         ubV+d9FgLH1ytJM07RsLnAfn2196y69IWG2W8LpyyRqW036Qe/pPnv/647FWO7YPEI0f
         kmWw==
X-Gm-Message-State: AOJu0YyVbg9JjAeDejL0suhDfaGG9iYUSnozvgM1OWc38mpzNoOfQQJr
	3H/v0gF+y3GmtUOEScHy6q+yJDDljCkQw0QW+t5DmohxWkxmSQClAX8=
X-Google-Smtp-Source: AGHT+IGpwIV6OO/9sVQxC5EN+/Y6ZUqA8tPgxDfINPenPFc6HdKLXxyA+9dmcY9bxRZnbNEWEYD4r461HyG1k/52LaU=
X-Received: by 2002:a17:907:d1a:b0:9bf:990f:ea11 with SMTP id
 gn26-20020a1709070d1a00b009bf990fea11mr538306ejc.19.1697307600619; Sat, 14
 Oct 2023 11:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231013130411.46569-1-avromanov@salutedevices.com>
In-Reply-To: <20231013130411.46569-1-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 14 Oct 2023 12:19:42 -0600
Message-ID: <CAPnjgZ1n9F5CdB3KQHsaC0WCn8bkP24YFV7Z23Y3hGyzYgzo4Q@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: don't compile Secure Monitor UCLASS unconditionally
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
	u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 15 Oct 2023 10:33:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1758

On Fri, 13 Oct 2023 at 09:57, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> It makes no sense to compile Secure Monitor unconditionally.
> For example, this break the SPL build on boards with a small
> allowed SPL image size.
>
> Fixes: 126fbbefd89e ("drivers: introduce Secure Monitor uclass")
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

