Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A8C4829B
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 09:40:38 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.10664.1707178905778509284
 for <u-boot-amlogic@groups.io>;
 Mon, 05 Feb 2024 16:21:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=Rf2zFwYj;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9849D86F8E;
	Tue,  6 Feb 2024 01:21:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707178902;
	bh=Y6OQOwFa7AZjHIdrN6oTk5e77B6dWZQ1AMUDtDocvIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rf2zFwYjuIPq9oLNVYBM89gnlbastzL723huKRh8BH9Kvlmb1/1NQHdz2xAN9Uor9
	 3Xyr58s6T8hSjQnp6jCjZOI22qzvrFIdqBr+fTfC93AkzjKOwKxRSgBLn1NmdziPtc
	 eKpC1aRLZ42CyAoBKR+ldMlkkMoeSd8jWuqN+d/99aNGQgjVXpyZ6NOHympHogFwDV
	 5Z37zCOQg14hrRiA2srjn6MbmGyZxK8Iw7QIcYJLwuE5lmEDjBTKLTfhfozGK8nG/6
	 pFKMT4IqWy4jyPuj4rb31tg28oHoqcoa6UAIl+isNxxKVhVwy0aEPMGFCdF7WsuwHH
	 3KbQd29JtvWCQ==
Message-ID: <ae946009-64a6-44bd-9034-b035684341a6@denx.de>
Date: Tue, 6 Feb 2024 01:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] dts: Add script to uprev dts/upstream subtree
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, festevam@gmail.com,
 nm@ti.com, andre.przywara@arm.com
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-7-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240202130534.1051438-7-sumit.garg@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Feb 2024 09:40:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2117

On 2/2/24 14:05, Sumit Garg wrote:
> dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
> Usage from the top level U-Boot source tree, run:
> 
> $ ./dts/update-dts-subtree.sh pull <release-tag>
> $ ./dts/update-dts-subtree.sh pick <commit-id>
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

How are the fixes which land in linux-stable handled now ?

Do I have to duplicate the work which is already being done by the 
linux-stable maintainers ?

> ---
> 
> Changes in v5:
> - Added support to cherry-pick fixes in subtree update script. Also, used
>    https:// instead of git://.
> 
> Changes in v4:
> - New patch to add script dts/update-dts-subtree.sh as per Rob's comments.
> 
>   dts/update-dts-subtree.sh | 45 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100755 dts/update-dts-subtree.sh
> 
> diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> new file mode 100755
> index 000000000000..b781bf710025
> --- /dev/null
> +++ b/dts/update-dts-subtree.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2024 Linaro Ltd.
> +#
> +# Usage: from the top level U-Boot source tree, run:
> +# $ ./dts/update-dts-subtree.sh pull <release-tag>
> +# $ ./dts/update-dts-subtree.sh pick <commit-id>
> +#
> +# The script will pull changes from devicetree-rebasing repo into U-Boot
> +# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
> +# automatically create a squash/merge commit listing the commits imported.
> +
> +set -e
> +
> +merge_commit_msg=$(cat << EOF
> +Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
> +
> +[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> +EOF
> +)
> +
> +remote_add() {
> +    if ! git remote | grep -w devicetree-rebasing

I think you are looking for git-remote get-url here.

> +    then
> +        git remote add devicetree-rebasing \
> +            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git

Rather than reconfigure user git remotes like this without user 
knowledge, either ask them, or print a warning and let the user 
configure their git remotes knowingly as they need to. Include the 
command in the warning to make it easier on the user.

> +    fi
> +    git fetch devicetree-rebasing master
> +}
> +
> +if [ ! -z $1 ] && [ $1 = "pull" ]
> +then
> +    remote_add

remote_add_and_fetch , since this does more then remote_add .

> +    git subtree pull --prefix dts/upstream devicetree-rebasing \
> +        $2 --squash -m "${merge_commit_msg}"
> +elif [ ! -z $1 ] && [ $1 = "pick" ]

The non-zero test is not useful, just add missing quotes around "$1" and 
compare:

elif [ "$1" = "pick" ]

> +then
> +    remote_add
> +    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ $2
> +else
> +    echo "usage: $0 param1 param2"

The param names could really use improvement, instead of 'param1' that 
could be some '<op>' and 'param2' could be some '<url>' or something.

> +    echo "  param1    pull or pick"
> +    echo "  param2    release tag [pull] or commit id [pick]"
> +fi

Please run shellcheck on this .

