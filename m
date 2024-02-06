Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00032C48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 09:40:47 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
 by mx.groups.io with SMTP id smtpd.web10.15518.1707197244525128483
 for <u-boot-amlogic@groups.io>;
 Mon, 05 Feb 2024 21:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=am+205r7;
 spf=pass (domain: linaro.org, ip: 209.85.221.171, mailfrom: sumit.garg@linaro.org)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c0184e27fbso123363e0c.1
        for <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707197243; x=1707802043; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs62gTzX4rbhqeYwanBX7CqrlYec5j8ZYSDncgb/OR4=;
        b=am+205r7FnkJssppuBdbhwr8EDEd7OHlo7oiDsromkf59f2S04ajr++xi0mhzF7ATU
         3seB3MGHhfH7+o2XPGGWvk5euHdooAb8VxRzeY3EkG5tjqwPE5GNAWo8wlgTP8YNTnZY
         BTgTGcCinpst0mR7jilWs4qxq6lpDtSlwKIU6HnBpzKHnSMp50oq46Cmyb0IDBI14gFV
         X/zV2nJSEc8PaQIQRL0Js+6N9AaFx0/qQeBZdRZ2JGmu1emFrJj1ojiBi4jHnI4G6JvY
         RXp5rn7aSsMTrT502wSJJZo3jNSWbd5z7NVbPTBv+T1xtI/erOnhDSwhluw5zRT0U6Lc
         nY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707197243; x=1707802043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs62gTzX4rbhqeYwanBX7CqrlYec5j8ZYSDncgb/OR4=;
        b=ZbIcHUTU7DneEVNHtSQ1elr/Hr0xQfVHCepaVnID7WjBp228HOKfgZM3YbnNEoziGa
         M5uVzjNK+oiuCtxIqt2IM76yWA8KVdAcB2txXF+1ZqIeCfpJu9fF8x71N8u+Q/VmWUrw
         tViqEtCDxQIQmNcj194f2pEevFUzcmoQD8Sf9HA9DRX3qTOhlCLDFg0O6BWRMI8nOeus
         FchAn5TgSdgt8WAwBsq3f/i3UsdGSC3q6vkEIfdoZOtp/8ISdjDZ97cy7CDUJgrmz267
         tXYgK61DY+MB5AE2LzhP1Ps2o3TgDs1P6x54M0E0juuw1rAMiKQmEPQjjxLGnTGjADOT
         hXuQ==
X-Gm-Message-State: AOJu0Yxz80urGr1wouDojTXWKiswByuLtgD3/IjE014/CNBoZcz492lc
	o1XSktPtQcQ479Pz+lkm3vEIvqcwh+WNefsglS2WtkkLhnE6/r9WLqNg87tUxu9YD/rfMK0wmhz
	0DKNnA/MS+NPnoZBaD8sd75Hxp52/yGSoVkk/p5bvCQHgTgzRaWM=
X-Google-Smtp-Source: AGHT+IHMKvD9PAhoTt4KezO7bu9FNq84kDYgqXAvdKGo9aGPV2w1Yeqc6Xh1lgCcdvKO5jmIMe4HGzsorSJXv3dibGg=
X-Received: by 2002:a05:6122:30a6:b0:4c0:3929:2748 with SMTP id
 cd38-20020a05612230a600b004c039292748mr2867893vkb.7.1707197243480; Mon, 05
 Feb 2024 21:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org> <20240202180226.GF1152441@bill-the-cat>
In-Reply-To: <20240202180226.GF1152441@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 6 Feb 2024 10:57:12 +0530
Message-ID: <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance within U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
	nm@ti.com, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 09:40:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2118

Hi Tom,

On Fri, 2 Feb 2024 at 23:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:
>
> > Changes in v5:
> > --------------
> > - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> > - Created v5_dt branch for testing purposes:
> >   https://github.com/b49020/u-boot/tree/v5_dt
> > - Patch #6: Added support to cherry-pick fixes in subtree update script.
> >   Also, used https:// instead of git://.
> > - Patch #7: Fixed inappropriate documentation update.
> > - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
> >   tree.
>
> OK, for v6 please push this through CI. I've started a run now to check
> other things, but just sandbox currently fails to build right now.
>

Yeah it looks like patch#3 rework in v4 has broken EFI capsule .dtsi
file generation logic which should be fixed by add-on fix [1] for
patch#3. The github CI passes [2] with that included. I suppose the
gitlab CI should be fine too. If its fine for your testing as well
then I will incorporate it in v6.

[1] https://github.com/u-boot/u-boot/pull/484/commits/d796c34307cd363674e0d0d2e31618643ac8e76c
[2] https://github.com/u-boot/u-boot/pull/484

-Sumit

> --
> Tom

