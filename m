Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.4983.1631180557495099496
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Sep 2021 02:42:38 -0700
Received: by mail-wr1-f42.google.com with SMTP id n5so1596357wro.12
        for <u-boot-amlogic@groups.io>; Thu, 09 Sep 2021 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Htx1V7x2idQcs5ZoxOj5x8w0LryhGlvpPuudgDvlxUs=;
        b=EBpfFMZ5AB91h536om3iUTz6dNaC/xZQJuAe3jEDybd1G2LWFrhP8qWDzCPpoaigaZ
         K1SZrXJJaMfJSL6mkYta+pC3/gSe77GehRgVZdWHajR3iKWflSOub4AQusC8QJHAZKmX
         UzDGXsCtihgoHTQVsFB7Sc7z3OYdpDK0PSkeQht4g14RmZAxXJZlETLQfqLj59l/Wr+K
         lhMH6FHwAc1I3h0F6kugtwfZ2XBqCN/MDLXNQkUauXECQF1Eu9Q2zhyfSDWALFFooqRF
         A+N+OpJC+IL6j/gqULqh6X7rXIiqeD9J0RIZLElpis7G028nVfraQ3z26UajcCQ7SuDj
         ZksA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/9] ARM: meson: Sync Amlogic DT from Linux 5.14
References: <20210908141728.585797-1-narmstrong@baylibre.com>
 <20210908154606.GF12964@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e5cbdedc-5c62-ba35-c5fc-194042870875@baylibre.com>
Date: Thu, 9 Sep 2021 11:42:34 +0200
MIME-Version: 1.0
In-Reply-To: <20210908154606.GF12964@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

On 08/09/2021 17:46, Tom Rini wrote:
> On Wed, Sep 08, 2021 at 04:17:20PM +0200, Neil Armstrong wrote:
> 
>> Import Amlogic DT changes from Linux commit 7d2a07b76933 ("Linux 5.14"),
>> dt-bindings clock changes and new meson-g12b-gsking-x.dts,
>> meson-sm1-bananapi-m5 & odroid-hc4 boards.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Given some other related email threads, I'm curious.  Does this mean
> that everything U-Boot specific is currently in -u-boot.dtsi files?  Or
> is there some manual syncing within the main dts files (aside from
> perhaps needing to #include a -u-boot.dtsi) ?  Thanks!

The dts, dtsi and bindings files are copied verbatim from Linux and all
the U-Boot specific changes are in the -u-boot.dtsi files indeed.

Is this an issue somehow ?

Neil
