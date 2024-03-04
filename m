Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5188C54E67
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.2206.1709583853035012779
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Mar 2024 12:24:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=U2mCquMG;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=8d7b=kl=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709583847;
 bh=yue8JLPupABBdqygA0EMatoBvWzc9y+LdbG73Zrk0is=;
 b=U2mCquMGgMICAoDELBbO/2meILkSsw0LVYUYW7+l+JJejU6XFU6P+bvFYMjTaonfbcFL4+5nq
 6Te2eumEEr5payxBx9wHyPj0ZEyrthPopo+z/6OtPZN7XCcaZGx0BbuuQ77L2GNjKH7Qn6rEmOZ
 IjhnZnRWFiHYEsUe4PhAZtfnnWGwkI2WVhWiIj4tEl6mL41t+YY4Hmwicf3XjhpRzvHVUmRQZ2b
 GEJX5rjJeCvxJYgq/d+O4zBXjG81erSvaxhUUOG09hS6F8s6Qh7OciY9tRu0Y6Qq5mFcpyWYdzc
 gJQUp/5ncYNooztBzMIbf/UOwpnjP6wx8nTonX2epcpg==
Message-ID: <e6285379-d4c9-45b7-8913-bcf27c52bbda@kwiboo.se>
Date: Mon, 4 Mar 2024 21:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/26] rockchip: drop remaining dt-binding headers
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com, uboot-snps-arc@synopsys.com, Tom
 Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Matthias Brugger <mbrugger@suse.com>, Peter
 Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Ryan Chen <ryan_chen@aspeedtech.com>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Aspeed BMC SW team
 <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Dai Okamura <okamura.dai@socionext.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-10-b7ff41925f92@linaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-10-b7ff41925f92@linaro.org>
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e62de5a5d3328d0fcb4c53
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2183

Hi Caleb,

On 2024-03-04 17:51, Caleb Connolly wrote:
> Drop in favour of dts/upstream.
> 
> Small driver adjustment to fix compatibility.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/rockchip/pinctrl-rk3568.c         |  15 +
>  include/dt-bindings/pinctrl/rockchip.h            |  60 --
>  include/dt-bindings/power/px30-power.h            |  27 -
>  include/dt-bindings/power/rk3066-power.h          |  22 -
>  include/dt-bindings/power/rk3188-power.h          |  24 -
>  include/dt-bindings/power/rk3228-power.h          |  21 -
>  include/dt-bindings/power/rk3288-power.h          |  32 -
>  include/dt-bindings/power/rk3328-power.h          |  19 -
>  include/dt-bindings/power/rk3399-power.h          |  53 --
>  include/dt-bindings/power/rk3568-power.h          |  32 -
>  include/dt-bindings/power/rk3588-power.h          |  69 --
>  include/dt-bindings/power/rockchip,rv1126-power.h |  35 -
>  include/dt-bindings/reset/rockchip,rk3588-cru.h   | 754 ----------------------
>  include/dt-bindings/soc/rockchip,boot-mode.h      |  16 -
>  include/dt-bindings/soc/rockchip,vop2.h           |  18 -
>  15 files changed, 15 insertions(+), 1182 deletions(-)
> 
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> index 1d4391982605..35a69c2a1a28 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> @@ -11,8 +11,23 @@
>  #include <dt-bindings/pinctrl/rockchip.h>
>  
>  #include "pinctrl-rockchip.h"
>  
> +#define RK_GPIO0	0
> +#define RK_GPIO1	1
> +#define RK_GPIO2	2
> +#define RK_GPIO3	3
> +#define RK_GPIO4	4
> +#define RK_GPIO6	6
> +
> +#define RK_FUNC_GPIO	0
> +#define RK_FUNC_1	1
> +#define RK_FUNC_2	2
> +#define RK_FUNC_3	3
> +#define RK_FUNC_4	4
> +#define RK_FUNC_5	5
> +#define RK_FUNC_6	6

I would suggest to just drop the RK_GPIO and RK_FUNC_ prefix in the
table below instead of having to define these here.

Regards,
Jonas

> +
>  static struct rockchip_mux_route_data rk3568_mux_route_data[] = {
>  	MR_PMUGRF(RK_GPIO0, RK_PB7, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(1, 0, 0)), /* PWM0 IO mux selection M0 */
>  	MR_PMUGRF(RK_GPIO0, RK_PC7, RK_FUNC_2, 0x0110, RK_GENMASK_VAL(1, 0, 1)), /* PWM0 IO mux selection M1 */
>  	MR_PMUGRF(RK_GPIO0, RK_PC0, RK_FUNC_1, 0x0110, RK_GENMASK_VAL(3, 2, 0)), /* PWM1 IO mux selection M0 */

[snip]

