Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D974C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:44:19 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
 by mx.groups.io with SMTP id smtpd.web10.37099.1737526845357358861
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Jan 2025 22:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=p329+NdP;
 spf=pass (domain: linaro.org, ip: 209.85.217.45, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4affbc4dc74so3814946137.0
        for <u-boot-amlogic@groups.io>; Tue, 21 Jan 2025 22:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737526844; x=1738131644; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0y5rTPIweGann6oq8+gN36Tmp4hLahaeOE41Olhbu4=;
        b=p329+NdPP7nGcq1z6PChnHwy90If5/solfoH/pEn52B4j+bi2obq2sN4hWY2TrJ7yD
         wBzNNHlPDPRphDcIvlJ6kw47BWs9oS3j2oLM2lk6gy88AFsmg6/zUNSC/0i4pUSlEQSf
         twQXxYxlWgjV2DcJzpLy1YaN4MH+1XfDt11onhPILJS1FyIflYPJ0anYdT0jwbgQ8eux
         hzjmJ9P53EAzhAbFbL7lLVtogKafZCkUdd6VVI2uWkAPZP+0542oKjaLAuE8EG9o0huf
         7IZaOYUU8E6qcrJDbyPWW1fWHgzbPQO7piJ+oTRihIZ8/ihu+WwzIQWiGVjS2wDpo9AF
         Q30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526844; x=1738131644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0y5rTPIweGann6oq8+gN36Tmp4hLahaeOE41Olhbu4=;
        b=CbY2zY6u2HUxpPus2FgBX8iVvJHISKHgd8+NWwxKxqKZ1tzQWYum4PUdiT0vy9HLj4
         7z4QcjtqYbogAjYGds0OM/KLbGTDPx+V7vTtjxlgxj46sOihONvt/2TAHEa+RH1aikAG
         RU2gPj2u+kDpGXEd7iZ7OEYa2OC6/foSa4FzO3Omul5DFf1XpOuLN1MKNYMXQPP8+T0U
         NcoNFzV5vYBqSSvszBHtiELdwZDn9I3u2QqeurVQ30gyI+O+H7ikwuRepsi/kzU5r5eQ
         J5nKaczyL4CaICHgTBti7sxpaewLA0IcsgKlkwBAjokqCmXty/FghPDEJPRGRvP1IvTi
         Eocg==
X-Forwarded-Encrypted: i=1; AJvYcCWgGAHvBdkLevQg94Ouq1jnn+zCCP3y4cpMQ8ZG5eG+2GDAlcUhnuwkVIGlwi47J/TxN9I4jVy52efg+iF7wA==@groups.io
X-Gm-Message-State: AOJu0YxUv5h2J39P934BOKy63deTm9BmxAByugE3IxL+as//eZ/EGaTz
	RexR/HvG/z6bGLOUduRktJ+FKREFAWmrQApD+WXKY+4po5lM05u+gmpQyfGleRQB7woLhtLgzvh
	KVA4FzCS9o+bOOtyR+AYkszS2NkSeJ5hsU7Qvtw==
X-Gm-Gg: ASbGnctqVC52KcGqbYBIEa0PE3cr3ZVjTTbEMJqqS9hQ2DHJgm3sFfgMNMbCfS0ahyD
	DAogQMpnKJmg4yTGgyKZjoD88CW9EMDqIQW82p7GgideedaWm1vD9rA==
X-Google-Smtp-Source: AGHT+IGuBPZgRPp1D3nhedpEJ+seND1LTip07KKc3umKUovX44+1TS0FQNVMAO66mPMtnwzplrjZK+uGEPqB1vamZfg=
X-Received: by 2002:a05:6102:d86:b0:4b1:1b67:6a5c with SMTP id
 ada2fe7eead31-4b690c77495mr15728123137.18.1737526844294; Tue, 21 Jan 2025
 22:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20250121203147.4133618-1-trini@konsulko.com>
In-Reply-To: <20250121203147.4133618-1-trini@konsulko.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 22 Jan 2025 11:50:33 +0530
X-Gm-Features: AWEUYZkflzPz44vyXcXgSBu-GqKDVkI5YLQ-xuV2dLI26OqV7af_mUWc9sLhe-A
Message-ID: <CAFA6WYNNMvYNEdPRhaUWasgmS-74U3-sssoq8NYqON-t81NTLQ@mail.gmail.com>
Subject: Re: [PATCH] Squashed 'dts/upstream/' changes from 9b6ba2666d63..8531b4b4988c
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, u-boot-qcom@groups.io, 
	u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 30 Jan 2025 09:44:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2616

Hi Tom,

On Wed, 22 Jan 2025 at 02:01, Tom Rini <trini@konsulko.com> wrote:
>
> 8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
> [snip]
> git-subtree-dir: dts/upstream
> git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
> ---
> This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
> and so match v6.13 release. Changes and changelog omitted due to size,
> and everyone who is listed as a maintainer of a platform with
> OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
> being marked as spam, hopefully.
>

Glad to see DT subtree resync, it has been smooth up-revs then what I
had expected initially when we introduced it.

-Sumit

> --
> Tom

