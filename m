Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.17883.1592227239948234040
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Jun 2020 06:20:40 -0700
Received: by mail-wm1-f65.google.com with SMTP id d128so14806399wmc.1
        for <u-boot-amlogic@groups.io>; Mon, 15 Jun 2020 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BIsvtWA7vGjCLyBJtwetDrMJFwKYQF94/UPm/3lGPXQ=;
        b=TuawGdEYUje2rBJJr0OwdmmzPNs2WA1OeV4KwUr/AgITZo15s1oc2rQ1BGRVxmpsCP
         2Fe6PoMUUhcgO+GTwUOLRY8WzOsEiMOhIHNlJjbDwSmhzmWqyCHztcBCph9UoMZZcROl
         8EGKhgzpUZLUGQ0oqj77hFMiect8hNVKg0l5gfmW7vzmqTWtDYdW+RwPeVBpNAApKnPq
         jZNGL0pBuCQsRFLVUE1kQJQCloDwDJVKmSawTGbu9XGGC8kavgJc9vq60ihesbdtWfeI
         nQu8EO/swoNVOnKQbEKXQhn7K5QXlLq7CYH7AOzN864/h9T04xvTULMy8DQyw6b1+QWB
         8bIA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] board: amlogic: move boards doc into doc/board/amlogic
References: <20200611132841.6546-1-narmstrong@baylibre.com>
 <20200611132841.6546-2-narmstrong@baylibre.com>
 <71d6a971-0ed9-2389-8412-41c5525ccd20@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3b062090-590f-a398-37d1-e01d4a7c8afb@baylibre.com>
Date: Mon, 15 Jun 2020 15:20:36 +0200
MIME-Version: 1.0
In-Reply-To: <71d6a971-0ed9-2389-8412-41c5525ccd20@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, trini@konsulko.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 12/06/2020 12:55, Heinrich Schuchardt wrote:
> On 6/11/20 3:28 PM, Neil Armstrong wrote:
>> Move the natural text Amlogic board README files to doc/board/amlogic
>> into reStructuredText and :
>> - add reStructuredText markup for bash code
>> - fix secondary titles markup
>> - move board support into global support matrix
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Thanks for moving this to the HTML documentation.
> 
> Please, add an SPDX license identifier to each file, e.g.
> .. SPDX-License-Identifier: GPL-2.0+

Indeed, forgot this.. thanks !

Neil

> 
> make htmldocs shows no problems
> 
> Best regards
> 
> Heinrich
> 

