Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD7C4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 18:18:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.34934.1699640177555061770
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Nov 2023 10:16:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=QvybsABb;
 spf=pass (domain: baylibre.com, ip: 209.85.128.54, mailfrom: jbrunet@baylibre.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40838915cecso17497125e9.2
        for <u-boot-amlogic@groups.io>; Fri, 10 Nov 2023 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699640176; x=1700244976; darn=groups.io;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=BvjXQlUY6/PP7bOwN11QvjkURrxXgeIa9hol/Db3KYM=;
        b=QvybsABb7qTAkvFKW5BFMtTb4Mz8AarbrP3plpaTM9hFb7e3eMcyJIUqKAX7KvzmtY
         x1/ahJHpxpI4TbrKerSsCScXHO8sef/gALjzHY/8cz85rc2b4zgnXSuqiDH1S5DTQYP+
         NCMh4DTPkwfqSDKF/6LhrF3LI7FObS6gTynMzHuL8u85uAlXs5gcg4SUmDMkui3WCpDE
         d54sXeCEBkez+Ecdcvztde24BYjsq6eWc6hpqUfqYyCfGqKeQjUsDA5xotkE5d2BBR4V
         Ee/lvN96wm5J1kgZrzbsLqZ1moobTQQlorimJ20MbVyIeRhAjR3DBvKFX+BKLXYjAsnl
         RtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699640176; x=1700244976;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvjXQlUY6/PP7bOwN11QvjkURrxXgeIa9hol/Db3KYM=;
        b=U7vAz30yo+XfSbzKLRinF8GgTJEVppMNgcEu3OyC2S77hbpW5GSwHdj5PQcA03Apqo
         T+zKLvLEjVR6OlB7v+8NxbRQF/OVDK6reihz53QQgAXag3kiKYfuX9DGvR7T4z7SzGRf
         2TFAOYSXhoSxXi+XIr9mmqsouwj/aIvcAToIQRr60xqCXsF2lBjwbOF1LrL844sN2euc
         n72andlkPP1GmCHtOE63B3K5z9VQNRaMAdbNSsa4L4TtbSuMBNrk3ZGvAbTdgt3373KZ
         nuiX1kOCq5maldYHCIEJZBQ8M3wcIkVvDJMtBY/HrTb0Lffx0Fs9txkugEWCvreVa7UK
         Iq4A==
X-Gm-Message-State: AOJu0Yzey1iISAnsQSdrl/uRc8UqG/R/F3TfLppdklWTNrOsBCCqijAm
	UZA9fcTtMWhzwmxhG1w6eQE7RQ==
X-Google-Smtp-Source: AGHT+IHpAM92a5dRWGtidgqRmsC55wVaaK0ocnwNfY87HD3xHLyjMxZNbgKlgxrhSiSwll1ne2s/ww==
X-Received: by 2002:a05:600c:4fd2:b0:3fe:d71a:d84e with SMTP id o18-20020a05600c4fd200b003fed71ad84emr127537wmq.1.1699640175973;
        Fri, 10 Nov 2023 10:16:15 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:2169:e902:f0d0:1845])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b0040a4751efaasm76526wmo.17.2023.11.10.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:16:15 -0800 (PST)
References: <20230915160130.352099-1-jbrunet@baylibre.com>
 <20230915160130.352099-3-jbrunet@baylibre.com>
 <c89408dd98f78aace3f04c3fdba5702b3045a743.camel@lexina.in>
User-agent: mu4e 1.8.13; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Viacheslav <adeep@lexina.in>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [RFT PATCH 2/2] mmc: meson-gx: set 270 core phase during the identification
Date: Fri, 10 Nov 2023 19:10:46 +0100
In-reply-to: <c89408dd98f78aace3f04c3fdba5702b3045a743.camel@lexina.in>
Message-ID: <1jy1f5bhjl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Nov 2023 18:18:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1866


On Thu 09 Nov 2023 at 16:49, Viacheslav <adeep@lexina.in> wrote:

> After running some tests, I've noticed inconsistent behavior with the eMMC:
>  On a cold boot (following a shutdown), the eMMC operates as expected within U-Boot.
>  On a hot reboot (via the kernel's reboot command), the eMMC sometimes (not always, but if
> fit in error, next need to do poweroff) does not work:

No sure I understand.
MMC appears to work (passes the ID phases - which was the problem
before) but fitImage (or dtb) you get is not correct out of eMMC read,
is not correct ?

Have you checked the content ? some checksum maybe ?

What does 'mmc info' reports on boot and reboot (when it fails or not) ?

>     U-Boot is able to read the dtb file but won't boot kernel completely, or
>     U-Boot might fail to read from the eMMC altogether.
>
> This behavior had not occurred before (when the phase was set to 270 on axg).
>
> On Fri, 2023-09-15 at 18:01 +0200, Jerome Brunet wrote:
>> It has been reported that some devices have problems with a 180 degree
>> core phase. Setting 270 helped some of these devices. Other continue to
>> struggle (while it works fine with 180 in Linux ... :sigh:)
>> 
>> Poking around the HW, it seems that setting a 270 core phase during the
>> identification, then using 180 for the rest of the operations, helps the
>> device operate correctly.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/mmc/meson_gx_mmc.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>> index c6168792cbae..284be2b9dca4 100644
>> --- a/drivers/mmc/meson_gx_mmc.c
>> +++ b/drivers/mmc/meson_gx_mmc.c
>> @@ -54,9 +54,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>  
>>  	/* Clk always on */
>>  	meson_mmc_clk |= pdata->version->clk_always_on;
>> -	meson_mmc_clk |= CLK_CO_PHASE_180;
>>  	meson_mmc_clk |= CLK_TX_PHASE_000;
>>  
>> +	/* Core phase according to mode */
>> +	if (mmc->selected_mode == MMC_LEGACY)
>> +		meson_mmc_clk |= CLK_CO_PHASE_270;
>> +	else
>> +		meson_mmc_clk |= CLK_CO_PHASE_180;
>> +
>>  	/* 1GHz / CLK_MAX_DIV = 15,9 MHz */
>>  	if (mmc->clock > 16000000) {
>>  		clk = SD_EMMC_CLKSRC_DIV2;


