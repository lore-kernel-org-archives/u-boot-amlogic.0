Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A7EC47DDC
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.47965.1705847603226655004
 for <u-boot-amlogic@groups.io>;
 Sun, 21 Jan 2024 06:33:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=mNRpxN7v;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EBEA9807E2;
	Sun, 21 Jan 2024 15:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705847600;
	bh=LrwLBFnO0HXkWuR1s9YFZTc/wREXVsH4sswbnOBbpYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mNRpxN7vVM+kXA5evrJWhlGfNqX+BDumInV4Mqae12wZeZGNQPnAgxNKicGErwewK
	 CbURqhRtojMIIHmpWj8zRW6WRLo07ML3RLp2XP8oetw+yt50fZaSuHlg0fH3H7FdOW
	 CkvE7DpykIawp94aFyfaGJ+9IfA09CmMGTr/csFCMVZLNpB77/hayYUwDXxhitf6sM
	 EZY17CrM11+o31I22SBwhEU3rQHol6QJmkPvGuNUHHiGrony1WIwg1nYf1cF42rtXk
	 hf8ioUpg6YzFUIgv5+A2yXeXD5Tkw9ctWg3gHyW5SsWSzIPlgDxnjHibifkrGctDMw
	 kIVqa7a6jmvAQ==
Message-ID: <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
Date: Sun, 21 Jan 2024 15:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl
References: <20240110103547.719757-1-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jan 2024 11:44:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2074

On 1/10/24 11:35, Sumit Garg wrote:
> Changes in v4:
> --------------
> - Switched subtree to be imported as dts/upstream sub-directory rather
>    than devicetree-rebasing sub-directory to better suite U-Boot
>    directory structure.
> - Since we now have v6.7-dts tag available now, so switch subtree to
>    that from its beginning.
> - Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
>    old U-Boot Kbuild infrastructure.
> - Patch #3: Incorporate fix to resolve rk3399 migration issue reported
>    by Simon.
> - Patch #4: New patch to reuse upstream DT includes by U-Boot as per
>    Brian's use-case for TI K3 SoCs.
> - Patch #5: Added a note to OF_UPSTREAM Kconfig option.
> - Patch #6: New patch to add script dts/update-dts-subtree.sh as per
>    Rob's comments.
> - Patch #7: Separate patch to align documentation to use Kconfig symbols
>    instead.
> - Patch #8: Clarify subtree uprev schedule as a separate documentation
>    section. Also, fixed documentation typos.
> - Patch #9: Added commit description.
> 
> Changes in v3:
> --------------
> - Patch #4: Minor commit message update
> - Patch #5: Replace CONFIG_* with Kconfig options
> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>    instead.
> - Patch #1, #3, #6 and #8: Picked up review tags
> 
> Changes in v2:
> --------------
> - Patch #1: excluded gitab CI config check and added commit description.
> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> - Patch #5: s/U-boot/U-Boot/
> - Patch #6 and #7: Picked up review tags
> 
> Prerequisite
> ------------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
> 
> $ git subtree add --prefix dts/upstream \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        v6.7-dts --squash
> 
> Background
> ----------
> 
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-Boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
> 
> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-Boot will maintains a Git
> subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
> opens with the next available kernel major release.
> `dts/update-dts-subtree.sh` script provides a wrapper around git subtree
> pull command, usage from the top level U-Boot source tree, run:
> 
> $ ./dts/update-dts-subtree.sh <devicetree-rebasing-release-tag>
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-Boot maintainers here [4]. Now we would like to
> reach out to wider U-Boot community to seek feedback.

I very much agree with the direction this is going in, but I do have two 
simple questions:

How do you propose to handle fixes to DTs which are applied to 
linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which 
has some defect that is fixed in 6.6.1, how will that fix get into 
U-Boot DTs ?

Assume that there is some large breaking change in Linux 6.(n+1), 
something which would be problematic for specific U-Boot platform (e.g. 
i.MX) or would require a lot of work to sort out, will there be a way to 
temporarily pin DTs for specific platform to older DT version until that 
is resolved (e.g. pin to 6.n) ?

