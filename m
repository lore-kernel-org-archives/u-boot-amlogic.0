Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70EFCFC507
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.10725.1728398180818072078
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 07:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=rJMnj+VD;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=ecb7=rf=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1728398178;
 bh=xOVw6RjLtZEjCpH2Ta8mGGffDnVMpZtRSkiXyOtBOvI=;
 b=rJMnj+VDC4k9CYctR1YHwtxMbayqUkC7rS/SAhEx6P2DuJPLUQzr2pmVTvR/d3Q5yClu2BVH+
 Zt6Kg22bFCu7BEl8dZVP90Z+rSXTHo1kXrtED6MgRBsYFGPN0TnSyvjikLSqwF9QuyyHIAOpaaR
 QvArYPmfYxmL7PTw5Jwey9XIzVK9Vj2nCs8ag5Dh8ouDkB9FBrZ9r2ysk+bzcW3Xb1vAhZ1lzwP
 buNgALhGWsFMsFp4FTYd5vQq0wHh3yW7VZUYLciYvGowZzvOfKQggQsj1v/IvLaNG9Dxt5WTI3e
 mH4LgeoFs8UHn7skk169Tm7EnN82ZgL7BoFiMbX/TIxg==
Message-ID: <b0174edf-5055-4c67-827c-2edefbf969fa@kwiboo.se>
Date: Tue, 8 Oct 2024 16:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: meson: dw-hdmi: do not fail probe if HDMI regulator is already enabled
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 670543610dc2a0a5051d9cdd
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2475

Hi Neil,

On 2024-10-08 14:58, Neil Armstrong wrote:
> If the regulator is already enabled, this happens if the regulator
> is set in regulator-always-on, regulator_set_enable() return -EALREADY.
> 
> Ignore the -EALREADY return since it's not an error.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/video/meson/meson_dw_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 587df7beb9b..ee219ce6ec4 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -419,7 +419,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>  
>  	if (!ret) {
>  		ret = regulator_set_enable(supply, true);
> -		if (ret)
> +		if (ret && ret != -EALREADY)

You could possible relax this further using something like:

  ret = regulator_set_enable_if_allowed(supply, true);
  if (ret && ret != -ENOSYS)

That way you only reach the error state when there is an error with
supply, for other states e.g. when supply is not found, DM_REGULATOR=n
or the regulator is already enabled will be treated as success (ret=0).

Regards,
Jonas

>  			return ret;
>  	}
>  #endif
> 
> ---
> base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
> change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb
> 
> Best regards,


