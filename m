Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1817EC47422
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 08:47:47 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web10.7624.1704765272304628920
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Jan 2024 17:54:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=YPsE1MNm;
 spf=pass (domain: ti.com, ip: 198.47.19.141, mailfrom: bb@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4091sJ1M084211;
	Mon, 8 Jan 2024 19:54:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704765259;
	bh=yoUHyqWX9A6Yh3DlXN93YWvBLn/HBnJDSqxWCM12LX8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YPsE1MNmDo3ZBw3ycoPmyoKvQ4ErhYE2c615/84nLKRHQpovTRff0Gn1+mNAacrcE
	 S+569TaUPcz0C4kNwJ9dQE3j9IsRkeln5BMRtq+o8AUAxWrnv5IlBL3hp3A5I6OHjS
	 YHGcZ1mbvWB2nz84bLNkULkgTNTD7dQFEowHjL2s=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4091sJrj011973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 19:54:19 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 19:54:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 19:54:19 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4091sJQf000918;
	Mon, 8 Jan 2024 19:54:19 -0600
Date: Mon, 8 Jan 2024 19:54:19 -0600
From: Bryan Brattlof <bb@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
        <u-boot-custodians@lists.denx.de>, <trini@konsulko.com>,
        <sjg@chromium.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor@kernel.org>,
        <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
        <ff@shokubai.tech>, <daniel.thompson@linaro.org>,
        <dgilmore@fedoraproject.org>, <pbrobinson@gmail.com>,
        <ilias.apalodimas@linaro.org>, <maxim.uvarov@linaro.org>,
        <b.galvani@gmail.com>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
        <seanga2@gmail.com>, <rasmus.villemoes@prevas.dk>, <peng.fan@nxp.com>,
        <jh80.chung@samsung.com>, <rfried.dev@gmail.com>, <marex@denx.de>,
        <mibodhi@gmail.com>
Subject: Re: [PATCH v3 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
Message-ID: <20240109015419.f6lwlhkudqy7uvly@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-4-sumit.garg@linaro.org>
 <20240105204137.pdzgacapwpgpualp@bryanbrattlof.com>
 <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYMoEcg+niaf+3+a29c9Fon5LrJQ9E5X7YtWyjEX_1RKDA@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 08:47:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2050

On January  8, 2024 thus sayeth Sumit Garg:
> Hi Bryan,
> 
> On Sat, 6 Jan 2024 at 02:12, Bryan Brattlof <bb@ti.com> wrote:
> >
> > Hi Sumit!
> >
> > On December 28, 2023 thus sayeth Sumit Garg:
> > > Allow u-boot to build DTB from a different directory tree such that
> > > *-u-boot.dtsi files can be included from a common location. Currently
> > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > location.
> > >
> > > This is needed for platform owners to start building DTB files from
> > > devicetree-rebasing directory but still being able to include
> > > *-u-boot.dtsi files.
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> >
> > ...
> >
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 27b9437027c..09330421856 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> >
> > ...
> >
> > >  # Uncomment for debugging
> > > @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> > >  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
> > >                $(UBOOTINCLUDE)                                         \
> > >                -I$(dir $<)                                             \
> > > +              -I$(u_boot_dtsi_loc)                                     \
> > >                -I$(srctree)/arch/$(ARCH)/dts/include                   \
> > >                -I$(srctree)/include                                    \
> > >                -D__ASSEMBLY__                                          \
> > > @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> > >         echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> > >       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> > >       $(DTC) -O dtb -o $@ -b 0 \
> > > -             -i $(dir $<) $(DTC_FLAGS) \
> > > +             -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
> > >               -d $(depfile).dtc.tmp $(dtc-tmp) || \
> > >               (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
> > >               ; \
> >
> > One of the issues I see with having a separate OF_UPSTREAM and U-Boot dt
> > directory is when we have U-Boot board files that use dtsi files in the
> > OF_UPSTREAM folder.
> >
> > For example our reference boards uses the primary bootloader's dtb (eg:
> > k3-am62a7-r5-sk.dts) which #includes the k3-am62a7-sk.dts that will be
> > found in the OF_UPSTREAM directory and modifies it to give it the
> > perspective of the micro-controller it will be running on during boot.
> 
> Thanks for bringing this up. I have been playing with the idea to
> reuse DT includes from upstream.
> 
> >
> > What do you think if we have both paths included regardless if
> > OF_UPSTREAM is selected or not? IDK if this will break anyone else
> 
> Sure, we should be able to do that if we maintain the correct order of
> include paths as per following patch [1]. If this works for you let me
> know and I will include it for v4.
> 

This works beautifully.

I did have to hack around to get Makefile.spl working but this is headed 
in the right direction for me :)

Thank you
~Bryan

