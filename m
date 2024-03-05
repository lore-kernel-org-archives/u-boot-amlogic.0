Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C57C54E58
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.22678.1709644511213221144
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Mar 2024 05:15:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yOIOiIzT;
 spf=pass (domain: linaro.org, ip: 209.85.219.180, mailfrom: sumit.garg@linaro.org)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso626989276.3
        for <u-boot-amlogic@groups.io>; Tue, 05 Mar 2024 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709644510; x=1710249310; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8eq13me9D0mT3pdn+HJ78Y033XhwtevLa9pKlcKglx0=;
        b=yOIOiIzTEpdNR6ta25kBI692EdZPZ0pPqok35XdWv/FhUvrJEkSdGwvefCQQD9A/t5
         BvFI024m740GMorfLtkcZSLZ9LRI1D7Dnu/5tkWrLhTpXWbfB2qZHAvJEeaF/Z5DWaD1
         EMzfb4fgZYBEU8rN0n8uhxzNBuaDirGQzJ5Ejpr9YucUvz3TMAiaoLx6z6mTvTyAwoFJ
         LZGUmzhYh9RK7VtakdgI4s/XzndzAILZ91oREgZ88mZBqeVB/mExPNXYLyyzHezdzZuC
         gJhvB1lxxVop5tpHjPGOQAFSceH1gE6afyF9d1EfRf5quCkFqN9eK4++5ngF6z0GLzpQ
         UbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644510; x=1710249310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eq13me9D0mT3pdn+HJ78Y033XhwtevLa9pKlcKglx0=;
        b=Aug3QTkzgIloLLbFr3vxHqy/ALbBC2z8xHJl+ZGLs+AKkffr8hYT+GfMBmTvXknAr9
         Eq6GUGYAfzrlMhP0zD0Ia95MlYrRPc3gEDbc14N4oHs7kxoStMrdaQGvLAxTycZbgdol
         bMj84cI6DrgUcF+cSYTLH/A6aPjumay2UI6f7kqdfpox4FwavUDSNba/As2652nUzTwf
         OAbzdXWCF2qEmSnoxdj9J7XNz7udteFT+qTcqRxgIxwL1eXIzJnImeVzle6VrJHJOs3S
         FIjhljVFG647UPt/21CWAN/QmOwcatg69zdSq0r8tcyxOqtWzJVvzRQtGkOBm/ZPBCj9
         BkNg==
X-Forwarded-Encrypted: i=1; AJvYcCXM5/slP3wv7JnMSOgx2/Crf3UunirLh0rDJ6u4ftQ7vTWkhQQzELb2FoFAUr0+GmAWqqUMtJWGxV3FVKcYZfK1vVaMZEc1Sog=
X-Gm-Message-State: AOJu0Yzfek29X0F3E5icfPd9s1HTg2J8LE06blPCNXR4zzhXXXodnl8F
	AkedS3dnGt/HqxhKlFW69tzRcIrS+XnqVHOKL3JP/aAy/SHBRJ+66IBJNSzPRKWZmoweFi3m4W8
	Ngjacy0JT5Y1/oJugahmC2MswwJdGsiQn+zJF6w==
X-Google-Smtp-Source: AGHT+IGpmcRKLyaEcw5hNNT7SJqVPPNVAYEJT86r3u7snoLb0aAl1p2KObnxrsncTIS2uy0D9ZVg3t2hpA/sh0Bkh+Q=
X-Received: by 2002:a5b:34a:0:b0:dcc:8e02:a6b6 with SMTP id
 q10-20020a5b034a000000b00dcc8e02a6b6mr9884996ybp.2.1709644510384; Tue, 05 Mar
 2024 05:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com> <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
In-Reply-To: <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 18:44:59 +0530
Message-ID: <CAFA6WYNHkU2xp+6_+K0JoOpVrAP3ryS2zs+Q2L6Wb+TTVL+mWg@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
	Sean Anderson <seanga2@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
	Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Dai Okamura <okamura.dai@socionext.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
	uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2189

On Tue, 5 Mar 2024 at 18:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 05/03/2024 12:35, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> >> all the devicetree files for a given vendor to be compiled. This is
> >> useful for Qualcomm in particular as most boards are supported by a
> >> single U-Boot build just provided with a different DT.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  dts/Kconfig          | 24 ++++++++++++++++++++++++
> >>  scripts/Makefile.dts | 17 ++++++++++++++++-
> >>  2 files changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/dts/Kconfig b/dts/Kconfig
> >> index b9b6367154ef..67d9dc489856 100644
> >> --- a/dts/Kconfig
> >> +++ b/dts/Kconfig
> >> @@ -100,8 +100,32 @@ config OF_UPSTREAM
> >>           However, newer boards whose devicetree source files haven't landed in
> >>           the dts/upstream subtree, they can override this option to have the
> >>           DT build from existing U-Boot tree location instead.
> >>
> >> +config OF_UPSTREAM_BUILD_VENDOR
> >> +       bool "Build all devicetree files for a particular vendor"
> >> +       depends on OF_UPSTREAM
> >> +       help
> >> +         Enable building all devicetree files for a particular vendor. This
> >
> > Do we really want to build all the DTBs even if many of those aren't
> > supported by U-Boot at all? I would have rather added Makefile targets
> > for boards which really supports a single defconfig eg.
> > qcom_defconfig.
>
> Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
> targets that ought to be able to run U-Boot to some extent

Have you tested U-Boot on all of them? IMO, it would be good to make
people aware about supported boards via listing their DTs at least.

>
> $ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
>         | wc -l
> 51
>

qcom_defconfig currently only supports sdm845 and qcs404.

> What do you mean by a "makefile target"? Like copying
> arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
> would be keeping it in sync, and introducing additional busywork when
> porting.

See following diff:

diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
index 9a8f6aa35846..ecc15021cb08 100644
--- a/dts/upstream/src/arm64/Makefile
+++ b/dts/upstream/src/arm64/Makefile
@@ -2,6 +2,10 @@

 include $(srctree)/scripts/Makefile.dts

+dtb-$(CONFIG_ARCH_SNAPDRAGON) += qcom/sdm845-db845c.dtb \
+       qcom/sdm845-samsung-starqltechn.dtb \
+       qcom/qcs404-evb-4000.dtb
+
 targets += $(dtb-y)

>
> We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
> compile them all on my machine, but that's only once. With incremental
> builds this becomes largely irrelevant.

Maybe someone cares about build time too but that's not my primary
concern. We shouldn't be giving the false impression that all the DTs
present in the vendor directory are supported by U-Boot.

-Sumit

