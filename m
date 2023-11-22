Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76481C636CB
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.34189.1700683356070728260
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Nov 2023 12:02:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UpB8wvaO;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: pbrobinson@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50abbb23122so105667e87.3
        for <u-boot-amlogic@groups.io>; Wed, 22 Nov 2023 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700683354; x=1701288154; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOexmxQKxiAf9chOv+PhgG9cWkgZX/PAwbTyJnDhTrU=;
        b=UpB8wvaOYekdRe54wYR3U//WswlDkMCG5ckLQjhtqc9Thz5i7YIeyc5moCR1LBbs9P
         2Dve13uE9/2RgEf2W0dftnGhNfyhTP6MlsRGJ/4gOVtETro9Hk8W+2MarzjVy6bDtEnl
         HiUmlQ6YiUteycikBKEaXmyCIZ/hYxJT9r3TmvW0eMoyi1d1I49uvGxJk1s3yunG1VT5
         WzlJ/LMV1NxNGcS1o3vrU+qgXn8aavoLLdcf7+iQOHixhNYy4BBE/TRQqxr79jcYxgXa
         2q+nrxtlQb7CcLcMJIgVq1MyRoBfBZPwTfheAllhULU7d59jqWzgP821ITMpuLTg6qGq
         HjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683354; x=1701288154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOexmxQKxiAf9chOv+PhgG9cWkgZX/PAwbTyJnDhTrU=;
        b=k7nlpyj8OF8ytq9tcLDwh+YN5EIUg1ig36+skquXUjyjngjVXvrFvqDYBwX5gjkBx7
         xU+nUYlUohPKEDMf0tz5a5+4UfgI1qdrtRe3MUSCMo9+TY2NNYMWy3jJR8LFYnk34dQC
         Cro1Wt65T5AVchWdrqeHrsabMmEu9KAdoZ1wmaJyj2c+yik5y3aQZKSOI/Dd8l85xcgS
         uD4nWG40W1pSndWxzycG/m7/OZpip8YihXP52uSgi5vsjilZPLDEXEmRA2qGFdSzjrqy
         j8pJOICE9eMm5eD2nc6b9vca8uOVe6qusuHqLS89yF+NuZUyefvX3TruyETbOs1AJ8hP
         yTmg==
X-Gm-Message-State: AOJu0YwpsPRNXvnH6K0nZ128dfxBFWZGtLvlqx0Plq8b0X3ozLeZ3e2s
	nKOJ1jK8/mH2PRLPwaG6ace4R6MuafCcKML8/YE=
X-Google-Smtp-Source: AGHT+IHAz4nm6KgyLsc02wlODAY4tUpGfNXkPZXYEKAY0/jbWuEQTx9IsLbA5W9Qe8O6FCyWBYouKJx329iphLSVxcI=
X-Received: by 2002:a19:f818:0:b0:509:8e22:ae5 with SMTP id
 a24-20020a19f818000000b005098e220ae5mr2313454lff.60.1700683353875; Wed, 22
 Nov 2023 12:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com> <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat> <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
 <20231121140929.GV2513409@bill-the-cat> <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
In-Reply-To: <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 20:02:22 +0000
Message-ID: <CALeDE9PGErp+wDRR3VDvHNZc6_3ph=vDuvR-dk3TAWBrppayoA@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1888

On Tue, Nov 21, 2023 at 2:50=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 21/11/2023 15:09, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> >> On 21/11/2023 14:15, Tom Rini wrote:
> >>> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 20/11/2023 21:16, Tom Rini wrote:
> >>>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux c=
an
> >>>>> eventually display this information
> >>>>>
> >>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>>> ---
> >>>>> Posting this as this was the easiest platform for me to test some S=
MBIOS
> >>>>> related patches on and I needed to populate the nodes so I could ch=
eck
> >>>>> things in dmidecode once Linux was up.
> >>>>
> >>>> Sorry to be late a the party, but can't this be dynamically found fr=
om DT's compatible & model ?
> >>>> Since I'll probably need to add this to all boards, it seems like a =
duplicate of what's already in the DT.
> >>>
> >>> Part of the "fun" as to why we have the binding here is that while we
> >>> could use the top-level model property, there's not a corresponding o=
ne
> >>> for manufacturer. I'm fine ignoring the patch I posted here and havin=
g a
> >>> longer discussion about populating SMBIOS more usefully, globally, as=
 I
> >>> think has been suggested a time or two.
> >>>
> >>
> >> I'm ok landing it with the same data as from the vendor.
> >> but couldn't we use the first top-level compatible as default smbios d=
ata ?
> >>
> >> compatible =3D "vendor1,board-name", "vendor1,soc-name";
> >>
> >> and translate to:
> >>
> >>
> >> smbios {
> >>      system {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
> >>      };
> >>
> >>      baseboard {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
> >>      };
> >>
> >>      chassis {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
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
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2=
-ilias.apalodimas@linaro.org/
> > which had a bunch of comments on 1/2:
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1=
-ilias.apalodimas@linaro.org/
> >
> > But I think that since then some thoughts on the subject have changed
> > and that approach might be more welcome now than it was then.
> >
>
> Thanks for the pointer, seems I had the exact same idea.
> Hope this will be re-spinned, I don't want to add this to the 45 amlogic
> boards when we have the necessary info already available and documented..=
.

Fedora has carried this patch for some time for the same reason, a lot
of the tools in distros around support use dmidecode for HW
information and reporting "Unknown" meant there was lots of reports
against tools all over the place. I'd been asking Ilias to upstream it
for a while so I'm in full agreement here and he did mention he would
resend it soon :)

Peter

