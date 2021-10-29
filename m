Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.8614.1635527791840550827
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 10:16:32 -0700
Received: by mail-wr1-f52.google.com with SMTP id o14so17245488wra.12
        for <u-boot-amlogic@groups.io>; Fri, 29 Oct 2021 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zsOOICBYt3N2lgBQCEObw95lpyGnuJ65QskGHFBgYt0=;
        b=7rj+V4cnYlPmr3tpla1iLnCbUD0Q6oGDvRJ2hvutQ6ZMchu89gDhfKQ6Kojy1WLM0S
         rKKt5Rhwg/R0tZ9yZf6VfH5T2WnNKWnlxeonoAslzq7b/TjRYvbc7P+h9hncedWy8htE
         J4cbh2LNU1MQRJDF5SiIUtHy7LyRmPtMAYTx+4JOfp8zX4n+w6CfkwTXijL77xZGuTUQ
         24iXmyeQ1ALwx1OaUbLskLIRKIQA2Ede4bvD6FoS5WbVIeiv4crWlzBMrPfXnWDwh9l8
         bRPhbOd+rNPfdqoi5B4/M9EfSUpes7fflJMZ9D+Kx9K769+2B/ASpBhyq3ip/inyhHcx
         UTXA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
References: <20211029070820.3607994-1-adeep@lexina.in>
 <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
 <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
 <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
 <42561313-e883-bb7d-282c-20898f616ebd@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6dab4529-1d4a-915f-4419-4e3f9036162f@baylibre.com>
Date: Fri, 29 Oct 2021 19:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <42561313-e883-bb7d-282c-20898f616ebd@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/10/2021 16:49, Vyacheslav wrote:
> #include <u-boot/crc.h>

Thanks,
Applied & squashed !

Neil
