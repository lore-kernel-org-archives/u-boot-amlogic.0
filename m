Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8756.1632124233608171351
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 00:50:34 -0700
Received: by mail-wm1-f50.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so14808196wmq.1
        for <u-boot-amlogic@groups.io>; Mon, 20 Sep 2021 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5ET2kcfWFc0wMzn0DC14RMOObesMWgx7SoVVpN+2jw=;
        b=iZwabRhbrLVOIEcBgv3UKwxr49uOxfSbKNUoRsGAt+nXXK8JXO7+3dpAV0ww924oI6
         /SfKAlqIShekZyUoKZ57urdehm0MRaXeY9pYxPQJzVsnzJTofm9/B42rFyindidl0Qq7
         3xHCoAk73/TxyBOh2GnI/WsoPj2zD9131wX9VHo0wOa9xEYcdMaIxACU5onNL+TvhIuU
         mDbXQ7yGaStLXhbrcQr3C2logZUww6GF/btTAPTK4cVZmZca5F6Do1hbN7r0LppgeH1x
         vZHOEMHpgHSeGrC9Smyd6+YTM4wORHwAEwaQAe08J3jKmr/sUt82A08HkW/F9iN9licV
         s+Ng==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 3/3] ARM: amlogic: add JetHub D1/H1 docs
References: <20210919155216.4000369-1-adeep@lexina.in>
 <20210919155216.4000369-4-adeep@lexina.in>
 <0226ea58-cf5d-45d9-9df5-d41541fdd259@baylibre.com>
 <6a049ffd-bdfc-15be-d73a-49041bf27d00@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3cf27fb3-e978-7967-63d2-e2390aaa0ce0@baylibre.com>
Date: Mon, 20 Sep 2021 09:50:29 +0200
MIME-Version: 1.0
In-Reply-To: <6a049ffd-bdfc-15be-d73a-49041bf27d00@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 20/09/2021 09:08, Vyacheslav wrote:
> 20.09.2021 09:46, Neil Armstrong wrote:
>> Hi,
>>
> 
>> I got the error:
>>
>> Warning, treated as error:
>> /home/narmstrong/projects/amlogic/u-boot-upstream/doc/board/amlogic/jethub-j100.rst:16:Block quote ends without a blank line; unexpected unindent.
>>
> Weird, patman doesn't show this problem. Which tool is checking this?

Simply `make htmldocs` as root

Neil

> 
> Thanks.

