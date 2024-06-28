Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD6C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.13986.1719570191501397763
 for <u-boot-amlogic@groups.io>;
 Fri, 28 Jun 2024 03:23:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qJhGUV8p;
 spf=pass (domain: linaro.org, ip: 209.85.218.47, mailfrom: caleb.connolly@linaro.org)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a70c0349b64so54952366b.1
        for <u-boot-amlogic@groups.io>; Fri, 28 Jun 2024 03:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719570190; x=1720174990; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqsgQ1eLQ0uiSW4nlzjnB3sCbmoe62JZW1v1i4GDWP0=;
        b=qJhGUV8phMU2GBwTl/5Pil7fhuxmoMLY086+PjNHZS5GtnH/41sYpaNutRQVWOCu0v
         VBJpscPlzZkO9kR3Zi8GgelsjByD/KkIfPgTshek93wHs1bWNXWXziTtrhc8VpUYyYhV
         GOh5qBEaunin2UHlxDUUGuyITrEL2KPr2poQzYiedWAzlNyaPcVkzgpePBsxRb8qW2AT
         F3kxgQUm+xTfQMU0uej8vsL/y3JZqXU3MmW2x52X9RwBMuR/wOkgFS9UekSU5ON0U8JP
         O1zIbxXHDyIyQw0LSZTgbQu+QRU0GYiUuIDj98WQ41Y3YE9Tf1ubhCOlofZX2m3Sfx/8
         27Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570190; x=1720174990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqsgQ1eLQ0uiSW4nlzjnB3sCbmoe62JZW1v1i4GDWP0=;
        b=geZYKbUGPWwxvC8fW4gIOOXDWwR3LDb5k8Az59uVi2YfE9+DyDul9S9PHwednjxYWu
         wBuCDqxTwAr2O4ox9ZNL/Kbd+Pvq9L3B8Zph4BPzKJf59CwofPurz6AVHu7/Nej+7iqZ
         CNpoHMHCvE/bz+5qcYLa721bOt/kjjZb9pLHejfjLjLBP2jXnllp9SAsss81IbhbbK1i
         XoLUEoTsyw5qx5Wzabc8quR9DxQPGy0gUVKwC8FIpxIDoWUFVkwXACnozG2kmmOPXnuH
         pNyUfnh+kf+oGFUtrRALl3bc2Vg6GxsmOHPks/YrDYyKjSSA9vfi6VIw4bzD1xKWs1bZ
         sp+A==
X-Forwarded-Encrypted: i=1; AJvYcCXiGzug71Cw2/LUZbsXdbKfa6EGgRILhh6s8c8Wy1n1AxfDcXL2lOrglyfVeJ9b+wThVzCjXgETM00mVl9ZQk/CL7L4nMsoPVE=
X-Gm-Message-State: AOJu0YzAksEil9XcYDS/6Tm6LANtM9CS8XlDJR/Ven1rjjahdRZ23Tlf
	g4N3k4adzCDA6nSZZEPzjSDG0PHmmBQTbmQxVgInEwO+vowUWmIhrUCxcG500X0=
X-Google-Smtp-Source: AGHT+IENOK4lyqsP/C8G9OL/LSuejh4RLzbOPyh/vsC53PQVajvsTQbEU6Pj24oQWwBk6lN+2hZQPQ==
X-Received: by 2002:a17:907:874e:b0:a72:8323:4298 with SMTP id a640c23a62f3a-a7283234518mr590607166b.68.1719570189850;
        Fri, 28 Jun 2024 03:23:09 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf63914sm65811366b.87.2024.06.28.03.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 03:23:09 -0700 (PDT)
Message-ID: <7fcaa045-2d27-483e-84d1-72c0434854d2@linaro.org>
Date: Fri, 28 Jun 2024 12:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
 <CAFLszTijRhB1dRraPBQSTU3ypJ_wJU7yghJ9c9Rk-XcbcfvkFg@mail.gmail.com>
 <38150a1b-6c71-4b42-a8ec-6b0de8ad6848@linaro.org>
 <CAFLszTg078XuQ5WxUVvMktA95zZm+PHs+MtVu2eL-xZYYkHxFA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTg078XuQ5WxUVvMktA95zZm+PHs+MtVu2eL-xZYYkHxFA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2348

Hi Simon,

>>>>>
>>>>> This is reading a lot of DT stuff very early, which may be slow. It is
>>>>> also reading from the DT in the bind() step which we sometimes have to
>>>>> do, but try to avoid.
>>>>
>>>> Could we set up the livetree pre-bind? What about MMU? On armv8 at least
>>>> this would have a huge impact on performance. I've done some
>>>> measurements and there is at least 1 order of magnitude difference
>>>> between parsing FDT with no caches vs parsing livetree with, it's huge.
>>>
>>> That seems like a great idea to me, in general. The fact that SPL sets
>>> up the MMU on armv8 makes it more practical.
>>
>> Well, on qcom we don't use SPL (yet?), we did have a cyclical dependency
>> since we rely on DTB for the memory layout, although I have some patches
>> to do all the memory parsing in board_fdt_blob_setup() since that's
>> needed for multi-dtb FIT. So I guess we could enable caches at the same
>> time.
> 
> Yes...it seems that enabling cache in SPL has become common on armv8.
> 
> As to the memory layout, I'm not sure what is happening there, but it
> seems that the DT does not describe it in general (at least not until
> U-Boot adds the nodes).

I suppose this depends on the platform. On Qualcomm we use DT as the 
source of truth as it lets us support many platforms (with totally 
different memory maps) with a single U-Boot binary, at least for 
development this is quite nice.
> 
>>>
>>> But for this series I believe we are going to have to define what
>>> happens in what phase. We have power_init_board() which is the old way
>>> of doing this...but perhaps we could use that as a way to start up
>>> regulators which are needed.
>>>
>>> As to my question about whether this happens in SPL / pre-reloc /
>>> proper, I forgot that we have the bootph tags for that, so it should
>>> be fine. The main issue is that in U-Boot proper we will re-init the
>>> regulators even though that has already been done. Probably that can
>>> be handled by Kconfig or a flag in SPL handoff.
>>
>> Ensuring that it isn't done multiple times sounds like the right
>> approach to me.
> 
> OK...I wonder how we can solve this. Needs some though.
> 
> 
>>>
>>>
>>>>>
>>>>> Also this seems to happen in SPL and again pre-reloc and again in
>>>>> U-Boot post-reloc?
>>>>>
>>>>> Should we have a step in the init sequence where we set up the
>>>>> regulators, by calling regulators_enable_boot_on() ?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

