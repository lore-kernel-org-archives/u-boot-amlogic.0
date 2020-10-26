Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.13601.1603723823469098664
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Oct 2020 07:50:24 -0700
Received: by mail-wr1-f49.google.com with SMTP id s9so12894223wro.8
        for <u-boot-amlogic@groups.io>; Mon, 26 Oct 2020 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGH6l4KlgxyKORcT57GTz5HBgTsAINLeShUBbme44Fc=;
        b=k3XJ7I4fwNDRhlniKPJGpNtsYSdNwyRprLAS21CotRXnjgCnBzWnAOb+dYtgPY8zup
         RgO7S5n4pUuCfBy7yGea9dfOEaRgTQmE3ODiONz19rhtXvDFSdg3KjZkc9LI3MZP2/fU
         8GFW/yli5P5NZ71lMa/FAEJ/Uz4OiebnH5JDj5uGdXunP4tMdx3GkW518mw0cxtw+tHL
         CQsLwTTbmS62dMDupjnHYy7feIjLiMCsI5hFEP9ZA4WJdnToxyhLWJ8N5avLPnOaznHf
         SwudBTwlizT18uwQSDA92k0pFTyZfmTcg6ZE/gfa8zSKFd5LF2ee0+1fF1AJclpNnxPK
         wGyA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com>
Date: Mon, 26 Oct 2020 15:50:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anton Arapov <arapov@gmail.com>
Cc: jbrunet@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Thanks for the report.

Next time, please send the email to u-boot-amlogic@groups.io

It's weird this fixes the issue, because the BOOT_0 to BOOT_8 have default Pull-Up by default,
and Linux works fine with this.

S905_Public_Datasheet_V1.1.4.pdf pages 17 & 18

Maybe there is another issue in pinctrl instead ?

Neil


On 26/10/2020 15:36, Anton Arapov wrote:
> Neil, Jerome,
> 
> the commit:
> https://gitlab.denx.de/u-boot/u-boot/-/commit/dd5f2351e99aad8fcbedbc1305b8b51b09952336
> introduced "bias-pull-up" for emmc:
> https://gitlab.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/meson-gxbb.dtsi#L411
> and breaks booting from eMMC on the Odroid C2 board.
> 
> uboot output:
>   => mmc dev 1
>   Card did not respond to voltage select!
> 
> removing bias-pull-up fixes the issue, though it is not the fix obviously.
> 
> Could you suggest what could be done in order to fix the issue? Where
> should I look?
> Any hint would be helpful.
> 
> Thanks,
> Anton
> 

