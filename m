Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.10637.1581955499692579202
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Feb 2020 08:05:00 -0800
Received: by mail-wm1-f66.google.com with SMTP id a9so19043636wmj.3
        for <u-boot-amlogic@groups.io>; Mon, 17 Feb 2020 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5K5Efnh0yIIlfkFUj8ODPGtENpjzsgMB9ic0yshLDU=;
        b=KdyG4lrDp379hs05VxywNTu0APOOl7/LRb0egDpGe4FrSO/Oaz0rJWO56b7bSf68QC
         +NiKpcSPkNaHRG6/PMnS3tpMqso9SwadclVJ+JYh/HwsmpPjkAPXHbdoSYjotnEzIrzw
         dkDHy/AGEhMNrMVgbdZKtnS3/c/khJuP640AI2q+9Huu//UwRiQqDlweg6zlk9TkZ9+t
         h5Md5BWT0vL0CvHfxKd2Sv028nXawji1f6qiClPyd/H4jFQyqKZs0wUNN/fskZ4bqPRf
         phS25iEtanxGOsuwYaw6+bMQQ8cHxQpWCr65Efs3gOAvhMu0KuwAUat05kkCOXOLBKYO
         GBFQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] Revert "dm: core: device: switch off power domain after device removal"
References: <20200217091036.19028-1-narmstrong@baylibre.com>
 <20200217125336.39990b93@crub>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ff81b1eb-4750-a371-3033-93e1898f2020@baylibre.com>
Date: Mon, 17 Feb 2020 17:04:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200217125336.39990b93@crub>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: sjg@chromium.org, trini@konsulko.com, oliver.graute@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, lokeshvutla@ti.com, sbabic@denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Anatolij,

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

Thanks for pushing these, they should do the trick.

Let me test them and ack them.

Neil

> Please test if these two patches fix the problem:
>  http://patchwork.ozlabs.org/patch/1239143
>  http://patchwork.ozlabs.org/patch/1239144
> 
> --
> Anatolij
> 

