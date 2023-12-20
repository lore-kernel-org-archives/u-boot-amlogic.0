Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46CC47070
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.19414.1703071681723243348
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 03:28:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=O31jYBGw;
 spf=pass (domain: linaro.org, ip: 209.85.128.172, mailfrom: sumit.garg@linaro.org)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e811c5c1adso12578647b3.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071681; x=1703676481; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfDLIE52bS8HvDhc6h/xvsuBlhtPG04nzterLLUGczo=;
        b=O31jYBGwaC0GXr/2Ig9ymUKfALKnFnXHAna4fGbjfBWnhe0+DKUrbMUKLujj6+79Vz
         ZjAns2G7219hM+9sY71Q+iYECbPrgbQFcTpNweRTKja44lxDhpyQLKoTmD8ACjtnmntF
         H7gyDNp1XfnbEDBDM7UAu59LQv2Drn+xgV5NHurUyCdExk2ApMDKI0BN6nr8Z9KMImSL
         04kU2HWmPEt2QLrBBS+h/5b02e6rB4WJRtgQOJ23ognahD8FsIAYjdqqAw7fSUIzEObg
         ePnwQwd4erX0RqFfdQk2PoXgNzn4+g7JJXgnI6mbCLbC1FO2BcWGkns5Msi5pgoCbDRC
         LYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071681; x=1703676481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfDLIE52bS8HvDhc6h/xvsuBlhtPG04nzterLLUGczo=;
        b=NO++qqZJ7vwMPpUAysvq+nICGekFVWIS1EloqsC8Wz2xN835H6l5JMEugcJL187ldU
         6YwH2ZzhpGu5XQmigiSK0RVaMm4hJLm879Skiptn33SCZLh4aZlIjCdVZE78zMqZOkul
         rql2W7h/sW9XmbvTv9uW3C2cX4YEYLTi3Ec+TEFer6vA4uYdyW27qBzcBW/jSIrLMCP2
         fx/7SQ7b6cNpEjfknWyRhdMNUEo5ihbhJtii4UlrCxSch8J0DV4IGLiJZ1InzipRg+ya
         eO9nHWzqtDH3KUD0RtkrF+a8jhK7XBMaGI4PGZesof+BAdRhVHCSSd18vAE5zZkUuLTF
         Z4xQ==
X-Gm-Message-State: AOJu0YzfzaY6PMZr9KXUzHWpILAJUsLA+iYWAGMYif8U9NA7zEJYEr4D
	ja00SdDiyzlVFKG2wCMxhUqv9MnEt6lueUYU82AsjQ==
X-Google-Smtp-Source: AGHT+IF/qoQCEJYf7aDwidLASTj7RR73NkX9AgNDY+/8Bv0rigRpTUvDHOzXlpsN2vKzS4i0Ez5rEcBMhBVy5wG0rx8=
X-Received: by 2002:a0d:d882:0:b0:5e7:e1da:53eb with SMTP id
 a124-20020a0dd882000000b005e7e1da53ebmr1699134ywe.88.1703071680937; Wed, 20
 Dec 2023 03:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-3-sumit.garg@linaro.org> <CAPnjgZ2v5WZ4aEOTqrGB7mxdmVAMYsHc8A7+YgUKubL51dp9WQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2v5WZ4aEOTqrGB7mxdmVAMYsHc8A7+YgUKubL51dp9WQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 16:57:49 +0530
Message-ID: <CAFA6WYPWVf+=Y5fLnhFJHsfZoqb6w8rvLOb_=G5zzU858B67pw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Makefile: Add support for DT bindings schema checks
To: Simon Glass <sjg@chromium.org>
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
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1956

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:51, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dtb files using the binding schema. Here we use
> > devicetree-rebasing directory to provide the DT bindings.
> >
> > Dependency:
> > -----------
> >
> > The DT schema project must be installed in order to validate the DT schema
> > binding documents and validate DTS files using the DT schema. The DT schema
> > project can be installed with pip::
> >
> >     pip3 install dtschema
> >
> > Note that 'dtschema' installation requires 'swig' and Python development
> > files installed first. On Debian/Ubuntu systems::
> >
> >     apt install swig python3-dev
> >
> > Testing:
> > --------
> >
> > Build dts files and check using DT binding schema:
> > $ make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Note, at this point dtbs_check is an optional build target as there are
> > many warnings generated due to custom DT properties used by many
> > platforms in u-boot. It is expected with these checks that compliance
> > with DT bindings to take place. Once that's done it can be added to CI
> > builds to remain compliant with DT bindings.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  Makefile             | 20 ++++++++++++++++++--
> >  scripts/Makefile.lib | 17 +++++++++++++++--
> >  2 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 750bbdb1b71..d8d168cd4c3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1158,12 +1158,28 @@ endif
> >         @# disabling OF_BOARD.
> >         $(call cmd,ofcheck,$(KCONFIG_CONFIG))
> >
> > -PHONY += dtbs
> > +PHONY += dtbs dtbs_check
> >  dtbs: dts/dt.dtb
> >         @:
> > -dts/dt.dtb: u-boot
> > +dts/dt.dtb: dtbs_prepare u-boot
> >         $(Q)$(MAKE) $(build)=dts dtbs
> >
> > +dtbs_prepare: prepare3
> > +
> > +ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
> > +export CHECK_DTBS=y
> > +endif
> > +
> > +ifneq ($(CHECK_DTBS),)
> > +dtbs_prepare: dt_binding_check
> > +endif
> > +
> > +dtbs_check: dt_binding_check dtbs
> > +
> > +DT_BINDING_DIR := devicetree-rebasing/Bindings
> > +dt_binding_check: scripts_dtc
> > +       $(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
> > +
> >  quiet_cmd_copy = COPY    $@
> >        cmd_copy = cp $< $@
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 16bbc277a9f..27b9437027c 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -356,8 +356,21 @@ endif
> >
> >  dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> >
> > -$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> > -       $(call if_changed_dep,dtc)
> > +ifneq ($(CHECK_DTBS),)
> > +DT_CHECKER ?= dt-validate
> > +DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > +DT_BINDING_DIR := devicetree-rebasing/Bindings
> > +DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > +
> > +quiet_cmd_dtb = DTC_CHK $@
> > +      cmd_dtb = $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > +else
> > +quiet_cmd_dtb = $(quiet_cmd_dtc)
> > +      cmd_dtb = $(cmd_dtc)
> > +endif
> > +
> > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FORCE
> > +       $(call if_changed_dep,dtb)
> >
> >  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
> >  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
> > --
> > 2.34.1
> >
>
> This is great.
>
> Can you put the commit message in doc/ somewhere?

As per your comment on the doc patch, this is already addressed.

-Sumit

>
> Regards,
> Simon

