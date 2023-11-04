Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B7C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 18:09:36 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.15220.1699121369001241515
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Nov 2023 11:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=Iq+byYFH;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 85D66100007;
	Sat,  4 Nov 2023 21:09:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 85D66100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699121364;
	bh=+nsfvzxnhXZxJigzwXk0wF3QH/yYUzP6fPMyyoKN+gk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Iq+byYFHNXSFcMgZ+KjBvRs//pxkHCik4i25Y8tWhR5RgLgcnyn7dpMCpbb5H0V31
	 fF4W4kUAPE15+FhvsIecddJmia1eHsobqipSO/uW9f/cRBGKjGceGGijOBgqu0rr6t
	 ni/LnGVsKfn4fbvOOPMwF6Q31rlMOB9my1HUtuJf4akLeCLhxqs01PnoZdfhLfVMv+
	 dFpyY+3j/ATp8vznaMnhOPFcWct4yWkSFVtN0MJDEkgJTsoyH9CUOPcjuGuvP3J5RQ
	 qfvjUKv1qC7SD/LIyOcFp6zD3U6RJXjzKfJIGqCuGUSk+cbKb5WL4jxqJ9WYkUrrnw
	 YkGuRQ0xj4jPA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat,  4 Nov 2023 21:09:22 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Sat, 4 Nov
 2023 21:09:22 +0300
Date: Sat, 4 Nov 2023 21:09:20 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Sean Anderson <seanga2@gmail.com>
CC: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
	<michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, <prusovigor@gmail.com>,
	<kernel@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v5 5/8] clk: Add dump operation to clk_ops
Message-ID: <20231104180920.ubq4odp454n4wo52@pc>
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-6-ivprusov@sberdevices.ru>
 <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181122 [Nov 03 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/04 17:19:00 #22402819
X-KSMG-AntiVirus-Status: Clean, skipped
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 18:09:36 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1830

On Sat, Nov 04, 2023 at 11:24:32AM -0400, Sean Anderson wrote:
> On 11/2/23 08:20, Igor Prusov wrote:
> > This adds dump function to struct clk_ops which should replace
> > soc_clk_dump. It allows clock drivers to provide custom dump
> > implementation without overriding generic CCF dump function.
> > 
> > Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> > Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > ---
> >   include/clk-uclass.h | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> > index a22f1a5d84..793bf14160 100644
> > --- a/include/clk-uclass.h
> > +++ b/include/clk-uclass.h
> > @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
> >    * @set_parent: Set current clock parent
> >    * @enable: Enable a clock.
> >    * @disable: Disable a clock.
> > + * @dump: Print clock information.
> >    *
> >    * The individual methods are described more fully below.
> >    */
> > @@ -39,6 +40,9 @@ struct clk_ops {
> >   	int (*set_parent)(struct clk *clk, struct clk *parent);
> >   	int (*enable)(struct clk *clk);
> >   	int (*disable)(struct clk *clk);
> > +#if IS_ENABLED(CONFIG_CMD_CLK)
> > +	int (*dump)(struct udevice *dev);
> > +#endif
> >   };
> >   #if 0 /* For documentation only */
> > @@ -135,6 +139,17 @@ int enable(struct clk *clk);
> >    * Return: zero on success, or -ve error code.
> >    */
> >   int disable(struct clk *clk);
> > +
> > +/**
> > + * dump() - Print clock information.
> > + * @clk:	The clock device to dump.
> > + *
> > + * If present, this function is called by "clk dump" command for each
> > + * bound device.
> > + *
> > + * Return: zero on success, or -ve error code.
> > + */
> > +int dump(struct udevice *dev);
> 
> Actually, this should return void, since we don't do anything with the return code.
Good catch! Though there is, for example, zynqmp_clk_dump() that may
return an error code. Wouldn't it be better to print an error message
with the code in soc_clk_dump()? It might be convinient to have common
code handling unexpected errors during dump.
> 
> --Sean
> 
> >   #endif
> >   #endif
> 

-- 
Best Regards,
Igor Prusov

