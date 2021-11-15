Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.19898.1636967626625899898
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Nov 2021 01:13:47 -0800
Received: by mail-wr1-f43.google.com with SMTP id a9so3014284wrr.8
        for <u-boot-amlogic@groups.io>; Mon, 15 Nov 2021 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eLFG6ZVDLYrsZCb9R8/7Q1neY+/cmUtU8QQO/xsjmdM=;
        b=3TyAmncRhi8ngHrkA5um3YcwSbtPLDKq3H8LI+VZs9F9j6PtYQ3rLKbJ3SSHMqDJAp
         cW331z/bV/VhBvp1g8gbZOfwYJr0ZE216y/UpebI4xngNXwuPiRtKDynoP20JZoVxtks
         kdhnY/BDVvxTGSgIEbCUpKPWKUlwS7bWBYrchiwe11SxyfFc5fz6/BNvN98ioOeLCJJ0
         i8vpEqHZuiN2m1EtThr/3/uTnQvDhoe+aR5tiT5/8rw2k394EE992V7vkcwpXu12Pm9q
         A5+6CrgUom0Y6D9UPU2jPqDXv8rUQlLQG6HFRgkHvj3eBpv8Pbfl50bVHKoMWjGGrIqB
         a04Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] pinctrl: meson: Correct the driver GPIO declaration
References: <20211113140716.371496-1-sjg@chromium.org>
 <20211113154943.GX24579@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1e3c853a-9b95-89f2-aed2-78512f6eddd6@baylibre.com>
Date: Mon, 15 Nov 2021 10:13:43 +0100
MIME-Version: 1.0
In-Reply-To: <20211113154943.GX24579@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 13/11/2021 16:49, Tom Rini wrote:
> On Sat, Nov 13, 2021 at 07:07:15AM -0700, Simon Glass wrote:
> 
>> This should use the provided U_BOOT_DRIVER() macro so that the driver gets
>> added to the appropriate linker list. Fix it.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 7c9dcfed50f ("pinctrl: meson: rework gx pmx function")
> 
> Reported-by: Tom Rini <trini@konsulko.com>
> Tested-by: Tom Rini <trini@konsulko.com> on libretech-cc
> 

thanks !

Applied to u-boot-amlogic

I'll build all amlogic boards & test on all soc variants,

Neil
