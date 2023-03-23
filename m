Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.67808.1679561299144794752
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 01:48:19 -0700
Received: by mail-wm1-f44.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso596019wmo.0
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679561297;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GurEupKGuxcCAmolW+mWL7L/rx0OvQUf+1Zcf2lb9gA=;
        b=cAAHK7+la370gDR1wly25ZP/ODtunZsfjwgxXZ8YkJ9bVj0CFwn1mYxb72gKth6mF5
         DuY2f4nsAmHJvJC1NSgILSb9Awm6XucB3eXlfU47Q9OcMzJVLxws1PkSDgvewNTtmUzz
         2oN4tmwu0aysKGmw74uTHwsc0bdDaZn9gSj4byNwJ7/U+JqqkXT+rvYBtRPkGeLWvEgm
         mK3AHxcBw/sBygNdXhXkg2Ck5a3P3UeOlIuM9NLHsFaBqJN4c2L5Ru77DxfKzayVyQ6I
         USRMPtF9JR4FMO0Ssh/9NkB6vgMiU9WKFqSeVYny/J+35w/xKXhTs2X7ZDkUHqY4CTdS
         K39Q==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <ff2177db-db80-4f85-ef00-1335c3d60316@linaro.org>
Date: Thu, 23 Mar 2023 09:48:17 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 01/13] docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
References: <20230323065458.776029-1-christianshewitt@gmail.com>
 <20230323065458.776029-2-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323065458.776029-2-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 07:54, Christian Hewitt wrote:
> The bananapi-m5 docs are missing from the file, so add them.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/u200/MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
> index 47cec234a1..919e349922 100644
> --- a/board/amlogic/u200/MAINTAINERS
> +++ b/board/amlogic/u200/MAINTAINERS
> @@ -7,4 +7,5 @@ F:	configs/u200_defconfig
>   F:	configs/bananapi-m5_defconfig
>   F:	configs/radxa-zero_defconfig
>   F:	doc/board/amlogic/u200.rst
> +F:	doc/board/amlogic/bananapi-m5.rst
>   F:	doc/board/amlogic/radxa-zero.rst

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
