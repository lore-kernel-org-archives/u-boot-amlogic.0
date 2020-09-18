Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
 by mx.groups.io with SMTP id smtpd.web11.2656.1600451989118495914
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 10:59:49 -0700
Received: by mail-pg1-f195.google.com with SMTP id 67so3902274pgd.12
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZyUf2vG1qH6dFPuKVvHqhcYpLpYXaBNB6xbhLeRLxVk=;
        b=qiOb1B9iJkJUDA/Vhk61YmUAL0AmnTiCzoUvcn1nYM0dAKoar49SGJaICBAEv/kSH9
         BIZTBjOAFAwjJpJDJQTAHQGjmdFRRlpIF5tzekU4Sp7JFae2HyRVBIitcRDxiYConkez
         tAoZXVDGk2MYblAGLlJks3qEnDdP2v+ARy+id+1c62lyKmsDQBP1iixHnnoEAS+s2smR
         c6F0Xbu3ow9kdPGcOCn25CMWhfxUqX7WOvAQ37FL/VRSyXbBwn2yL4lTgQFv9IvVXLhv
         d2boswN7WCHayn78mHSctYL3B2tVEijqUGlCyxpqFl8UoL6E3GNOvlk+uJSkvX6Jmw9L
         Z1UA==
Return-Path: <khilman@baylibre.com>
From: "Kevin Hilman" <khilman@baylibre.com>
Subject: Re: [PATCH 0/4] amlogic: vim3: add support for dynamic PCIe enable
In-Reply-To: <20200918092902.28028-1-narmstrong@baylibre.com>
References: <20200918092902.28028-1-narmstrong@baylibre.com>
Date: Fri, 18 Sep 2020 10:59:47 -0700
Message-ID: <7h1rizdkz0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Neil Armstrong <narmstrong@baylibre.com> writes:

> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> an USB3.0 Type A connector and a M.2 Key M slot.
> The PHY driving these differential lines is shared between
> the USB3.0 controller and the PCIe Controller, thus only
> a single controller can use it.
>
> This serie adds a VIM3 specific board support and adds this dynamic
> switching right before booting Linux.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested on khadas vim3

Kevin
