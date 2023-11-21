Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F7C636CC
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.43295.1700579312634488658
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Nov 2023 07:08:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ne2p8oc4;
 spf=pass (domain: linaro.org, ip: 209.85.167.48, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50970c2115eso8144168e87.1
        for <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700579311; x=1701184111; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vGT0NpFUMgYkrYUeDgaGq+Q1+63290QnrrCH8cu3isI=;
        b=ne2p8oc47GzSb3qw15i/m737K794Sf2LOcEHJdjSeTSWm0Oxd6QxLCsg4RooMs56W5
         98CRRO3tq05utRBEWdYok2Ljb6kCiQQLpvojUoTH4405QaGF32oiBUskB7bQv8vGUIBn
         0gvAh6Xc9J86X+X2AcwpoU0p+PloMPzfXJgEdjnMPGGz0mxmXI4No/9e1LkTfOTBWrg0
         Tek1z8h2CJRWCO0T9c2Lxm08G8Lr8Klk0c9Gkb4LWwCOQojA4fBk8zFOv8jmNriGN07z
         XgDrjCfyQgt8qrvwy3I5hDEDvBcuMI8EZtq3+2EdygFF/5SazB0BLT95OSkORGO0opLC
         1fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579311; x=1701184111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGT0NpFUMgYkrYUeDgaGq+Q1+63290QnrrCH8cu3isI=;
        b=NNKlHzdQm3FI8QXzVhMyAaVkugBSk3Gb7jCp/nEwjGkVH0VnXNV2EYvhd3S0IvCe/D
         nD1W7R0DItDQ9oGtsYl+PYjgrqaM6HnSm5MvgYkV/nn0KpUTyxT5Ui15R8AQG4Bkr1bm
         VQHlQUFUAril20/F7NESFfToqn63ZN+D/+6KrjPp4AtgXTlWLdzRPN6pY336ZhSWYLo3
         b7bsSx8JEvRto1CdMMLEwQnFbSMMUsNhj0+AaUrGz05Q7oCQfxYWYOavvHuQZvRpr43q
         RXkQPYu00GGW8eRyCowhrCpMm7n8BHEJ61Yf+L/ouZdwoJmbjfPtoKr9sCb/Lbg9fEcl
         wXVg==
X-Gm-Message-State: AOJu0YzL5AzO0tSICPOBZWBgWIGymtU/Ds7qNprs0YBIsuXvMW/BYDxi
	IN9EmiINWnUTUkeF1MQn62CBwXjlv1uxFWIA4M4fpA==
X-Google-Smtp-Source: AGHT+IHNWFRMQaod+sV0GpUmSzPlzajdj3ASduJL8dvLYn0evqmFD9GsloB+KkdcprAGNbj6Qoe3PME+30r2irUsicQ=
X-Received: by 2002:ac2:4556:0:b0:509:8a47:3672 with SMTP id
 j22-20020ac24556000000b005098a473672mr7240868lfm.34.1700579310798; Tue, 21
 Nov 2023 07:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com> <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat> <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
 <20231121140929.GV2513409@bill-the-cat> <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
In-Reply-To: <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 17:07:54 +0200
Message-ID: <CAC_iWjJn4g7V1QG-HZQx7hjgc9uFUPVZqMSQzC6PYgFgx3CPUA@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1887

Hi Neil,

On Tue, 21 Nov 2023 at 16:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 21/11/2023 15:09, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> >> On 21/11/2023 14:15, Tom Rini wrote:
> >>> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 20/11/2023 21:16, Tom Rini wrote:
> >>>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> >>>>> eventually display this information
> >>>>>
> >>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>>> ---
> >>>>> Posting this as this was the easiest platform for me to test some SMBIOS
> >>>>> related patches on and I needed to populate the nodes so I could check
> >>>>> things in dmidecode once Linux was up.
> >>>>
> >>>> Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
> >>>> Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.
> >>>
> >>> Part of the "fun" as to why we have the binding here is that while we
> >>> could use the top-level model property, there's not a corresponding one
> >>> for manufacturer. I'm fine ignoring the patch I posted here and having a
> >>> longer discussion about populating SMBIOS more usefully, globally, as I
> >>> think has been suggested a time or two.
> >>>
> >>
> >> I'm ok landing it with the same data as from the vendor.
> >> but couldn't we use the first top-level compatible as default smbios data ?
> >>
> >> compatible = "vendor1,board-name", "vendor1,soc-name";
> >>
> >> and translate to:
> >>
> >>
> >> smbios {
> >>      system {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >>
> >>      baseboard {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >>
> >>      chassis {
> >>              manufacturer = "vendor1";
> >>              product = "board-name";
> >>      };
> >> };
> >>
> >> since the vendor name should be already documented in the linux
> >> bindings, same for the board name.
> >> And we would be free to add some custom data in the DT if needed.
> >>
> >> Anyway, not sure it's the right place to discuss about that !
> >
> > That's essentially
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2-ilias.apalodimas@linaro.org/
> > which had a bunch of comments on 1/2:
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1-ilias.apalodimas@linaro.org/
> >
> > But I think that since then some thoughts on the subject have changed
> > and that approach might be more welcome now than it was then.
> >
>
> Thanks for the pointer, seems I had the exact same idea.
> Hope this will be re-spinned, I don't want to add this to the 45 amlogic
> boards when we have the necessary info already available and documented...

I'll respin the patches Tom mentioned once I find some time to address
the comments in v1. Hope to do it by the end of the week

Cheers
/Ilias
>
> Neil
>

