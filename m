Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web09.11985.1583143048183385770
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:57:28 -0800
Received: by mail-wm1-f65.google.com with SMTP id a5so10359948wmb.0
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yaCkbSLvAL6nPJ0ayaxDNjXbAKGaxW8JJuf1tmQ1zYY=;
        b=wRiRuY2pKQIqIYzE+DxjYJXNyUddTEyX4ElprBcXa8s6sK8jzDY9l3lZqvgd1GNalq
         2SWgH2oX7MHzbMexpz7NQ8UoReSlkgi9Sq25T1hsk7gIwEcVFle2zcrsY4VJRHGUGuD+
         vViRB3Xa1oDjkHdJf+pkoSLTdNlMzKlSTvhYkcdugvj38vjwudJbGKS2uQ3A+TW/1gHC
         SMPZlwd6KHbxcfiSRgxyWLmfpcJEOyzGX7NfY9V+MDWJHeUSowpy50sL/oLGzr+GBZro
         f0z2IQgZDZj6HZJahVT6N3bqNLoMlyJsruqEufkU7dWaaNxhGrhhdlnok0LyiQuVWRyw
         CrXg==
Return-Path: <jbrunet@baylibre.com>
References: <20200227112738.494579-1-jbrunet@baylibre.com> <20200227112738.494579-7-jbrunet@baylibre.com> <d9397867-7071-a387-95d8-fb4ecc9bba96@baylibre.com> <c1a60140-e340-96fd-3011-187538cfdf75@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: meson: add libretech-pc support
In-reply-to: <c1a60140-e340-96fd-3011-187538cfdf75@baylibre.com>
Date: Mon, 02 Mar 2020 10:57:25 +0100
Message-ID: <1jmu8zt6yi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>


On Mon 02 Mar 2020 at 10:52, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 02/03/2020 10:34, Neil Armstrong wrote:
>> On 27/02/2020 12:27, Jerome Brunet wrote:
>
> The defconfig fails with :
> scripts/kconfig/conf  --syncconfig Kconfig
> .config:164:warning: symbol value '' invalid for ENV_SECT_SIZE
> .config:165:warning: symbol value '' invalid for ENV_OFFSET
>
> for both configs on master.

That's quite a few comment about master which propably means I messed up
while rebasing on it (or trying to).

I can fix this up a resubmit the whole thing if you want.

>
> Neil

