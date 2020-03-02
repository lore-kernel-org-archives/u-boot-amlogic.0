Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.12242.1583143773259511458
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 02:09:33 -0800
Received: by mail-wr1-f68.google.com with SMTP id n7so3854355wrt.11
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 02:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7aCBhMs730XSUTMSAbR1rB31VnSByRm1kmxLTW5HeY=;
        b=rt7GX8T7t0L9Q+jjfjVV6vwAL7jJmOzN9HgEy/pF55l+lO9m/mjg3Y+5IweAZDw1kr
         yo+G+TNLr9Bkr7SOYmDwm0fcWTSRYauw1L+5OF5lQnvkUwr68eSxMEkYYs9PjVm4C+Qz
         5tenSkW48kYL/qhtHCyIDnY/wWgzzSQ6u6k8zrj1TZR/u1NQCgXBWCB/1hyM2HKmtneN
         K6Kb8TYwl6Vgdmj0djvle2fEmDMjvm5dKesGpuxNsUnGej/m54qyW7BuYBcKDwhWW3FR
         xfJ96ekJ1JUJav3w6n4h8XC+77Jyr8JnuvFVqqCsMmlA5xQiap+MRiQy89fqxMezRQ4o
         5coQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: meson: add libretech-pc support
References: <20200227112738.494579-1-jbrunet@baylibre.com>
 <20200227112738.494579-7-jbrunet@baylibre.com>
 <d9397867-7071-a387-95d8-fb4ecc9bba96@baylibre.com>
 <c1a60140-e340-96fd-3011-187538cfdf75@baylibre.com>
 <1jmu8zt6yi.fsf@starbuckisacylon.baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c03e02ef-4283-f27d-b620-bb881bc277a5@baylibre.com>
Date: Mon, 2 Mar 2020 11:09:30 +0100
MIME-Version: 1.0
In-Reply-To: <1jmu8zt6yi.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 02/03/2020 10:57, Jerome Brunet wrote:
> 
> On Mon 02 Mar 2020 at 10:52, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> On 02/03/2020 10:34, Neil Armstrong wrote:
>>> On 27/02/2020 12:27, Jerome Brunet wrote:
>>
>> The defconfig fails with :
>> scripts/kconfig/conf  --syncconfig Kconfig
>> .config:164:warning: symbol value '' invalid for ENV_SECT_SIZE
>> .config:165:warning: symbol value '' invalid for ENV_OFFSET
>>
>> for both configs on master.
> 
> That's quite a few comment about master which propably means I messed up
> while rebasing on it (or trying to).
> 
> I can fix this up a resubmit the whole thing if you want.

Yes please

Thanks,
Neil

> 
>>
>> Neil
> 

