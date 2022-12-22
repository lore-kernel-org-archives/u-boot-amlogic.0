Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.43264.1671707231712000975
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 03:07:12 -0800
Received: by mail-wr1-f49.google.com with SMTP id h7so1264131wrs.6
        for <u-boot-amlogic@groups.io>; Thu, 22 Dec 2022 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W3UyrclwY/krvZmQCf4y0JKfNjcP4ccDrF0Ls1hsgms=;
        b=QnjmvzZXrvWLBPOAxq95t7WcY/vghLzencWjcjTyaV0KP9eoC9/xm0lby1OxJ3vd+5
         5/ekxBad7hV4sIZSD1JscV6xbeCIx3AdAnSE8IdcQpRlKBQHdG5EztJDiizAU4cQkYRi
         eyaVlYbRaX/LbWb3/ZELfKiw3S4+HS6rCKbIPAqcb+5YsCrtP5Snx3Y1kS2vyyygzXJW
         OaCyn/LeWPT2RqcYxXfbiEaqWl+XdJTCcWYTBCicd1YQcoi1PZJSj9KDT63jV85BsYvu
         DZunepQ9cu3RVRlPHW/F9XZ6BBAkUMEQNwMVrCzkZMGlYnSZNmGQTDAiVor47+A48ISa
         bjpA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3f6f8c83-4684-0555-5166-06b0d62bb747@linaro.org>
Date: Thu, 22 Dec 2022 12:07:09 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] board: amlogic: jethub j100: add rescue boot from microSD
References: <20221222093358.204520-1-adeep@lexina.in>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222093358.204520-1-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, adeep@lexina.in, Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 22/12/2022 10:33, Vyacheslav Bocharov via groups.io wrote:
> From: Viacheslav Bocharov <adeep@lexina.in>
> 
> The new JetHub D1+ has a microSD slot. Add rescue boot from microSD
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   include/configs/jethub.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/jethub.h b/include/configs/jethub.h
> index 35f85095ac..e22db4991d 100644
> --- a/include/configs/jethub.h
> +++ b/include/configs/jethub.h
> @@ -12,6 +12,7 @@
>   #define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
>   	"bootcmd_rescue=" \
>   		"if gpio input 10; then " \
> +		"run bootcmd_mmc0; " \
>   		"run bootcmd_usb0;" \
>   		"fi;\0"
>   #else


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
