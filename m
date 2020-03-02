Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.11859.1583141434500795807
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:30:35 -0800
Received: by mail-wr1-f66.google.com with SMTP id e10so10142822wrr.10
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1QJI0kmru69aPSv2gWuVMKIbAIwbRpbImJlz93ZxaxU=;
        b=TdbydlEDp9jMtCP0O9eZMiugF6PSekgTnrQkwTclGeDM2SyHkL8yjalYP2ALs7U9mu
         q1KpA8lGq18NxRi+SIKUO7TMhG55gd2j1lb9yxTsL/4CJba3SjIggD9/uayqJv6w97J2
         2Ot4qI+/cYZ22l6Cmsm1CgsEAGjSUZL6EfPAFgO/Gc05dvg+uo1UNOrS5qCcxShJJ82S
         XH+Kk1Hk0OVTwrPUDPHzl9bXvbQmoP8WtFfgJfW8+9KhC1Y4bDNtgOBr7IYXKz9Qr4nH
         unKL575sxKS3MsQ7kKWXqosqUh4kgJZzW7k1X8APb1kTypxwH17Bc4+VPwLeQhHiNh1Z
         GqBQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] Revert "dm: core: device: switch off power domain after device removal"
References: <20200217091036.19028-1-narmstrong@baylibre.com>
 <20200217125336.39990b93@crub>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4ca30460-15e5-1d9e-9a52-0044e308a590@baylibre.com>
Date: Mon, 2 Mar 2020 10:30:31 +0100
MIME-Version: 1.0
In-Reply-To: <20200217125336.39990b93@crub>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: sjg@chromium.org, trini@konsulko.com, oliver.graute@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, lokeshvutla@ti.com, sbabic@denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Analolij,

On 17/02/2020 12:53, Anatolij Gustschin wrote:
> On Mon, 17 Feb 2020 10:10:36 +0100
> Neil Armstrong narmstrong@baylibre.com wrote:
> 
>> This commit breaks Linux boot on Amlogic libretech-cc, libretech-ac, sei510,
>> sei610 board by automatically disabling the power domain after device removal.
>> This because the power domain associated to the video driver must be kept
>> enabled for linux to boot.
>>
>> The only way is to use the introduced flag DM_FLAG_DEFAULT_PD_CTRL_OFF, which
>> removes automatic handling of power domain.
>> This flag is not a complete solution since it will force reverting to manually
>> enable the power domain from the driver probe.
>>
>> Instead a flag to keep the power domain enabled after removal should be
>> introduced.
>>
>> In the meantime revert this commit until a proper solution is found.
>>
>> This reverts commit 52edfed65de967a86983a55c51ba0727090efc43.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Hi Simon, Tom,
>>
>> This revert is the simplest fix to make the boards boot again on v2020.04,
>> the goal is to make this behavior happen again with a proper flag to keep the
>> power domain enabled on specific drivers.
>>
>> I can push it on my next PR on my branch, is it ok ?
> 
> Please test if these two patches fix the problem:
>  http://patchwork.ozlabs.org/patch/1239143
>  http://patchwork.ozlabs.org/patch/1239144

Should I apply these through my tree or you plan to push these yourself ?

Thanks,
Neil

> 
> --
> Anatolij
> 

