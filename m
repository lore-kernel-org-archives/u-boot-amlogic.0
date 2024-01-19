Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D5C4725D
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web11.25925.1705679817367056154
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Jan 2024 07:56:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=AQu5PNZq;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: nm@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JFulak043062;
	Fri, 19 Jan 2024 09:56:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705679807;
	bh=3PdO6q3NWoROLWG9kG53LgxYWUNTQv0ztf8B9wM4kl0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AQu5PNZqtu527j6wv/Wr9Ie9CcDsN0d3/JPi5nzVClOgPMWYu/21CheuZrhqgYJM5
	 2suHtJ+fKxRmT3kRCBKCQsjObT+ZURNscqmM/P0JJIi3PkArfwiP/mWazN8aoZI/6E
	 yqYkGBraN9xNRiF0cD//Wu+am8MgvZBbMovbTwq4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JFul4O006804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Jan 2024 09:56:47 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 09:56:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 09:56:46 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JFukgP026459;
	Fri, 19 Jan 2024 09:56:46 -0600
Date: Fri, 19 Jan 2024 09:56:46 -0600
From: Nishanth Menon <nm@ti.com>
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
        <mibodhi@gmail.com>, <bb@ti.com>, <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
Message-ID: <20240119155646.qq7bvgmha6cyftkv@nullify>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jan 2024 11:44:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2073

On 16:05-20240110, Sumit Garg wrote:
[...]
> Prerequisite
> ------------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
> 
> $ git subtree add --prefix dts/upstream \
>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \

Please use https://

also what is the baseline? didn't seem to apply on (fails at patch #2):
next f28a77589e75 Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
master f7cca7ccc511 Revert "test: hush: dollar: fix bugous behavior"

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

